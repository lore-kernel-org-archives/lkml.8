Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E02C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D591E20884
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGDAsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 20:48:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55646 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGDAsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 20:48:21 -0400
Received: by mail-io1-f72.google.com with SMTP id k10so20052109ioh.22
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 17:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9OzbTej0eRMNtBlY/Y4wiBSxoUbN0sJufbnpKWM6F+4=;
        b=CzcKRY6yaKsv0amEm0BSX5awkTbP3tXqB8gtCgyPLO/Ks7+Rs0J80Q3rGSbfST01AR
         6Vz7njUYS7J4OJip3piuH7QgJaAC3IOaTriKnZSBb3Jbrg796lV1xaR3sDFHErOzmza5
         bmtibnQwc/QDTwkIfLYegFBWinETWfeAJL7su1iP+vECnvAmFuWl5dWezLQ5wvSzLb5D
         92sr4OE68hEyVCsWwWmQCTpdDY9A6LNS/aWweF5wum8weeeng9asdvaH+u1z6D0pyJ7v
         S18tj4Nuc4/9xtxxJyWQ3PdTKTuMF8g6piaBRHeZbsnS/pPl8ASFqqZkBjo5qS1I5uKn
         WJlw==
X-Gm-Message-State: AOAM531JFufKuP6tGxmroUWHWMqrw4qYzZIExOK89gaDJrw+8ONstCbu
        Tt/UYIUSwzQz5pSZcx60r0XZ+Z7IZ7krq+JCMBbBOptENj6G
X-Google-Smtp-Source: ABdhPJwO24V0iVeIJgs/HPNqj8Oop1C4EvXfNQXLS/ec6EjCZb0Nn+7wP38er6bgj8xr70GJVORIkRx3j3fA3TXVCzXCnV+rDNav
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1408:: with SMTP id t8mr15057603iov.125.1593823700210;
 Fri, 03 Jul 2020 17:48:20 -0700 (PDT)
Date:   Fri, 03 Jul 2020 17:48:20 -0700
In-Reply-To: <00000000000042f21905a991ecea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c5de505a992ff57@google.com>
Subject: Re: KASAN: stack-out-of-bounds Read in csd_lock_record
From:   syzbot <syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    9e50b94b Add linux-next specific files for 20200703
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1224dc83100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
dashboard link: https://syzkaller.appspot.com/bug?extid=0f719294463916a3fc0e
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170442d5100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162ef66d100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in csd_lock_record+0xd2/0xe0 kernel/smp.c:119
Read of size 8 at addr ffffc900016d75f8 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.8.0-rc3-next-20200703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 csd_lock_record+0xd2/0xe0 kernel/smp.c:119
 flush_smp_call_function_queue+0x285/0x730 kernel/smp.c:391
 __sysvec_call_function_single+0x98/0x490 arch/x86/kernel/smp.c:248
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_call_function_single+0xe0/0x120 arch/x86/kernel/smp.c:243
 asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:604
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: ff 4c 89 ef e8 33 30 c7 f9 e9 8e fe ff ff 48 89 df e8 26 30 c7 f9 eb 8a cc cc cc cc e9 07 00 00 00 0f 00 2d 14 4b 5c 00 fb f4 <c3> 90 e9 07 00 00 00 0f 00 2d 04 4b 5c 00 f4 c3 cc cc 55 53 e8 c9
RSP: 0018:ffffc90000d3fd18 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880a95f0340 RSI: ffffffff87ec78c8 RDI: ffffffff87ec789e
RBP: ffff88821af4d864 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88821af4d864
R13: 1ffff920001a7fad R14: ffff88821af4d865 R15: 0000000000000001
 arch_safe_halt arch/x86/include/asm/paravirt.h:150 [inline]
 acpi_safe_halt+0x8d/0x110 drivers/acpi/processor_idle.c:111
 acpi_idle_do_entry+0x15c/0x1b0 drivers/acpi/processor_idle.c:525
 acpi_idle_enter+0x3f9/0xab0 drivers/acpi/processor_idle.c:651
 cpuidle_enter_state+0xff/0x960 drivers/cpuidle/cpuidle.c:235
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:346
 call_cpuidle kernel/sched/idle.c:126 [inline]
 cpuidle_idle_call kernel/sched/idle.c:214 [inline]
 do_idle+0x431/0x6d0 kernel/sched/idle.c:276
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:372
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243


Memory state around the buggy address:
 ffffc900016d7480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900016d7500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc900016d7580: 00 00 00 00 f1 f1 f1 f1 00 00 00 00 f3 f3 f3 f3
                                                                ^
 ffffc900016d7600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900016d7680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

