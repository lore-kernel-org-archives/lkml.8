Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB58C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 05:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE54B252C3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 05:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgFVF1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 01:27:14 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33004 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgFVF1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 01:27:13 -0400
Received: by mail-il1-f197.google.com with SMTP id c11so11245682ilq.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 22:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WAbF95MgN8ZYZsWID6ErjvPvo/yEVx8gXF6X3UgNnwE=;
        b=WaNktqqpTTOibeWHUpR8y0YC1RXvzJb3JO4fngJ2JmZpepKn/x7DphTW6PVZJkFdxU
         zxhCsur5qXmggDG/F2jqDb1b50nvBs3MoBNhoW6gDyGHrpjnKzJCoOkZQfSP8aM/9tL3
         u2BEpSMxBzi/lsQPRtSvUeo43W4qwku1zeTqvDQulN65+W/lmlQxUwLhGKEIZTmZ0r2k
         qI430Gp1/prcJhf0flgS2UgXkWG4ayC4n3Il/DR10cc5b4yNcKNOKpVVOY+fO2kuDU8u
         4kkoaZqiaQdBazvVns0QqMmLUfuDX5PaPb6Vto1sj0ZZqJsDgoFbn/ZOTzaf2qfeUDwC
         VKtw==
X-Gm-Message-State: AOAM530Hw94q87e4YpjN31OKt91B4Tz1UVyUPt1sMbNHR0ZzIlFnTrsQ
        OOe00bNnV3WSBfst2mZrR1I+Xx+Vy3X+54SLTxNNVOD9Y5Gs
X-Google-Smtp-Source: ABdhPJx1d2x8MplJ7qZiLPqN7qsCGSk24mbh9hQ0jkWLY6ngXy5/k2A7sFw9yePX9F81jEWL281xJItlf+5A1VMl9Sqtp1btximk
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d42:: with SMTP id d2mr16942376jak.9.1592803631022;
 Sun, 21 Jun 2020 22:27:11 -0700 (PDT)
Date:   Sun, 21 Jun 2020 22:27:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fc59f05a8a57efd@google.com>
Subject: KASAN: null-ptr-deref Write in kvm_vcpu_halt
From:   syzbot <syzbot+76004d8cdf5443dcd8e7@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17d9bfa9100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=76004d8cdf5443dcd8e7
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+76004d8cdf5443dcd8e7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in kvm_vcpu_halt+0xea/0x110 arch/x86/kvm/x86.c:7546
Write of size 4 at addr 0000000000000000 by task syz-executor.0/11111

CPU: 1 PID: 11111 Comm: syz-executor.0 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:517 [inline]
 kasan_report+0x151/0x1d0 mm/kasan/report.c:530
 kvm_vcpu_halt+0xea/0x110 arch/x86/kvm/x86.c:7546
 </IRQ>
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 11111 Comm: syz-executor.0 Tainted: G    B             5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:221
 end_report mm/kasan/report.c:104 [inline]
 __kasan_report mm/kasan/report.c:520 [inline]
 kasan_report+0x1c9/0x1d0 mm/kasan/report.c:530
 kvm_vcpu_halt+0xea/0x110 arch/x86/kvm/x86.c:7546
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
