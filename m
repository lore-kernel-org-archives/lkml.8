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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4FAC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD42F2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meKAh8Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgD0Igs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgD0Igr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:36:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35127C061A0F;
        Mon, 27 Apr 2020 01:36:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so13366919eje.13;
        Mon, 27 Apr 2020 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vQTluHrFlTPouGYN0L8RFSa0ut56oC/RfYr17kNASok=;
        b=meKAh8FbBdII7WfsflAdIDuNSKAWExOwNGTQONordCK+iMffZUBH4QRLKIj9g3hUAn
         YdV1IZ903/Ia+CRl7z1QLOG/iAvLvkeIL46dC+N8HcIA085a47xkeVd/d8bh4ILznfGK
         mYG0TqRV+AdXCoDveEOkLJcaLWYYbpZaf7DWgkpl3d7DEzkPG7MzqxCPG++2mTyCXzBB
         hn2CMjRyBXSOLouKFBFwh/GBKSrvfsJlTDDekvK5NO2FzQWaOyfa9p1QwBfW9k21v7U5
         PCHOoFKOplRT4+78hCu4tj17YMcjc4ZIs+YJhSOwjlxGEh0trr1ZwuzG8JMqICaBTnqK
         TpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vQTluHrFlTPouGYN0L8RFSa0ut56oC/RfYr17kNASok=;
        b=Pep8qUtO9whatpkvdV2dFDFM3rFxdgQK3aDdbDTc8KCJ1rCBzapI+hEJFQ3TYNVr/E
         U7vLVrx1pFuTz3DJ1cr+zHNDXV4b70dkoakAxAjJrKfy46Rkyv2EFP4a2Ze40vOuOic/
         EJcBEIYeKmxL0VlysNFJX/ZWSMo6JJ4Alult+Z0Dnbqmt+rkMFQ8iJlNOo7n5glYhbKW
         yJ8ABKfd7i3skHpg4dtX3puYlFbABudlPBxo7w06UDxjS9p6+VlwPvSRC4hpfUlJr5rw
         nzvBu4SABmeX/hxjuYedX9iiDvMKdNW+mYP0OnW8yNt58lC4Xt4+rPPY2su/t6SVfFYf
         wWkQ==
X-Gm-Message-State: AGi0Pub0BJTlL/Dg+6awNXHr5lri0iyFuOsOHB80IXLcqNDu7O5rTlCl
        rl7EuEKDpZyXt9WVDZSmYxGh+JmOu9DF/Q==
X-Google-Smtp-Source: APiQypIRUAnXaWz08Q8liiasN60ylITxEvvKR+QbUyjJant5k2FUB9f77S8t1viHZzIbcdXyf4L9nA==
X-Received: by 2002:a17:906:496:: with SMTP id f22mr18305568eja.311.1587976604820;
        Mon, 27 Apr 2020 01:36:44 -0700 (PDT)
Received: from localhost (ipv6-80adf4751ff4da96.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:80ad:f475:1ff4:da96])
        by smtp.gmail.com with ESMTPSA id s18sm2810366ejm.63.2020.04.27.01.36.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:36:44 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:36:42 +0200
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: Initialize the Display
Message-ID: <20200427083642.GD18436@portage>
References: <1586424337-26602-1-git-send-email-oliver.graute@gmail.com>
 <20200409102013.GP2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409102013.GP2001@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/20, Dan Carpenter wrote:
> On Thu, Apr 09, 2020 at 11:25:32AM +0200, Oliver Graute wrote:
> > From: Oliver Graute <oliver.graute@kococonnector.com>
> > 
> > Set Gamma Values and Register Values for the HSD20_IPS
> > 
> > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> > ---
> >  drivers/staging/fbtft/fb_st7789v.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> > index 84c5af2dc9a0..b0aa96b703a8 100644
> > --- a/drivers/staging/fbtft/fb_st7789v.c
> > +++ b/drivers/staging/fbtft/fb_st7789v.c
> > @@ -17,8 +17,8 @@
> >  #define DRVNAME "fb_st7789v"
> >  
> >  #define DEFAULT_GAMMA \
> > -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25\n" \
> > -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25"
> > +	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
> > +	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
> 
> How do you know this won't break someone else's setup?

Should I declare an extra define for my values?

+#define HSD20_IPS_GAMMA \
+	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
+	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"

> 
> Without knowing anything at all about this driver, it feels like this
> should be:
> 
> 	if (new_hardware)
> 		write_reg(par, PORCTRL, 0x05, 0x05, 0x00, 0x33, 0x33);
> 	else
> 		write_reg(par, PORCTRL, 0x08, 0x08, 0x00, 0x22, 0x22);

ok, I'll update this.

Best regards,

Oliver
