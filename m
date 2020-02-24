Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81913C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573A720836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJmbsmwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBXQOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:14:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39692 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgBXQOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:14:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so4240314plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNCPDhY2rBi3SKiGAc64x5UFQgTRx5e56yo7dkev/24=;
        b=sJmbsmwR6bcWllqxgVn8BygS5XA3EAIPcJNmFUi4aLASR48L3gS37YAJa9jF1vytX9
         OCz/nm3XPUlz/n3DALojC2+gw/TM6lUuQJ/qObnvHaiylbmkEENUg3vvvjslVka9aeeN
         FDoGZgMzPDaoIRbZxt0KK+M8YjFTBIStk+b+42cyMnSPHEeftqPlqBMGiX1IBbTwoxwy
         QAYUe7cKpHc5odKqaJ28LkMk0CisrmO8PAxU/do7mAfOnBZT2p72DSdeQqbkrS2frH3U
         S1I+RCw/WlxAg73158fyqFbzBYwzL1Bkt4v183osjbcgOMux4R0Tn3jolfbtIsL1B18k
         orTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNCPDhY2rBi3SKiGAc64x5UFQgTRx5e56yo7dkev/24=;
        b=p9/0vYFkSzbujHNBwbljzmPDWufhsOBWMX6scwsJCq19WrQvVxknToGtTQ5d8iDx5Z
         FIJkBKsyUZLrObyvFf/G09zTt4f26q1veAHgSoPCC8q3VlzeBXg72hV7+YZ6srVP7bIL
         uKt9LV/8wQ217JBXvHKpy1MgM1F3WshB4Rljd4ThmuhHEXuz1Xx6i3Scg8fNTi5jUrqG
         hYLra1gl9w1qKFhBJaqy316OpdNJ0aIDp5UjB5eDblOADk3ikFuot3pWgl8glSHRAINb
         HWUuZGItko6QOi421fMqXUPypQXL0vMjaKcFojstTZunaEjD0FYmugdOY+7gGPtl+lne
         yUsQ==
X-Gm-Message-State: APjAAAXhtAeoM5xba1Itdj7tu8rQ1BwDq9S5zboqhnc6b/PARDq/SvCb
        /ON2YyGQlfcra+Ez7HcqFlafkJSS5+J9s1e2ePqwcQ==
X-Google-Smtp-Source: APXvYqwEO19ym1rQgbvAzn0qCjC/bIx9lh8iZOfduzyeDaY/Z2z0u8K18I3iutG4FujiM2k8vObhxg8pTrzBn9i5TMY=
X-Received: by 2002:a17:902:8486:: with SMTP id c6mr52636096plo.147.1582560878971;
 Mon, 24 Feb 2020 08:14:38 -0800 (PST)
MIME-Version: 1.0
References: <000000000000058a87059f1882b9@google.com> <Pine.LNX.4.44L0.2002211138300.1488-100000@iolanthe.rowland.org>
 <CAAeHK+yGS+wj5ovxu5P2Wyc=hgcmwEgK8LJ62+_T25vv8JOaOA@mail.gmail.com> <CAAeHK+wdVKrmQq1aDqJALMmCUAWfDuz4LT0pm4cYJpH_MfSO+w@mail.gmail.com>
In-Reply-To: <CAAeHK+wdVKrmQq1aDqJALMmCUAWfDuz4LT0pm4cYJpH_MfSO+w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 24 Feb 2020 17:14:28 +0100
Message-ID: <CAAeHK+zMNKSUo4PoJLRaHcGRx66890HBkSET_NA5o8rwcTbZag@mail.gmail.com>
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

On Mon, Feb 24, 2020 at 4:48 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Fri, Feb 21, 2020 at 7:44 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Fri, Feb 21, 2020 at 5:41 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Fri, 21 Feb 2020, syzbot wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    7f0cd6c7 usb: gadget: add raw-gadget interface
> > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=17b58e5ee00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f10b12ae04e03319
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=55ae006e0a1feae5aeab
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > >
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+55ae006e0a1feae5aeab@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 1 PID: 19332 at drivers/usb/gadget/udc/dummy_hcd.c:679 dummy_free_request+0x6c/0x80 drivers/usb/gadget/udc/dummy_hcd.c:679
> > > > Kernel panic - not syncing: panic_on_warn set ...
> > > > CPU: 1 PID: 19332 Comm: syz-executor.5 Not tainted 5.6.0-rc1-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > Call Trace:
> > > >  __dump_stack lib/dump_stack.c:77 [inline]
> > > >  dump_stack+0xef/0x16e lib/dump_stack.c:118
> > > >  panic+0x2aa/0x6e1 kernel/panic.c:221
> > > >  __warn.cold+0x2f/0x30 kernel/panic.c:582
> > > >  report_bug+0x27b/0x2f0 lib/bug.c:195
> > > >  fixup_bug arch/x86/kernel/traps.c:174 [inline]
> > > >  fixup_bug arch/x86/kernel/traps.c:169 [inline]
> > > >  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
> > > >  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
> > > >  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> > > > RIP: 0010:dummy_free_request+0x6c/0x80 drivers/usb/gadget/udc/dummy_hcd.c:679
> > > > Code: c5 75 22 e8 26 06 96 fd 48 89 ef e8 3e 54 be fd 5b 5d e9 17 06 96 fd e8 12 06 96 fd 0f 0b 5b 5d e9 09 06 96 fd e8 04 06 96 fd <0f> 0b eb d5 48 89 ef e8 08 ae be fd eb c2 66 0f 1f 44 00 00 41 56
> > > > RSP: 0018:ffff8881c9eafdd8 EFLAGS: 00010016
> > > > RAX: 0000000000040000 RBX: ffff8881d0d5aa10 RCX: ffffc900012a0000
> > > > RDX: 000000000000012f RSI: ffffffff83a95c1c RDI: ffff8881d4d501c8
> > > > RBP: ffff8881d0d5aa00 R08: ffff8881d0f9b100 R09: ffffed103b666a84
> > > > R10: ffffed103b666a83 R11: ffff8881db33541b R12: 0000000000000212
> > > > R13: ffff8881ca832008 R14: 0000000000000000 R15: ffff8881ca832180
> > > >  raw_ioctl_ep_disable drivers/usb/gadget/legacy/raw_gadget.c:814 [inline]
> > > >  raw_ioctl+0x1281/0x19e0 drivers/usb/gadget/legacy/raw_gadget.c:1031
> > >
> > > Andrey:
> > >
> > > This could be a bug in your raw_gadget driver.  This particular WARN is
> > > triggered when a gadget driver tries to call usb_ep_free_request() for
> > > a request that is still in flight.
> >
> > Hi Alan,
> >
> > It might. It's not obvious what's wrong though. raw_ioctl_ep_disable()
> > calls usb_ep_disable()->dummy_disable() first, that supposedly does
> > list_del_init(&req->queue). And then it calls
> > usb_ep_free_request()->dummy_free_request(), which for some reason
> > still causes the warning. And a racy queueing of another request
> > should be prevented by the disabling flag.
> >
> > I'll take a closer look on Monday.
>
> OK, I see the issue, will post v6 with a fix soon.

#syz invalid
