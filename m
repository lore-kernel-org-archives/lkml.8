Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6153C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbgF2Ul0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbgF2TOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:07 -0400
Received: from mail-il1-x148.google.com (mail-il1-x148.google.com [IPv6:2607:f8b0:4864:20::148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522FDC00875E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:51:11 -0700 (PDT)
Received: by mail-il1-x148.google.com with SMTP id x2so3261818ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ROvN58bMs+/Mdp+fmaywI8ZO468/VS7QI9MJ+inN3wQ=;
        b=iUUuEUDRWSAEw8y4cNzydW8zRhQJmUa5l7hq3Ip7aIkROJMzbq81w/SgRsVW6phih3
         hYuvgnJ5f/mWF61NfH2r7qmyjpmYdBMuxw/vyj0gGJWTCprRTz2WcC2sRrhOQWVD/W8p
         iSP6X5ddPiYsK5dV4Xe307aSnbPP9FiBh0tZzk6yO3j2Xh/CEvDXGCjRDT3mbSmBujDf
         YGJojdlde3JymJ8ZXpwnw7tjABFQiHjpWgCuoSlu1PwkcxZJ6Zp5HeQ8hXGyt+1YCIMh
         vk35+x4I3q05z1PWab4lJDQsXeGLmBAtyrKb5qnWGV2q8XzB/3AzRyEZVp+onaEZt0GM
         rWyw==
X-Gm-Message-State: AOAM533O6bLMrGOmkyFfFhRvzd2qevGjjn1+4oN4dXZZy2vHor16+RIx
        DdmQfM2qAXX/3AqmMks/huKI7tYEwcwQHG4f0Y8i9fZXMOle
X-Google-Smtp-Source: ABdhPJwWSIaP5qztCBfp4O0+tW449qcsNaqurETy0KKZrJmSIlXdLHj3Dsc1s8iJi2HSTJ4Jk4yrPZwR7aFDELFxt6eaBzHfdOWp
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2172:: with SMTP id p18mr17111736jak.63.1593420670562;
 Mon, 29 Jun 2020 01:51:10 -0700 (PDT)
Date:   Mon, 29 Jun 2020 01:51:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bf7b405a93529d8@google.com>
Subject: general protection fault in __apic_accept_irq (2)
From:   syzbot <syzbot+1bf777dfdde86d64b89b@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1024dead100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=1bf777dfdde86d64b89b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e542f9100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154c1c03100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1bf777dfdde86d64b89b@syzkaller.appspotmail.com

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
general protection fault, probably for non-canonical address 0xdffffc0000000013: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000098-0x000000000000009f]
CPU: 1 PID: 6780 Comm: syz-executor153 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__apic_accept_irq+0x46/0xb80 arch/x86/kvm/lapic.c:1039
Code: 4c 24 18 4c 89 4c 24 08 e8 67 0d 61 00 49 8d 87 98 00 00 00 48 89 c2 48 89 44 24 20 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 1b 0a 00 00 49 8b af 98 00 00 00 0f 1f 44 00 00
RSP: 0018:ffffc900015f79a8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888095b00040 RCX: 0000000000000000
RDX: 0000000000000013 RSI: ffffffff8112c159 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: fffff520002bef4c R12: 0000000000000000
R13: ffff8880a00b8e68 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001193880(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa6130226c0 CR3: 00000000a1257000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kvm_arch_async_page_present+0x7de/0x9e0 arch/x86/kvm/x86.c:10580
 kvm_check_async_pf_completion+0x18d/0x400 arch/x86/kvm/../../../virt/kvm/async_pf.c:151
 vcpu_enter_guest arch/x86/kvm/x86.c:8437 [inline]
 vcpu_run arch/x86/kvm/x86.c:8669 [inline]
 kvm_arch_vcpu_ioctl_run+0x18bf/0x69f0 arch/x86/kvm/x86.c:8890
 kvm_vcpu_ioctl+0x46a/0xe20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3163
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:771
 __do_sys_ioctl fs/ioctl.c:780 [inline]
 __se_sys_ioctl fs/ioctl.c:778 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:778
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x440299
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc336022f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440299
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401b20
R13: 0000000000401bb0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 85b25eaa183f3d19 ]---
RIP: 0010:__apic_accept_irq+0x46/0xb80 arch/x86/kvm/lapic.c:1039
Code: 4c 24 18 4c 89 4c 24 08 e8 67 0d 61 00 49 8d 87 98 00 00 00 48 89 c2 48 89 44 24 20 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 1b 0a 00 00 49 8b af 98 00 00 00 0f 1f 44 00 00
RSP: 0018:ffffc900015f79a8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888095b00040 RCX: 0000000000000000
RDX: 0000000000000013 RSI: ffffffff8112c159 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: fffff520002bef4c R12: 0000000000000000
R13: ffff8880a00b8e68 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001193880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560b8ba34fa8 CR3: 00000000a1257000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
