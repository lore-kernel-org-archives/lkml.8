Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47477C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2407A2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598705236;
	bh=oUo/HmRGIjaVQ1eyTUpvy8/RjDz639TH7CrJfdDF/BI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A6XF77qfmMXUfgTn+Tu/ktgdl3F2x0zcoZPU/pjdJyLi5OMayn9ITej+Ke2kn4u8B
	 szmudT+0jPiGl7Bp4s3nEaKmamPFacfEHABZ3iym5BQgGNfwKggZKTS0CtQcEfjNv9
	 AQeuN3jr1+c0uqOoFIIPuTeFSjZQXn6u+RS6SbeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgH2MrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 08:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2MrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:47:09 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C11207DA;
        Sat, 29 Aug 2020 12:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598705228;
        bh=oUo/HmRGIjaVQ1eyTUpvy8/RjDz639TH7CrJfdDF/BI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ihjt3o12At8Ekp1TS74TIWJsMdHHkp254RtPSrcEM4YmUmr6aG5hr9TS4TwdHbOXs
         hTr0ZaVnZ0N6yWv//eFcXcCP0Fts7/Rri8pLI8CcojH+Qo5LVHV/2D2+BZYEBgnU9L
         CTVWlMxCKmC9pg8fGp1gntcqwciewCFt/8q3Yjq8=
Received: by mail-lf1-f44.google.com with SMTP id k10so1107239lfm.5;
        Sat, 29 Aug 2020 05:47:07 -0700 (PDT)
X-Gm-Message-State: AOAM531NjSXIO0PpxeUzLWitczuMXynJfSTpPzXubbCE74JTj7R17WqI
        cSOosvUm3NpydmNmOWeP5/7UpFFGqAKPtCqFoVM=
X-Google-Smtp-Source: ABdhPJxgGgIqqL+z8yejEctXevu1FZNCnfuqdpf64nAPg35qWMWW0LskVaaTWC4Rbirzia4fRj+fCXLscd+uF9R/Qp4=
X-Received: by 2002:ac2:55bb:: with SMTP id y27mr1558371lfg.107.1598705226106;
 Sat, 29 Aug 2020 05:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200826171539eucas1p2e999972d3e7dd6dd701e312548933e87@eucas1p2.samsung.com>
 <20200826171529.23618-1-s.nawrocki@samsung.com>
In-Reply-To: <20200826171529.23618-1-s.nawrocki@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sat, 29 Aug 2020 21:46:28 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1Pzs3W4d-3+wNFw4PZVa4KD-2qEdD=oXTHyPRLPeUwBg@mail.gmail.com>
Message-ID: <CAGTfZH1Pzs3W4d-3+wNFw4PZVa4KD-2qEdD=oXTHyPRLPeUwBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: samsung: Add clk ID definitions for the CPU
 parent clocks
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     linux-clk@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On Thu, Aug 27, 2020 at 2:16 AM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> Add clock ID definitions for the CPU parent clocks for SoCs
> which don't have such definitions yet. This will allow us to
> reference the parent clocks directly by cached struct clk_hw
> pointers in the clock provider, rather than doing clk lookup
> by name.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  include/dt-bindings/clock/exynos5250.h | 4 +++-
>  include/dt-bindings/clock/exynos5420.h | 5 +++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
> index bc8a3c5..e259cc0 100644
> --- a/include/dt-bindings/clock/exynos5250.h
> +++ b/include/dt-bindings/clock/exynos5250.h
> @@ -172,8 +172,10 @@
>  #define CLK_MOUT_GPLL          1025
>  #define CLK_MOUT_ACLK200_DISP1_SUB     1026
>  #define CLK_MOUT_ACLK300_DISP1_SUB     1027
> +#define CLK_MOUT_APLL          1028
> +#define CLK_MOUT_MPLL          1029
>
>  /* must be greater than maximal clock id */
> -#define CLK_NR_CLKS            1028
> +#define CLK_NR_CLKS            1030
>
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5250_H */
> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
> index ff917c8..9fffc6c 100644
> --- a/include/dt-bindings/clock/exynos5420.h
> +++ b/include/dt-bindings/clock/exynos5420.h
> @@ -231,6 +231,11 @@
>  #define CLK_MOUT_SCLK_SPLL     660
>  #define CLK_MOUT_MX_MSPLL_CCORE_PHY    661
>  #define CLK_MOUT_SW_ACLK_G3D   662
> +#define CLK_MOUT_APLL          663
> +#define CLK_MOUT_MSPLL_CPU     664
> +#define CLK_MOUT_KPLL          665
> +#define CLK_MOUT_MSPLL_KFC     666
> +
>
>  /* divider clocks */
>  #define CLK_DOUT_PIXEL         768
> --
> 2.7.4
>

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
