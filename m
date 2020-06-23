Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BAEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8ECC2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbgFWMRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:17:18 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:38865 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732421AbgFWMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:17:17 -0400
Received: by mail-il1-f197.google.com with SMTP id c8so14363893ilm.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 05:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wlhuLVD4u+XXQ7HeSYAD3cLeISlYbuyy5YsqjwGO8Ac=;
        b=niS8U/jLHjNirXf1K+0gFbNgaCtOg4VFFTl9W4Ruf5+FJJL3EEpBAU1AcZQiKnRmWT
         ALU8MQa6BnA57TN1Wztl3N4opnwLRxlB3kidzBENSkJd5fsH9RgI+JsBtqoHs1O5+5hj
         knBuFhhRDu3GijFSfYrSXrrL8iTbyg1s1S5oJ0mE976S9WT68QWt93whL3eoqG4JpY4a
         jZ8s6LMAKsFIt/Kals7aUalnQulbP6P98xaNYSUQrYuWoSEopSPm8c8bsI3HOatLOgQD
         vqw6AjqJZWBfq9pFJkx0Ef3m7EFXJSmPHU8KM+0gxPr9iDrCHvrADKmXRqdynlegGDJW
         V/kw==
X-Gm-Message-State: AOAM531erzbXsNIb2LJZlj8G7chZJ+tTKAttrQwy4xfTRC9njBgCXZFr
        6OWOZ8a+UJD04KcKtuMjgbzzERzmF8SbTGhM0/63MPdLO1Td
X-Google-Smtp-Source: ABdhPJyU4beGPn+n5GTW5K+FfN41A3Vtb/0AYshbsOeC1yWAFc6mdL777MAvP/4VCkWzyTUfevSP1uF075zX0wT6JKuF/ak8WPuo
MIME-Version: 1.0
X-Received: by 2002:a6b:b984:: with SMTP id j126mr24459783iof.114.1592914635879;
 Tue, 23 Jun 2020 05:17:15 -0700 (PDT)
Date:   Tue, 23 Jun 2020 05:17:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000077a6505a8bf57b2@google.com>
Subject: KASAN: null-ptr-deref Read in kvm_arch_check_processor_compat
From:   syzbot <syzbot+a99874f5323ce6088e53@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135e7235100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=a99874f5323ce6088e53
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d001be100000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13a8e549100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1068e549100000
console output: https://syzkaller.appspot.com/x/log.txt?x=17a8e549100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a99874f5323ce6088e53@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
BUG: KASAN: null-ptr-deref in kvm_arch_check_processor_compat+0x1f8/0x750 arch/x86/kvm/x86.c:9818
Read of size 8 at addr 0000000000000060 by task syz-executor.2/8085

CPU: 1 PID: 8085 Comm: syz-executor.2 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:517 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x141/0x190 mm/kasan/generic.c:192
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 kvm_arch_check_processor_compat+0x1f8/0x750 arch/x86/kvm/x86.c:9818
 </IRQ>
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8085 Comm: syz-executor.2 Tainted: G    B             5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 end_report+0x4d/0x53 mm/kasan/report.c:104
 __kasan_report mm/kasan/report.c:520 [inline]
 kasan_report.cold+0xd/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x141/0x190 mm/kasan/generic.c:192
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 kvm_arch_check_processor_compat+0x1f8/0x750 arch/x86/kvm/x86.c:9818
 </IRQ>
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
