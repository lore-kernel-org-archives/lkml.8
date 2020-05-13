Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91159CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B113204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EMSk3UsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbgEMOTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbgEMOTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:19:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8968FC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:19:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so28677867wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BzAexTZdGzkbU+qJJMsz3TVTPGgn5vUNElmT2RDA+0U=;
        b=EMSk3UsQmqMg3qEBeIiZBKeutU51C2Am8qcTqR7Q2SowTC8lSSMSOTktt+pODhHRqu
         /zflH4TS2WyqQZ1bXRIN22wwOvMJCkJj1MfbpJtMBW2brWoJlSqqkWsnLOjHvij6SGt1
         eDQNH/b9oxeBVrvMV7yB7YGvt8GEHzvCmz0oTUPs79f2ghXYwlEk6x4XECsJywANYj15
         B6NpF89xsgtyaYqwfXgFF5bJ45LB/wRkbPI8zvn+8MWbrk3bTII/QMl0xuYmcx0rsTS5
         6netlog87B91EQZD9i6sfEILUPnRx13EFZUG4UtDPWTcwYESOI7PV7Lxfq1vTXWcHalv
         x/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BzAexTZdGzkbU+qJJMsz3TVTPGgn5vUNElmT2RDA+0U=;
        b=OTy9YV4cqse5EDThm90iidCNY8bBxfnINHY8mAJ/cu0Jcue6IAEDiz3tiuSpBIgPfz
         dDKiVZcIgEtrXy6Ww+uuj1e3UelWWjv7aiJzgn2QPUkvx+UDdycxu7/T8LsM347caARS
         nS/szlLX0iV8DLw+i9ZFlqrexHY2sePtwGs4f/43r7+70l00Rcg9rCTwVWAtZtLu13GQ
         XXAEGriMFL3iq2FVGeOzxsbm+kayB+P4SR0AT5cEOuKfaig2Z1ok91rf62CdMzVDAyHV
         pDqRN1J70Jjzn0tj4loiWCcvwnJCumnlf8i+oI6h4DLl0INrKl/T9PMJw0SEJaodhu+N
         1bvA==
X-Gm-Message-State: AGi0PubcQu0nK4OvizdKDWEjTllP1NeCXhvN1yvEA8a2H5WAZzzh2uyv
        9VRh9wetIK1t1XRd1QpT06UV7xRR4fi7CQ==
X-Google-Smtp-Source: APiQypLlLxrBWuZUOf7uO7jUrf5MahbqULe0GeT1lcuPz15SOwBAA5AV5SB9vJ2x/uvf5Q7yBD3egw==
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr46248266wme.177.1589379581774;
        Wed, 13 May 2020 07:19:41 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:4460:3fd3:382:4a71? ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id s15sm1950722wro.80.2020.05.13.07.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 07:19:41 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] soc: amlogic: meson-ee-pwrc: add support for the
 Meson GX SoCs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        robh+dt@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200420202612.369370-1-martin.blumenstingl@googlemail.com>
 <20200420202612.369370-5-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <b8399d8f-5ff7-0911-21a1-70158d93789b@baylibre.com>
