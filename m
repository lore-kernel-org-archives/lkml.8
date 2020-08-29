Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E948DC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FFF2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598705250;
	bh=G5POm/l/Mhu3agdjYvkhnGvOwZD3JiO8GKxLkcTjquc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xDdMuBqW/8B4EBW5yjJSP3eXo/qp2qyeotPYggDEMyCmtookTdcM9bROuWVz+6wdi
	 c1Y6oCKOSYLYeyf0UvOOJpuKX8XarGicnPMcSV8hVO/D7/4DNHHjhr0CxW48hslrWV
	 g32QnPmWbVaGeuBLNfUXGGfbFfgUlDN441YTjjnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgH2Mr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 08:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2MrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:47:25 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D803B2076D;
        Sat, 29 Aug 2020 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598705244;
        bh=G5POm/l/Mhu3agdjYvkhnGvOwZD3JiO8GKxLkcTjquc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eg76DLMnCHJLD9TjTctYM9MYnxIcGUpVHqVFFj6tbHxkrs0MxBcu2PT01HZpVNYZE
         8JVkIUeSDazqto2+rrp+z8y4f184ATkZEYxo5RSoAEQxLAbsX26vd5k2LtYwyVz7Q2
         e/vMdY1GlOVQtpb+QSHnviv4R/NNmeyWbV1jqA24=
Received: by mail-lf1-f44.google.com with SMTP id c15so1118990lfi.3;
        Sat, 29 Aug 2020 05:47:23 -0700 (PDT)
X-Gm-Message-State: AOAM530W1ldWzY/LyxwgBmg7xuBTUK/wVLfSQnqkDfwsnxA4AtJYAMTI
        a24V2CUhg9MqwFfyCiKrRgABFCyf4vC701wri5A=
X-Google-Smtp-Source: ABdhPJzcHhQ0w6+s+JQElU8amX+yRrFpwwY89WO57XJiqfaEmqSmJnf3iKHZA4vvT44I0LaTWN+qc7YMVUcZ3MNyGoM=
X-Received: by 2002:ac2:42c2:: with SMTP id n2mr1554451lfl.117.1598705242223;
 Sat, 29 Aug 2020 05:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200826171552eucas1p28ace6b1efbcdab420aaa4458ac8bad08@eucas1p2.samsung.com>
 <20200826171529.23618-1-s.nawrocki@samsung.com> <20200826171529.23618-2-s.nawrocki@samsung.com>
In-Reply-To: <20200826171529.23618-2-s.nawrocki@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sat, 29 Aug 2020 21:46:45 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0xP_q6sMYQ4Q8EeLeDjcQX_ZQotHXxE82wVdBP8-aKhQ@mail.gmail.com>
Message-ID: <CAGTfZH0xP_q6sMYQ4Q8EeLeDjcQX_ZQotHXxE82wVdBP8-aKhQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: samsung: exynos5420/5250: Add IDs to the CPU
 parent clk definitions
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

On Thu, Aug 27, 2020 at 2:17 AM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> Use non-zero clock IDs in definitions of the CPU parent clocks
> for exynos5420, exynos5250 SoCs. This will allow us to reference
> the parent clocks directly in the driver by cached struct clk_hw
> pointers, rather than doing clk lookup by name.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5250.c |  4 ++--
>  drivers/clk/samsung/clk-exynos5420.c | 11 ++++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index 931c70a..7bcff76 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -253,14 +253,14 @@ static const struct samsung_mux_clock exynos5250_mux_clks[] __initconst = {
>         /*
>          * CMU_CPU
>          */
> -       MUX_F(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
> +       MUX_F(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
>                                         CLK_SET_RATE_PARENT, 0),
>         MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
>
>         /*
>          * CMU_CORE
>          */
> -       MUX(0, "mout_mpll", mout_mpll_p, SRC_CORE1, 8, 1),
> +       MUX(CLK_MOUT_MPLL, "mout_mpll", mout_mpll_p, SRC_CORE1, 8, 1),
>
>         /*
>          * CMU_TOP
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index f76ebd6..d07cee2 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -596,13 +596,14 @@ static const struct samsung_gate_clock exynos5420_gate_clks[] __initconst = {
>  static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>         MUX(0, "mout_user_pclk66_gpio", mout_user_pclk66_gpio_p,
>                         SRC_TOP7, 4, 1),
> -       MUX(0, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
> -       MUX(0, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
> -
> -       MUX_F(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
> +       MUX(CLK_MOUT_MSPLL_KFC, "mout_mspll_kfc", mout_mspll_cpu_p,
> +           SRC_TOP7, 8, 2),
> +       MUX(CLK_MOUT_MSPLL_CPU, "mout_mspll_cpu", mout_mspll_cpu_p,
> +           SRC_TOP7, 12, 2),
> +       MUX_F(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
>               CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0),
>         MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
> -       MUX_F(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1,
> +       MUX_F(CLK_MOUT_KPLL, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1,
>               CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0),
>         MUX(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
>
> --
> 2.7.4
>

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
