Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9A6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B50206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsKIVXu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgF3D6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgF3D6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:58:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D896C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 20:58:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so3852523pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 20:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UZusoLCqQIlmRSmX7EYHoJ+kmGqv5TOFQ681QDZwXoc=;
        b=SsKIVXu80NJaGcP9XxkTvHup/+86G0WKF/H65wb9Zyz8D3Z0b3grSBTnYtYoCcSbiz
         5WhM9l0uW9H5fX05jeSGCKCTLmTlizMTFRY2RqtOpwoSFMvu9MWcu0dLeLf/AJfcUl/i
         f9NPE3vzdN2mykqy6aNxc3TYrJbWBEljao59Cgl68Llnqs/jQ4hFsZiEPSynI63Fthc9
         ykkkTumhT/X1XBzXb1gd+6OSo7MlPB1SU6n/UN9v9D5zv3I3o7LMMgfgCKBMKzWIC9Is
         pseq2oiwc3IUKKVobAI9ZJ6U6VU/k4GovPu4cbt5MQgdYcmiw+ECl+8xc0xh1Wpik2nt
         lTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UZusoLCqQIlmRSmX7EYHoJ+kmGqv5TOFQ681QDZwXoc=;
        b=dE7o4c1h04qCYdoCzPwdhtkmxBq1EWX59qBTIKhz2d9J0XIcBMHYUAoief7wUOKru2
         QMnwMnGbCnlP4pDUolu3ZLoC0zrZ6XTTsieSTKYXreBZHUVxSMD/bFB8eSXlR1f2gLwb
         FlvvUr1nhJyXHvDTEWVWXCyPez87UJLVB6lVBNp6I4kZ9ShvDX3NPHfV4fvI20QZ4CDt
         ayx6QeQP+N53SDiQGVoxc8GCAx6rJaBo7YtThXeRwqbV1JtCv+znv5IrW2AKqjE2zGEU
         N2iwj7IYfpDjVGxDEMR/B//2ISZQlJNSR+yJ9rtp36t5yf2T6oSynJHmPKvuBJWT7OxU
         wcpg==
X-Gm-Message-State: AOAM531yxcKyBg5TfLLxN1Caxw0sxHDUXPo8ok9+vv60J4ouCuBySZZN
        1BU+fkY6faUvDNUHzcGDEOE=
X-Google-Smtp-Source: ABdhPJxVkCnMhpselOG4wuQz3QDMY85DnMs7gYCCc5LJUiCw7WwaOoCV9Uc9nEvf7Udn3fGD/WmeQA==
X-Received: by 2002:a17:902:a412:: with SMTP id p18mr15812016plq.341.1593489499918;
        Mon, 29 Jun 2020 20:58:19 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 64sm1128851pgb.63.2020.06.29.20.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 20:58:19 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 30 Jun 2020 12:58:16 +0900
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Raul Rangel <rrangel@google.com>, Tony Lindgren <tony@atomide.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kurt@linutronix.de, "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200630035816.GA21591@jagdpanzerIV.localdomain>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing more people

https://lore.kernel.org/lkml/CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com

