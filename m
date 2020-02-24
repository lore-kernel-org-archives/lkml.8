Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845C8C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E5220836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dO861vxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgBXTcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:32:33 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36635 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgBXTcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:32:33 -0500
Received: by mail-vs1-f66.google.com with SMTP id a2so6440294vso.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 11:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgL45fhULAGu5G+w7I1P5SZRJSZy9unRzGksGlG5Ac8=;
        b=dO861vxh0JbDJlF8dML1sOiyH1MDcmL4Zp5QNt6Au8+HWAMJbbaV0ys5arCMrYnV20
         NhcM3dZjvHefFpOcL62Wa+Y/yM88qqN2gQJpEH1ImycEmUcS3sV8Ex0m1hIFHGhZj5kl
         i9TCt5a5fmqkuzEuepliXC1g1Tf5c/0pgSzMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgL45fhULAGu5G+w7I1P5SZRJSZy9unRzGksGlG5Ac8=;
        b=cgxiQyBUPFw4yjJb0gwQRY7qZDePoLhXm5gasmYqjRArpXJxGrOIOgfz14Wl5lo5PK
         hdHRlpENB1cGtQwbLMDZaCBkN/kILLNLcB08a1AZpxIU3x2mdsvU9xCv7YtE07AbLvic
         JgpmRmQs3PCN8OeinmGv99B9doAnl8tOCxuokwywmLD63lNgOwBAu3VRciHzjeqZJAmj
         /kAXTfVyvDVK4Fc1iNhQPGoT85PxqsB+kmhyBFqusgOPGa+S/C7uGReSs+MLfk7k0tWD
         Xv6vIPCXuxz/Un0iAACSPNsTavRL3VDsixPqB1cFzshRJewV2vcVuAnuE/DzMyxZwERi
         fvEQ==
X-Gm-Message-State: APjAAAVE8ujqLL1liDOUS3H+VIO0QbuenGTM0Kcfj2dsyYoGie6EA5Vo
        +LR71PZp+Rp56dHZqudwB6N9gGKvyX9Gw1ERCNPt2g==
X-Google-Smtp-Source: APXvYqx1q97BlcOmkjgYEGVruOJfe4m4wnPFvEzBNmD79LKbHDZWVUv4ovG9D5w6eIpxyEBGpsJQag8+B15P7pmhy2c=
X-Received: by 2002:a67:fc8c:: with SMTP id x12mr25076429vsp.96.1582572751694;
 Mon, 24 Feb 2020 11:32:31 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000cce30059f4e27e9@google.com>
In-Reply-To: <0000000000000cce30059f4e27e9@google.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 24 Feb 2020 11:32:20 -0800
Message-ID: <CANFp7mWobejCpiq5xXouKAcRBSAbVwxKOnFbJ_XfiU6rLsT0Vw@mail.gmail.com>
Subject: Re: WARNING: refcount bug in l2cap_chan_put
To:     syzbot <syzbot+198362c76088d1515529@syzkaller.appspotmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resent in plain text; sorry for double send)

I took a brief look at this error and uncovered that 6lowpan uses zero
locks when using l2cap (should be using the channel lock).

It seems like it would be better just to convert its direct use of
l2cap channel into using an l2cap socket.

On Mon, Feb 24, 2020 at 12:28 AM syzbot
<syzbot+198362c76088d1515529@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    bee46b30 Add linux-next specific files for 20200221
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1244ea7ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=10693880b4976691
> dashboard link: https://syzkaller.appspot.com/bug?extid=198362c76088d1515529
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160a03d9e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f8e1dde00000
>
> Bisection is inconclusive: the bug happens on the oldest tested release.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f03a7ee00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=10083a7ee00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f03a7ee00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+198362c76088d1515529@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 1 PID: 2940 at lib/refcount.c:28 refcount_warn_saturate+0x1dc/0x1f0 lib/refcount.c:28
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 2940 Comm: kworker/1:12 Not tainted 5.6.0-rc2-next-20200221-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: events do_enable_set
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x197/0x210 lib/dump_stack.c:118
>  panic+0x2e3/0x75c kernel/panic.c:221
>  __warn.cold+0x2f/0x3e kernel/panic.c:582
>  report_bug+0x289/0x300 lib/bug.c:195
>  fixup_bug arch/x86/kernel/traps.c:175 [inline]
>  fixup_bug arch/x86/kernel/traps.c:170 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
>  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> RIP: 0010:refcount_warn_saturate+0x1dc/0x1f0 lib/refcount.c:28
> Code: e9 d8 fe ff ff 48 89 df e8 81 81 10 fe e9 85 fe ff ff e8 07 54 d1 fd 48 c7 c7 00 c8 91 88 c6 05 6b f6 fc 06 01 e8 23 74 a1 fd <0f> 0b e9 ac fe ff ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 55 48
> RSP: 0018:ffffc9000952fbd8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff815ee766 RDI: fffff520012a5f6d
> RBP: ffffc9000952fbe8 R08: ffff88809e82e600 R09: ffffed1015d26661
> R10: ffffed1015d26660 R11: ffff8880ae933307 R12: 0000000000000003
> R13: ffff888095b3f018 R14: dead000000000122 R15: ffffc9000952fc98
>  refcount_sub_and_test include/linux/refcount.h:261 [inline]
>  refcount_dec_and_test include/linux/refcount.h:281 [inline]
>  kref_put include/linux/kref.h:64 [inline]
>  l2cap_chan_put+0x1d9/0x240 net/bluetooth/l2cap_core.c:501
>  do_enable_set+0x54b/0x960 net/bluetooth/6lowpan.c:1075
>  process_one_work+0xa05/0x17a0 kernel/workqueue.c:2266
>  worker_thread+0x98/0xe40 kernel/workqueue.c:2412
>  kthread+0x361/0x430 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
