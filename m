Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CE2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E7A22525
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579623903;
	bh=ApLdmg+pAobH5jvwP927zb6tG46YhJdCkCHtaNFvwvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=scMvq9v4rdBIP1tJ4a2L0SM/OFUTdV5G82Tuy9O7R4IlvE2HbcQxTdqHuZY7LoxCX
	 t+zNQN9RPSHOl2sOBQAhxe5PAWFxb6Q3KOVSA6g7RerWhmPk7JLXxNuTj45fWO9h1y
	 LWqvsITIA5eM1JlSAdbdD2A25CmyyfpKaI+xPWtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgAUQZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:25:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgAUQZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:25:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3421C206A2;
        Tue, 21 Jan 2020 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579623901;
        bh=ApLdmg+pAobH5jvwP927zb6tG46YhJdCkCHtaNFvwvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGrITbR7uVApg1jMZMOd6ydm3qz2sO0s0TavAd+L25+/U7RQLQjpBAcYwBhrsHQiU
         DtukFV2kCW0WDHFJMd/T+0U1a/5kBh4oQ85QNQelaqFfuQke+aJbMfaNQ/cLHYA/6Y
         j9q7H+0dJXD8ZsDjfQQRVHosx9Uh4mnNj+s8P47Q=
Date:   Tue, 21 Jan 2020 17:24:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Harald Welte <laforge@gnumonks.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcmcia/cm4000: remove useless variable tmp
Message-ID: <20200121162459.GA592268@kroah.com>
References: <1579596599-258299-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAK8P3a0LJETeKbQvs-EeQ1cF84gVO3JS75SOZYD0F+puWhi9=w@mail.gmail.com>
 <37f03cf9-5666-7561-13f6-2ff72e936b7a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37f03cf9-5666-7561-13f6-2ff72e936b7a@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 05:53:53PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/1/21 下午5:08, Arnd Bergmann 写道:
> > On Tue, Jan 21, 2020 at 9:50 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
> >>
> >> No one care the value of 'tmp' in func cmm_write. better to remove it.
> > 
> > Hi Alex,
> > 
> >> @@ -1146,7 +1145,7 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
> >>         set_cardparameter(dev);
> >>
> >>         /* dummy read, reset flag procedure received */
> >> -       tmp = inb(REG_FLAGS1(iobase));
> >> +       inb(REG_FLAGS1(iobase));
> > 
> > I think this may cause warnings on some architectures, when inb() is a macro
> > that just turns into a pointer dereference. You could write it as
> > 
> >      (void)inb(REG_FLAGS1(iobase));
> > 
> > which would not warn anywhere.
> > 
> >       Arnd
> > 
> 
> Thanks a lot Arnd!
> 
> 
> >From 9e54770c6911ae7da7d2f74774bbef019e459bc9 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Fri, 17 Jan 2020 09:10:47 +0800
> Subject: [PATCH v2] pcmcia/cm4000: remove useless variable tmp
> 
> No one care the value of 'tmp' in func cmm_write. better to remove it.
> 
> Arnd Bergmann pointed just remove may cause warning in some arch where 
> inb is macro, and suggest add a cast '(void)' for this. Thanks!
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Harald Welte <laforge@gnumonks.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/char/pcmcia/cm4000_cs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
> index 15bf585af5d3..0f55bed6c71f 100644
> --- a/drivers/char/pcmcia/cm4000_cs.c
> +++ b/drivers/char/pcmcia/cm4000_cs.c
> @@ -1048,7 +1048,6 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
>  	struct cm4000_dev *dev = filp->private_data;
>  	unsigned int iobase = dev->p_dev->resource[0]->start;
>  	unsigned short s;
> -	unsigned char tmp;
>  	unsigned char infolen;
>  	unsigned char sendT0;
>  	unsigned short nsend;
> @@ -1146,7 +1145,7 @@ static ssize_t cmm_write(struct file *filp, const char __user *buf,
>  	set_cardparameter(dev);
>  
>  	/* dummy read, reset flag procedure received */
> -	tmp = inb(REG_FLAGS1(iobase));
> +	(void)inb(REG_FLAGS1(iobase));

That's horrid, just keep tmp :)

