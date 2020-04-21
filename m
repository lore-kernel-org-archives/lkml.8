Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813ECC54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640C8206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 00:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgDUAPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:15:13 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:53892 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgDUAPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:15:12 -0400
Received: by mail-il1-f199.google.com with SMTP id 9so14548630ill.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 17:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=e7tbGnQOw9ScmhkM05mN4FRYPqxD9li27999npT/skU=;
        b=M0HI2ydEMPqin+n5xl74Uz9T8aBXA2I8ejEHyYB5QZGgSisYE5aIrCbUEhn2Qw95uQ
         BSV12slncUV2Avzt2HmEkBXolF5cL+FZKThOySWL4x9w1AwLBLp/nrWuYhTkgABQq2uC
         hpJgwI2YMESHQ8zlkC41QXdMW056EIQE6n49muw5EMDbZpS66EcbYRK5pRZf7Qdb4Vmi
         tw3/uidVJDSeSoQNimCrzSzhwNaavMq2KC55IIO23ldXB+0C07vDXB08JvEd33oP4HI/
         7KTEo0bhlD0gO24sfJGW64MZiFnuUXO/9g35zXewHfC0NeRofuL6OaK3qmA1mIpRJUhh
         GqsQ==
X-Gm-Message-State: AGi0PuamJ2cr/AFNgIaFIe90iqiP0O+scS3TONl2Xs9fBYMD6WVwRgg9
        GAzhiAhUtUiRNnRFfZlyF2GwR0YpH8RESRJ1VUEYAKiGfpYW
X-Google-Smtp-Source: APiQypK2oxzMcVjMaAjUZbJ5UFJDdFif3UDI31S7agiTfM9mWKWx4JcocFJQv3QDpVm4tU98Irz77V3iVc9BvLbfoRX34BoYcQKZ
MIME-Version: 1.0
X-Received: by 2002:a5e:c804:: with SMTP id y4mr18439396iol.58.1587428111906;
 Mon, 20 Apr 2020 17:15:11 -0700 (PDT)
Date:   Mon, 20 Apr 2020 17:15:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b77ac905a3c1e81f@google.com>
Subject: KASAN: out-of-bounds Write in nested_sync_vmcs12_to_shadow
From:   syzbot <syzbot+6ad11779184a3afe9f7e@syzkaller.appspotmail.com>
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

HEAD commit:    9786cab6 Merge tag 'selinux-pr-20200416' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1110c920100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d351a1019ed81a2
dashboard link: https://syzkaller.appspot.com/bug?extid=6ad11779184a3afe9f7e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141f46abe00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b44c73e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11b44c73e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b44c73e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6ad11779184a3afe9f7e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in copy_vmcs12_to_enlightened arch/x86/kvm/vmx/nested.c:1820 [inline]
BUG: KASAN: out-of-bounds in nested_sync_vmcs12_to_shadow+0x49e3/0x4a60 arch/x86/kvm/vmx/nested.c:2000
Write of size 2 at addr ffffc90004db72e8 by task syz-executor.4/8294

CPU: 1 PID: 8294 Comm: syz-executor.4 Not tainted 5.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x315 mm/kasan/report.c:382
 __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 copy_vmcs12_to_enlightened arch/x86/kvm/vmx/nested.c:1820 [inline]
 nested_sync_vmcs12_to_shadow+0x49e3/0x4a60 arch/x86/kvm/vmx/nested.c:2000
 </IRQ>


Memory state around the buggy address:
 ffffc90004db7180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004db7200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90004db7280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                                                             ^
 ffffc90004db7300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004db7380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
