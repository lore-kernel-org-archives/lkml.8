Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F04C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E408C20728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYjyhUXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgD0Ib2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0Ib2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:31:28 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99FAC061A0F;
        Mon, 27 Apr 2020 01:31:27 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l3so12796005edq.13;
        Mon, 27 Apr 2020 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WPH5/Zlcqqn9jGHb2A/nk7Bqq0SDpzjFGzAMIfPBowQ=;
        b=mYjyhUXFbxEIMXtgY0vSdYqGUr1EbrvFAIQjTkRr1ALQCGiJvo7s6Bcx4m7NS1IwuB
         uRh/LzJNgY89RlGpRkq+u4mZ6jAvNtGW9rvhAlMDK3pc9dV/b6ruLFaZ32gGsPz3MxFY
         wqhIUEWUwN2ZJ39Y+PYE54BQ1WqmIju37doUrpO/SbUQ0rFO+isDIsgqPacYITyRlk6P
         q2YqHEwIEN3LW8d63Y7TiHgP9P/+RcvcDrhT7bqOzXh378wDK453x8L5j5WZSoqUFOm2
         tzy/rl/kc4V5G7mwbCb2r/fM2uaaK5t8GQGRJw1QXwmNNHKn6b+StnGdM6EPaG4AkJQn
         mwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WPH5/Zlcqqn9jGHb2A/nk7Bqq0SDpzjFGzAMIfPBowQ=;
        b=H6cOZ4FPmRRBTEvIrAZyGTmL+vIPs6IU+z3tjKPpUMZfsZVa/cbv0AcpUtdKr0nVmH
         OVpkO1H6xdn2YfrVrq2GJucSmnZ3sV6FuLDTdBxfNDUUi4zytXMiG066996EHR/7Pbws
         sO3Udek75q2mUXyAmfsh4oYLgpDNIdMPNbUoI08KRJK4XjagH8DHK++rNz5jQpwrah7D
         E9z/SLNQGAloo3Hg+wrrfkVb51UTCYr4GUsLn21cw64f5zXv9Qkyo5reKCVgIRYlP2Aw
         7mo6WurhXfzzLGyUMiz77qGOYAx6zOdvcl4vBQ3GEZkSGYEPh7A/ZYMzJ1/dcZflZiIu
         AnjA==
X-Gm-Message-State: AGi0PuaU2ie2cPwwI5DCxTyB47yZgIyWu3eNqw00kTT2FSZ3oKf14eeb
        NKz2Xo5WQpXJhA/krUI2dFY=
X-Google-Smtp-Source: APiQypJYZ21+xAeHnds1LUPiq55TXGrzfyODDqdoQ37szQSXON7GL+0GbZVJL5ws5i/hPdVWqYs5zQ==
X-Received: by 2002:a50:d98b:: with SMTP id w11mr16355293edj.196.1587976286295;
        Mon, 27 Apr 2020 01:31:26 -0700 (PDT)
Received: from localhost (ipv6-80adf4751ff4da96.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:80ad:f475:1ff4:da96])
        by smtp.gmail.com with ESMTPSA id w4sm2005854eds.92.2020.04.27.01.31.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:31:25 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:31:24 +0200
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: enabled inversion
Message-ID: <20200427083124.GC18436@portage>
References: <1586424250-25897-1-git-send-email-oliver.graute@gmail.com>
 <20200409101416.GN2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409101416.GN2001@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/20, Dan Carpenter wrote:
> On Thu, Apr 09, 2020 at 11:24:05AM +0200, Oliver Graute wrote:
> > From: Oliver Graute <oliver.graute@kococonnector.com>
> > 
> > Enable inversion mode
> > 
> > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> > ---
> >  drivers/staging/fbtft/fb_st7789v.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> > index 3c3f387936e8..84c5af2dc9a0 100644
> > --- a/drivers/staging/fbtft/fb_st7789v.c
> > +++ b/drivers/staging/fbtft/fb_st7789v.c
> > @@ -120,6 +120,10 @@ static int init_display(struct fbtft_par *par)
> >  	write_reg(par, PWCTRL1, 0xA4, 0xA1);
> >  
> >  	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
> > +
> > +	/* enable inversion mode */
> > +	write_reg(par, 0x21);
> 
> Use the define and delete the comment.
> 
> 	write_reg(par, MIPI_DCS_ENTER_INVERT_MODE);

ok, I'll do on next version

Best regards,

Oliver
