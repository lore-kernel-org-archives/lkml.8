Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA277C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B65A20810
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgFPTjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:39:15 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:32992 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgFPTjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:39:14 -0400
Received: by mail-il1-f197.google.com with SMTP id c11so15335541ilq.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 12:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xhWTXz6SmpEnhzfxWd+ix6TSZuz6ykxq9UiT0D4oYAs=;
        b=c0pyTyouSa81/h/wgHo0Lnl+tObQ0C4jncrvsB7Sbo1fC1WKsbXSyl2iy/z4NPTZuD
         StUQsRI7sEiz1RJSDaOkdEK+Nc0JLiKoFDHG5AUu7jdMDpC8ZIo0lxA5PkJh1FksKL1I
         7Yf/IUhPvuV0H7k+BnPQ1Ch5IsTivjk5T54BoCOb8UTk4zuqh14rg6wBfEBTEUpEbOrb
         mM+JHmyNvvCMPMDl8YDQIyJa/v0u7glDO9NhCPzX+a6UpWFbvRqyRNuEMp9qq5aYtlFD
         /PPc2oeyB2Pb9xyRyLhgv5OHdher3Dj85DqbfTRMZlgJHC2bCJIzJPWBxQEBdxhYw9FZ
         MfQg==
X-Gm-Message-State: AOAM532Q9+pvtQyBxN6iiwd6lTBLUmT4peuo0Rd3SP2G3GeVzWnqKe77
        hA2VFKHTPt3UFfHqfCkgpveWqkf70Hn3MzDX1kNxJdGtqWPC
X-Google-Smtp-Source: ABdhPJybcNcAP46lIRGqhcmL2DWu9VS8dbLVuupp560V+LfqLzVSt4u+Oi1giUa6whiX5ml9Qf1TlhPyzYCQlwGoOFEDK7jfloWj
MIME-Version: 1.0
X-Received: by 2002:a92:2907:: with SMTP id l7mr4878547ilg.48.1592336353676;
 Tue, 16 Jun 2020 12:39:13 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:39:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b953d805a838b240@google.com>
Subject: KASAN: user-memory-access Read in sync_vmcs02_to_vmcs12
From:   syzbot <syzbot+961278f56598a876c889@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=14f70989100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=961278f56598a876c889
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+961278f56598a876c889@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in vmcs12_guest_cr0 arch/x86/kvm/vmx/nested.c:3545 [inline]
BUG: KASAN: user-memory-access in sync_vmcs02_to_vmcs12+0x16fb/0x1a40 arch/x86/kvm/vmx/nested.c:3960
Read of size 18446744071694194346 at addr 0000000001617928 by task systemd-udevd/3877

CPU: 1 PID: 3877 Comm: systemd-udevd Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:517 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
 vmcs12_guest_cr0 arch/x86/kvm/vmx/nested.c:3545 [inline]
 sync_vmcs02_to_vmcs12+0x16fb/0x1a40 arch/x86/kvm/vmx/nested.c:3960
 </IRQ>
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 3877 Comm: systemd-udevd Tainted: G    B             5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 end_report+0x4d/0x53 mm/kasan/report.c:104
 __kasan_report mm/kasan/report.c:520 [inline]
 kasan_report.cold+0xd/0x37 mm/kasan/report.c:530
 vmcs12_guest_cr0 arch/x86/kvm/vmx/nested.c:3545 [inline]
 sync_vmcs02_to_vmcs12+0x16fb/0x1a40 arch/x86/kvm/vmx/nested.c:3960
 </IRQ>
Shutting down cpus with NMI
Kernel Offset: disabled


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
