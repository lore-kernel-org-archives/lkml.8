Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37761C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136AD20729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597057592;
	bh=iCudXyjdYzGdwBeDT9k0njKXIiJW45q0BJa7WH0s4Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tFWXf3VnkjdH5fYkjoOwkzQadH0kE7U1IKigqYiNauNdau/n1vk8VhStNmwjgAqw7
	 xLLcYopiBJ22fZrxG9KscuP6tWsls+LTLFQhufBQ3S/XTVpOwVVQSLBKRZ8IWhp0kk
	 sxoxgQ05cs6oxUqK6Lky5u2Rorb3G///Kbm7UEj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgHJLG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgHJLGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:06:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C15220729;
        Mon, 10 Aug 2020 11:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597057565;
        bh=iCudXyjdYzGdwBeDT9k0njKXIiJW45q0BJa7WH0s4Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6eT13jgvH1KgFLo4PP1uO1yglBPMk1iFWkVhMmoCHpwDj4kJa4iMoRswlSbq2sWc
         w1/S1CEcrlWQeDm71kCfbONmR0+vnJRdeekSbtJuk3aVYyX2PMBiLI6WDLVt36BaqQ
         GKyQkCR0P03BgDtUGLKl+Qr1ish6QyANqXtgnqac=
Date:   Mon, 10 Aug 2020 13:06:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+a7e220df5a81d1ab400e@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>, balbi@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KMSAN: kernel-infoleak in raw_ioctl
Message-ID: <20200810110616.GA2415197@kroah.com>
References: <000000000000ce85c405ac744ff6@google.com>
 <20200810074706.GD1529187@kroah.com>
 <CACT4Y+aS6oangE4BzhCfx3gs9guAW=zQpwN1LP+yB3kza68xFw@mail.gmail.com>
 <20200810090833.GA2271719@kroah.com>
 <20200810091538.GA2273701@kroah.com>
 <20200810095754.GA2404978@kroah.com>
 <CACT4Y+badWwK8L3HjYrv2nu-W+WnUfj5Pi2JsLTUMU3o2tJL9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+badWwK8L3HjYrv2nu-W+WnUfj5Pi2JsLTUMU3o2tJL9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 12:21:49PM +0200, Dmitry Vyukov wrote:
> On Mon, Aug 10, 2020 at 11:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 10, 2020 at 11:15:38AM +0200, Greg KH wrote:
> > > On Mon, Aug 10, 2020 at 11:08:33AM +0200, Greg KH wrote:
> > > > On Mon, Aug 10, 2020 at 11:00:07AM +0200, Dmitry Vyukov wrote:
> > > > > On Mon, Aug 10, 2020 at 9:46 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Sun, Aug 09, 2020 at 09:27:18AM -0700, syzbot wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > syzbot found the following issue on:
> > > > > > >
> > > > > > > HEAD commit:    ce8056d1 wip: changed copy_from_user where instrumented
> > > > > > > git tree:       https://github.com/google/kmsan.git master
> > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=141eb8b2900000
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=a7e220df5a81d1ab400e
> > > > > > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > > > > > > userspace arch: i386
> > > > > > >
> > > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > >
> > > > > > The irony of a kernel module written for syzbot testing, causing syzbot
> > > > > > reports....
> > > > >
> > > > > The raw gadget and KCOV are also kernel code and subject to all the
> > > > > same rules as any other kernel code from syzkaller point of view.
> > > > >
> > > > > But I think the root cause of this bug is the origin of the uninitialized-ness:
> > > > >
> > > > > Local variable ----buf.i@asix_get_phy_addr created at:
> > > > >  asix_read_cmd drivers/net/usb/asix_common.c:312 [inline]
> > > > >  asix_read_phy_addr drivers/net/usb/asix_common.c:295 [inline]
> > > > >  asix_get_phy_addr+0x4d/0x290 drivers/net/usb/asix_common.c:314
> > > > >  asix_read_cmd drivers/net/usb/asix_common.c:312 [inline]
> > > > >  asix_read_phy_addr drivers/net/usb/asix_common.c:295 [inline]
> > > > >  asix_get_phy_addr+0x4d/0x290 drivers/net/usb/asix_common.c:314
> > > >
> > > > read buffers sent to USB hardware are ment to be filled in by the
> > > > hardware with the data received from it, we do not zero-out those
> > > > buffers before passing the pointer there.
> > > >
> > > > Perhaps with testing frameworks like the raw usb controller, that might
> > > > cause a number of false-positives to happen?
> > >
> > > Ah, wait, that buffer is coming from the stack, which isn't allowed in
> > > the first place :(
> > >
> > > So that should be changed anyway to a dynamic allocation, I'll go write
> > > up a patch...
> >
> > Nope, my fault, the data is not coming from the stack, so all is good.
> 
> My reading of the code is that asix_read_cmd returns the number of
> bytes actually read, which may be less than requested.
> This happens in __usbnet_read_cmd:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/usb/usbnet.c#L2002
> So this code in asix_read_phy_addr will need produce an uninit value
> for result if <2 bytes read:
> 
>     u8 buf[2];
>     int ret = asix_read_cmd(dev, AX_CMD_READ_PHY_ID, 0, 0, 2, buf, 0);
>     if (ret < 0)
>         netdev_err(dev->net, "Error reading PHYID register: %02x\n", ret);
>     ret = buf[offset];
>     return ret;
> 
> And it looks like all of 13 uses of asix_read_cmd in
> drivers/net/usb/asix_common.c are subject to this bug as well.

Ah, yeah, and no one checks error values either, there's even a TODO
statement in the driver about that :(

Good catch, I'll point some interns at this and see if they can fix it
up, thanks!

greg k-h
