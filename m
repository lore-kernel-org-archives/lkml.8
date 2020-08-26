Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F04BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E842074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="0XBaJLdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHZQWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgHZQW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:22:28 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38EFC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:22:27 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so268958pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=M2pM6oqlNN6MFOKK7t3LmYxIe8hLNoDE+c6Oy6sDbps=;
        b=0XBaJLdphBcrsfjbCsPV/DnDtCuoTybU7kmvMapFYxXvE3qZVFr9blFuHjPXHdTCei
         +jJzOZv28p3I5AapTR4ZbPqikFLUJjy4pvnArkspXnEkiY7GYz3ETVp7OVydR5uMTZM2
         kNbkLJK4XIMHrkChkpj+RwFk29h+27rr1PHt8H2kBjI/enJtfY/WnH80fl+UpX3RP0NU
         TjeoCU06rYZPWboZIgjOEMBygqnFDHBdvdAXceru+Hk8HcCZNQ/RQ1mTpWbBaGnCmI2z
         llHFdLKaXFPfd+lmlicsjJx0Gpg8eX+6uxm66QadJ0HlK1kjZ+gq6LrJ+vvmkLGvJN0a
         UMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=M2pM6oqlNN6MFOKK7t3LmYxIe8hLNoDE+c6Oy6sDbps=;
        b=KfcIs9eKfvq/bLGl3uVVdFkMJGxsgBZ48lRrBVA+CUNszEMmoo7073oxxk81UsE3cB
         z2VsefK9DQB4dHat5X4wMmKrFVAXkDAN726yPkRRZ5azdur99Kpflz2MxUJ/kXG55H8o
         IBUXZqhpFOmroXZM1vVktaL74eYDVFm72s3nMAbFtiSHzBXPR75F1h73a+P18O1+ORrb
         p+60Z1VGPp370Km11xuR2O9fVFhRzuEW40vQL/RMsCOPD0bm1wu9Q+Fa1ONqKjJIPNRx
         5zc6mzga+uXUTHXirnvegnNmc8jqlHyOn29iG0bt6nLWcbQQroBeG4AnMM56YQbzRPCi
         lbVg==
X-Gm-Message-State: AOAM533vDMf0da6s/1bCcNw06Z0xOlOllVAyhxLkDrmMzS6Uef8Pirgl
        a/l/rP/17PaEnzYeCnm6PRo+lQ==
X-Google-Smtp-Source: ABdhPJxhvy1Fr0y470BQcg3U7zUExK/HTGZMY1TA2Yh1PBJT1AC0z2GSyGYGUWggFbvX+ZwTbRjMWA==
X-Received: by 2002:a63:4543:: with SMTP id u3mr10396963pgk.398.1598458946525;
        Wed, 26 Aug 2020 09:22:26 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j12sm2803760pjd.44.2020.08.26.09.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:22:24 -0700 (PDT)
Date:   Wed, 26 Aug 2020 09:22:24 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Aug 2020 09:22:22 PDT (-0700)
Subject:     Re: [PATCH 4/6] pwm: sifive: Simplify with dev_err_probe()
In-Reply-To: <20200826144747.9436-4-krzk@kernel.org>
CC:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, paul@crapouillou.net,
        heiko@sntech.de, Paul Walmsley <paul.walmsley@sifive.com>,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        mripard@kernel.org, wens@csie.org, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, krzk@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     krzk@kernel.org
Message-ID: <mhng-452a4fec-be33-4b49-a904-edb4b4c81e0c@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 07:47:45 PDT (-0700), krzk@kernel.org wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pwm/pwm-sifive.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index 62de0bb85921..2485fbaaead2 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -254,11 +254,9 @@ static int pwm_sifive_probe(struct platform_device *pdev)
>  		return PTR_ERR(ddata->regs);
>
>  	ddata->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(ddata->clk)) {
> -		if (PTR_ERR(ddata->clk) != -EPROBE_DEFER)
> -			dev_err(dev, "Unable to find controller clock\n");
> -		return PTR_ERR(ddata->clk);
> -	}
> +	if (IS_ERR(ddata->clk))
> +		return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +				     "Unable to find controller clock\n");
>
>  	ret = clk_prepare_enable(ddata->clk);
>  	if (ret) {

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
