Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7DFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DBA2076B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyNuaTsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHJORj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgHJORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:17:37 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B21CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:17:36 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p25so8441279qkp.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3++VDW9CFsksX2oCeztAkvfCJ7YATTDDH7DuF4MGyJQ=;
        b=dyNuaTscRCp4wBDLNz/Mruv3dtofts4bEpGRvKV/jCZAth4Mn+VC+W0vExNqTGHauZ
         leuHcVV5/cr6M/I2m20xTj0YCTcJWfIynjisVlsvzqC54Ejb1BX2cJXHMedQLDN433Q6
         W97KA5oqVwqNOSuPpf/z8QnHfGl8Tfk6RE/2CygSL8mdwguPwAhP5zpkFDghhEFxwdFT
         zNZoAZEaBFFKY0XzMZw+gU1v4yj76ammX6Pcy0Ny1iFvpCoCwlxoD7IEiwojPcWmf/fK
         xNpVUeNPKdzBgK2StUbyyjxRJ6QuQf0hYRK27QzcXx2kPCnZiw4JCRYsdbgN3KoQhw4t
         SbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3++VDW9CFsksX2oCeztAkvfCJ7YATTDDH7DuF4MGyJQ=;
        b=baUqVLhdrcSTRGwMlYMTmJLE8xSx6jzplAud30jP7tCRRvDqQukJOH68PM0c5d+yPd
         b2weRmhjvNuBmhCNwsp4MNPKPaoCuJ2NEgVd+ZNVEB/W2L6esl12Yj7eXMZnm36Odpn8
         G34YjFPZmNKTsb/C39Zbw1krWppTzGNWyjNVyLm1XfKUUH+gVnaq0AesMwQkj0cmAWcC
         QJzp98G3QqWQaXmPETRr+vSjRGNHXFPMcnZvS6ndxd03OpY29W9eZT/uq4/VLK/OAriS
         D6z3OI9vPy6QoLRIRDAVQq1eQukVuS/Fgce6ckBZO6/o2uEPnZvnYY2JHFM6B1UP0DKg
         YyLg==
X-Gm-Message-State: AOAM533CC9rSjMV6wI7eIhNZMZuvW4saeVAwIDgXM4wsU0XR6YRdlaXh
        e5BciB9kCuYpqrfjEVCY/eNTbAZArzHx1v6vi0OGCg==
X-Google-Smtp-Source: ABdhPJwOKbKK4/6wWw9jmPphWe7MUwI0KxmaNez7jEYi0uqr60dqPnsdZuy3ryr3K7PsV3eX+GTBj3b8Sken+dBZOcg=
X-Received: by 2002:a05:620a:21d2:: with SMTP id h18mr23412240qka.407.1597069055159;
 Mon, 10 Aug 2020 07:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ce85c405ac744ff6@google.com> <20200810074706.GD1529187@kroah.com>
 <CACT4Y+aS6oangE4BzhCfx3gs9guAW=zQpwN1LP+yB3kza68xFw@mail.gmail.com>
 <20200810090833.GA2271719@kroah.com> <20200810091538.GA2273701@kroah.com>
 <20200810095754.GA2404978@kroah.com> <CACT4Y+badWwK8L3HjYrv2nu-W+WnUfj5Pi2JsLTUMU3o2tJL9g@mail.gmail.com>
 <CAAeHK+wjkbuGenK+wwMPvU=jJ7JRQ14HsQhU3sWrsUQ2QK6RYQ@mail.gmail.com>
In-Reply-To: <CAAeHK+wjkbuGenK+wwMPvU=jJ7JRQ14HsQhU3sWrsUQ2QK6RYQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 10 Aug 2020 16:17:21 +0200
Message-ID: <CACT4Y+b5QZJ1yTzh9nFYRsqMa_SxD0sbteu_L+KRL8oV8CMPvQ@mail.gmail.com>
Subject: Re: KMSAN: kernel-infoleak in raw_ioctl
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        syzbot <syzbot+a7e220df5a81d1ab400e@syzkaller.appspotmail.com>,
        Felipe Balbi <balbi@kernel.org>,
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

