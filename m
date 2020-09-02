Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1A9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D8F204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599061532;
	bh=ijBnkVVdcjhZXwue0wkoqqh2MPDtx6F6WJZtVrmduIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hbeFt4hbZVbTMECesXLImwne+l9TN3w6iKdFY4uw2Vh3iAR0jBwGekmQb783qKR4j
	 VkO1Bj7TP2dehdey66rT8+2Dd2CM2RtiGObzG1MRVDP+8P9QrqMaRheQJpUuzfQsYZ
	 DEG/PWz3/VFji7YkaWc9ZuD4d5RtB01yh1TmmDf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIBPpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:45:30 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:45321 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgIBPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:45:20 -0400
Received: by mail-ej1-f68.google.com with SMTP id i26so7289020ejb.12;
        Wed, 02 Sep 2020 08:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CbjBKHsNFYbmhkSKiXfeqKeTOD9op4yW4EQUpwppWSE=;
        b=QnYSLrjJY9sFpJ+dixZx5uad8EIIplx8kvVmC/kz41Bls/j8v8YYwwwtbPu6JPUqkL
         eGgmpDZMShpK/7/ncnj5c3qIYkapyAWeabF0FC4uoakUpuErBR18Mul9esXML6eoJoh+
         cWhe2TAn/MYy37XsCZRDZCKN2hl6BmjPdhP/LiOArMiCxLVq+/k8CMJIL614HksVgOcD
         oKAjZM1GDwii9sqEKYdFwNVH7wHBlkLrpZuD4amUY+ntaS/sfczCiUlDaANwLpMKsuju
         Z4ss+ewNPQFnvcYeWKqyJ/stMSNsf24IrGFkyEfvYg1dE88ahKrWA0THPA4gWUAsUb4K
         C7bQ==
X-Gm-Message-State: AOAM531yeXwkqUfNrVyXfDEkYtWY+D3oyh8P2bRo01bVtvJ1sHVqCKTk
        bJ+WVj4jx/wWNJdwCUcYFek=
X-Google-Smtp-Source: ABdhPJxbrSCvE1jscskVpGAgJwHs/4bDMu2P/ON+hkWK12T/tM8tjNPSmxTEbAY2t2HS35m9Q9iDnA==
X-Received: by 2002:a17:906:a242:: with SMTP id bi2mr639084ejb.122.1599061506936;
        Wed, 02 Sep 2020 08:45:06 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id l10sm4551399edr.12.2020.09.02.08.45.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 08:45:06 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:45:03 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis GNUtoo Carikli <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 22/33] ARM: dts: exynos: Align MHL GPIO pin configuration
 with dtschema on Galaxy I9100
Message-ID: <20200902154503.GD21503@kozik-lap>
References: <20200830135200.24304-1-krzk@kernel.org>
 <20200830135200.24304-22-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200830135200.24304-22-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 03:51:49PM +0200, Krzysztof Kozlowski wrote:
> Align the name of mag-mhl-gpio node to avoid dtschema confusion and
> dtbs_check warning:
> 
>   arch/arm/boot/dts/exynos4210-i9100.dt.yaml: pinctrl@11000000: mag-mhl-gpio:
>     {'samsung,pins': ['gpd0-2'], 'samsung,pin-function': [[3]], 'samsung,pin-pud': [[0]]} is not of type 'array'
>     From schema: dtschema/schemas/gpio/gpio-consumer.yaml
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos4210-i9100.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied 13-22.

Best regards,
Krzysztof

