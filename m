Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286B2C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED58F2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598705280;
	bh=fJktu3ahF1FVQuNFFBTQ35Th6ZWE0a9/I1RH/h9FSwA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ddoQmyRrPEAobup8NcylrSPNzWWEJ39m2/N31l5japn2gJ/ceB6PNRScoBKgB22Zg
	 u7N6DniFJk2TBKr86zBv1tU1mYmrZjhyVzAP5BayPpITPO4V4vSyQvEJ8S/k4byR6k
	 edE+bnFfZRMET3bmvcmYozYHZGohEchHqv9aVXy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgH2Mr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 08:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2Mrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:47:48 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7242100A;
        Sat, 29 Aug 2020 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598705266;
        bh=fJktu3ahF1FVQuNFFBTQ35Th6ZWE0a9/I1RH/h9FSwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=crPFJsHmwlFBie/DSBpMbxl6eJg+wCbAJ+0cEkj0OI39rx0m6KUN23ClRHDMxRgrR
         F6pt3ClncEOzGp/5YNSFHgxvDkX/fHMCbOBsVJYce2G0YwmVt8dEHyaucI3lr22hmt
         gCIT3VnViJtRdb+Q0VPwpnu4wRjWdZxFLyPRU+Z4=
Received: by mail-lj1-f173.google.com with SMTP id r13so1832701ljm.0;
        Sat, 29 Aug 2020 05:47:45 -0700 (PDT)
X-Gm-Message-State: AOAM532R2UVZM40UgCanY+LARWliKOR7eAH+kWknzcHnBlGv4Vn3xHBw
        qNiLjt02tgiPLwaOmBp4pPBZsHMPKzvF42bwgpo=
X-Google-Smtp-Source: ABdhPJyzthbGgmBfZI08GFl27HKIqHG+6L6i/US067Bfp/P+u4qd81cgLzVFMPa5TcRRg/qayBA3NOBB2inQT40raME=
X-Received: by 2002:a2e:320c:: with SMTP id y12mr1427799ljy.399.1598705263670;
 Sat, 29 Aug 2020 05:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200826171557eucas1p13c960ad6abc814cf53bc125f5c4d9b39@eucas1p1.samsung.com>
 <20200826171529.23618-1-s.nawrocki@samsung.com> <20200826171529.23618-3-s.nawrocki@samsung.com>
