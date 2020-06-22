Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAD5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F192A2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVMUyuVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgFVRhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbgFVRhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:37:41 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C485DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:37:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u8so144926pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdXI2s5S4kudE5Kpf5InJOwVNVZ2ZQUWE7Pvf2z0HOw=;
        b=DVMUyuVE5uUuzCVNk4u70aFnuMhJmyz19f0uadeZu7BS+TET7YVCAX1O0WMDmX965s
         BkE4I1dFdoKd1i/Ao9SQ8l2XNUXRtTtad2FHM0Nl5Po22lm3bF/Cr2WetEnSfRSFPi2a
         L/D0EmfhB+F3qDiTHVPPcfkvvxlgykGD6l641RQjz+7Yf5Y5TWcR7umHbwJahxIGORqS
         Yng+sz1hOLCHL3wOhiFaA24wqEYWVCfjz4uAPfnZVNrQjfz9fuEWM7v/UTVI9yFljlIx
         QIa9Y3CfEFGo7zHBldNfyc/6An7oKLquZJ+rcxoCbLL0We7nxASt8fNCBiUkQ7kp/nJA
         923Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdXI2s5S4kudE5Kpf5InJOwVNVZ2ZQUWE7Pvf2z0HOw=;
        b=cmYAVLuv8cgRLh4FKYvcbCVldMMWRIisSkt0K4GLb8nmCJ44u02tHoMXksf5a31Uo4
         z8vg5sarPH97SIFHpOgjksHPEvGOL334UA9sQoJ3xf90lheWU1RdVEiiq57G4MDreSAX
         X2Wx+4kyadlx8I6edD4GkV3mHFORlTEo1cU1W/oz6hiOwaMC1XLkbEM6b0STwD1kPp+8
         s0pdUr7BK7T84Z4sjAxx2lHiWyWahVBW++Eh0tXB94ATbFyLFiQd7wsWzLnLBknFkbJ2
         r9AUNQyPiUNTh/ZBgnCvjmwDTd4wn1EBSYy/Ko/mVIkTfhozUXp2rl0/kHSmuQ78NI+k
         8gjg==
X-Gm-Message-State: AOAM530coHcLHmhmlixtIvEvU+ZDVjIiIhmq6amiTnUFYqHkG9LN+RUY
        kT+w0eE6Nj8Gt00DYJ6qeptq36FSw4ybmRfirpE=
X-Google-Smtp-Source: ABdhPJxs2m7oQzTuBi9rM+9Dob9Ydf3qig8oUsxBDHSAo569MIl+iRFq53Y6ei/IsmHz208VdamTOarOve7gf13rt4E=
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr21018016pll.18.1592847461205;
 Mon, 22 Jun 2020 10:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
In-Reply-To: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Jun 2020 20:37:28 +0300
Message-ID: <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
Subject: Re: UART/TTY console deadlock
To:     Raul Rangel <rrangel@google.com>, Tony Lindgren <tony@atomide.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kurt@linutronix.de, "S, Shirish" <Shirish.S@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Tony and console people

