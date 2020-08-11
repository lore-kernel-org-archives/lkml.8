Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E437AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DF4206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1cPlHbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgHKM7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgHKM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:59:20 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A639C06174A;
        Tue, 11 Aug 2020 05:59:20 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a5so12452982ioa.13;
        Tue, 11 Aug 2020 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L4VCtsk+eO3KDXEQLGgJf5dPTkohmyWSCRua6qP4R2w=;
        b=a1cPlHbXG7/oObTe7n/VqHdbhBE414RChB3tSAZkKzywVxmsmOkaNcYbSbj1Gu3Tf/
         krBW5rdDOybwW78WM3g6wNCyn+FPpO4kWF1xwE0uP9sKRUUYeJaaASyfKXD4Qu0M2fSZ
         KWT/1x7WL+z0xPQj0dPBBjH+F3+gielk+5mTUuFIH4kGyXa6cP75FXRLEGst+v+19leQ
         ETON+1EfEtf0Ca34H/+EIPm178wQ2lls6uH+O0/2jEOnq4haURXiVcWQxS+6XgXtwP1Q
         KtQX6ehmrG/lta7w2jrfPlJ1cTh38yFGiL6Stk+N0TgkyWsejmlcNPYDdiPO45+9si19
         6lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L4VCtsk+eO3KDXEQLGgJf5dPTkohmyWSCRua6qP4R2w=;
        b=mwqc2LSCaDzEztfpge6IGNTTeREntsYC5wKJYvatLv1m1JPhkSXspEmwVHeZe0mmj3
         H+ilGJpUFLVRHNZrvxeFX6tftI7HIC04GKeEKS7hCKAPdzuD+7y2cfreRd8I/OiCs3i5
         fZWBsIt2SYYca+5CgFM55m6rUSndfw8TwQsirge1yQFM4K+D2EdaPFMB1QsSa7h3ixGO
         5HqlLQ5XL8/gz9WJn5OzNzrVdA0r0JW1DBjz0rpGYK6+rF/omrgoeYlEy+9iyP/XwNvw
         cXMr2Lv14SW59jbTLH+v4DjGIbMr+T3Z/s8Eh6p2styv2YC2ZyEkZlzMGqn0s9bDAQXw
         uVyg==
X-Gm-Message-State: AOAM53105gTYG8PiXg/4fvTqFwamFDSFJMCInrVGEwYhiRazqEML1C4B
        OF95FOrQA2SPBIMmoyuFpkZD+O2q/RXq8uaoaBE=
X-Google-Smtp-Source: ABdhPJxBD0kIvwYNZDd1trtjbqHvsmieIoGy0VInezlZ4VF7mNZMt70b7JWQPq++ealJfw7STzPt1eDYhWiPv3xFElA=
X-Received: by 2002:a02:95ae:: with SMTP id b43mr25387359jai.19.1597150759578;
 Tue, 11 Aug 2020 05:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54@eucas1p2.samsung.com>
 <20200811112507.24418-1-s.nawrocki@samsung.com>
In-Reply-To: <20200811112507.24418-1-s.nawrocki@samsung.com>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Tue, 11 Aug 2020 14:59:07 +0200
Message-ID: <CA+Ln22Hfys7r2EDstOsdks1X88Fuv77DLTuXLWDynTt4kmiCiQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: samsung: Prevent potential endless loop in the
 PLL set_rate ops
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

2020=E5=B9=B48=E6=9C=8811=E6=97=A5(=E7=81=AB) 13:25 Sylwester Nawrocki <s.n=
awrocki@samsung.com>:
>
> In the .set_rate callback for some PLLs there is a loop polling state
> of the PLL lock bit and it may become an endless loop when something
> goes wrong with the PLL. For some PLLs there is already (a duplicated)
> code for polling with timeout. This patch replaces that code with
> the readl_relaxed_poll_timeout_atomic() macro and moves it to a common
> helper function, which is then used for all the PLLs. The downside
> of switching to the common macro is that we drop the cpu_relax() call.

