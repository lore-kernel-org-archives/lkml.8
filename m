Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B16C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC189206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="IV8PI5CQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgF3WFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgF3WFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:05:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B9EC03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:05:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so17337606lji.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2sdEB61RJtM8BDd2CIWT1nB0HX2JryiKHhO/D2jAqk8=;
        b=IV8PI5CQ8lFS8fDfntNPJAhkpzSbt1Sm0P3/RptH8g9/vYG9k0my4HasL3nqVUOM6E
         Z5JLQXxOZWuWYPQqwFoTxmJla02+XbIFy6jJHuFywI1neiPX9qTdmmFwGweyD4GIXb+d
         Wt9SbMg05AucKleo3PjcbXcoEr7Q9oqNvTSz8oQP7JcV3RjS0kWe5dqMsptWNnX74pgs
         og+43De9aCjqCRk4Y7Ejihdak8GdolWxyynHKVpLve61H8jJ1bf0kiWT7IVGNAtG8Sdq
         2Be+5dTKLJdx5QqLam5VrTE7NAOKYbungLUKRSYE6oErMmBdzPFiH76AlVh7cnYST0ef
         Mb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2sdEB61RJtM8BDd2CIWT1nB0HX2JryiKHhO/D2jAqk8=;
        b=MccaMtc4oe3//QvOl1j5ApN4uTmGAjfNvBgbnykyLfycHCdfUBq1QqIMVS9DpIpecn
         j5lYNA7XJXMJOwkPdQr/XVU62KEc3sXQBN9UE/msxt7/ko1T3fSI3J8pFdyQ8IgCTUUJ
         Z6CPDKYR7Sjddt/vqjdUHEdCFhmVagcDEdHteQItR/FN4TMW7JDsFrdTFTyBljAtaY1l
         XWcO3rDwdbvjRPa1dzb74DPQhXuawHF7nHJQ/YVmqlCCr1/H0DgzJczrsbUzsEGfvUOv
         g4EB6MqEuc8KlNtQIOCc8FaXe61uIvQlFX15R+T//D67Yf1r2D7x/+O5gnKmk9OZsGGQ
         70PQ==
X-Gm-Message-State: AOAM531bruXu8JL4aeY8yqphDljPGkmxZ7pHK8A5SuZbmWZApdhaHx+q
        a7OL+58At6D9fEArxVG0WmxA2w==
X-Google-Smtp-Source: ABdhPJzuCDzU6N0J+RjoUepz5/Fcr5Ej88rFAeg0TRp0twjz7ihjFHu7iKSNwBUrjZzoNQiBPpno/Q==
X-Received: by 2002:a2e:3a17:: with SMTP id h23mr11076513lja.7.1593554703070;
        Tue, 30 Jun 2020 15:05:03 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id t15sm1135067lji.49.2020.06.30.15.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 15:05:02 -0700 (PDT)
Date:   Wed, 1 Jul 2020 00:05:02 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Suresh Udipi <sudipi@jp.adit-jv.com>
Cc:     mrodin@de.adit-jv.com, akiyama@nds-osk.co.jp,
        efriedrich@de.adit-jv.com, erosca@de.adit-jv.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, mchehab@kernel.org,
        michael@rodin.online, securitycheck@denso.co.jp
Subject: Re: [PATCH v8 2/3] media: rcar-csi2: Add warning for PHY speed less
 than minimum
Message-ID: <20200630220502.GK2365286@oden.dyn.berto.se>
References: <20200617133705.GA88066@vmlxhi-121.adit-jv.com>
 <1592476472-26235-1-git-send-email-sudipi@jp.adit-jv.com>
 <1592476472-26235-2-git-send-email-sudipi@jp.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1592476472-26235-2-git-send-email-sudipi@jp.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suresh,

Thanks for your patch.

On 2020-06-18 19:34:31 +0900, Suresh Udipi wrote:
> Add a warning message when the selected PHY speed is less
> than supported minimum PHY speed given in the hsfreq table[1].
> 
> For raspberry pi camera capture on Kingfisher board with resolution
> 640x480, the calculated PHY speed is 48 mbps which is less than
> the minimum PHY speed 80 Mbps from the table[1]. But in this cases
> capture is successful.
> 
> [1] specs r19uh0105ej0200-r-car-3rd-generation.pdf [Table 25.9]
> 
> Signed-off-by: Suresh Udipi <sudipi@jp.adit-jv.com>
> Signed-off-by: Michael Rodin <mrodin@de.adit-jv.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/media/platform/rcar-vin/rcar-csi2.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> index f18dedc..1184527 100644
> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> @@ -433,6 +433,10 @@ static int rcsi2_set_phypll(struct rcar_csi2 *priv, unsigned int mbps)
>  	const struct rcsi2_mbps_reg *hsfreq;
>  	const struct rcsi2_mbps_reg *hsfreq_prev = NULL;
>  
> +	if (mbps < priv->info->hsfreqrange->mbps)
> +		dev_warn(priv->dev, "%u Mbps less than min PHY speed %u Mbps",
> +			 mbps, priv->info->hsfreqrange->mbps);
> +
>  	for (hsfreq = priv->info->hsfreqrange; hsfreq->mbps != 0; hsfreq++) {
>  		if (hsfreq->mbps >= mbps)
>  			break;
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