On Mon, Jun 22, 2020 at 8:32 PM Raul Rangel <rrangel@google.com> wrote:
>
> We are trying an S3 suspend stress test and occasionally while
> entering S3 we get a console deadlock. Is this a known issue? I'm not
> really sure why a probe would be happening while suspending.
>
> The kernel command line is `console=ttyS0` and kernel 5.4.39.
>
> Here is the log:
>
> [  278.885831] leds mmc0::: calling led_resume+0x0/0x1c @ 3909,
> parent: 0000:02:00.0
> [  278.885835] leds mmc0::: led_resume+0x0/0x1c returned 0 after 0 usecs
> [  278.890230]  secondary_startup_64+0xa4/0xb0
> [  278.890236] handlers:
> [  279.752138] [<00000000b8e5d375>] i8042_interrupt
> [  279.756915] Disabling IRQ #1
> [  279.759801]
> [  279.759802] ======================================================
> [  279.759803] WARNING: possible circular locking dependency detected
> [  279.759803] 5.4.39 #55 Not tainted
> [  279.759804] ------------------------------------------------------
> [  279.759804] swapper/0/0 is trying to acquire lock:
> [  279.759805] ffffffffab65b6c0 (console_owner){-...}, at:
> console_lock_spinning_enable+0x31/0x57
> [  279.759806]
> [  279.759807] but task is already holding lock:
> [  279.759807] ffff88810a8e34c0 (&irq_desc_lock_class){-.-.}, at:
> __report_bad_irq+0x5b/0xba
> [  279.759809]
> [  279.759809] which lock already depends on the new lock.
> [  279.759810]
> [  279.759810]
> [  279.759811] the existing dependency chain (in reverse order) is:
> [  279.759811]
> [  279.759811] -> #2 (&irq_desc_lock_class){-.-.}:
> [  279.759813]        _raw_spin_lock_irqsave+0x61/0x8d
> [  279.759813]        __irq_get_desc_lock+0x65/0x89
> [  279.759814]        __disable_irq_nosync+0x3b/0x93
> [  279.759814]        serial8250_do_startup+0x451/0x75c
> [  279.759815]        uart_startup+0x1b4/0x2ff
> [  279.759815]        uart_port_activate+0x73/0xa0
> [  279.759815]        tty_port_open+0xae/0x10a
> [  279.759816]        uart_open+0x1b/0x26
> [  279.759816]        tty_open+0x24d/0x3a0
> [  279.759817]        chrdev_open+0xd5/0x1cc
> [  279.759817]        do_dentry_open+0x299/0x3c8
> [  279.759817]        path_openat+0x434/0x1100
> [  279.759818]        do_filp_open+0x9b/0x10a
> [  279.759818]        do_sys_open+0x15f/0x3d7
> [  279.759819]        kernel_init_freeable+0x157/0x1dd
> [  279.759819]        kernel_init+0xe/0x105
> [  279.759819]        ret_from_fork+0x27/0x50
> [  279.759820]
> [  279.759820] -> #1 (&port_lock_key){-.-.}:
> [  279.759822]        _raw_spin_lock_irqsave+0x61/0x8d
> [  279.759822]        serial8250_console_write+0xa7/0x2a0
> [  279.759823]        console_unlock+0x3b7/0x528
> [  279.759823]        vprintk_emit+0x111/0x17f
> [  279.759823]        printk+0x59/0x73
> [  279.759824]        register_console+0x336/0x3a4
> [  279.759824]        uart_add_one_port+0x51b/0x5be
> [  279.759825]        serial8250_register_8250_port+0x454/0x55e
> [  279.759825]        dw8250_probe+0x4dc/0x5b9
> [  279.759825]        platform_drv_probe+0x67/0x8b
> [  279.759826]        really_probe+0x14a/0x422
> [  279.759826]        driver_probe_device+0x66/0x130
> [  279.759827]        device_driver_attach+0x42/0x5b
> [  279.759827]        __driver_attach+0xca/0x139
> [  279.759827]        bus_for_each_dev+0x97/0xc9
> [  279.759828]        bus_add_driver+0x12b/0x228
> [  279.759828]        driver_register+0x64/0xed
> [  279.759829]        do_one_initcall+0x20c/0x4a6
> [  279.759829]        do_initcall_level+0xb5/0xc5
> [  279.759829]        do_basic_setup+0x4c/0x58
> [  279.759830]        kernel_init_freeable+0x13f/0x1dd
> [  279.759830]        kernel_init+0xe/0x105
> [  279.759831]        ret_from_fork+0x27/0x50
> [  279.759831]
> [  279.759831] -> #0 (console_owner){-...}:
> [  279.759833]        __lock_acquire+0x118d/0x2714
> [  279.759833]        lock_acquire+0x203/0x258
> [  279.759834]        console_lock_spinning_enable+0x51/0x57
> [  279.759834]        console_unlock+0x25d/0x528
> [  279.759834]        vprintk_emit+0x111/0x17f
> [  279.759835]        printk+0x59/0x73
> [  279.759835]        __report_bad_irq+0xa3/0xba
> [  279.759836]        note_interrupt+0x19a/0x1d6
> [  279.759836]        handle_irq_event_percpu+0x57/0x79
> [  279.759836]        handle_irq_event+0x36/0x55
> [  279.759837]        handle_fasteoi_irq+0xc2/0x18a
> [  279.759837]        do_IRQ+0xb3/0x157
> [  279.759838]        ret_from_intr+0x0/0x1d
> [  279.759838]        cpuidle_enter_state+0x12f/0x1fd
> [  279.759838]        cpuidle_enter+0x2e/0x3d
> [  279.759839]        do_idle+0x1ce/0x2ce
> [  279.759839]        cpu_startup_entry+0x1d/0x1f
> [  279.759840]        start_kernel+0x406/0x46a
> [  279.759840]        secondary_startup_64+0xa4/0xb0
> [  279.759840]
> [  279.759841] other info that might help us debug this:
> [  279.759841]
> [  279.759841] Chain exists of:
> [  279.759842]   console_owner --> &port_lock_key --> &irq_desc_lock_class
> [  279.759844]
> [  279.759844]  Possible unsafe locking scenario:
> [  279.759845]
> [  279.759845]        CPU0                    CPU1
> [  279.759845]        ----                    ----
> [  279.759846]   lock(&irq_desc_lock_class);
> [  279.759847]                                lock(&port_lock_key);
> [  279.759848]                                lock(&irq_desc_lock_class);
> [  279.759849]   lock(console_owner);
> [  279.759850]
> [  279.759850]  *** DEADLOCK ***
> [  279.759850]
> [  279.759851] 2 locks held by swapper/0/0:
> [  279.759851]  #0: ffff88810a8e34c0 (&irq_desc_lock_class){-.-.}, at:
> __report_bad_irq+0x5b/0xba
> [  279.759853]  #1: ffffffffab65b5c0 (console_lock){+.+.}, at:
> console_trylock_spinning+0x20/0x181
> [  279.759855]
> [  279.759855] stack backtrace:
> [  279.759856] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.39 #55
> [  279.759856] Hardware name: XXXXXX
> [  279.759857] Call Trace:
> [  279.759857]  <IRQ>
> [  279.759857]  dump_stack+0xbf/0x133
> [  279.759858]  ? print_circular_bug+0xd6/0xe9
> [  279.759858]  check_noncircular+0x1b9/0x1c3
> [  279.759858]  __lock_acquire+0x118d/0x2714
> [  279.759859]  lock_acquire+0x203/0x258
> [  279.759859]  ? console_lock_spinning_enable+0x31/0x57
> [  279.759860]  console_lock_spinning_enable+0x51/0x57
> [  279.759860]  ? console_lock_spinning_enable+0x31/0x57
> [  279.759861]  console_unlock+0x25d/0x528
> [  279.759861]  ? console_trylock+0x18/0x4e
> [  279.759861]  vprintk_emit+0x111/0x17f
> [  279.759862]  ? lock_acquire+0x203/0x258
> [  279.759862]  printk+0x59/0x73
> [  279.759862]  __report_bad_irq+0xa3/0xba
> [  279.759863]  note_interrupt+0x19a/0x1d6
> [  279.759863]  handle_irq_event_percpu+0x57/0x79
> [  279.759864]  handle_irq_event+0x36/0x55
> [  279.759864]  handle_fasteoi_irq+0xc2/0x18a
> [  279.759864]  do_IRQ+0xb3/0x157
> [  279.759865]  common_interrupt+0xf/0xf
> [  279.759865]  </IRQ>
> [  279.759866] RIP: 0010:cpuidle_enter_state+0x12f/0x1fd
> [  279.759867] Code: aa aa aa aa aa aa aa 48 89 45 c8 9c 8f 45 c8 0f
> ba 65 c8 09 0f 82 cc 00 00 00 31 ff e8 57 25 76 ff e8 36 bb 7b ff fb
> 45 85 ff <78> 47 44 89 f8 48 6b d0 68 49 8b 4c 16 48 4c 2b 65 b8 4c 89
> 63 18
> [  279.759867] RSP: 0018:ffffffffab607e20 EFLAGS: 00000202 ORIG_RAX:
> ffffffffffffffda
> [  279.759869] RAX: 86733df5ce911a00 RBX: ffff888104709000 RCX: ffffffffa9bb229b
> [  279.759870] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffffffffab62d780
> [  279.759870] RBP: ffffffffab607e68 R08: dffffc0000000000 R09: fffffbfff56eb96f
> [  279.759871] R10: fffffbfff56eb96f R11: ffffffffa9f4f800 R12: 00000040eb0f7ad6
> [  279.759871] R13: 0000000000000000 R14: ffffffffab6caf68 R15: 0000000000000001
> [  279.759871]  ? flatten_lpi_states+0x190/0x1d7
> [  279.759872]  ? trace_irq_enable_rcuidle+0x22/0xee
> [  279.759872]  cpuidle_enter+0x2e/0x3d
> [  279.759872]  do_idle+0x1ce/0x2ce
> [  279.759873]  cpu_startup_entry+0x1d/0x1f
> [  279.759873]  start_kernel+0x406/0x46a
> [  279.759873]  secondary_startup_64+0xa4/0xb0
> [  279.927956] i2c_designware AMD0010:00: controller timed out
> [  280.388120] elan_i2c i2c-ELAN0000:00: reading cmd (0x0307) fail.
> [  280.394413] elan_i2c i2c-ELAN0000:00: failed to read current power
> state: -110
> [  280.542626] elan_i2c i2c-ELAN0000:00: elan_resume+0x0/0x5f returned
> 0 after 1607813 usecs
>
>
> Thanks,
> Raul



-- 
With Best Regards,
Andy Shevchenko
