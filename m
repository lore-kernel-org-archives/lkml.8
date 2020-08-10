Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77299C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 10:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563BE206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 10:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJGOQHyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgHJKWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 06:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHJKWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 06:22:04 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A21DC061786
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 03:22:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c12so6284741qtn.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 03:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Op1czpXG/VkE4BR4++qVQNjZiLSQTMRo6R7AHTASdP0=;
        b=JJGOQHyvNgs3/ynY3Ckiwqnqff1JKhr97aAKBQDYNgmSr2UTaiZuqybBZqWilYkoja
         hzf1wowM0PhDueHkzroY8QuG7S9mTbSPjoZi0FGNlYAVs0aBeLZeq191gdIQ2cjERuKf
         Yg4SdQztj+ZCf7Rn6KBtM07MK1wLH0QSWZ8V6DjJU0n1w4CSNm31KCNpZ5EtjUCjrbg4
         gKST470MH919qVXq9yz6eMbh41LpSK3NZmWIk8/ridmmduYO4lrqPevHRqUffvKMrDOp
         qDmSXvXgALAssUyzwVl/P444FMa5RDO380GVWYr9uJuo/vndQeKrZp6viWxiiy2cNvie
         TKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Op1czpXG/VkE4BR4++qVQNjZiLSQTMRo6R7AHTASdP0=;
        b=QKp3FTQaegblQKhj+tNEs9Emknow0scSGj6eEdcT6g65zs6XN3rp9ElIKkBCZPfjuf
         pXzfLOdGUjIZZsJubcbo42jtDUw66u6ZCtQ9OFMqSk6OZuPwHO1JfufnjUYrzcb9mB2r
         N3rgBPQqN4BuOTbmk9DZNgt7BTF2EGEqa8bwJ1YiA/LHz6NL/6JuqbT6S/QDPv4dM4+5
         litV6ViTGR7nCU1IMCdVuUlX52yU4qQWjJPtrNqo3dby4YQT9qh3RBEgshnRmJO1eKXb
         gUqwl2Y3t+tD54KHtE1ylay6vgBowsHL/D1Fi8qr6Pceqh6Ia9TNMr5MmWbPobXwWwgw
         n9dQ==
X-Gm-Message-State: AOAM5321PhObwStH1ZiyLM/RoZgDDaKiMIkF5s0Ejf032JfCp0xo7qAH
        NOHf8cClDzN+2I9YZs4afCrGhH5k//NWg2ZYt5DmKARmi78=
X-Google-Smtp-Source: ABdhPJx49Lc4wyd7DIxK2LmZzqUThk8AWhOM212xm0BTV8n65kH62iatnkAnJlP8eZEjwFyO+R3wW0JiwZutori/AEw=
X-Received: by 2002:ac8:480c:: with SMTP id g12mr26079296qtq.257.1597054920691;
 Mon, 10 Aug 2020 03:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ce85c405ac744ff6@google.com> <20200810074706.GD1529187@kroah.com>
 <CACT4Y+aS6oangE4BzhCfx3gs9guAW=zQpwN1LP+yB3kza68xFw@mail.gmail.com>
 <20200810090833.GA2271719@kroah.com> <20200810091538.GA2273701@kroah.com> <20200810095754.GA2404978@kroah.com>
In-Reply-To: <20200810095754.GA2404978@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 10 Aug 2020 12:21:49 +0200
Message-ID: <CACT4Y+badWwK8L3HjYrv2nu-W+WnUfj5Pi2JsLTUMU3o2tJL9g@mail.gmail.com>
Subject: Re: KMSAN: kernel-infoleak in raw_ioctl
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+a7e220df5a81d1ab400e@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>, balbi@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 10, 2020 at 11:15:38AM +0200, Greg KH wrote:
> > On Mon, Aug 10, 2020 at 11:08:33AM +0200, Greg KH wrote:
> > > On Mon, Aug 10, 2020 at 11:00:07AM +0200, Dmitry Vyukov wrote:
> > > > On Mon, Aug 10, 2020 at 9:46 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Sun, Aug 09, 2020 at 09:27:18AM -0700, syzbot wrote:
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    ce8056d1 wip: changed copy_from_user where instrumented
> > > > > > git tree:       https://github.com/google/kmsan.git master
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=141eb8b2900000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=a7e220df5a81d1ab400e
> > > > > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > > > > > userspace arch: i386
> > > > > >
> > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > The irony of a kernel module written for syzbot testing, causing syzbot
> > > > > reports....
> > > >
> > > > The raw gadget and KCOV are also kernel code and subject to all the
> > > > same rules as any other kernel code from syzkaller point of view.
> > > >
> > > > But I think the root cause of this bug is the origin of the uninitialized-ness:
> > > >
> > > > Local variable ----buf.i@asix_get_phy_addr created at:
> > > >  asix_read_cmd drivers/net/usb/asix_common.c:312 [inline]
> > > >  asix_read_phy_addr drivers/net/usb/asix_common.c:295 [inline]
> > > >  asix_get_phy_addr+0x4d/0x290 drivers/net/usb/asix_common.c:314
> > > >  asix_read_cmd drivers/net/usb/asix_common.c:312 [inline]
> > > >  asix_read_phy_addr drivers/net/usb/asix_common.c:295 [inline]
> > > >  asix_get_phy_addr+0x4d/0x290 drivers/net/usb/asix_common.c:314
> > >
> > > read buffers sent to USB hardware are ment to be filled in by the
> > > hardware with the data received from it, we do not zero-out those
> > > buffers before passing the pointer there.
> > >
> > > Perhaps with testing frameworks like the raw usb controller, that might
> > > cause a number of false-positives to happen?
> >
> > Ah, wait, that buffer is coming from the stack, which isn't allowed in
> > the first place :(
> >
> > So that should be changed anyway to a dynamic allocation, I'll go write
> > up a patch...
>
> Nope, my fault, the data is not coming from the stack, so all is good.

My reading of the code is that asix_read_cmd returns the number of
bytes actually read, which may be less than requested.
This happens in __usbnet_read_cmd:
https://elixir.bootlin.com/linux/latest/source/drivers/net/usb/usbnet.c#L2002
So this code in asix_read_phy_addr will need produce an uninit value
for result if <2 bytes read:

    u8 buf[2];
    int ret = asix_read_cmd(dev, AX_CMD_READ_PHY_ID, 0, 0, 2, buf, 0);
    if (ret < 0)
        netdev_err(dev->net, "Error reading PHYID register: %02x\n", ret);
    ret = buf[offset];
    return ret;

And it looks like all of 13 uses of asix_read_cmd in
drivers/net/usb/asix_common.c are subject to this bug as well.
