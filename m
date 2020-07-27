Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4459AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23801206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cj1m6D1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgG0Pso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbgG0Pso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:48:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB50C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:48:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so15402114wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ftDaS4GB93pqR50K0HNKbC88ac2C5NLman44G8+/LyE=;
        b=cj1m6D1+swe4DvbRaDEeTwdxgGLAdA0culkB6Ks72KZ3YF/BmYDotHHfe2/+AUJG5l
         l1rQsTXvM7RO+oJdHgpMCmmCSP6Fc3/xaC4bD+7HQfE3/PEwvhaUCjNrHXJAXdqkxtRk
         RodYtqA8PhxVLQ1zWBEuQgu65kRlrj18zaVdbAQ4SEMeB6eRqwzIK62XZeogD9dcq/ac
         D3ZLysh+S5EnyQtnrvczHZ7SmdSUv1gjIBClYk+jZ0N+1AgHT8+e+KuhRH0UXsRnzq9s
         I0958lQD71PhvsJrMc5owFCmX3UvrPO/7PAEcHu/2AlLiAxvO8jnEBv2CHpTCKWXOUJL
         WQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ftDaS4GB93pqR50K0HNKbC88ac2C5NLman44G8+/LyE=;
        b=E5U4Uu51V9yha8ZoPN8PXINUMvXbThBs9jJ2fWG0qKhwPoKe8rQZLBA3q2RxKuARaP
         N2N2v3EttH6aeeC5WONCI4Ljk3xh/oVvaQZESIRQrq5zKe7rVFH15c8SUQTGLGaJ/qkT
         GuBpxE0o1o8ezgGNdC81aFFZHIVs+MZV3+AwYf+Mt61rpM5olMgCOu3NvMT3VuL7fbep
         DwccIRja3p/mvMSzpk3lWrsrBMEB/YzeT90iWJyXLH7JugW4oQ3RD3uxBnKtHFrUfDyZ
         tMSzQ2pgdfVq1+yEjIWTjFwp39t8VFOVCTHFSoL+zbnsnLBxivBnuvbMZyUsoCEAKZtZ
         91Zw==
X-Gm-Message-State: AOAM531pA/HxUhEqITk5eYudtpphI9a+NqXbyPvU3/x8gq8fj21RgYl8
        xqyms1RIbfsh0iYLlqVqCv5gsw==
X-Google-Smtp-Source: ABdhPJwGZmIBqv2Morq7xO0TtkIaGYFP6yK8oChVVtxF7/hPI4hIcO8UKMwe98O/xQHW7Hh7Ry8XpQ==
X-Received: by 2002:a5d:544f:: with SMTP id w15mr21015839wrv.208.1595864922765;
        Mon, 27 Jul 2020 08:48:42 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id r206sm34232wma.6.2020.07.27.08.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 08:48:42 -0700 (PDT)
Date:   Mon, 27 Jul 2020 16:48:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Subject: Re: [PATCH 1/8] mfd: mt6358: refine interrupt code
Message-ID: <20200727154840.GY1850026@dell>
References: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1595509133-5358-2-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595509133-5358-2-git-send-email-hsin-hsiung.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020, Hsin-Hsiung Wang wrote:

> This patch refines the interrupt related code to support new chips.

Refines in what way?

What makes this better?

> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/mt6358-irq.c        | 65 ++++++++++++++++++++++++-----------------
>  include/linux/mfd/mt6358/core.h |  8 ++---
>  2 files changed, 41 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
> index db734f2..4b094e5 100644
> --- a/drivers/mfd/mt6358-irq.c
> +++ b/drivers/mfd/mt6358-irq.c
> @@ -13,7 +13,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
> -static struct irq_top_t mt6358_ints[] = {
> +#define MTK_PMIC_REG_WIDTH 16
> +
> +static const struct irq_top_t mt6358_ints[] = {
>  	MT6358_TOP_GEN(BUCK),
>  	MT6358_TOP_GEN(LDO),
>  	MT6358_TOP_GEN(PSC),
> @@ -24,6 +26,13 @@ static struct irq_top_t mt6358_ints[] = {
>  	MT6358_TOP_GEN(MISC),
>  };
>  
> +static struct pmic_irq_data mt6358_irqd = {
> +	.num_top = ARRAY_SIZE(mt6358_ints),
> +	.num_pmic_irqs = MT6358_IRQ_NR,
> +	.top_int_status_reg = MT6358_TOP_INT_STATUS0,
> +	.pmic_ints = mt6358_ints,
> +};

Dynamically assigned driver data is usually preferred.

Why have you gone static?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
