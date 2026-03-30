import emailjs from '@emailjs/browser';

export function initEmailButton() {
  const btn = document.getElementById('emailDevButton');
  const modal = document.getElementById('emailModal');
  const closeBtn = document.getElementById('emailModalClose');
  const form = document.getElementById('emailForm');
  const status = document.getElementById('emailStatus');

  btn.addEventListener('click', () => {
    modal.classList.add('active');
  });

  closeBtn.addEventListener('click', () => {
    modal.classList.remove('active');
    status.textContent = '';
  });

  modal.addEventListener('click', (e) => {
    if (e.target === modal) {
      modal.classList.remove('active');
      status.textContent = '';
    }
  });

  form.addEventListener('submit', (e) => {
    e.preventDefault();
    status.textContent = 'Sending...';
    status.style.color = '#FF69B4';

    emailjs.sendForm(process.env.SERVICE_ID, process.env.TEMPLATE_ID, form, process.env.PUBLIC_KEY)
      .then(() => {
        status.textContent = 'Message sent! ✨';
        status.style.color = '#C71585';
        form.reset();
      }, (error) => {
        status.textContent = 'Failed to send. Please try again.';
        status.style.color = 'red';
        console.error('EmailJS error:', error);
      });
  });
}