On Mon, Aug 10, 2020 at 4:07 PM 'Andrey Konovalov' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
> > > On Mon, Aug 10, 2020 at 11:15:38AM +0200, Greg KH wrote:
> > > > On Mon, Aug 10, 2020 at 11:08:33AM +0200, Greg KH wrote:
> > > > > On Mon, Aug 10, 2020 at 11:00:07AM +0200, Dmitry Vyukov wrote:
> > > > > > On Mon, Aug 10, 2020 at 9:46 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Sun, Aug 09, 2020 at 09:27:18AM -0700, syzbot wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > syzbot found the following issue on:
> > > > > > > >
> > > > > > > > HEAD commit:    ce8056d1 wip: changed copy_from_user where instrumented
> > > > > > > > git tree:       https://github.com/google/kmsan.git master
> > > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=141eb8b2900000
> > > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
> > > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=a7e220df5a81d1ab400e
> > > > > > > > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > > > > > > > userspace arch: i386
> > > > > > > >
> > > > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > > >
> > > > > > > The irony of a kernel module written for syzbot testing, causing syzbot
> > > > > > > reports....
> > > > > >
> > > > > > The raw gadget and KCOV are also kernel code and subject to all the
> > > > > > same rules as any other kernel code from syzkaller point of view.
> > > > > >
> > > > > > But I think the root cause of this bug is the origin of the uninitialized-ness:
> > > > > >
> > > > > > Local variable ----buf.i@asix_get_phy_addr created at:
> > > > > >  asix_read_cmd drivers/net/usb/asix_common.c:312 [inline]
> > > > > >  asix_read_phy_addr drivers/net/usb/asix_common.c:295 [inline]
> > > > > >  asix_get_phy_addr+0x4d/0x290 drivers/net/usb/asix_common.c:314
> > > > > >  asix_read_cmd drivers/net/usb/asix_common.c:312 [inline]
> > > > > >  asix_read_phy_addr drivers/net/usb/asix_common.c:295 [inline]
> > > > > >  asix_get_phy_addr+0x4d/0x290 drivers/net/usb/asix_common.c:314
> > > > >
> > > > > read buffers sent to USB hardware are ment to be filled in by the
> > > > > hardware with the data received from it, we do not zero-out those
> > > > > buffers before passing the pointer there.
> > > > >
> > > > > Perhaps with testing frameworks like the raw usb controller, that might
> > > > > cause a number of false-positives to happen?
> > > >
> > > > Ah, wait, that buffer is coming from the stack, which isn't allowed in
> > > > the first place :(
> > > >
> > > > So that should be changed anyway to a dynamic allocation, I'll go write
> > > > up a patch...
> > >
> > > Nope, my fault, the data is not coming from the stack, so all is good.
> >
> > My reading of the code is that asix_read_cmd returns the number of
> > bytes actually read, which may be less than requested.
> > This happens in __usbnet_read_cmd:
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/usb/usbnet.c#L2002
> > So this code in asix_read_phy_addr will need produce an uninit value
> > for result if <2 bytes read:
> >
> >     u8 buf[2];
> >     int ret = asix_read_cmd(dev, AX_CMD_READ_PHY_ID, 0, 0, 2, buf, 0);
> >     if (ret < 0)
> >         netdev_err(dev->net, "Error reading PHYID register: %02x\n", ret);
> >     ret = buf[offset];
> >     return ret;
> >
> > And it looks like all of 13 uses of asix_read_cmd in
> > drivers/net/usb/asix_common.c are subject to this bug as well.
>
> Yeah, such issues are unfortunately currently getting attributed to
> raw-gadget. I wonder if we can improve crash parsing code to cover
> this kind of cases... We would need to skip the first few
> raw-gadget/USB-related stack traces, and only take one of the "Uninit
> was stored to memory at" ones.

Looking at some other reports in the past I considered if we should
attribute uninit's to the _origin_ stack rather than all places the
origin may end up being used. But I don't have quantitative data on if
it will improve quality overall or not. There are definitely cases
where it will be wrong as well -- in particular allocation of skb's in
sendmsg.
