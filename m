Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DAAC38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB5D21744
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWDft4bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgDTSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgDTSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:12:52 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A568C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:12:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n143so4939354qkn.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApN8wmrq6iDqYYI4CJMTNrRAj1G1KRWZLBPqVxRqFLw=;
        b=PWDft4bzENX3CPDcyQ/HP7tqGBUmAXBgqGH4DMGg2irFP1qxcyjE+DDxX5eykC9s6S
         zMqWUD0lGA/SrrHmzE9yP9mUYkZgwbaNgQB8YQ+oJOwXWBHvihr6pnv1Go5PUoGgJUdh
         k7Pn8+9pv+DD7CgXVn+zV8NAzbA1RJqH36BvtE8hLrE5xfXWH0yfnyLjSsO/zAo3pedk
         Rd8/Ga43wGDf6hq8fcW/KFdm7ZhnJ0LjPKCcgQr3x/vUR4d0R2DHBKAOi2vxQGSk7zBi
         b7XRcT71lwIaUet8+dnngR/CKc3p/pqTj1Z7p8Y0j+WxzZbEyDezb0kQnYP5tftENfLa
         gVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApN8wmrq6iDqYYI4CJMTNrRAj1G1KRWZLBPqVxRqFLw=;
        b=sIV1ukkyYKd/ZC9AxmXJl01wxxP9ttJzdSh8KZRts2JvA0ksj8EUMyAs+ahVIBoE5e
         phVgiYuU4qJVUN2UDg/wXvhHVC35hz6s7WDSvb9gPfkmCB8xXZJZTs3LxD4ZpjTs75Dn
         2yetbROWxgDsxmB0/16oiLBXBw/PqoPOc85B9PB2mjG26b6MnhKGblVG9Pfs9qeoxVz1
         Vsk6cKO7KFoPaWDvCZwiz6x4CWLM8QPhq5zdtRtPA+8TEIy6QTWSlVmZSmiJLTZIIX25
         T77C/jOV0slYI0fr2+C2lP6JaFETBtJnI8DJvfOPq+mxekOAllwH5qv33n3bMie+/YHa
         YPAg==
X-Gm-Message-State: AGi0Pub2EnUSErjbS6xfLfBsgbaX5PDgXtRM7ekSzRlYEQnNetSR2Jgx
        XY0TUJBfibsNiQP+YeB29VKTE7WDrEm963dKH6dLUIk1kcc=
X-Google-Smtp-Source: APiQypLEhPySgD+zorc2IAkZBKw/mx4BbugsqsqOezviihtUZsnrO5kfZvs2/jHrfYj0W7bqQ6US9UAVlnGGotWL3vw=
X-Received: by 2002:a05:620a:307:: with SMTP id s7mr15579555qkm.407.1587406370992;
 Mon, 20 Apr 2020 11:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000064f6e505a3b243aa@google.com> <CAHC9VhTZ_itetT4cx32vW3A79tb76dzjaBC_0S8Y_=DcEBL2nw@mail.gmail.com>
In-Reply-To: <CAHC9VhTZ_itetT4cx32vW3A79tb76dzjaBC_0S8Y_=DcEBL2nw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Apr 2020 20:12:39 +0200
Message-ID: <CACT4Y+ZUpH3giZmiA51NZ1BhHOoGETqfxscBW6kBxWDf6-Q-HA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in audit_log_vformat (2)
To:     Paul Moore <paul@paul-moore.com>
Cc:     syzbot <syzbot+49e69b4d71a420ceda3e@syzkaller.appspotmail.com>,
        Eric Paris <eparis@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        linux-audit@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 6:29 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Apr 20, 2020 at 1:35 AM syzbot
