Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCDDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6AC621582
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599060962;
	bh=AbssYCX9u2KiF1QbYK9CHg8zUKqCbMV3rsw9D3opKvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q5YL86EgSX8Ur9Yue34cfQ3E+bmBb+ub3c/JgmDGVCYvhdTbfVtYUHkjP8OtYVKMo
	 Ws1lSVQ0FpqQn4Y1ID7UsA93Hf4RS0qXekn4pGM2nLq+XoBH10t+rK4Kw6UOjgMg38
	 +t+s7yRZcIRJIfqJADR+NvGfY8G3g7YCx+mkkRHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgIBPgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:36:01 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:33725 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgIBPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:35:53 -0400
Received: by mail-ej1-f68.google.com with SMTP id j11so1592648ejk.0;
        Wed, 02 Sep 2020 08:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCEsTdInS4YkDl/rs9szjQgucjoUvpkSLEs7mz1t++4=;
        b=kEk0nAFLnXSWcXv04QUfqZACxSxV2guiswkFaOiOmRNF1tQLdNdjULMuRnLEZ7N8JR
         jJ5npkwRgkSbt+n35QgfctPyww+SczPAbwcbR6AgZH/YaO5hFWT08E0UxVYSFyI6/g2L
         Q5iyRUGLaRPHzruy5nDlXkYpn8HqsgbkET0UN9U5cj2C5Q5j7tb26qwi0inCyrbBb0US
         eK7iAn73iL0RTZgiwYA7kZcwFkuLhXwKflsQZqb/ANemPgsYdCV30cOxRIRmdnZQ2yJz
         IcuWRoFSdwAp207yHeyuvLqC9qafw5rYjNPXH3oemLVbLPp1DaksVN+C9X9BpDd66FCc
         De1Q==
X-Gm-Message-State: AOAM53152WQfy7ChpFJl5W0oug90KIJk7VghXafYnT6zJcZ7anRE/BiQ
        88q6QRuIvUZhtkCHr6c9YMOctvtR6WD3oQ==
X-Google-Smtp-Source: ABdhPJzw7TROsNYzuEprNdGNAqhujN6cK49CW6dMCBTEBU/ojNemUw092ImCl/ElfWwyB7tC0pTXIA==
X-Received: by 2002:a17:906:e24f:: with SMTP id gq15mr557382ejb.395.1599060951087;
        Wed, 02 Sep 2020 08:35:51 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id lg22sm4841727ejb.48.2020.09.02.08.35.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 08:35:50 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:35:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 4/4] ARM: dts: exynos: Remove snps,dwc2 compatible in
 Exynos3250
Message-ID: <20200902153547.GA21503@kozik-lap>
References: <20200829172532.29358-1-krzk@kernel.org>
 <20200829172532.29358-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829172532.29358-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 07:25:32PM +0200, Krzysztof Kozlowski wrote:
> The binding for DesignWare HS OTG USB 2.0 in Samsung SoCs take only one
> compatible.  This fixes dtbs_check warnings like:
> 
>   arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: hsotg@12480000:
>     compatible: ['samsung,s3c6400-hsotg', 'snps,dwc2'] is not valid under any of the given schemas (Possible causes of the failure):
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 2 +-

Applied.

Best regards,
Krzysztof

