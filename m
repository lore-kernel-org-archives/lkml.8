Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086D5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 20:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6AE22071A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 20:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgF0UBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 16:01:15 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:51847 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0UBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 16:01:14 -0400
Received: by mail-il1-f197.google.com with SMTP id m3so9025087ila.18
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 13:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Mvxz2KaB3q5DOPBNFkkKBK9pRd2aubCwIdLOx3Y8RO4=;
        b=WvGgCo0ZxAWpckdagg/7MieMWq4EF/nfSOj/aVXAlyu8TGiRR8d+xNtwt3f6yl/Ey+
         cr3O4Doiswn77jV0AHCr0z42mWJx+5/MUotKgOu1C1G2q9Ak1qh4JieLIlKOuMeE8uEL
         AmqE9TNLHHVwH4DcfI5GDWIncGuGMVlyqg6H6jfNvR4ugBUP768tw0gXQJYjHTFqPGh/
         o0mZtHbfbbNA9ClqOqcKCIN0NZJddO4DCe+ljmZB1lQLusbCn0Qax4XgQc6feIgpQD3/
         Itg/E+3FFzI075rvWnOMa8MFcCMaFX0bgq07KZKKVKSZpKVUzCHGwOFp5J2Rw15LYmbQ
         IzOg==
X-Gm-Message-State: AOAM530eO3W3kyIku7wbzAzfTsAeYOFqDsSQhFXgofol2EdOGLsotYGP
        q0Vc22l/0xfCDNXyBcgCmpaucBS/HxnwFoaMG+0/Mqa5Slow
X-Google-Smtp-Source: ABdhPJzUz9k0v2AcmLVOka0OuJvm7c8FJgmZAcfy7/t2BpZbuz9mS5cTrHmA6m5ohhrWENBHuIyNzDpdYgl52/ln+tdm7DPgu0MJ
MIME-Version: 1.0
X-Received: by 2002:a02:1443:: with SMTP id 64mr9868582jag.43.1593288073178;
 Sat, 27 Jun 2020 13:01:13 -0700 (PDT)
Date:   Sat, 27 Jun 2020 13:01:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0784a05a916495e@google.com>
Subject: KASAN: out-of-bounds Read in kvm_arch_hardware_setup
From:   syzbot <syzbot+e0240f9c36530bda7130@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1654e385100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=e0240f9c36530bda7130
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f3abc9100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131b7bb5100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e0240f9c36530bda7130@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in kvm_cpu_cap_get arch/x86/kvm/cpuid.h:292 [inline]
BUG: KASAN: out-of-bounds in kvm_cpu_cap_has arch/x86/kvm/cpuid.h:297 [inline]
BUG: KASAN: out-of-bounds in kvm_init_msr_list arch/x86/kvm/x86.c:5362 [inline]
BUG: KASAN: out-of-bounds in kvm_arch_hardware_setup+0xb05/0xf40 arch/x86/kvm/x86.c:9802
Read of size 4 at addr ffffffff896c3134 by task syz-executor614/6786

CPU: 1 PID: 6786 Comm: syz-executor614 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 kvm_cpu_cap_get arch/x86/kvm/cpuid.h:292 [inline]
 kvm_cpu_cap_has arch/x86/kvm/cpuid.h:297 [inline]
 kvm_init_msr_list arch/x86/kvm/x86.c:5362 [inline]
 kvm_arch_hardware_setup+0xb05/0xf40 arch/x86/kvm/x86.c:9802
 </IRQ>

The buggy address belongs to the variable:
 kvm_cpu_caps+0x24/0x50

Memory state around the buggy address:
 ffffffff896c3000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff896c3080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffff896c3100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                                        ^
 ffffffff896c3180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff896c3200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
