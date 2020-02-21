Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1658CC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1928208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2K47Ys0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgBUSo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:44:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45615 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgBUSo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:44:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so1390762pgk.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nx0SaMtsGeq6ig/Wx6A2oBthvSaJ4xp1AmuNs+tweqU=;
        b=m2K47Ys0LJhq/M1i/fWqT6yZqvfGk081hU3QUnO2zKyZETpt190S6RTduyaLCiRjr4
         oJ0fsVQRGZQ9W+C3umC4gKSEjdkTr+zu+8QWsElqK6PVNL6wzirJe4Tm/t6APNLVJGmN
         7eW4j4fnUL4DtzGpmFoYVbW8Km1JkSr/s2dBZA1NKoFMRVYtVXQnqM3wZeyfj5XmT9Qu
         itQip4xkUd4OeeRmkEUOoncPTuPrg2A73mj1z71TTqsp0xu/UvsEXvBIjl/F/V/tE0P4
         rNYKCZlog7+N+sXVDW6oAXlFCS7OBo10pKQ217TlxqS1+NOn4Q4xKsqvxXQzsMEF6O/6
         NiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nx0SaMtsGeq6ig/Wx6A2oBthvSaJ4xp1AmuNs+tweqU=;
        b=PSdwQ2IYI0kW/xQocYTLxM2b/pctgL/onyJ78Y5ZRlxx+IgxDM1YaMrvVpJ8I18e8V
         fW50/PkyGw2MbGGTr0y4FUGevasBsErV0/U3nB0OqEOiwbP/MUycY2RWA/+aHT9WhGa9
         kCKJxSgahDdCl/JQfNBUuJk3/053fng5HRGsCpkyRMgj7P1+zykwqn8fXOj66xoySo7K
         37mEwVEF/Fc32eU/U+AM4z3sIkAWLTY4+x2Sc2GWwopTrX95Wq/0G7WneESZ6IsJjE+f
         yvZ3/j1uUcwLdtdm/uD+V5YXCMoWGWtOq9tZyiYD8txz6sSlL/OH4OM8pM5gxfcPTK9F
         w9Kg==
X-Gm-Message-State: APjAAAVrQfZsOYg+goLVFWlNkoGsFUbrTcwPAhIwk948GdNj9flEMXFJ
        pQnt+aFEL9MAz13t9rk6mHvg5NhAWlJSxq0geL2LtQ==
X-Google-Smtp-Source: APXvYqwirH1IZiYstbEIv32o/k3vcvAnZc0dbTFnVC41dUdDcNUlFFRadbc7dyELmchHiFatNIdYL31n90gsfjWmGBY=
X-Received: by 2002:a63:34e:: with SMTP id 75mr41083312pgd.286.1582310694322;
 Fri, 21 Feb 2020 10:44:54 -0800 (PST)
MIME-Version: 1.0
References: <000000000000058a87059f1882b9@google.com> <Pine.LNX.4.44L0.2002211138300.1488-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2002211138300.1488-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 21 Feb 2020 19:44:43 +0100
Message-ID: <CAAeHK+yGS+wj5ovxu5P2Wyc=hgcmwEgK8LJ62+_T25vv8JOaOA@mail.gmail.com>
Subject: Re: WARNING in dummy_free_request
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+55ae006e0a1feae5aeab@syzkaller.appspotmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 5:41 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, 21 Feb 2020, syzbot wrote:
>
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    7f0cd6c7 usb: gadget: add raw-gadget interface
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17b58e5ee00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f10b12ae04e03319
> > dashboard link: https://syzkaller.appspot.com/bug?extid=55ae006e0a1feae5aeab
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+55ae006e0a1feae5aeab@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 19332 at drivers/usb/gadget/udc/dummy_hcd.c:679 dummy_free_request+0x6c/0x80 drivers/usb/gadget/udc/dummy_hcd.c:679
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 1 PID: 19332 Comm: syz-executor.5 Not tainted 5.6.0-rc1-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0xef/0x16e lib/dump_stack.c:118
> >  panic+0x2aa/0x6e1 kernel/panic.c:221
> >  __warn.cold+0x2f/0x30 kernel/panic.c:582
> >  report_bug+0x27b/0x2f0 lib/bug.c:195
> >  fixup_bug arch/x86/kernel/traps.c:174 [inline]
> >  fixup_bug arch/x86/kernel/traps.c:169 [inline]
> >  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
> >  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
> >  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> > RIP: 0010:dummy_free_request+0x6c/0x80 drivers/usb/gadget/udc/dummy_hcd.c:679
> > Code: c5 75 22 e8 26 06 96 fd 48 89 ef e8 3e 54 be fd 5b 5d e9 17 06 96 fd e8 12 06 96 fd 0f 0b 5b 5d e9 09 06 96 fd e8 04 06 96 fd <0f> 0b eb d5 48 89 ef e8 08 ae be fd eb c2 66 0f 1f 44 00 00 41 56
> > RSP: 0018:ffff8881c9eafdd8 EFLAGS: 00010016
> > RAX: 0000000000040000 RBX: ffff8881d0d5aa10 RCX: ffffc900012a0000
> > RDX: 000000000000012f RSI: ffffffff83a95c1c RDI: ffff8881d4d501c8
> > RBP: ffff8881d0d5aa00 R08: ffff8881d0f9b100 R09: ffffed103b666a84
> > R10: ffffed103b666a83 R11: ffff8881db33541b R12: 0000000000000212
> > R13: ffff8881ca832008 R14: 0000000000000000 R15: ffff8881ca832180
> >  raw_ioctl_ep_disable drivers/usb/gadget/legacy/raw_gadget.c:814 [inline]
> >  raw_ioctl+0x1281/0x19e0 drivers/usb/gadget/legacy/raw_gadget.c:1031
>
> Andrey:
>
> This could be a bug in your raw_gadget driver.  This particular WARN is
> triggered when a gadget driver tries to call usb_ep_free_request() for
> a request that is still in flight.

Hi Alan,

It might. It's not obvious what's wrong though. raw_ioctl_ep_disable()
calls usb_ep_disable()->dummy_disable() first, that supposedly does
list_del_init(&req->queue). And then it calls
usb_ep_free_request()->dummy_free_request(), which for some reason
still causes the warning. And a racy queueing of another request
should be prevented by the disabling flag.

I'll take a closer look on Monday.

Thanks!
