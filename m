Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B253BC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E142072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582532357;
	bh=UG25DR76Ubm+4It1jFHBHY9eXtM6lci9jA6RyXpUoKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DWEnTpHYLDX4pL2wBCG34boOJJcLv34Vr6BL8d6Oth1Uex0V4sLoZvQatiInI3IwB
	 wIOKlZ/rkWbaCAuvF1alXTgCY2O6Rzg4TiN13i2k3MT2JEnX4XGBzCx3zD3whv19qz
	 ZlIQImIvTgZ7Cm4NKuLLHTMEPUDuBSvPqOuvSru0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBXITQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:19:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBXITQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:19:16 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112FE20658;
        Mon, 24 Feb 2020 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582532355;
        bh=UG25DR76Ubm+4It1jFHBHY9eXtM6lci9jA6RyXpUoKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dDLyM1NxTxWqYDDCvpr7XSc8hlxvB05ruv9u3xgLz25YmB5SnhN95CiXSj72Q/QuP
         3Lib4QLAqYgNe/QsWpwBlF52oiQkbSTCa6JkF6o4saNTcA/wQQRnKj93F+6XK/o6Yu
         tw/Vkar+4YX3RHFFTMsdWo87KlNQEmwsbvTQJADk=
Date:   Mon, 24 Feb 2020 00:19:13 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual
 console
Message-ID: <20200224081913.GA299238@sol.localdomain>
References: <0000000000006663de0598d25ab1@google.com>
 <20200224071247.283098-1-ebiggers@kernel.org>
 <8fb00b38-abd0-6895-3ad2-85a6f05ee6cf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb00b38-abd0-6895-3ad2-85a6f05ee6cf@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:04:33AM +0100, Jiri Slaby wrote:
> > KASAN report:
> > 	BUG: KASAN: use-after-free in con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
> > 	Write of size 8 at addr ffff88806a4ec108 by task syz_vt/129
> > 
> > 	CPU: 0 PID: 129 Comm: syz_vt Not tainted 5.6.0-rc2 #11
> > 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
> > 	Call Trace:
> > 	 [...]
> > 	 con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
> > 	 release_tty+0xa8/0x410 drivers/tty/tty_io.c:1514
> > 	 tty_release_struct+0x34/0x50 drivers/tty/tty_io.c:1629
> > 	 tty_release+0x984/0xed0 drivers/tty/tty_io.c:1789
> > 	 [...]
> > 
> > 	Allocated by task 129:
> > 	 [...]
> > 	 kzalloc include/linux/slab.h:669 [inline]
> > 	 vc_allocate drivers/tty/vt/vt.c:1085 [inline]
> > 	 vc_allocate+0x1ac/0x680 drivers/tty/vt/vt.c:1066
> > 	 con_install+0x4d/0x3f0 drivers/tty/vt/vt.c:3229
> > 	 tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
> > 	 tty_init_dev+0x94/0x350 drivers/tty/tty_io.c:1341
> > 	 tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
> > 	 tty_open+0x3ca/0xb30 drivers/tty/tty_io.c:2035
> > 	 [...]
> > 
> > 	Freed by task 130:
> > 	 [...]
> > 	 kfree+0xbf/0x1e0 mm/slab.c:3757
> > 	 vt_disallocate drivers/tty/vt/vt_ioctl.c:300 [inline]
> > 	 vt_ioctl+0x16dc/0x1e30 drivers/tty/vt/vt_ioctl.c:818
> > 	 tty_ioctl+0x9db/0x11b0 drivers/tty/tty_io.c:2660
> 
> That means the associated tty_port is destroyed while the tty layer
> still has a tty on the top of it. That is a BUG anyway.
> 
> > Fixes: 4001d7b7fc27 ("vt: push down the tty lock so we can see what is left to tackle")
> > Cc: <stable@vger.kernel.org> # v3.4+
> > Reported-by: syzbot+522643ab5729b0421998@syzkaller.appspotmail.com
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  drivers/tty/vt/vt_ioctl.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> > index ee6c91ef1f6cf..57d681706fa85 100644
> > --- a/drivers/tty/vt/vt_ioctl.c
> > +++ b/drivers/tty/vt/vt_ioctl.c
> > @@ -42,7 +42,7 @@
> >  char vt_dont_switch;
> >  extern struct tty_driver *console_driver;
> >  
> > -#define VT_IS_IN_USE(i)	(console_driver->ttys[i] && console_driver->ttys[i]->count)
> > +#define VT_IS_IN_USE(i)	(console_driver->ttys[i] != NULL)
> >  #define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || vc_cons[i].d == sel_cons)
> >  
> >  /*
> > @@ -288,12 +288,14 @@ static int vt_disallocate(unsigned int vc_num)
> >  	struct vc_data *vc = NULL;
> >  	int ret = 0;
> >  
> > +	mutex_lock(&tty_mutex); /* synchronize with release_tty() */
> >  	console_lock();
> 
> Is this lock dependency new or pre-existing?

It's the same locking order used during release_tty().

> 
> Locking tty_mutex here does not sound quite right. What about switching
> vc_data to proper refcounting based on tty_port? (Instead of doing
> tty_port_destroy and kfree in vt_disallocate*.)
> 

How would that work?  We could make struct vc_data refcounted such that
VT_DISALLOCATE doesn't free it right away but rather it's freed in the next
con_shutdown().  But release_tty() still accesses tty->port afterwards, which is
part of the 'struct vc_data' that would have just been freed.

- Eric
