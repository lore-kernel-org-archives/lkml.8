Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343E8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6A62063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNT1KJPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgGPXiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgGPXiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:38:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CC3C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 16:38:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m22so5704073pgv.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YI7Vx/uvEtkVHjbnn5enh7Amkd8UUwSoGpt+t0J9E6s=;
        b=HNT1KJPvsw+DsJ8EOVLWmzitrBpr2yo7OeDS/ByQPu3+8YItroTU5tRmB2KmRs4P21
         1XdBvcw8tcZZxmOTswgMDE9PbYsIPXJqexuThr4oua0stDFqoqRnQfWaVLDynSbDgGBP
         +mRMfWfUqqnWFa/3agfFCCVTwGyXE9Uf0XW6eMoUfi0Y7i6+FT+TzKmhujId02r1dSpP
         EoRiQkBwdafl5ekL2/7NLOuVhAxIIsA3G0q6hzrXbZWVczzNTRhwCuaVqWJ5sR6J8rIC
         k6eEdlyYzR+qvFsGOEyzIzVx5a23yduG38u5JOFP5rsy3N26hZFlRa6mxiYAppwLyvYL
         4vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YI7Vx/uvEtkVHjbnn5enh7Amkd8UUwSoGpt+t0J9E6s=;
        b=L6Ltqr1WR5trdheHjX9BDBYMW4IRCaegMBKg/GhVfwmD4NUPqHzECf5s3Cu1TqBSvJ
         s7MyIjSqdSYGKPKgxfbnTxht8N8CN5BLgSzrdsheU3Desxi9vBQrxzQD64h9KjFeip3a
         TvHbpi568VsI5Rm7OiT7b/wnF7Bqiz5vzzf1D6cnfMl0ZLqbzUNH+aSXHiMyi4A2KQR1
         3DSbna+wfETqeFteRZCmu1I/O5G7fwdF91TVEmMaiitOm9OD85MqZquJnRCzliY72RNO
         t5/pSPvX107OlfaymPHMp0v9qrEWQiuWNlcb/JL4w4nRvBdmrVKa5FgwE4A6aFxp/q1u
         3EPA==
X-Gm-Message-State: AOAM530/xOOtlBKJkFg/pibnhycZCuFvjwlfBa/be4dcHWZA7/zTKNqs
        3z1BaHwzIVeBP/DVIft6WfI=
X-Google-Smtp-Source: ABdhPJzQHxH3wEjRwLvQBEJM/Bkm1Yppl+9h/O55FOV43a+W6m9xAk7+6BmVoJgvPO1jc9/gw2Zwfw==
X-Received: by 2002:a63:ac53:: with SMTP id z19mr6120867pgn.181.1594942693154;
        Thu, 16 Jul 2020 16:38:13 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y20sm5585405pfo.170.2020.07.16.16.38.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jul 2020 16:38:12 -0700 (PDT)
Date:   Thu, 16 Jul 2020 16:37:46 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 2/2] ASoC: fsl_asrc: always use internal ratio
Message-ID: <20200716233742.GA27376@Asurada-Nvidia>
References: <20200716145201.186270-1-arnaud.ferraris@collabora.com>
 <20200716151352.193451-1-arnaud.ferraris@collabora.com>
 <20200716151352.193451-3-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716151352.193451-3-arnaud.ferraris@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 05:13:54PM +0200, Arnaud Ferraris wrote:
> Even though the current driver calculates the dividers to be used
> depending on the clocks and sample rates, enabling the internal ratio
> can lead to noticeable improvements in the audio quality, based on my
> testing.
> 
> As stated in the documentation, "When USRx=1 and IDRx=0, ASRC internal
> measured ratio will be used", so setting this bit even when not in
> "Ideal Ratio" mode still makes sense.
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 6d43cab6c885..0b79a02d0d76 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -465,7 +465,7 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
>  	regmap_update_bits(asrc->regmap, REG_ASRCTR,
>  			   ASRCTR_ATSi_MASK(index), ASRCTR_ATS(index));
>  	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> -			   ASRCTR_USRi_MASK(index), 0);
> +			   ASRCTR_USRi_MASK(index), ASRCTR_USR(index));
>  
>  	/* Set the input and output clock sources */
>  	regmap_update_bits(asrc->regmap, REG_ASRCSR,
> @@ -507,8 +507,7 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool use_ideal_rate)
>  
>  	/* Enable Ideal Ratio mode */

The code is against the comments now -- need to update this line.

>  	regmap_update_bits(asrc->regmap, REG_ASRCTR,
> -			   ASRCTR_IDRi_MASK(index) | ASRCTR_USRi_MASK(index),
> -			   ASRCTR_IDR(index) | ASRCTR_USR(index));
> +			   ASRCTR_IDRi_MASK(index), ASRCTR_IDR(index);

The driver falls back to ideal ratio mode if there is no matched
clock source. Your change seems to apply internal ratio mode any
way? Probably would break the fallback routine.