In-Reply-To: <20200826171529.23618-3-s.nawrocki@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sat, 29 Aug 2020 21:47:06 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1chnWd85GSG7NGLkA3tvCteULenyepB9GvQYmm_-eW-Q@mail.gmail.com>
Message-ID: <CAGTfZH1chnWd85GSG7NGLkA3tvCteULenyepB9GvQYmm_-eW-Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: samsung: Use cached clk_hws instead of
 __clk_lookup() calls
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
> For the CPU clock registration two parent clocks are required, these
> are now being passed as struct clk_hw pointers, rather than by the
> global scope names. That allows us to avoid  __clk_lookup() calls
> and simplifies a bit the CPU clock registration function.
> While at it drop unneeded extern keyword in the function declaration.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-cpu.c        | 37 +++++++++++++++---------------------
>  drivers/clk/samsung/clk-cpu.h        |  6 +++---
>  drivers/clk/samsung/clk-exynos3250.c |  6 ++++--
>  drivers/clk/samsung/clk-exynos4.c    |  7 +++++--
>  drivers/clk/samsung/clk-exynos5250.c |  4 +++-
>  drivers/clk/samsung/clk-exynos5420.c |  6 +++---
>  drivers/clk/samsung/clk-exynos5433.c | 10 ++++++++--
>  7 files changed, 41 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
> index efc4fa6..00ef4d1 100644
> --- a/drivers/clk/samsung/clk-cpu.c
> +++ b/drivers/clk/samsung/clk-cpu.c
> @@ -401,26 +401,34 @@ static int exynos5433_cpuclk_notifier_cb(struct notifier_block *nb,
>
>  /* helper function to register a CPU clock */
>  int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
> -               unsigned int lookup_id, const char *name, const char *parent,
> -               const char *alt_parent, unsigned long offset,
> -               const struct exynos_cpuclk_cfg_data *cfg,
> +               unsigned int lookup_id, const char *name,
> +               const struct clk_hw *parent, const struct clk_hw *alt_parent,
> +               unsigned long offset, const struct exynos_cpuclk_cfg_data *cfg,
>                 unsigned long num_cfgs, unsigned long flags)
>  {
>         struct exynos_cpuclk *cpuclk;
>         struct clk_init_data init;
> -       struct clk *parent_clk;
> +       const char *parent_name;
>         int ret = 0;
>
> +       if (IS_ERR(parent) || IS_ERR(alt_parent)) {
> +               pr_err("%s: invalid parent clock(s)\n", __func__);
> +               return -EINVAL;
> +       }
> +
>         cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
>         if (!cpuclk)
>                 return -ENOMEM;
>
> +       parent_name = clk_hw_get_name(parent);
> +
>         init.name = name;
>         init.flags = CLK_SET_RATE_PARENT;
> -       init.parent_names = &parent;
> +       init.parent_names = &parent_name;
>         init.num_parents = 1;
>         init.ops = &exynos_cpuclk_clk_ops;
>
> +       cpuclk->alt_parent = alt_parent;
>         cpuclk->hw.init = &init;
>         cpuclk->ctrl_base = ctx->reg_base + offset;
>         cpuclk->lock = &ctx->lock;
> @@ -430,23 +438,8 @@ int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
>         else
>                 cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
>
> -       cpuclk->alt_parent = __clk_get_hw(__clk_lookup(alt_parent));
> -       if (!cpuclk->alt_parent) {
> -               pr_err("%s: could not lookup alternate parent %s\n",
> -                               __func__, alt_parent);
> -               ret = -EINVAL;
> -               goto free_cpuclk;
> -       }
> -
> -       parent_clk = __clk_lookup(parent);
> -       if (!parent_clk) {
> -               pr_err("%s: could not lookup parent clock %s\n",
> -                               __func__, parent);
> -               ret = -EINVAL;
> -               goto free_cpuclk;
> -       }
>
> -       ret = clk_notifier_register(parent_clk, &cpuclk->clk_nb);
> +       ret = clk_notifier_register(parent->clk, &cpuclk->clk_nb);
>         if (ret) {
>                 pr_err("%s: failed to register clock notifier for %s\n",
>                                 __func__, name);
> @@ -471,7 +464,7 @@ int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
>  free_cpuclk_data:
>         kfree(cpuclk->cfg);
>  unregister_clk_nb:
> -       clk_notifier_unregister(parent_clk, &cpuclk->clk_nb);
> +       clk_notifier_unregister(parent->clk, &cpuclk->clk_nb);
>  free_cpuclk:
>         kfree(cpuclk);
>         return ret;
> diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
> index ad38cc2..af74686 100644
> --- a/drivers/clk/samsung/clk-cpu.h
> +++ b/drivers/clk/samsung/clk-cpu.h
> @@ -46,7 +46,7 @@ struct exynos_cpuclk_cfg_data {
>   */
>  struct exynos_cpuclk {
>         struct clk_hw                           hw;
> -       struct clk_hw                           *alt_parent;
> +       const struct clk_hw                     *alt_parent;
>         void __iomem                            *ctrl_base;
>         spinlock_t                              *lock;
>         const struct exynos_cpuclk_cfg_data     *cfg;
> @@ -62,9 +62,9 @@ struct exynos_cpuclk {
>  #define CLK_CPU_HAS_E5433_REGS_LAYOUT  (1 << 2)
>  };
>
> -extern int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
> +int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
>                         unsigned int lookup_id, const char *name,
> -                       const char *parent, const char *alt_parent,
> +                       const struct clk_hw *parent, const struct clk_hw *alt_parent,
>                         unsigned long offset,
>                         const struct exynos_cpuclk_cfg_data *cfg,
>                         unsigned long num_cfgs, unsigned long flags);
> diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
> index 17897c7..17df7f9 100644
> --- a/drivers/clk/samsung/clk-exynos3250.c
> +++ b/drivers/clk/samsung/clk-exynos3250.c
> @@ -808,14 +808,16 @@ static const struct exynos_cpuclk_cfg_data e3250_armclk_d[] __initconst = {
>  static void __init exynos3250_cmu_init(struct device_node *np)
>  {
>         struct samsung_clk_provider *ctx;
> +       struct clk_hw **hws;
>
>         ctx = samsung_cmu_register_one(np, &cmu_info);
>         if (!ctx)
>                 return;
>
> +       hws = ctx->clk_data.hws;
>         exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
> -                       mout_core_p[0], mout_core_p[1], 0x14200,
> -                       e3250_armclk_d, ARRAY_SIZE(e3250_armclk_d),
> +                       hws[CLK_MOUT_APLL], hws[CLK_MOUT_MPLL_USER_C],
> +                       0x14200, e3250_armclk_d, ARRAY_SIZE(e3250_armclk_d),
>                         CLK_CPU_HAS_DIV1);
>
>         exynos3_core_down_clock(ctx->reg_base);
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index 51564fc..436fcd2 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -1233,6 +1233,8 @@ static void __init exynos4_clk_init(struct device_node *np,
>                                     enum exynos4_soc soc)
>  {
>         struct samsung_clk_provider *ctx;
> +       struct clk_hw **hws;
> +
>         exynos4_soc = soc;
>
>         reg_base = of_iomap(np, 0);
> @@ -1240,6 +1242,7 @@ static void __init exynos4_clk_init(struct device_node *np,
>                 panic("%s: failed to map registers\n", __func__);
>
>         ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
> +       hws = ctx->clk_data.hws;
>
>         samsung_clk_of_register_fixed_ext(ctx, exynos4_fixed_rate_ext_clks,
>                         ARRAY_SIZE(exynos4_fixed_rate_ext_clks),
> @@ -1302,7 +1305,7 @@ static void __init exynos4_clk_init(struct device_node *np,
>                         exynos4210_fixed_factor_clks,
>                         ARRAY_SIZE(exynos4210_fixed_factor_clks));
>                 exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
> -                       mout_core_p4210[0], mout_core_p4210[1], 0x14200,
> +                       hws[CLK_MOUT_APLL], hws[CLK_SCLK_MPLL], 0x14200,
>                         e4210_armclk_d, ARRAY_SIZE(e4210_armclk_d),
>                         CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1);
>         } else {
> @@ -1317,7 +1320,7 @@ static void __init exynos4_clk_init(struct device_node *np,
>                         ARRAY_SIZE(exynos4x12_fixed_factor_clks));
>
>                 exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
> -                       mout_core_p4x12[0], mout_core_p4x12[1], 0x14200,
> +                       hws[CLK_MOUT_APLL], hws[CLK_MOUT_MPLL_USER_C], 0x14200,
>                         e4412_armclk_d, ARRAY_SIZE(e4412_armclk_d),
>                         CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1);
>         }
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index 7bcff76..06588fa 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -782,6 +782,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
>  {
>         struct samsung_clk_provider *ctx;
>         unsigned int tmp;
> +       struct clk_hw **hws;
>
>         if (np) {
>                 reg_base = of_iomap(np, 0);
> @@ -792,6 +793,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
>         }
>
>         ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
> +       hws = ctx->clk_data.hws;
>
>         samsung_clk_of_register_fixed_ext(ctx, exynos5250_fixed_rate_ext_clks,
>                         ARRAY_SIZE(exynos5250_fixed_rate_ext_clks),
> @@ -821,7 +823,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
>         samsung_clk_register_gate(ctx, exynos5250_gate_clks,
>                         ARRAY_SIZE(exynos5250_gate_clks));
>         exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
> -                       mout_cpu_p[0], mout_cpu_p[1], 0x200,
> +                       hws[CLK_MOUT_APLL], hws[CLK_MOUT_MPLL], 0x200,
>                         exynos5250_armclk_d, ARRAY_SIZE(exynos5250_armclk_d),
>                         CLK_CPU_HAS_DIV1);
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index d07cee2..ba4e0a4 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1625,15 +1625,15 @@ static void __init exynos5x_clk_init(struct device_node *np,
>
>         if (soc == EXYNOS5420) {
>                 exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
> -                       mout_cpu_p[0], mout_cpu_p[1], 0x200,
> +                       hws[CLK_MOUT_APLL], hws[CLK_MOUT_MSPLL_CPU], 0x200,
>                         exynos5420_eglclk_d, ARRAY_SIZE(exynos5420_eglclk_d), 0);
>         } else {
>                 exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
> -                       mout_cpu_p[0], mout_cpu_p[1], 0x200,
> +                       hws[CLK_MOUT_APLL], hws[CLK_MOUT_MSPLL_CPU], 0x200,
>                         exynos5800_eglclk_d, ARRAY_SIZE(exynos5800_eglclk_d), 0);
>         }
>         exynos_register_cpu_clock(ctx, CLK_KFC_CLK, "kfcclk",
> -               mout_kfc_p[0], mout_kfc_p[1], 0x28200,
> +               hws[CLK_MOUT_KPLL], hws[CLK_MOUT_MSPLL_KFC],  0x28200,
>                 exynos5420_kfcclk_d, ARRAY_SIZE(exynos5420_kfcclk_d), 0);
>
>         samsung_clk_extended_sleep_init(reg_base,
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index 6f29ecd..f203074 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -3679,6 +3679,7 @@ static void __init exynos5433_cmu_apollo_init(struct device_node *np)
>  {
>         void __iomem *reg_base;
>         struct samsung_clk_provider *ctx;
> +       struct clk_hw **hws;
>
>         reg_base = of_iomap(np, 0);
>         if (!reg_base) {
> @@ -3701,8 +3702,10 @@ static void __init exynos5433_cmu_apollo_init(struct device_node *np)
>         samsung_clk_register_gate(ctx, apollo_gate_clks,
>                                   ARRAY_SIZE(apollo_gate_clks));
>
> +       hws = ctx->clk_data.hws;
> +
>         exynos_register_cpu_clock(ctx, CLK_SCLK_APOLLO, "apolloclk",
> -               mout_apollo_p[0], mout_apollo_p[1], 0x200,
> +               hws[CLK_MOUT_APOLLO_PLL], hws[CLK_MOUT_BUS_PLL_APOLLO_USER], 0x200,
>                 exynos5433_apolloclk_d, ARRAY_SIZE(exynos5433_apolloclk_d),
>                 CLK_CPU_HAS_E5433_REGS_LAYOUT);
>
> @@ -3933,6 +3936,7 @@ static void __init exynos5433_cmu_atlas_init(struct device_node *np)
>  {
>         void __iomem *reg_base;
>         struct samsung_clk_provider *ctx;
> +       struct clk_hw **hws;
>
>         reg_base = of_iomap(np, 0);
>         if (!reg_base) {
> @@ -3955,8 +3959,10 @@ static void __init exynos5433_cmu_atlas_init(struct device_node *np)
>         samsung_clk_register_gate(ctx, atlas_gate_clks,
>                                   ARRAY_SIZE(atlas_gate_clks));
>
> +       hws = ctx->clk_data.hws;
> +
>         exynos_register_cpu_clock(ctx, CLK_SCLK_ATLAS, "atlasclk",
> -               mout_atlas_p[0], mout_atlas_p[1], 0x200,
> +               hws[CLK_MOUT_ATLAS_PLL], hws[CLK_MOUT_BUS_PLL_ATLAS_USER], 0x200,
>                 exynos5433_atlasclk_d, ARRAY_SIZE(exynos5433_atlasclk_d),
>                 CLK_CPU_HAS_E5433_REGS_LAYOUT);
>
> --
> 2.7.4
>

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
