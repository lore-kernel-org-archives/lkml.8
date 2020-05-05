Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A72C3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDCD206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 00:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgEEA4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 20:56:18 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53848 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgEEA4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 20:56:18 -0400
Received: by mail-io1-f69.google.com with SMTP id i26so234257ioe.20
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 17:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Dv4O+0Da2ApKMxxVKOZ1rWiwoYjMBDdMmxohPYEYF8Y=;
        b=BSjxRt+YT31lThmG8wPreRtPHfH0CGhxP1i/d3zfoJoEr2DubRYUFOtJTB4bRplWoy
         Vv+5uUoyQNaLA0s3i89Loupo63YY6wGQklOk4DP+Ws7JUHCAEA4HJIRw0G0pfsI+CkAF
         mTfe7C9SJB9U+lMftXCkAqUQsIMIAab8rCp+ngF1iBAY1lOk2dzQz5Vp+npFwl4G3X5c
         Ntp0hDvcK18l4lMIvOFsuMkao5kfQuKSgfNqguti9yRCWEaIXDou6a2esBVKaZjOuJ91
         aZOQdn2laIbYLqKurMxCCCsNcihgH8gEjOes6p0j1NbKe/eeL8HNpNLVhUJBGv9tStEJ
         gomQ==
X-Gm-Message-State: AGi0Pubnn3+JZfgz/wuit558WDSlRM4Dh9gFHXYmZF7a4rgQIr5tiIOP
        G8JOjoXXAQg7NLElSMd8ols/qzvAtHygJh0/8sTXVmmWp8Ox
X-Google-Smtp-Source: APiQypInnMvefjG0e09hsyb3MhTZCaH954WJchR+5hA16tZm9D3C5PD5LTr4shO5aDcIf0hVll8j83Dd4wKFinHAlEl1G5gPUkiI
MIME-Version: 1.0
X-Received: by 2002:a92:ce0d:: with SMTP id b13mr1174488ilo.55.1588640177098;
 Mon, 04 May 2020 17:56:17 -0700 (PDT)
Date:   Mon, 04 May 2020 17:56:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ea42405a4dc1d45@google.com>
Subject: KASAN: null-ptr-deref Read in uncore_pmu_event_add
From:   syzbot <syzbot+832ccf42c61e3c63654e@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ac935d22 Add linux-next specific files for 20200415
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f5743fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc498783097e9019
dashboard link: https://syzkaller.appspot.com/bug?extid=832ccf42c61e3c63654e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fa7d40100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bfa540100000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b06540100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15b06540100000
console output: https://syzkaller.appspot.com/x/log.txt?x=11b06540100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+832ccf42c61e3c63654e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:56 [inline]
BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
BUG: KASAN: null-ptr-deref in uncore_msr_perf_ctr arch/x86/events/intel/uncore.h:335 [inline]
BUG: KASAN: null-ptr-deref in uncore_perf_ctr arch/x86/events/intel/uncore.h:378 [inline]
BUG: KASAN: null-ptr-deref in uncore_assign_hw_event arch/x86/events/intel/uncore.c:230 [inline]
BUG: KASAN: null-ptr-deref in uncore_pmu_event_add+0xa25/0x16d0 arch/x86/events/intel/uncore.c:602
Read of size 8 at addr 0000000000000000 by task syz-executor764/7073

CPU: 0 PID: 7073 Comm: syz-executor764 Not tainted 5.7.0-rc1-next-20200415-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 __kasan_report.cold+0x5/0x4d mm/kasan/report.c:515
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 check_memory_region_inline mm/kasan/generic.c:187 [inline]
 check_memory_region+0x141/0x190 mm/kasan/generic.c:193
 instrument_atomic_read include/linux/instrumented.h:56 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 uncore_msr_perf_ctr arch/x86/events/intel/uncore.h:335 [inline]
 uncore_perf_ctr arch/x86/events/intel/uncore.h:378 [inline]
 uncore_assign_hw_event arch/x86/events/intel/uncore.c:230 [inline]
 uncore_pmu_event_add+0xa25/0x16d0 arch/x86/events/intel/uncore.c:602
 </IRQ>
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7073 Comm: syz-executor764 Tainted: G    B             5.7.0-rc1-next-20200415-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 end_report+0x4d/0x53 mm/kasan/report.c:103
 __kasan_report.cold+0xd/0x4d mm/kasan/report.c:518
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 check_memory_region_inline mm/kasan/generic.c:187 [inline]
 check_memory_region+0x141/0x190 mm/kasan/generic.c:193
 instrument_atomic_read include/linux/instrumented.h:56 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 uncore_msr_perf_ctr arch/x86/events/intel/uncore.h:335 [inline]
 uncore_perf_ctr arch/x86/events/intel/uncore.h:378 [inline]
 uncore_assign_hw_event arch/x86/events/intel/uncore.c:230 [inline]
 uncore_pmu_event_add+0xa25/0x16d0 arch/x86/events/intel/uncore.c:602
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
