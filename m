Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D02C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B8323119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEE+LFon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgHFQ7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbgHFQkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:40:42 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F90C00216F;
        Thu,  6 Aug 2020 09:11:46 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z3so30689532ilh.3;
        Thu, 06 Aug 2020 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SALjLR3myMkdR3uhiNDrkIW0bJXa5yZIDqj4S53HXjM=;
        b=tEE+LFonFqYAn+0LuKS2dxu00jPEZm4sOUuRn1HVlbe/OlLy0N+RoxJ6GZ4stS/Fmn
         I8gZtSAOdge7AGglK35Bd6h9WesYHuVt+kUNXr8a8f2A+Ut3lkT74tF4cRkSdhFY7Ng9
         R7cuMrvgc/zCbcXBR7+kqPoclrHG/QgL9DURLoaSxBRtTlQKQpXG3pEv827CpN1WeKN1
         r6u8rAoevIgAkugOORCtf5MQZ5u5ncs8CDB7zlzLPlZgwEb444xPbBIA2TTW6xM2M/+z
         7cGBHYNRzYHs9h5op7as06Qi/MHk0oX9SpJxf6xtMnxtsdqQR1LZ/aiV/JBNsYTeEeT3
         PJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SALjLR3myMkdR3uhiNDrkIW0bJXa5yZIDqj4S53HXjM=;
        b=L+/tlRS0a/PHLByNEw3qltHcRyGp7CR8FOPY8PtPVGyrg6QTiRdgQ1ybiA+qL+Lv/F
         UXkKa+32U/wp8Co7QJjrHCQ9J9XzMeQNVuLT5XSyFIz9dfRqlBHrmPyvcqyDDEVVHxxz
         nFUT2tENouy4UBfdXfXq8qqxyS/kzEw1d0W5/u6Q/AXr0ieSpv539OMc3/5ATIWFPc8V
         7Ufvx/NDaAX/52w/Hjb/NCpUMEnbazq3FYmhitP+nzhz0mZeUo2RmKWOvyF3coMHUlpX
         1GtMGa1nd8sjYwRpgXJRMH4FVRVIpSheLAISsFcB1GpbVJZk+L8C5Vrk+hujt2a4EaZw
         kU3A==
X-Gm-Message-State: AOAM531XZcMvMKfE4kXOtoL4btfUeeqywkosLYKxbijLJe/1tf5pk4Gn
        b7EUS6TzlEL+qtrg924yuG3qMhPmvTOXSVIQHiY=
X-Google-Smtp-Source: ABdhPJzCvgp1VQ7dfviQns9lRkbVGee+ASA6F4+by6tRrBJAe0uFr4NZhxA63R8qOChVpC9S+ec3LNkXQBU3xINxhQk=
X-Received: by 2002:a92:8946:: with SMTP id n67mr12395030ild.168.1596730305803;
 Thu, 06 Aug 2020 09:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f@eucas1p2.samsung.com>
 <20200806160646.1997-1-s.nawrocki@samsung.com>
In-Reply-To: <20200806160646.1997-1-s.nawrocki@samsung.com>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Thu, 6 Aug 2020 18:11:32 +0200
Message-ID: <CA+Ln22HGSj4gFRmw1rSLaTvw3TiPC9jaM6JB4Z1fbxpwsWNZWw@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: Prevent potential endless loop in the PLL
 set_rate ops
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