On (20/06/22 20:37), Andy Shevchenko wrote:
> > [  279.759811] -> #2 (&irq_desc_lock_class){-.-.}:
> > [  279.759813]        _raw_spin_lock_irqsave+0x61/0x8d
> > [  279.759813]        __irq_get_desc_lock+0x65/0x89
> > [  279.759814]        __disable_irq_nosync+0x3b/0x93
> > [  279.759814]        serial8250_do_startup+0x451/0x75c
> > [  279.759815]        uart_startup+0x1b4/0x2ff
> > [  279.759815]        uart_port_activate+0x73/0xa0
> > [  279.759815]        tty_port_open+0xae/0x10a
> > [  279.759816]        uart_open+0x1b/0x26
> > [  279.759816]        tty_open+0x24d/0x3a0
> > [  279.759817]        chrdev_open+0xd5/0x1cc
> > [  279.759817]        do_dentry_open+0x299/0x3c8
> > [  279.759817]        path_openat+0x434/0x1100
> > [  279.759818]        do_filp_open+0x9b/0x10a
> > [  279.759818]        do_sys_open+0x15f/0x3d7
> > [  279.759819]        kernel_init_freeable+0x157/0x1dd
> > [  279.759819]        kernel_init+0xe/0x105
> > [  279.759819]        ret_from_fork+0x27/0x50
> > [  279.759820]
> > [  279.759820] -> #1 (&port_lock_key){-.-.}:
> > [  279.759822]        _raw_spin_lock_irqsave+0x61/0x8d
> > [  279.759822]        serial8250_console_write+0xa7/0x2a0
> > [  279.759823]        console_unlock+0x3b7/0x528
> > [  279.759823]        vprintk_emit+0x111/0x17f
> > [  279.759823]        printk+0x59/0x73
> > [  279.759824]        register_console+0x336/0x3a4
> > [  279.759824]        uart_add_one_port+0x51b/0x5be
> > [  279.759825]        serial8250_register_8250_port+0x454/0x55e
> > [  279.759825]        dw8250_probe+0x4dc/0x5b9
> > [  279.759825]        platform_drv_probe+0x67/0x8b
> > [  279.759826]        really_probe+0x14a/0x422
> > [  279.759826]        driver_probe_device+0x66/0x130
> > [  279.759827]        device_driver_attach+0x42/0x5b
> > [  279.759827]        __driver_attach+0xca/0x139
> > [  279.759827]        bus_for_each_dev+0x97/0xc9
> > [  279.759828]        bus_add_driver+0x12b/0x228
> > [  279.759828]        driver_register+0x64/0xed
> > [  279.759829]        do_one_initcall+0x20c/0x4a6
> > [  279.759829]        do_initcall_level+0xb5/0xc5
> > [  279.759829]        do_basic_setup+0x4c/0x58
> > [  279.759830]        kernel_init_freeable+0x13f/0x1dd
> > [  279.759830]        kernel_init+0xe/0x105
> > [  279.759831]        ret_from_fork+0x27/0x50
> > [  279.759831]
> > [  279.759831] -> #0 (console_owner){-...}:
> > [  279.759833]        __lock_acquire+0x118d/0x2714
> > [  279.759833]        lock_acquire+0x203/0x258
> > [  279.759834]        console_lock_spinning_enable+0x51/0x57
> > [  279.759834]        console_unlock+0x25d/0x528
> > [  279.759834]        vprintk_emit+0x111/0x17f
> > [  279.759835]        printk+0x59/0x73
> > [  279.759835]        __report_bad_irq+0xa3/0xba
> > [  279.759836]        note_interrupt+0x19a/0x1d6
> > [  279.759836]        handle_irq_event_percpu+0x57/0x79
> > [  279.759836]        handle_irq_event+0x36/0x55
> > [  279.759837]        handle_fasteoi_irq+0xc2/0x18a
> > [  279.759837]        do_IRQ+0xb3/0x157
> > [  279.759838]        ret_from_intr+0x0/0x1d
> > [  279.759838]        cpuidle_enter_state+0x12f/0x1fd
> > [  279.759838]        cpuidle_enter+0x2e/0x3d
> > [  279.759839]        do_idle+0x1ce/0x2ce
> > [  279.759839]        cpu_startup_entry+0x1d/0x1f
> > [  279.759840]        start_kernel+0x406/0x46a
> > [  279.759840]        secondary_startup_64+0xa4/0xb0

Hmm. So this is uart->port => desc->lock vs desc->lock => uart->port

chain #1:

 serial8250_do_startup()
  spin_lock_irqsave(&port->lock);
   disable_irq_nosync(port->irq);
    raw_spin_lock_irqsave(&desc->lock)

chain #2:

  __report_bad_irq()
   raw_spin_lock_irqsave(&desc->lock)
    for_each_action_of_desc()
     printk()
      spin_lock_irqsave(&port->lock);


Breaking up chain #2 is not an option, I suppose. Those are a rather
important KERN_ERR messages, printk_deferred() will upset people badly.

So... Do we need to hold uart->port when we disable port->irq? What do we
race with? Module removal? The function bumps device PM counter (albeit
for UART_CAP_RPM ports only). But, at the same time, we do a whole bunch
of unprotected port->FOO accesses in serial8250_do_startup(). We even set
the IRQF_SHARED up->port.irqflags without grabbing the port->lock:

	 up->port.irqflags |= IRQF_SHARED;
	 spin_lock_irqsave(&port->lock, flags);
	 if (up->port.irqflags & IRQF_SHARED)
	    disable_irq_nosync(port->irq);

IOW, can we do something like this?

---
 drivers/tty/serial/8250/8250_port.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d64ca77d9cfa..ad30991e1b3b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2275,6 +2275,11 @@ int serial8250_do_startup(struct uart_port *port)
 
 	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
 		unsigned char iir1;
+		bool irq_shared = up->port.irqflags & IRQF_SHARED;
+
+		if (irq_shared)
+			disable_irq_nosync(port->irq);
+
 		/*
 		 * Test for UARTs that do not reassert THRE when the
 		 * transmitter is idle and the interrupt has already
@@ -2284,8 +2289,6 @@ int serial8250_do_startup(struct uart_port *port)
 		 * allow register changes to become visible.
 		 */
 		spin_lock_irqsave(&port->lock, flags);
-		if (up->port.irqflags & IRQF_SHARED)
-			disable_irq_nosync(port->irq);
 
 		wait_for_xmitr(up, UART_LSR_THRE);
 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
@@ -2297,9 +2300,9 @@ int serial8250_do_startup(struct uart_port *port)
 		iir = serial_port_in(port, UART_IIR);
 		serial_port_out(port, UART_IER, 0);
 
-		if (port->irqflags & IRQF_SHARED)
-			enable_irq(port->irq);
 		spin_unlock_irqrestore(&port->lock, flags);
+		if (irq_shared)
+			enable_irq(port->irq);
 
 		/*
 		 * If the interrupt is not reasserted, or we otherwise
-- 
2.27.0