Date:   Wed, 13 May 2020 16:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200420202612.369370-5-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2020 22:26, Martin Blumenstingl wrote:
> Add support for the Meson GX SoCs to the meson-ee-pwrc driver.
> 
> The power domains on the GX SoCs are very similar to G12A. The only
> known differences so far are:
> - The GX SoCs do not have the HHI_VPU_MEM_PD_REG2 register (for the
>   VPU power-domain)
> - The GX SoCs have an additional reset line called "dvin"
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/soc/amlogic/meson-ee-pwrc.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
> index b30868da456a..a90572cb9c82 100644
> --- a/drivers/soc/amlogic/meson-ee-pwrc.c
> +++ b/drivers/soc/amlogic/meson-ee-pwrc.c
> @@ -16,6 +16,7 @@
>  #include <linux/clk.h>
>  #include <dt-bindings/power/meson8-power.h>
>  #include <dt-bindings/power/meson-g12a-power.h>
> +#include <dt-bindings/power/meson-gxbb-power.h>
>  #include <dt-bindings/power/meson-sm1-power.h>
>  
>  /* AO Offsets */
> @@ -73,7 +74,7 @@ struct meson_ee_pwrc_domain_data {
>  
>  /* TOP Power Domains */
>  
> -static struct meson_ee_pwrc_top_domain g12a_pwrc_vpu = {
> +static struct meson_ee_pwrc_top_domain gxbb_pwrc_vpu = {

I thing it could be renamed gx_pwrc_vpu, but it's not a strong one

>  	.sleep_reg = AO_RTI_GEN_PWR_SLEEP0,
>  	.sleep_mask = BIT(8),
>  	.iso_reg = AO_RTI_GEN_PWR_SLEEP0,
> @@ -138,6 +139,12 @@ static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_vpu[] = {
>  	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
>  };
>  
> +static struct meson_ee_pwrc_mem_domain gxbb_pwrc_mem_vpu[] = {
> +	VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
> +	VPU_MEMPD(HHI_VPU_MEM_PD_REG1),
> +	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
> +};
> +
>  static struct meson_ee_pwrc_mem_domain meson8_pwrc_mem_eth[] = {
>  	{ HHI_MEM_PD_REG0, GENMASK(3, 2) },
>  };
> @@ -223,11 +230,17 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
>  static bool pwrc_ee_get_power(struct meson_ee_pwrc_domain *pwrc_domain);
>  
>  static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
> -	[PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &g12a_pwrc_vpu, g12a_pwrc_mem_vpu,
> +	[PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &gxbb_pwrc_vpu, g12a_pwrc_mem_vpu,
>  				     pwrc_ee_get_power, 11, 2),
>  	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson8_pwrc_mem_eth),
>  };
>  
> +static struct meson_ee_pwrc_domain_desc gxbb_pwrc_domains[] = {
> +	[PWRC_GXBB_VPU_ID]  = VPU_PD("VPU", &gxbb_pwrc_vpu, gxbb_pwrc_mem_vpu,
> +				     pwrc_ee_get_power, 12, 2),
> +	[PWRC_GXBB_ETHERNET_MEM_ID] = MEM_PD("ETH", meson8_pwrc_mem_eth),
> +};
> +
>  static struct meson_ee_pwrc_domain_desc meson8_pwrc_domains[] = {
>  	[PWRC_MESON8_VPU_ID]  = VPU_PD("VPU", &meson8_pwrc_vpu,
>  				       meson8_pwrc_mem_vpu, pwrc_ee_get_power,
> @@ -514,6 +527,11 @@ static struct meson_ee_pwrc_domain_data meson_ee_g12a_pwrc_data = {
>  	.domains = g12a_pwrc_domains,
>  };
>  
> +static struct meson_ee_pwrc_domain_data meson_ee_gxbb_pwrc_data = {
> +	.count = ARRAY_SIZE(gxbb_pwrc_domains),
> +	.domains = gxbb_pwrc_domains,
> +};
> +
>  static struct meson_ee_pwrc_domain_data meson_ee_m8_pwrc_data = {
>  	.count = ARRAY_SIZE(meson8_pwrc_domains),
>  	.domains = meson8_pwrc_domains,
> @@ -542,6 +560,10 @@ static const struct of_device_id meson_ee_pwrc_match_table[] = {
>  		.compatible = "amlogic,meson8m2-pwrc",
>  		.data = &meson_ee_m8b_pwrc_data,
>  	},
> +	{
> +		.compatible = "amlogic,meson-gxbb-pwrc",
> +		.data = &meson_ee_gxbb_pwrc_data,
> +	},
>  	{
>  		.compatible = "amlogic,meson-g12a-pwrc",
>  		.data = &meson_ee_g12a_pwrc_data,
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
