Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D189C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 12:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E359F20679
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 12:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579438354;
	bh=hkorFzS20Sg7Hls9B7ufciAKy2m5s8NGIxauhTm8x7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NGIkE8Cw3OB1PFeRvT3OsuiIvXNY+v6icrH5rmmROTVHo1sIcW309k4XpeE/gF5pB
	 r+lOT27n4h7ESU+1cfZKl4W8VT7FCWeaTS5Mwyq6iumpOf839j8Q68ZDeB+invG/we
	 4pBo6JcpIDLWFA2OsW4gl+n0I2fnJLn13OZ96S98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgASMwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 07:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgASMwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 07:52:32 -0500
Received: from localhost (lns-bzn-36-82-251-23-53.adsl.proxad.net [82.251.23.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EBB220679;
        Sun, 19 Jan 2020 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579438352;
        bh=hkorFzS20Sg7Hls9B7ufciAKy2m5s8NGIxauhTm8x7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyibJUneDPHPt4IAkmsbiNZhCMbz3X3X0GMANMp6poBat48Gup9EY3XF0k6lgP+0N
         i9my6pj2goY4q3Qx769id5jHHFLpMFLz5j8/YyCmRGHWtKcR5ORaQPBD528z8nHsRz
         QnyZzaUPGd4gebybjmKASENKy1FXO2ftTPQeWy2E=
Date:   Sun, 19 Jan 2020 13:52:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon Fong <simon.fongnt@gmail.com>
Cc:     abbotti@mev.co.uk, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, colin.king@canonical.com
Subject: Re: [PATCH 3/3] Staging: comedi: usbdux: cleanup long line and align
 it
Message-ID: <20200119125229.GA149325@kroah.com>
References: <20200119035243.7819-1-simon.fongnt@gmail.com>
 <20200119125024.GA149057@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119125024.GA149057@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 01:50:24PM +0100, Greg KH wrote:
> On Sun, Jan 19, 2020 at 11:52:43AM +0800, Simon Fong wrote:
> > Clean up long line and align it
> > 
> > Signed-off-by: Simon Fong <simon.fongnt@gmail.com>
> > ---
> >  drivers/staging/comedi/drivers/usbdux.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/comedi/drivers/usbdux.c b/drivers/staging/comedi/drivers/usbdux.c
> > index 0350f303d557..b9c0b1a1d86e 100644
> > --- a/drivers/staging/comedi/drivers/usbdux.c
> > +++ b/drivers/staging/comedi/drivers/usbdux.c
> > @@ -204,7 +204,8 @@ struct usbdux_private {
> >  	struct mutex mut;
> >  };
> >  
> > -static void usbdux_unlink_urbs(struct urb **urbs, int num_urbs)
> > +static void usbdux_unlink_urbs(struct urb **urbs,
> > +			       int num_urbs)
> 
> As Joe said, there is no reason to change this line that I can see, why
> do you want to do that?

Also, where are patches 1 and 2 of this 3 patch series?

thanks,

greg k-h
