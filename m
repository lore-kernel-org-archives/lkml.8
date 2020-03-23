Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB76C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678DC206F7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYG5N/Fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCWDeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 23:34:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38737 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgCWDeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 23:34:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so12928507ljh.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 20:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fVeSqe6WLUik8YqlISLlzVYFaPVNJoGzH5CdvUMY7Mg=;
        b=GYG5N/FnCemSWnoHlBQ/q/1hv8MVIo1L2tt3+lDvezBTJLCJBdS83ODR2HyQMD5HjQ
         avbRqtK9J07v7f32Ri8yyxeC16hdcC2Rt8yAK8TTIIXRROparEliR3hWR4ate36dpqwy
         kGmVKZpy/xagQNn3YJMdAtGQzh4CgVzD6Gi043z3ywLT2OVzi+G9G3OxeODtaDDS6I0L
         q431banXrcibH7UbzFzFwURwYwxH6CpN/YUvN3p2C8Hk0KyXQ4ZBXMochDeSc8YoNCtv
         n4wn+RSt6HH87+QKZSOXG2sDRZfyZy0HKiUc/ifrwjZXu5lKksGKgfO7FJ+6LTCXAL7V
         I0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fVeSqe6WLUik8YqlISLlzVYFaPVNJoGzH5CdvUMY7Mg=;
        b=Jdp2c4CLBMNCjNKjTYRQOUzC1G2C+QVWdDcARi6TMhQisBr3oH3jMMLw4XjsJYF82A
         V8sxVbX9BT8zDLwcCkQzfaGxQ2SsQ8LzZskLFN9ZAMSDfKgSp14wfmPIHZjMK00eZEAR
         37CqBo4i9iCfhW2ZO8J6vp9g779tco64p0zV4tqtP/kJxiaj//4F4KYYbhEnGnx9inlv
         xgK3FhzN2JIXhdlBGFN/Vx5wvuHYyFtb/Pbrw8Ha8b8Aj9hBXZ/PFz6mvNtCxiyVo5O4
         I/6ZhY/kD7RrJsq7zG6Kr68gYMmiHTdnj1nNRzdo4Xapvgv8EmzHxdtJfm7Dc+5ykVcf
         2bZA==
X-Gm-Message-State: ANhLgQ21r/c0kpod54IViYlpileKREdU9Pckodv0dCVsMzOPOLr1ySPh
        Ig7MyzIYdW5j+0bYvlZT/SDSrG5Q7hBBy79OkiI2NA==
X-Google-Smtp-Source: ADFU+vsR9MjnHVQYElmVrZah9BBnjNY8zjOorcLoPvHg0nDR1a3gTIlgR1WImXZIwm0DGAj6+mR+QxMwAd49s6dZflY=
X-Received: by 2002:a2e:9d84:: with SMTP id c4mr12648082ljj.51.1584934452677;
 Sun, 22 Mar 2020 20:34:12 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Sun, 22 Mar 2020 23:34:01 -0400
Message-ID: <CAEAjamv3wT4aqF0y1_PHG_=cbzH-ATsP6TiV5Zt5Qc+ACVnOPw@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in drivers/tty/vt/keyboard.c
To:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        slyfox@gentoo.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        rei4dan@gmail.com
Cc:     Dave Tian <dave.jing.tian@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug (in linux-5.5.11) found by FuzzUSB (modified version
of syzkaller)

Seems the variable "npadch" has a very large value (i.e., 333333333)
as a result of multiple executions of the function "k_ascii" (keyboard.c:888)
while the variable "base" has 10.
So their multiplication at line 888 in "k_ascii" will become
larger than the max of type int, causing such an integer overflow.

I believe this can be solved by checking for overflow ahead of operations
e.g., using check_mul_overflow().

kernel config: https://kt0755.github.io/etc/config_v5.5.11

==================================================================
UBSAN: Undefined behaviour in drivers/tty/vt/keyboard.c:888:19
signed integer overflow:
10 * 333333333 cannot be represented in type 'int'
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.11 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xce/0x128 lib/dump_stack.c:118
 ubsan_epilogue+0xe/0x30 lib/ubsan.c:154
 handle_overflow+0x141/0x150 lib/ubsan.c:184
 __ubsan_handle_mul_overflow+0x2a/0x40 lib/ubsan.c:205
 k_ascii+0xbf/0xd0 drivers/tty/vt/keyboard.c:888
 kbd_keycode drivers/tty/vt/keyboard.c:1477 [inline]
 kbd_event+0x85d/0x3b90 drivers/tty/vt/keyboard.c:1495
 input_to_handler+0x3a9/0x4b0 drivers/input/input.c:118
 input_pass_values.part.8+0x25e/0x690 drivers/input/input.c:145
 input_pass_values drivers/input/input.c:181 [inline]
 input_repeat_key+0x1fa/0x2e0 drivers/input/input.c:193
 call_timer_fn+0x226/0x7a0 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 run_timer_softirq+0x661/0x13e0 kernel/time/timer.c:1786
 __do_softirq+0x262/0xb46 kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x161/0x1b0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x137/0x500 arch/x86/kernel/apic/apic.c:1146
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:default_idle+0x2d/0x2e0 arch/x86/kernel/process.c:700
Code: e5 41 57 41 56 65 44 8b 35 78 c6 5c 7a 41 55 41 54 53 0f 1f 44
00 00 e8 91 dd a3 fb e9 07 00 00 00 0f 00 2d 85 48 5d 00 fb f4 <65> 44
8b 35 53 c6 5c 7a 0f 1f 44 00 00 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffffffff87007ce8 EFLAGS: 00000292 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000007 RBX: ffffffff87032700 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffffffff87032f4c
RBP: ffffffff87007d10 R08: fffffbfff0e064e1 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff88c37a80 R14: 0000000000000000 R15: 0000000000000000
 arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:690
 default_idle_call+0x50/0x70 kernel/sched/idle.c:94
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x345/0x550 kernel/sched/idle.c:269
 cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:361
 rest_init+0x240/0x3d0 init/main.c:451
 arch_call_rest_init+0xe/0x1b
 start_kernel+0x81c/0x858 init/main.c:785
 x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:490
 x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:471
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
==================================================================