> <syzbot+49e69b4d71a420ceda3e@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    5356842d [EXPERIMENTAL] kmsan: eagerly allocate shadow at ..
> > git tree:       https://github.com/google/kmsan.git master
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12f06720100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a5915107b3106aaa
> > dashboard link: https://syzkaller.appspot.com/bug?extid=49e69b4d71a420ceda3e
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > userspace arch: i386
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133b5dabe00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143e1610100000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+49e69b4d71a420ceda3e@syzkaller.appspotmail.com
> >
> > =====================================================
> > BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:608 [inline]
> > BUG: KMSAN: uninit-value in string+0x522/0x690 lib/vsprintf.c:689
> > CPU: 1 PID: 8854 Comm: syz-executor694 Not tainted 5.6.0-rc7-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1c9/0x220 lib/dump_stack.c:118
> >  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
> >  __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
> >  string_nocheck lib/vsprintf.c:608 [inline]
> >  string+0x522/0x690 lib/vsprintf.c:689
> >  vsnprintf+0x207d/0x31b0 lib/vsprintf.c:2574
>
> Are there any ongoing problems with [vsn]printf() in the kernel at the
> moment with syzbot?
>
> I ask because on first look I'm not seeing any obvious problems in the
> audit portion of this code path.

None I am aware of. Alex?
Can it be related to data_len==0? I don't see any obvious checks for
this. And in that case will 0-terminate out-of-bounds (at offset -1?)
and print potentially uninit data. But I looked at the code only very
briefly so potentially I am totally wrong.

> >  audit_log_vformat+0x583/0xcd0 kernel/audit.c:1858
> >  audit_log_format+0x220/0x260 kernel/audit.c:1892
> >  audit_receive_msg kernel/audit.c:1344 [inline]
> >  audit_receive+0x18a4/0x6d50 kernel/audit.c:1515
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
> >  netlink_unicast+0xf9e/0x1100 net/netlink/af_netlink.c:1329
> >  netlink_sendmsg+0x1246/0x14d0 net/netlink/af_netlink.c:1918
> >  sock_sendmsg_nosec net/socket.c:652 [inline]
> >  sock_sendmsg net/socket.c:672 [inline]
> >  ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2345
> >  ___sys_sendmsg net/socket.c:2399 [inline]
> >  __sys_sendmsg+0x451/0x5f0 net/socket.c:2432
> >  __compat_sys_sendmsg net/compat.c:642 [inline]
> >  __do_compat_sys_sendmsg net/compat.c:649 [inline]
> >  __se_compat_sys_sendmsg net/compat.c:646 [inline]
> >  __ia32_compat_sys_sendmsg+0xed/0x130 net/compat.c:646
> >  do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
> >  do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
> >  entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
> > RIP: 0023:0xf7fa0d99
> > Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> > RSP: 002b:00000000ffb27c7c EFLAGS: 00000246 ORIG_RAX: 0000000000000172
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000200002c0
> > RDX: 0000000000000000 RSI: 00000000080ea078 RDI: 00000000ffb27cd0
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >
> > Uninit was created at:
> >  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
> >  kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
> >  kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
> >  slab_alloc_node mm/slub.c:2801 [inline]
> >  __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4420
> >  __kmalloc_reserve net/core/skbuff.c:142 [inline]
> >  __alloc_skb+0x2fd/0xac0 net/core/skbuff.c:210
> >  alloc_skb include/linux/skbuff.h:1081 [inline]
> >  netlink_alloc_large_skb net/netlink/af_netlink.c:1175 [inline]
> >  netlink_sendmsg+0x7d3/0x14d0 net/netlink/af_netlink.c:1893
> >  sock_sendmsg_nosec net/socket.c:652 [inline]
> >  sock_sendmsg net/socket.c:672 [inline]
> >  ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2345
> >  ___sys_sendmsg net/socket.c:2399 [inline]
> >  __sys_sendmsg+0x451/0x5f0 net/socket.c:2432
> >  __compat_sys_sendmsg net/compat.c:642 [inline]
> >  __do_compat_sys_sendmsg net/compat.c:649 [inline]
> >  __se_compat_sys_sendmsg net/compat.c:646 [inline]
> >  __ia32_compat_sys_sendmsg+0xed/0x130 net/compat.c:646
> >  do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
> >  do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
> >  entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
> > =====================================================
>
> --
> paul moore
> www.paul-moore.com
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAHC9VhTZ_itetT4cx32vW3A79tb76dzjaBC_0S8Y_%3DDcEBL2nw%40mail.gmail.com.
