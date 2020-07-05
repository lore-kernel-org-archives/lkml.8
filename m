Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1AFC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9D22074F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593973393;
	bh=GbBgUHwVyFNVrox6zXNCfKHMyhGZPd6sbF6NrHKp9Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L2z9A+bwN7wYXWm0eKLt2mKqwEClS155Zxa+JcH/YPeZuqytVC7Nb1mi+iuO/Of2F
	 i6O9RcMZmXtspjb1M0t109MV2THkE0M8ckjoPzj4rv6RJ+yFMC3c5Hl0pTbjmjempX
	 vR3JN6UNOYt+wvF7ciQ6Qknjv5aZXvSNcBR1/7lI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGESXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:23:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54865 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgGESXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:23:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id o8so36806802wmh.4;
        Sun, 05 Jul 2020 11:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ewSbHGUAYFQOAlLNlmtHPlZwLMl/ZdY7qWT4Kwd5Vw=;
        b=Ad3UXYha9OjEjh0YXkJ15BSPKAM7VWhJCi1LOJaCgWH3/lA+Vq+P+6jiNcj+tgpOJn
         68vSW9MQhPrwfEotY/5dzBhDYMpuIBa2YJMzpZMaQ+4yy5m0UZe90fK6nd4K7HiRLGni
         awG4e31MZjxgYnozLA4ckB96oBfN1SF5kwl99DBbRzxOQfvm0PBjOuMXlsFPGxe2sDoR
         cPAOZ8H58jeF2GT99gbyoUbvmaJ/ftXu9bv1CuHHpvwgAK+t4K4m1yc5wvOHrRHpYVLL
         LoKezTy9dr8xjLKUDVmAsLbyAHnK6eZzLBxTvYUPY5ctS1orf66B3q810gPfgVlkc1De
         coKA==
X-Gm-Message-State: AOAM533+Sh0bjEkrob6gnGqWPBCp9eeLKUlNoRYNp0Xd6cBZTl/9yZeR
        0nah54pIFqI6yajbtGG+TqR7WaYH
X-Google-Smtp-Source: ABdhPJxf+h2deTZ0d1sNxH1w2pDDNt/UiEgEEdWTSth3T5lJVshwp5A+S2mwSPC8Fv2zMDbUvcbUIg==
X-Received: by 2002:a1c:7216:: with SMTP id n22mr40486802wmc.189.1593973389531;
        Sun, 05 Jul 2020 11:23:09 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id v11sm57523694wmb.3.2020.07.05.11.23.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Jul 2020 11:23:08 -0700 (PDT)
Date:   Sun, 5 Jul 2020 20:23:06 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v1 2/2] arm64: dts: exynos: keep LDO12 always-on
Message-ID: <20200705182306.GA13827@kozik-lap>
References: <20200705070918.63531-1-alim.akhtar@samsung.com>
 <CGME20200705072938epcas5p479f0d040ca34fd44b2ba893a199efb79@epcas5p4.samsung.com>
 <20200705070918.63531-2-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200705070918.63531-2-alim.akhtar@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 12:39:18PM +0530, Alim Akhtar wrote:
> LDO12 on exynos7 supply power to VDDQ_UFS20_RESET,
> in case this regulator is OFF, UFS host controller
> can not send command to UFS device. To keep this supply
> ON, set regulator-always-on property for this ldo.

Why UFS does not take any supplies? This looks like a workaround for the
case of not implementing any consumer.

Best regards,
Krzysztof


> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index bb86950032d3..92fecc539c6c 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -194,6 +194,7 @@
>  				regulator-min-microvolt = <1000000>;
>  				regulator-max-microvolt = <1300000>;
>  				regulator-enable-ramp-delay = <125>;
> +				regulator-always-on;
>  			};
>  
>  			ldo13_reg: LDO13 {
> -- 
> 2.17.1
> 
