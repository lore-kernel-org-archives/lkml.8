Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6056C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EBD206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgEODCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 23:02:19 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47322 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgEODCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 23:02:18 -0400
Received: by mail-io1-f72.google.com with SMTP id v23so972281ioj.14
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 20:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GMXYp38X7Oaj54tuq4Dozr4lCPEmXzTIfiSVtioIQzk=;
        b=FDRGOOWA0fRh9v8z/QgHbFrAPtZ6Fob3KNG59OH8OxYRk2TuknHtwCkEKsmLkfgc5B
         BPrEAsNXAByzAq3B1zocs4MMlX+cV1vbabyIPCpjHkxfkTs6Ck5RHSnn02YFS+xaebq4
         lqVDou6yHleB+PEl++pGKYmgyOtEBa3KiVEAi4kNvWZiKnI1nVvWDhaGBVo3AK/DDF9L
         x8wxA4BTmZ01bTmheTWuXRHyeGtxdfp8utlsLSb6QtKAr+a2UaUJ4NbUewkgKtWc0eK8
         pALTYKzbivnZQry2s9TLY1Fan4XKd498h+dR9JNjXElLEoXMuwH4utoJgPyEyrc8NiFl
         kWTA==
X-Gm-Message-State: AOAM530WimEvYAlMgFzxpGaVwI0qSo1uD/ocCNGFuqsLlIx9JYxqo8vN
        bEpgSn+tL4oB8WYHh1rWiTWENjo3D0ihgT4rM9672//onYgB
X-Google-Smtp-Source: ABdhPJzkeMa5bqbmGRpbgTVa5RL+BI7YvsR4SFxDq1B/T/BXttEC7DQw16E49IGTgrJkJFNW/g1UVmGoh1ULwta8wf3179jrZcLT
MIME-Version: 1.0
X-Received: by 2002:a92:d391:: with SMTP id o17mr1134828ilo.37.1589511737257;
 Thu, 14 May 2020 20:02:17 -0700 (PDT)
Date:   Thu, 14 May 2020 20:02:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077346605a5a70a32@google.com>
Subject: KASAN: out-of-bounds Read in pebs_update_state
From:   syzbot <syzbot+45862e7027be5d590577@syzkaller.appspotmail.com>
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

HEAD commit:    e99332e7 gcc-10: mark more functions __init to avoid secti..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e4a10c100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a96cf498e199d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=45862e7027be5d590577
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17bb1714100000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e02714100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11e02714100000
console output: https://syzkaller.appspot.com/x/log.txt?x=16e02714100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+45862e7027be5d590577@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in pebs_update_adaptive_cfg arch/x86/events/intel/ds.c:991 [inline]
BUG: KASAN: out-of-bounds in pebs_update_state+0xc27/0xc80 arch/x86/events/intel/ds.c:1046
Read of size 8 at addr ffffc90004857428 by task syz-executor.1/8320

CPU: 0 PID: 8320 Comm: syz-executor.1 Not tainted 5.7.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x315 mm/kasan/report.c:382
 __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 pebs_update_adaptive_cfg arch/x86/events/intel/ds.c:991 [inline]
 pebs_update_state+0xc27/0xc80 arch/x86/events/intel/ds.c:1046
 </IRQ>


Memory state around the buggy address:
 ffffc90004857300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004857380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90004857400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                                     ^
 ffffc90004857480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004857500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