Tbh. I'm not sure what effect was exactly expected from cpu_relax() in
the functions which already had timeout handling. Could someone shed
some light on this?

> Using a common helper function rather than the macro directly allows
> to avoid repeating the error message in the code and to avoid the object
> code size increase due to inlining.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v2:
>  - use common readl_relaxed_poll_timeout_atomic() macro
> ---
>  drivers/clk/samsung/clk-pll.c | 92 +++++++++++++++----------------------=
------
>  1 file changed, 32 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.=
c
> index ac70ad7..c3c1efe 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -9,13 +9,14 @@
>  #include <linux/errno.h>
>  #include <linux/hrtimer.h>
>  #include <linux/delay.h>
> +#include <linux/iopoll.h>
>  #include <linux/slab.h>
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
>  #include "clk.h"
>  #include "clk-pll.h"
>
> -#define PLL_TIMEOUT_MS         10
> +#define PLL_TIMEOUT_US         10000U

I'm also wondering if 10ms is the universal value that would cover the
oldest PLLs as well, but my loose recollection is that they should
still lock much faster than that. Could you double check that in the
documentation?

Otherwise the patch looks good to me, thanks!

Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz

>
>  struct samsung_clk_pll {
>         struct clk_hw           hw;
> @@ -63,6 +64,22 @@ static long samsung_pll_round_rate(struct clk_hw *hw,
>         return rate_table[i - 1].rate;
>  }
>
> +static int samsung_pll_lock_wait(struct samsung_clk_pll *pll,
> +                                unsigned int reg_mask)
> +{
> +       u32 val;
> +       int ret;
> +
> +       /* Wait until the PLL is in steady locked state */
> +       ret =3D readl_relaxed_poll_timeout_atomic(pll->con_reg, val,
> +                                       val & reg_mask, 0, PLL_TIMEOUT_US=
);
> +       if (ret < 0)
> +               pr_err("%s: Could not lock PLL %s\n",
> +                      __func__, clk_hw_get_name(&pll->hw));
> +
> +       return ret;
> +}
> +
>  static int samsung_pll3xxx_enable(struct clk_hw *hw)
>  {
>         struct samsung_clk_pll *pll =3D to_clk_pll(hw);
> @@ -241,12 +258,9 @@ static int samsung_pll35xx_set_rate(struct clk_hw *h=
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
> @@ -318,7 +332,7 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw=
, unsigned long drate,
>                                         unsigned long parent_rate)
>  {
>         struct samsung_clk_pll *pll =3D to_clk_pll(hw);
> -       u32 tmp, pll_con0, pll_con1;
> +       u32 pll_con0, pll_con1;
>         const struct samsung_pll_rate_table *rate;
>
>         rate =3D samsung_get_pll_settings(pll, drate);
> @@ -356,13 +370,8 @@ static int samsung_pll36xx_set_rate(struct clk_hw *h=
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
> @@ -437,7 +446,6 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw=
, unsigned long drate,
>         struct samsung_clk_pll *pll =3D to_clk_pll(hw);
>         const struct samsung_pll_rate_table *rate;
>         u32 con0, con1;
> -       ktime_t start;
>
>         /* Get required rate settings from table */
>         rate =3D samsung_get_pll_settings(pll, drate);
> @@ -489,20 +497,7 @@ static int samsung_pll45xx_set_rate(struct clk_hw *h=
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
> @@ -588,7 +583,6 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw=
, unsigned long drate,
>         struct samsung_clk_pll *pll =3D to_clk_pll(hw);
>         const struct samsung_pll_rate_table *rate;
>         u32 con0, con1, lock;
> -       ktime_t start;
>
>         /* Get required rate settings from table */
>         rate =3D samsung_get_pll_settings(pll, drate);
> @@ -648,20 +642,7 @@ static int samsung_pll46xx_set_rate(struct clk_hw *h=
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
> @@ -1035,14 +1016,9 @@ static int samsung_pll2550xx_set_rate(struct clk_h=
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
> @@ -1132,13 +1108,9 @@ static int samsung_pll2650x_set_rate(struct clk_hw=
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
> 2.7.4
>
