Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614482080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593182850;
	bh=eMZncK8eiSRxgmFvB1YKwD/xSxVgTemsMnIedQb9Ih0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Imhb+0DrvN+xaIQ2qjzVPrHe+MplcJmi/zEYcGewNnIQIEG5istnIv3NmGAVlYNg
	 QgFBOZyVgNLjA0F8hZkOEGcKKWxX6azw+XthC4ldoJ/in0CJILOowDDF9J84kQr57a
	 5j+w4KTkJmyToUb5SGC+Nd07L4XOM/1jTe2ZlPIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgFZOr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbgFZOrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:47:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72E7B2053B;
        Fri, 26 Jun 2020 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593182842;
        bh=eMZncK8eiSRxgmFvB1YKwD/xSxVgTemsMnIedQb9Ih0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7zVpiO7xA2FIw9s2Y9fXIg1W1kqkRQm6qRWswguknf+BUEytKGJxeqgOpOmaAtSq
         gJyQWn7DUUN+ECerxBdtKvsW7bP61hbkmePT5VDaIR/WQcMai5/anJ6PrcWnPiWzkQ
         5eiwu/OKpXbweTTO5ABPvMtfb0P2x/aCVrUQv7vw=
Date:   Fri, 26 Jun 2020 16:47:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     B K Karthik <bkkarthik@pesu.pes.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: usbvision: removing prohibited space
 before ',' (ctx:WxW)
Message-ID: <20200626144718.GA1218319@kroah.com>
References: <20200626143205.xns6nwggskssujao@pesu-pes-edu>
 <a9efda13-4425-8cb0-5854-8421f6c14181@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9efda13-4425-8cb0-5854-8421f6c14181@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 04:36:52PM +0200, Hans Verkuil wrote:
> On 26/06/2020 16:32, B K Karthik wrote:
> > fixing ERROR: space prohibited before that ',' (ctx:WxW)
> > 
> > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> 
> usbvision is another driver that is scheduled for removal by the end of the year,
> so I won't apply this patch.
> 
> > ---
> >  drivers/staging/media/usbvision/usbvision-i2c.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/media/usbvision/usbvision-i2c.c b/drivers/staging/media/usbvision/usbvision-i2c.c
> > index 6e4df3335b1b..010ad03c6ec1 100644
> > --- a/drivers/staging/media/usbvision/usbvision-i2c.c
> > +++ b/drivers/staging/media/usbvision/usbvision-i2c.c
> > @@ -32,7 +32,7 @@ MODULE_PARM_DESC(i2c_debug, "enable debug messages [i2c]");
> >  #define PDEBUG(level, fmt, args...) { \
> >  		if (i2c_debug & (level)) \
> >  			printk(KERN_INFO KBUILD_MODNAME ":[%s:%d] " fmt, \
> > -				__func__, __LINE__ , ## args); \
> > +				__func__, __LINE__, ## args); \
> 
> Actually, older (buggy) gcc compiler needed a space there, if memory serves.

Yes, that will break on old versions of gcc.  crazy...

