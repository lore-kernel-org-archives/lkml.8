Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C045C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603F620663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="PPMraiP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgCQKiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:38:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35958 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgCQKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:38:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id s1so16711558lfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7mUtSodRzVFrNOdwotyLpGRUL0sXdt0yPPIiSrVrsLs=;
        b=PPMraiP7BrnvbgEUdY7vtJGlY/uq1xXN0yspKo+AerSKh+3S/VAgqVbKJPIs3l0k7U
         ut6qoQMdEwd7W3g0K8vz6PZfWVjKyFLUpSo+bOxY9DSGFmBoMTXOYKfP+G8N0BxszBLV
         9HOPnE3mLGCz2eO7SrH+k89yt2n3fCLD9mpcts/8gq5t7kZytl/xqlIjZR3MWh5/gYln
         Hs+1EX00oS9H9TViCN6KUHqH+UV7vLXXAcNnEYlRp1tTH7tt00Zn+hT/IP6uIWfV8FQO
         FF9vMbelEhdvFltQ+P363Wqfo/crm/zEjIGfsHAxCWhjBfprUGL7wE6fC+NnNkdCDGds
         4F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7mUtSodRzVFrNOdwotyLpGRUL0sXdt0yPPIiSrVrsLs=;
        b=X3u8Ck/tzua/zdbQXVcsvk9/igmm/oRibmmaR6JEyal6FF1NmFkKi/njuu9kkk91yQ
         v9GmFon7JgDjQ2wEFPoxC3FSmOo4f4Jr5kTa4UXVeydPyrcXRL8evPrcNJ210DjGLt/Z
         TKPwzvDFcPGEVNogq0Q6as5MHilwA7ctQ1aFWdZCyxHbXdS6heOEE6oLfv8eNVl5OooJ
         0fqkQRXj7JjxmtT4/dVjsaPTEIpV2vMs1umE9KOYyqIkxb7ExBYr+Y9p/ffGluqZ29Qc
         I6onMVTSM65NELTmpZr28XaCdE/MpWcRTMI/+JXuQ5kpjpR+jS5ql8JJMW2Df0lmtMU+
         vl3Q==
X-Gm-Message-State: ANhLgQ3TxTPPIA42yMh7KGpvY+8S9JRy794iN0RkX3PpidgjRA4BYZm8
        9xn8kyeAHkf/+MwC3THYkIPOvQ==
X-Google-Smtp-Source: ADFU+vtVlYRQTZ5F59LQqxdeWy9nM1l8g9ypwAvky2egMozG6VNQd4T99otV//QeFt6Y/pXumoW8qQ==
X-Received: by 2002:ac2:59c6:: with SMTP id x6mr730389lfn.177.1584441477770;
        Tue, 17 Mar 2020 03:37:57 -0700 (PDT)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id y11sm1989763ljn.83.2020.03.17.03.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 03:37:56 -0700 (PDT)
Date:   Tue, 17 Mar 2020 11:37:56 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Suresh Udipi <sudipi@jp.adit-jv.com>
Cc:     akiyama@nds-osk.co.jp, efriedrich@de.adit-jv.com,
        erosca@de.adit-jv.com, hverkuil-cisco@xs4all.nl,
        jacopo+renesas@jmondi.org, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, mrodin@de.adit-jv.com,
        securitycheck@denso.co.jp
Subject: Re: [PATCH v2] [RFC] rcar-vin: rcar-csi2: Correct the selection of
 hsfreqrange
Message-ID: <20200317103756.GC2496015@oden.dyn.berto.se>
References: <20200316130247.GA2258968@oden.dyn.berto.se>
 <1584428905-21560-1-git-send-email-sudipi@jp.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1584428905-21560-1-git-send-email-sudipi@jp.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suresh,

Thanks for your work.

