Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C0FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA152084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lj0CjFEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDIGHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:07:01 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38903 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgDIGHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:07:01 -0400
Received: by mail-pj1-f65.google.com with SMTP id t40so839349pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 23:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PDVCcQ8eW3xzr0q0fg0rFZhCBqGt/pkIyn1XMDFNGIQ=;
        b=lj0CjFEmmT9lQy65b0Ne6akclJt8eimW65qFTdm50riSBxgY5Oea+B9HT8lYxTkpCz
         /P1YjHZpiEUN9UGqGlVwmH2hPKZd2YcsnmNllqEEeXRHi8WNZpZdMBFAeIrpx4T632eq
         uHEkWyWv1h55xsKN1ZnTz4zBLbec8p3u17o8jdgejp69SEDt8oNSmXFzaRfcG5h9jLmM
         mL1/ycLrGvNc2K4a5Cc8/Cnm6yUEoLxPtnsjLzV+2qLQP2TJzAIA6TP+dOtcVbd2WjN2
         Nr38UjdfRfGJuBGfx0y3kINf9naWJD2TT9MbyUlC1dmC/7boMG3zfPO1aLLMWvEAuGF1
         dANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PDVCcQ8eW3xzr0q0fg0rFZhCBqGt/pkIyn1XMDFNGIQ=;
        b=uHtMQFcwv2vVf/HTKFnW7WILH0eI5NJinPuOKNasvRJ/I44L9uGOi7lctJ0c4JCeWJ
         a1jU8nvH1mtTXpAMrKZ3l+5z3Ggi0jSoMwlFZ4GI7h6uvHaT+gjAPZpE5xWnO0afvMF7
         5sL5A0ilTLM0IgU2IvB0PRujuw+VzwnaWXsCJBgGZkWsagK1mTwNqiP9tG7Dt7+JtHzs
         MM4UQRb1RatvgU5fB7DqapjVq+pj/fq4i5i4JbfyygrdLTiqP1pLfbIQ4whpim4miE9z
         5PMaveAU2nkeLpmriR++mdw7Tl5y8XElXbUSRC92AvAvSd+QUWoNy0W73VnMyeGB4j4d
         HViQ==
X-Gm-Message-State: AGi0Pub8uwOy+ahlnNz314Diu8D4dbQmigHFt2z4lW4FAU+9/BtBUuyf
        MwXm4EwcEfZTQo22HmLo+rLm
X-Google-Smtp-Source: APiQypLzQNmwG//ib7FauV8yUSzEnCm4L6N8bPxdz2kPV14xDTahS4nqsqZcfN1scrt9Fem/iVmZNQ==
X-Received: by 2002:a17:902:d3cb:: with SMTP id w11mr10543306plb.257.1586412420780;
        Wed, 08 Apr 2020 23:07:00 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:880:9bea:1d3e:17d:bd87:fce7])
        by smtp.gmail.com with ESMTPSA id r189sm17408396pgr.31.2020.04.08.23.06.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Apr 2020 23:06:59 -0700 (PDT)
Date:   Thu, 9 Apr 2020 11:36:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     thor.thayer@linux.intel.com, krzysztof.adamski@nokia.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        nsekhar@ti.com, bgolaszewski@baylibre.com,
        jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, baruch@tkos.co.il,
        wsa+renesas@sang-engineering.com, kgene@kernel.org,
        krzk@kernel.org, paul@crapouillou.net, vz@mleia.com,
        khilman@baylibre.com, matthias.bgg@gmail.com,
        gregory.clement@bootlin.com, rrichter@marvell.com,
        afaerber@suse.de, agross@kernel.org, bjorn.andersson@linaro.org,
        heiko@sntech.de, baohua@kernel.org, linus.walleij@linaro.org,
        mripard@kernel.org, wens@csie.org, ardb@kernel.org,
        michal.simek@xilinx.com, gcherian@marvell.com, jun.nie@linaro.org,
        shawnguo@kernel.org, rayagonda.kokatanur@broadcom.com,
        lori.hikichi@broadcom.com, nishkadg.linux@gmail.com,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        bigeasy@linutronix.de, info@metux.net, hslester96@gmail.com,
        narmstrong@baylibre.com, martin.blumenstingl@googlemail.com,
        qii.wang@mediatek.com, drinkcat@chromium.org, hsinyi@chromium.org,
        fparent@baylibre.com, opensource@jilayne.com, swinslow@gmail.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 03/28] i2c: owl: convert to
 devm_platform_ioremap_resource
Message-ID: <20200409060640.GA4243@Mani-XPS-13-9360>
References: <20200407163741.17615-1-zhengdejin5@gmail.com>
 <20200407163741.17615-4-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407163741.17615-4-zhengdejin5@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 12:37:16AM +0800, Dejin Zheng wrote:
> use devm_platform_ioremap_resource() to simplify code, which
> contains platform_get_resource and devm_ioremap_resource.
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/i2c/busses/i2c-owl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index b6b5a495118b..c9e7fcac12ae 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -399,15 +399,13 @@ static int owl_i2c_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct owl_i2c_dev *i2c_dev;
> -	struct resource *res;
>  	int ret, irq;
>  
>  	i2c_dev = devm_kzalloc(dev, sizeof(*i2c_dev), GFP_KERNEL);
>  	if (!i2c_dev)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	i2c_dev->base = devm_ioremap_resource(dev, res);
> +	i2c_dev->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(i2c_dev->base))
>  		return PTR_ERR(i2c_dev->base);
>  
> -- 
> 2.25.0
> 