2020=E5=B9=B48=E6=9C=886=E6=97=A5(=E6=9C=A8) 18:06 Sylwester Nawrocki <s.na=
wrocki@samsung.com>:
>
> In the .set_rate callback for some PLLs there is a loop polling state
> of the PLL lock bit and it may become an endless loop when something
> goes wrong with the PLL. For some PLLs there is already (duplicated)
> code for polling with a timeout. This patch refactors that code a bit
> and moves it to a common helper function which is then used
> in .set_rate callbacks for all the PLLs.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-pll.c | 94 +++++++++++++----------------------
>  1 file changed, 35 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.=
c
> index ac70ad785d8e..0929644be99a 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -63,6 +63,27 @@ static long samsung_pll_round_rate(struct clk_hw *hw,
>         return rate_table[i - 1].rate;
>  }
>
> +static int samsung_pll_lock_wait(struct samsung_clk_pll *pll,
> +                                unsigned int reg_mask)
> +{
> +       ktime_t timeout;
> +
> +       /* Wait until the PLL is in steady locked state */
> +       timeout =3D ktime_add_ms(ktime_get(), PLL_TIMEOUT_MS);
> +
> +       while (!(readl_relaxed(pll->con_reg) & reg_mask)) {
> +               if (ktime_after(ktime_get(), timeout)) {
> +                       pr_err("%s: Could not lock PLL %s\n",
> +                               __func__, clk_hw_get_name(&pll->hw));
> +                       return -EFAULT;
> +               }
> +
> +               cpu_relax();
> +       }

Thanks for the patch! Good to have this consolidated. How about going
one step further and using the generic
readl_relaxed_poll_timeout_atomic() helper?

Best regards,
Tomasz

> +
> +       return 0;
> +}
> +
>  static int samsung_pll3xxx_enable(struct clk_hw *hw)
>  {
>         struct samsung_clk_pll *pll =3D to_clk_pll(hw);
> @@ -241,12 +262,9 @@ static int samsung_pll35xx_set_rate(struct clk_hw *h=
w, unsigned long drate,
>         writel_relaxed(tmp, pll->con_reg);
>
>         /* Wait until the PLL is locked if it is enabled. */
> -       if (tmp & BIT(pll->enable_offs)) {
> -               do {
> -                       cpu_relax();
> -                       tmp =3D readl_relaxed(pll->con_reg);
> -               } while (!(tmp & BIT(pll->lock_offs)));
> -       }
> +       if (tmp & BIT(pll->enable_offs))
> +               return samsung_pll_lock_wait(pll, BIT(pll->lock_offs));
> +
>         return 0;
>  }
>
> @@ -318,7 +336,7 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw=
, unsigned long drate,
>                                         unsigned long parent_rate)
>  {
>         struct samsung_clk_pll *pll =3D to_clk_pll(hw);
> -       u32 tmp, pll_con0, pll_con1;
> +       u32 pll_con0, pll_con1;
>         const struct samsung_pll_rate_table *rate;
>
>         rate =3D samsung_get_pll_settings(pll, drate);
> @@ -356,13 +374,8 @@ static int samsung_pll36xx_set_rate(struct clk_hw *h=
w, unsigned long drate,
>         pll_con1 |=3D rate->kdiv << PLL36XX_KDIV_SHIFT;
>         writel_relaxed(pll_con1, pll->con_reg + 4);
>
> -       /* wait_lock_time */
> -       if (pll_con0 & BIT(pll->enable_offs)) {
> -               do {
> -                       cpu_relax();
> -                       tmp =3D readl_relaxed(pll->con_reg);
> -               } while (!(tmp & BIT(pll->lock_offs)));
> -       }
> +       if (pll_con0 & BIT(pll->enable_offs))
> +               return samsung_pll_lock_wait(pll, BIT(pll->lock_offs));
>
>         return 0;
>  }
> @@ -437,7 +450,6 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw=
, unsigned long drate,
>         struct samsung_clk_pll *pll =3D to_clk_pll(hw);
>         const struct samsung_pll_rate_table *rate;
>         u32 con0, con1;
> -       ktime_t start;
>
>         /* Get required rate settings from table */
>         rate =3D samsung_get_pll_settings(pll, drate);
> @@ -489,20 +501,7 @@ static int samsung_pll45xx_set_rate(struct clk_hw *h=
w, unsigned long drate,
>         writel_relaxed(con0, pll->con_reg);
>
>         /* Wait for locking. */
> -       start =3D ktime_get();
> -       while (!(readl_relaxed(pll->con_reg) & PLL45XX_LOCKED)) {
> -               ktime_t delta =3D ktime_sub(ktime_get(), start);
> -
> -               if (ktime_to_ms(delta) > PLL_TIMEOUT_MS) {
> -                       pr_err("%s: could not lock PLL %s\n",
> -                                       __func__, clk_hw_get_name(hw));
> -                       return -EFAULT;
> -               }
> -
> -               cpu_relax();
> -       }
> -
> -       return 0;
> +       return samsung_pll_lock_wait(pll, PLL45XX_LOCKED);
>  }
>
>  static const struct clk_ops samsung_pll45xx_clk_ops =3D {
> @@ -588,7 +587,6 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw=
, unsigned long drate,
>         struct samsung_clk_pll *pll =3D to_clk_pll(hw);
>         const struct samsung_pll_rate_table *rate;
>         u32 con0, con1, lock;
> -       ktime_t start;
>
>         /* Get required rate settings from table */
>         rate =3D samsung_get_pll_settings(pll, drate);
> @@ -648,20 +646,7 @@ static int samsung_pll46xx_set_rate(struct clk_hw *h=
w, unsigned long drate,
>         writel_relaxed(con1, pll->con_reg + 0x4);
>
>         /* Wait for locking. */
> -       start =3D ktime_get();
> -       while (!(readl_relaxed(pll->con_reg) & PLL46XX_LOCKED)) {
> -               ktime_t delta =3D ktime_sub(ktime_get(), start);
> -
> -               if (ktime_to_ms(delta) > PLL_TIMEOUT_MS) {
> -                       pr_err("%s: could not lock PLL %s\n",
> -                                       __func__, clk_hw_get_name(hw));
> -                       return -EFAULT;
> -               }
> -
> -               cpu_relax();
> -       }
> -
> -       return 0;
> +       return samsung_pll_lock_wait(pll, PLL46XX_LOCKED);
>  }
>
>  static const struct clk_ops samsung_pll46xx_clk_ops =3D {
> @@ -1035,14 +1020,9 @@ static int samsung_pll2550xx_set_rate(struct clk_h=
w *hw, unsigned long drate,
>                         (rate->sdiv << PLL2550XX_S_SHIFT);
>         writel_relaxed(tmp, pll->con_reg);
>
> -       /* wait_lock_time */
> -       do {
> -               cpu_relax();
> -               tmp =3D readl_relaxed(pll->con_reg);
> -       } while (!(tmp & (PLL2550XX_LOCK_STAT_MASK
> -                       << PLL2550XX_LOCK_STAT_SHIFT)));
> -
> -       return 0;
> +       /* Wait for locking. */
> +       return samsung_pll_lock_wait(pll,
> +                       PLL2550XX_LOCK_STAT_MASK << PLL2550XX_LOCK_STAT_S=
HIFT);
>  }
>
>  static const struct clk_ops samsung_pll2550xx_clk_ops =3D {
> @@ -1132,13 +1112,9 @@ static int samsung_pll2650x_set_rate(struct clk_hw=
 *hw, unsigned long drate,
>         con1 |=3D ((rate->kdiv & PLL2650X_K_MASK) << PLL2650X_K_SHIFT);
>         writel_relaxed(con1, pll->con_reg + 4);
>
> -       do {
> -               cpu_relax();
> -               con0 =3D readl_relaxed(pll->con_reg);
> -       } while (!(con0 & (PLL2650X_LOCK_STAT_MASK
> -                       << PLL2650X_LOCK_STAT_SHIFT)));
> -
> -       return 0;
> +       /* Wait for locking. */
> +       return samsung_pll_lock_wait(pll,
> +                       PLL2650X_LOCK_STAT_MASK << PLL2650X_LOCK_STAT_SHI=
FT);
>  }
>
>  static const struct clk_ops samsung_pll2650x_clk_ops =3D {
> --
> 2.17.1
>