On 2020-03-17 16:08:25 +0900, Suresh Udipi wrote:
> hsfreqrange should be chosen based on the calculated mbps which
> is closer to the default bit rate  and within the range as per
> table[1]. But current calculation always selects first value which
> is greater than or equal to the calculated mbps which may lead
> to chosing a wrong range in some cases.
> 
> For example for 360 mbps for H3/M3N
> Existing logic selects
> Calculated value 360Mbps : Default 400Mbps Range [368.125 -433.125 mbps]
> 
> This hsfreqrange is out of range.
> 
> The logic is changed to get the default value which is closest to the
> calculated value [1]
> 
> Calculated value 360Mbps : Default 350Mbps  Range [320.625 -380.625 mpbs]
> 
> [1] specs r19uh0105ej0200-r-car-3rd-generation.pdf [Table 25.9]
> 
> There is one exectpion value 227Mbps, which may cause out of
> range.

Then something else is needed I think :-)

I liked v1 of this RFC more, where you added a u16 min and max to struct 
rcsi2_mbps_reg. I think that is the right solution.

What I tried to express in my review of v1 was

- You should remove the mbps member from struct rcsi2_mbps_reg.
- Update the walk of the array in rcsi2_set_phypll() so that it finds 
  the first entry where the calculated target value is between min and 
  max and use the reg setting for that entry.

Would that solution make sens too you? Sorry if I expressed myself a but 
muddy in v1 about this.

> 
> Fixes: 769afd212b16 ("media: rcar-csi2: add Renesas R-Car MIPI CSI-2 receiver driver")
> 
> Signed-off-by: Suresh Udipi <sudipi@jp.adit-jv.com>
> Signed-off-by: Kazuyoshi Akiyama <akiyama@nds-osk.co.jp>
> ---
> Changes in v2:
>   - Added the boundary check for the maximum bit rate.
>   
>   - Simplified the logic by remmoving range check 
>     as only the closest default value covers most 
>     of the use cases.
> 
>   - Aligning the commit message based on the above change
> 
>  drivers/media/platform/rcar-vin/rcar-csi2.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> index faa9fb2..6573625 100644
> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> @@ -199,6 +199,7 @@ static const struct rcsi2_mbps_reg phtw_mbps_v3m_e3[] = {
>  /* PHY Frequency Control */
>  #define PHYPLL_REG			0x68
>  #define PHYPLL_HSFREQRANGE(n)		((n) << 16)
> +#define PHYPLL_HSFREQRANGE_MAX		1500
>  
>  static const struct rcsi2_mbps_reg hsfreqrange_h3_v3h_m3n[] = {
>  	{ .mbps =   80, .reg = 0x00 },
> @@ -431,16 +432,23 @@ static int rcsi2_wait_phy_start(struct rcar_csi2 *priv)
>  static int rcsi2_set_phypll(struct rcar_csi2 *priv, unsigned int mbps)
>  {
>  	const struct rcsi2_mbps_reg *hsfreq;
> +	const struct rcsi2_mbps_reg *hsfreq_prev = NULL;
>  
> -	for (hsfreq = priv->info->hsfreqrange; hsfreq->mbps != 0; hsfreq++)
> -		if (hsfreq->mbps >= mbps)
> -			break;
> -
> -	if (!hsfreq->mbps) {
> +	if (mbps > PHYPLL_HSFREQRANGE_MAX) {
>  		dev_err(priv->dev, "Unsupported PHY speed (%u Mbps)", mbps);
>  		return -ERANGE;
>  	}
>  
> +	for (hsfreq = priv->info->hsfreqrange; hsfreq->mbps != 0; hsfreq++) {
> +		if (hsfreq->mbps >= mbps)
> +			break;
> +		hsfreq_prev = hsfreq;
> +	}
> +
> +	if (hsfreq_prev &&
> +	    ((mbps - hsfreq_prev->mbps) <= (hsfreq->mbps - mbps)))
> +		hsfreq = hsfreq_prev;
> +
>  	rcsi2_write(priv, PHYPLL_REG, PHYPLL_HSFREQRANGE(hsfreq->reg));
>  
>  	return 0;
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
