Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D875C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244122072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqr9f9v9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgG0L31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgG0L30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:29:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ECDC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:29:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so14399074wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EKtNZF82mH4EnUTfOug/S5EqMmxmydLS/o7zuPsZsAg=;
        b=oqr9f9v9ib3ir2dTayTCoS6+B/x4vLofP7/ciW3dY1I6LcRa6FGyYqAoyRJIG76GE1
         oH8PB5k8BDapkVVfjFdS7CRSVr2DK7Of3iLXi+PCpcml3vbAKZPCq+LBrWNh+Jz7Bbcu
         d2yS/viPCeYaH8BH8Lge/c9ZRzatFiidYJsjLR9vyV+r+aytOenZou+60oe3Mrj3CSmO
         oe2ynIo6sqDPh4v09oVYqlM6xv6gxkbOBLbUUiEbRjr5L7QE6hqL9Ynaap5V/UJQsMkm
         66rh7TkFOWTm0S7wEsShM6qqdIV8pxrUBlCm6+8tFPPscrNtZZk6pz6IEHQXDjEB0Zx5
         4Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EKtNZF82mH4EnUTfOug/S5EqMmxmydLS/o7zuPsZsAg=;
        b=ujwjDJL3D1j1ndHTJQofUVpetGMF3FAWRNwWD4ns9Q7fudlBuaxisrWJsqJA/9PGcQ
         ofhJ1kbkm73rYbmB+DrFnBdFe4BzV0c4w2erymnpNFcFzKzkYxm+v3Y3xbyLxYBA7z6K
         wyMInn7hWYTTe1MseKwKI4kbwOX4mkRrDVA76kv4YiDualDhH4pRNWpdJaxBa+DkHpj8
         1dvJtB6yW+hqcSm5Jz7MLou3vFyyCJeIaG4PW0JrS6e0av7g5d45FKDSadiuOLbvMMGO
         eammw7cUoRjh/qmIsUPFFgV++y14jvg8KjtDNh3fQzkN48SldtBPvy7QrSDnDMOeQ2ju
         m2Zg==
X-Gm-Message-State: AOAM532rx/mORbxchZbWirEmoyHsB8VHema+qayOa2EGROytloCFgar0
        kM1gAiuTEP33lkr1XMUZ1pWmEA==
X-Google-Smtp-Source: ABdhPJwozf0SUllR1Iqin/QO4pcEiW+aQJPZDJ37xCt8IxZMIGjhFfx+9XxaifgFKqEPWIcyZbOEEA==
X-Received: by 2002:a1c:7204:: with SMTP id n4mr4687818wmc.161.1595849363913;
        Mon, 27 Jul 2020 04:29:23 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id k131sm19041738wmb.36.2020.07.27.04.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 04:29:23 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:29:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 4/9] mfd: mt6360: Combine mt6360 pmic/ldo resouces
 into mt6360 regulator resources
Message-ID: <20200727112921.GK1850026@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-5-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594983811-25908-5-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Combine mt6360 pmic/ldo resouces into mt6360 regulator resources
> to simplify the similar resources object.

Do the sub-devices actually share these resources, or are you doing
this just to make the code simpler?

> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 7cc1b59..665e26f 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
>  };
>  
> -static const struct resource mt6360_pmic_resources[] = {
> +static const struct resource mt6360_regulator_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> -};
> -
> -static const struct resource mt6360_ldo_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] = {
>  		    NULL, 0, 0, "mediatek,mt6360-chg"),
>  	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
>  		    NULL, 0, 0, "mediatek,mt6360-led"),
> -	OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> -		    NULL, 0, 0, "mediatek,mt6360-pmic"),
> -	OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> -		    NULL, 0, 0, "mediatek,mt6360-ldo"),
> +	OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> +		    NULL, 0, 0, "mediatek,mt6360-regulator"),
>  	OF_MFD_CELL("mt6360-tcpc", NULL,
>  		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
>  };

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
