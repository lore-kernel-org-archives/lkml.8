Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30D8C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806C02067C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580437449;
	bh=Pdxga/qBDj47DdXwGIqcfTTBY4CMNcMT8UfysrEQFZ0=;
	h=In-Reply-To:References:Subject:To:From:Cc:Date:List-ID:From;
	b=wDX8KMZNjiDWSMJtIsfzu44Gc5o+6VtlcCbWnFPg3q+FFyA7HsoNDbwHunDUiYekJ
	 1M7n5v6ZJCUibhymXdFNRDXhaT+o/CiqBDXc8sbLMGL+uKBw5PWOt30s18OZGjbK7e
	 mkgHoy6x9s5JZb2E3z2JqEGau6EWkp9i89nBNH4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgAaCYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:24:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgAaCYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:24:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98E72067C;
        Fri, 31 Jan 2020 02:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580437445;
        bh=Pdxga/qBDj47DdXwGIqcfTTBY4CMNcMT8UfysrEQFZ0=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=j6AcT4A7x2FP3//mNrW0JwEfQGov7QQNPcA7PEUkP9KZZmmRQ4QORh9smjEIZOSU3
         9LNG9H6HsD6XCbiaWuSLhvxVaS84ATeoJenbHAHum5Hy+4cYHiot9DhEtFYzYlH+u2
         JACEQfO41kkzH3tgNhJJ3YycnBmNV5CzBXDSh8jY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <03edda37330a2b517b98afe0de99f082758a2219.1580374761.git.rahul.tanwar@linux.intel.com>
References: <cover.1580374761.git.rahul.tanwar@linux.intel.com> <03edda37330a2b517b98afe0de99f082758a2219.1580374761.git.rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v4 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, robh@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        rtanwar <rahul.tanwar@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
User-Agent: alot/0.8.1
Date:   Thu, 30 Jan 2020 18:24:04 -0800
Message-Id: <20200131022405.B98E72067C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2020-01-30 01:04:02)
> From: rtanwar <rahul.tanwar@intel.com>
>=20
> Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming

Can you say what IP it is? Something about Lightning Mountain?

> Intel network processor SoC. It provides programming interfaces to control
> & configure all CPU & peripheral clocks. Add common clock framework based
> clock controller driver for CGU.
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>

> diff --git a/drivers/clk/x86/Kconfig b/drivers/clk/x86/Kconfig
> new file mode 100644
> index 000000000000..76ca6d2899bf
> --- /dev/null
> +++ b/drivers/clk/x86/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config CLK_LGM_CGU

Can you add a depends on x86 || COMPILE_TEST line here?

> +       depends on OF && X86 && HAS_IOMEM

And remove X86 from here? That way we can compile test this driver.

> +       select OF_EARLY_FLATTREE
> +       bool "Clock driver for Lightning Mountain(LGM) platform"
> +       help
> +         Clock Generation Unit(CGU) driver for Intel Lightning Mountain(=
LGM)
> +         network processor SoC.
> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
> index e3ec81e2a1c2..7c774ea7ddeb 100644
> --- a/drivers/clk/x86/Makefile
> +++ b/drivers/clk/x86/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_PMC_ATOM)          +=3D clk-pmc-atom.o
>  obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)  +=3D clk-st.o
>  clk-x86-lpss-objs              :=3D clk-lpt.o
>  obj-$(CONFIG_X86_INTEL_LPSS)   +=3D clk-x86-lpss.o
> +obj-$(CONFIG_CLK_LGM_CGU)      +=3D clk-cgu.o clk-cgu-pll.o clk-lgm.o
> diff --git a/drivers/clk/x86/clk-cgu-pll.c b/drivers/clk/x86/clk-cgu-pll.c
> new file mode 100644
> index 000000000000..59efb1cfcf1b
> --- /dev/null
> +++ b/drivers/clk/x86/clk-cgu-pll.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + * Zhu YiXin <yixin.zhu@intel.com>
> + * Rahul Tanwar <rahul.tanwar@intel.com>
> + */
> +
> +#include <linux/clk.h>

Is this include used? Please try to avoid having clk.h and
clk-provider.h included in the same file.

> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Is clkdev used?

> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#include "clk-cgu.h"
> +
> +#define to_lgm_clk_pll(_hw)    container_of(_hw, struct lgm_clk_pll, hw)
> +
> +/*
> + * Calculate formula:
> + * rate =3D (prate * mult + (prate * frac) / frac_div) / div
> + */
> +static unsigned long
> +lgm_pll_calc_rate(unsigned long prate, unsigned int mult,
> +                 unsigned int div, unsigned int frac, unsigned int frac_=
div)
> +{
> +       u64 crate, frate, rate64;
> +
> +       rate64 =3D prate;
> +       crate =3D rate64 * mult;
> +       frate =3D rate64 * frac;
> +       do_div(frate, frac_div);
> +       crate +=3D frate;
> +       do_div(crate, div);
> +
> +       return (unsigned long)crate;

Please drop the cast.

> +}
> +
> +static int lgm_pll_wait_for_lock(struct lgm_clk_pll *pll)
> +{
> +       unsigned int count =3D 100;
> +       unsigned long flags;
> +       unsigned int val;
> +
> +       do {
> +               raw_spin_lock_irqsave(&pll->lock, flags);
> +               val =3D lgm_get_clk_val(pll->membase, pll->reg, 0, 1);
> +               raw_spin_unlock_irqrestore(&pll->lock, flags);
> +
> +               if (val)
> +                       return 0;
> +               udelay(1);
> +       } while (--count);

Looks like a readl_poll_timeout() implementation. Please use that.

> +
> +       return -EIO;
> +}
> +
> +static void
> +lgm_pll_get_params(struct lgm_clk_pll *pll, unsigned int *mult,

This is used once. Please inline it at the call site instead of passing
pointers and returning many pointers back. Some compilers get confused
and think variables aren't used because this type of design is
complicated.

> +                  unsigned int *div, unsigned int *frac)
> +{
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&pll->lock, flags);
> +       *mult =3D lgm_get_clk_val(pll->membase, pll->reg + 0x8, 0, 12);
> +       *div =3D lgm_get_clk_val(pll->membase, pll->reg + 0x8, 18, 6);

Is there a macro for this register name?

> +       *frac =3D lgm_get_clk_val(pll->membase, pll->reg, 2, 24);
> +       raw_spin_unlock_irqrestore(&pll->lock, flags);
> +}
> +
> +static unsigned long lgm_pll_recalc_rate(struct clk_hw *hw, unsigned lon=
g prate)
> +{
> +       struct lgm_clk_pll *pll =3D to_lgm_clk_pll(hw);
> +       unsigned int div, mult, frac;
> +
> +       lgm_pll_get_params(pll, &mult, &div, &frac);
> +       if (pll->type =3D=3D TYPE_LJPLL)
> +               div *=3D 4;
> +
> +       return lgm_pll_calc_rate(prate, mult, div, frac, BIT(24));
> +}
> +
> +static int lgm_pll_is_enabled(struct clk_hw *hw)
> +{
> +       struct lgm_clk_pll *pll =3D to_lgm_clk_pll(hw);
> +       unsigned long flags;
> +       unsigned int ret;
> +
> +       raw_spin_lock_irqsave(&pll->lock, flags);
> +       ret =3D lgm_get_clk_val(pll->membase, pll->reg, 0, 1);
> +       raw_spin_unlock_irqrestore(&pll->lock, flags);
> +
> +       return ret;
> +}
> +
> +static int lgm_pll_enable(struct clk_hw *hw)
> +{
> +       struct lgm_clk_pll *pll =3D to_lgm_clk_pll(hw);
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&pll->lock, flags);
> +       lgm_set_clk_val(pll->membase, pll->reg, 0, 1, 1);
> +       raw_spin_unlock_irqrestore(&pll->lock, flags);
> +
> +       return lgm_pll_wait_for_lock(pll);
> +}
> +
> +static void lgm_pll_disable(struct clk_hw *hw)
> +{
> +       struct lgm_clk_pll *pll =3D to_lgm_clk_pll(hw);
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&pll->lock, flags);
> +       lgm_set_clk_val(pll->membase, pll->reg, 0, 1, 0);
> +       raw_spin_unlock_irqrestore(&pll->lock, flags);
> +}
> +
> +static long
> +lgm_pll_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long =
*prate)
> +{
> +       return lgm_pll_recalc_rate(hw, *prate);
> +}

This can probably just be removed if you're not doing anything besides
pass through.

> +
> +const static struct clk_ops lgm_pll_ops =3D {

static const.

> +       .recalc_rate =3D lgm_pll_recalc_rate,
> +       .is_enabled =3D lgm_pll_is_enabled,
> +       .enable =3D lgm_pll_enable,
> +       .disable =3D lgm_pll_disable,
> +       .round_rate =3D lgm_pll_round_rate,
> +};
> +
> +static struct clk_hw *
> +lgm_clk_register_pll(struct lgm_clk_provider *ctx,
> +                    const struct lgm_pll_clk_data *list)
> +{
> +       struct clk_init_data init;
> +       struct lgm_clk_pll *pll;
> +       struct device *dev =3D ctx->dev;
> +       struct clk_hw *hw;
> +       int ret;
> +
> +       init.ops =3D &lgm_pll_ops;
> +       init.name =3D list->name;
> +       init.flags =3D list->flags;
> +       init.parent_names =3D list->parent_names;
> +       init.num_parents =3D list->num_parents;
> +
> +       pll =3D devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pll->membase =3D ctx->membase;
> +       pll->lock =3D ctx->lock;
> +       pll->dev =3D ctx->dev;
> +       pll->reg =3D list->reg;
> +       pll->flags =3D list->flags;
> +       pll->type =3D list->type;
> +       pll->hw.init =3D &init;
> +
> +       hw =3D &pll->hw;
> +       ret =3D clk_hw_register(dev, hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return hw;
> +}
> +
> +int lgm_clk_register_plls(struct lgm_clk_provider *ctx,
> +                         const struct lgm_pll_clk_data *list,
> +                         unsigned int nr_clk)
> +{
> +       struct clk_hw *hw;
> +       int i;
> +
> +       for (i =3D 0; i < nr_clk; i++, list++) {
> +               hw =3D lgm_clk_register_pll(ctx, list);
> +               if (IS_ERR(hw)) {
> +                       dev_err(ctx->dev, "failed to register pll: %s\n",
> +                               list->name);
> +                       return -EIO;

return PTR_ERR(hw)?

> +               }
> +
> +               lgm_clk_add_lookup(ctx, hw, list->id);
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
> new file mode 100644
> index 000000000000..850f56117f1e
> --- /dev/null
> +++ b/drivers/clk/x86/clk-cgu.c
> @@ -0,0 +1,714 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + * Zhu YiXin <yixin.zhu@intel.com>
> + * Rahul Tanwar <rahul.tanwar@intel.com>
> + */
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Is this include used? Drop it if it isn't used.

> +#include <linux/device.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#include "clk-cgu.h"
> +
> +#define GATE_HW_REG_STAT(reg)  ((reg) + 0x0)
> +#define GATE_HW_REG_EN(reg)    ((reg) + 0x4)
> +#define GATE_HW_REG_DIS(reg)   ((reg) + 0x8)
> +#define MAX_DDIV_REG   8
> +#define MAX_DIVIDER_VAL 64
> +
> +#define to_lgm_clk_mux(_hw) container_of(_hw, struct lgm_clk_mux, hw)
> +#define to_lgm_clk_divider(_hw) container_of(_hw, struct lgm_clk_divider=
, hw)
> +#define to_lgm_clk_gate(_hw) container_of(_hw, struct lgm_clk_gate, hw)
> +#define to_lgm_clk_ddiv(_hw) container_of(_hw, struct lgm_clk_ddiv, hw)
> +
> +void lgm_set_clk_val(void *membase, u32 reg, u8 shift, u8 width, u32 set=
_val)

Should have __iomem on membase.

> +{
> +       u32 mask =3D (GENMASK(width - 1, 0) << shift);
> +       u32 regval;
> +
> +       regval =3D readl(membase + reg);
> +       regval =3D (regval & ~mask) | ((set_val << shift) & mask);
> +       writel(regval, membase + reg);
> +}
> +
> +u32 lgm_get_clk_val(void *membase, u32 reg, u8 shift, u8 width)

Add __iomem on membase. Please run sparse.

> +{
> +       u32 val;
> +
> +       val =3D readl(membase + reg);
> +       val =3D (val >> shift) & (BIT(width) - 1);

No GENMASK on this one?

> +
> +       return val;
> +}
> +
> +void lgm_clk_add_lookup(struct lgm_clk_provider *ctx, struct clk_hw *hw,
> +                       unsigned int id)
> +{
> +       ctx->clk_data.hws[id] =3D hw;

Just inline this function.

> +}
> +
> +static struct clk_hw *lgm_clk_register_fixed(struct lgm_clk_provider *ct=
x,
> +                                            const struct lgm_clk_branch =
*list)
> +{
> +       unsigned long flags;
> +
> +       if (list->div_flags & CLOCK_FLAG_VAL_INIT) {
> +               raw_spin_lock_irqsave(&ctx->lock, flags);
> +               lgm_set_clk_val(ctx->membase, list->div_off, list->div_sh=
ift,

Really seems like the set_clk_val function should do the locking itself.
Or rather the function should be inlined here.

> +                               list->div_width, list->div_val);
> +               raw_spin_unlock_irqrestore(&ctx->lock, flags);
> +       }
> +
> +       return clk_hw_register_fixed_rate(NULL, list->name,
> +                                         list->parent_names[0],
> +                                         list->flags, list->mux_flags);

Can fixed rate clks come from DT? Or does this value change sometimes?

> +}
> +
> +static u8 lgm_clk_mux_get_parent(struct clk_hw *hw)
> +{
> +       struct lgm_clk_mux *mux =3D to_lgm_clk_mux(hw);
> +       unsigned long flags;
> +       u32 val;
> +
> +       raw_spin_lock_irqsave(&mux->lock, flags);
> +       if (mux->flags & MUX_CLK_SW)
> +               val =3D mux->reg;
> +       else
> +               val =3D lgm_get_clk_val(mux->membase, mux->reg, mux->shif=
t,
> +                                     mux->width);
> +       raw_spin_unlock_irqrestore(&mux->lock, flags);
> +       return clk_mux_val_to_index(hw, NULL, mux->flags, val);
> +}
> +
> +static int lgm_clk_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct lgm_clk_mux *mux =3D to_lgm_clk_mux(hw);
> +       unsigned long flags;
> +       u32 val;
> +
> +       val =3D clk_mux_index_to_val(NULL, mux->flags, index);
> +       raw_spin_lock_irqsave(&mux->lock, flags);
> +       if (mux->flags & MUX_CLK_SW)
> +               mux->reg =3D val;
> +       else
> +               lgm_set_clk_val(mux->membase, mux->reg, mux->shift,
> +                               mux->width, val);
> +       raw_spin_unlock_irqrestore(&mux->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int lgm_clk_mux_determine_rate(struct clk_hw *hw,
> +                                     struct clk_rate_request *req)
> +{
> +       struct lgm_clk_mux *mux =3D to_lgm_clk_mux(hw);
> +
> +       return clk_mux_determine_rate_flags(hw, req, mux->flags);
> +}
> +
> +const static struct clk_ops lgm_clk_mux_ops =3D {
> +       .get_parent =3D lgm_clk_mux_get_parent,
> +       .set_parent =3D lgm_clk_mux_set_parent,
> +       .determine_rate =3D lgm_clk_mux_determine_rate,
> +};
> +
> +static struct clk_hw *
> +lgm_clk_register_mux(struct lgm_clk_provider *ctx,
> +                    const struct lgm_clk_branch *list)
> +{
> +       unsigned long flags, cflags =3D list->mux_flags;
> +       struct device *dev =3D ctx->dev;
> +       u8 shift =3D list->mux_shift;
> +       u8 width =3D list->mux_width;
> +       struct clk_init_data init;
> +       struct lgm_clk_mux *mux;
> +       u32 reg =3D list->mux_off;
> +       struct clk_hw *hw;
> +       int ret;
> +
> +       mux =3D devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> +       if (!mux)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D list->name;
> +       init.ops =3D &lgm_clk_mux_ops;
> +       init.flags =3D list->flags;
> +       init.parent_names =3D list->parent_names;
> +       init.num_parents =3D list->num_parents;
> +
> +       mux->membase =3D ctx->membase;
> +       mux->lock =3D ctx->lock;
> +       mux->reg =3D reg;
> +       mux->shift =3D shift;
> +       mux->width =3D width;
> +       mux->flags =3D cflags;
> +       mux->dev =3D dev;
> +       mux->hw.init =3D &init;
> +
> +       hw =3D &mux->hw;
> +       ret =3D clk_hw_register(dev, hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       if (cflags & CLOCK_FLAG_VAL_INIT) {
> +               raw_spin_lock_irqsave(&mux->lock, flags);
> +               lgm_set_clk_val(mux->membase, reg, shift, width, list->mu=
x_val);
> +               raw_spin_unlock_irqrestore(&mux->lock, flags);
> +       }
> +
> +       return hw;
> +}
> +
> +static unsigned long
> +lgm_clk_divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +       struct lgm_clk_divider *divider =3D to_lgm_clk_divider(hw);
> +       unsigned long flags;
> +       unsigned int val;
> +
> +       raw_spin_lock_irqsave(&divider->lock, flags);
> +       val =3D lgm_get_clk_val(divider->membase, divider->reg,
> +                             divider->shift, divider->width);
> +       raw_spin_unlock_irqrestore(&divider->lock, flags);
> +
> +       return divider_recalc_rate(hw, parent_rate, val, divider->table,
> +                                  divider->flags, divider->width);
> +}
> +
> +static long
> +lgm_clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> +                          unsigned long *prate)
> +{
> +       struct lgm_clk_divider *divider =3D to_lgm_clk_divider(hw);
> +
> +       return divider_round_rate(hw, rate, prate, divider->table,
> +                                 divider->width, divider->flags);
> +}
> +
> +static int
> +lgm_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
> +                        unsigned long prate)
> +{
> +       struct lgm_clk_divider *divider =3D to_lgm_clk_divider(hw);
> +       unsigned long flags;
> +       int value;
> +
> +       value =3D divider_get_val(rate, prate, divider->table,
> +                               divider->width, divider->flags);
> +       if (value < 0)
> +               return value;
> +
> +       raw_spin_lock_irqsave(&divider->lock, flags);
> +       lgm_set_clk_val(divider->membase, divider->reg,
> +                       divider->shift, divider->width, value);
> +       raw_spin_unlock_irqrestore(&divider->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int lgm_clk_divider_enable(struct clk_hw *hw)
> +{
> +       struct lgm_clk_divider *div =3D to_lgm_clk_divider(hw);
> +       unsigned long flags;
> +
> +

Weird double newline here. Consider rolling this into some
enable_disable function that takes an 'int enable' and then the below
two functions are one liners.

> +       raw_spin_lock_irqsave(&div->lock, flags);
> +       lgm_set_clk_val(div->membase, div->reg, div->shift_gate,
> +                       div->width_gate, 1);
> +       raw_spin_unlock_irqrestore(&div->lock, flags);
> +       return 0;
> +}
> +
> +static void lgm_clk_divider_disable(struct clk_hw *hw)
> +{
> +       struct lgm_clk_divider *div =3D to_lgm_clk_divider(hw);
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&div->lock, flags);
> +       lgm_set_clk_val(div->membase, div->reg, div->shift_gate,
> +                       div->width_gate, 0);
> +       raw_spin_unlock_irqrestore(&div->lock, flags);
> +}
> +
> +const static struct clk_ops lgm_clk_divider_ops =3D {

static const.

> +       .recalc_rate =3D lgm_clk_divider_recalc_rate,
> +       .round_rate =3D lgm_clk_divider_round_rate,
> +       .set_rate =3D lgm_clk_divider_set_rate,
> +       .enable =3D lgm_clk_divider_enable,
> +       .disable =3D lgm_clk_divider_disable,
> +};
> +
> +static struct clk_hw *
> +lgm_clk_register_divider(struct lgm_clk_provider *ctx,
> +                        const struct lgm_clk_branch *list)
> +{
> +       unsigned long flags, cflags =3D list->div_flags;
> +       struct device *dev =3D ctx->dev;
> +       struct lgm_clk_divider *div;
> +       struct clk_init_data init;
> +       u8 shift =3D list->div_shift;
> +       u8 width =3D list->div_width;
> +       u8 shift_gate =3D list->div_shift_gate;
> +       u8 width_gate =3D list->div_width_gate;
> +       u32 reg =3D list->div_off;
> +       struct clk_hw *hw;
> +       int ret;
> +
> +       div =3D devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D list->name;
> +       init.ops =3D &lgm_clk_divider_ops;
> +       init.flags =3D list->flags;
> +       init.parent_names =3D &list->parent_names[0];
> +       init.num_parents =3D 1;
> +
> +       div->membase =3D ctx->membase;
> +       div->lock =3D ctx->lock;
> +       div->reg =3D reg;
> +       div->shift =3D shift;
> +       div->width =3D width;
> +       div->shift_gate =3D shift_gate;
> +       div->width_gate =3D width_gate;
> +       div->flags =3D cflags;
> +       div->table =3D list->div_table;
> +       div->dev =3D dev;
> +       div->hw.init =3D &init;
> +
> +       hw =3D &div->hw;
> +       ret =3D clk_hw_register(dev, hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       if (cflags & CLOCK_FLAG_VAL_INIT) {
> +               raw_spin_lock_irqsave(&div->lock, flags);
> +               lgm_set_clk_val(div->membase, reg, shift, width, list->di=
v_val);
> +               raw_spin_unlock_irqrestore(&div->lock, flags);
> +       }
> +
> +       return hw;
> +}
> +
> +static struct clk_hw *
> +lgm_clk_register_fixed_factor(struct lgm_clk_provider *ctx,
> +                             const struct lgm_clk_branch *list)
> +{
> +       unsigned long flags;
> +       struct clk_hw *hw;
> +
> +       hw =3D clk_hw_register_fixed_factor(ctx->dev, list->name,
> +                                         list->parent_names[0], list->fl=
ags,
> +                                         list->mult, list->div);
> +       if (IS_ERR(hw))
> +               return ERR_CAST(hw);
> +
> +       if (list->div_flags & CLOCK_FLAG_VAL_INIT) {
> +               raw_spin_lock_irqsave(&ctx->lock, flags);
> +               lgm_set_clk_val(ctx->membase, list->div_off, list->div_sh=
ift,
> +                               list->div_width, list->div_val);
> +               raw_spin_unlock_irqrestore(&ctx->lock, flags);
> +       }
> +
> +       return hw;
> +}
> +
> +static int lgm_clk_gate_enable(struct clk_hw *hw)
> +{
> +       struct lgm_clk_gate *gate =3D to_lgm_clk_gate(hw);
> +       unsigned long flags;
> +       unsigned int reg;
> +
> +       if (gate->flags & GATE_CLK_HW) {
> +               reg =3D GATE_HW_REG_EN(gate->reg);
> +       } else if (gate->flags & GATE_CLK_SW) {
> +               reg =3D gate->reg;
> +       } else {
> +               dev_err(gate->dev, "%s has unsupported flags 0x%lx\n",

Please use %#lx to get 0x for free.

> +                       clk_hw_get_name(hw), gate->flags);
> +               return 0;
> +       }
> +
> +       raw_spin_lock_irqsave(&gate->lock, flags);
> +       lgm_set_clk_val(gate->membase, reg, gate->shift, 1, 1);
> +       raw_spin_unlock_irqrestore(&gate->lock, flags);
> +
> +       return 0;
> +}
> +
> +static void lgm_clk_gate_disable(struct clk_hw *hw)
> +{
> +       struct lgm_clk_gate *gate =3D to_lgm_clk_gate(hw);
> +       unsigned long flags;
> +       unsigned int reg;
> +       unsigned int set;
> +
> +       if (gate->flags & GATE_CLK_HW) {
> +               reg =3D GATE_HW_REG_DIS(gate->reg);
> +               set =3D 1;
> +       } else if (gate->flags & GATE_CLK_SW) {
> +               reg =3D gate->reg;
> +               set =3D 0;
> +       } else {
> +               dev_err(gate->dev, "%s has unsupported flags 0x%lx!\n",
> +                       clk_hw_get_name(hw), gate->flags);
> +               return;
> +       }
> +
> +       raw_spin_lock_irqsave(&gate->lock, flags);
> +       lgm_set_clk_val(gate->membase, reg, gate->shift, 1, set);
> +       raw_spin_unlock_irqrestore(&gate->lock, flags);
> +}
> +
> +static int lgm_clk_gate_is_enabled(struct clk_hw *hw)
> +{
> +       struct lgm_clk_gate *gate =3D to_lgm_clk_gate(hw);
> +       unsigned int reg, ret;
> +       unsigned long flags;
> +
> +       if (gate->flags & GATE_CLK_HW) {
> +               reg =3D GATE_HW_REG_STAT(gate->reg);
> +       } else if (gate->flags & GATE_CLK_SW) {
> +               reg =3D gate->reg;
> +       } else {
> +               dev_err(gate->dev, "%s has unsupported flags 0x%lx\n",
> +                       clk_hw_get_name(hw), gate->flags);
> +               return 0;
> +       }
> +
> +       raw_spin_lock_irqsave(&gate->lock, flags);
> +       ret =3D lgm_get_clk_val(gate->membase, reg, gate->shift, 1);
> +       raw_spin_unlock_irqrestore(&gate->lock, flags);
> +
> +       return ret;
> +}
> +
> +const static struct clk_ops lgm_clk_gate_ops =3D {
> +       .enable =3D lgm_clk_gate_enable,
> +       .disable =3D lgm_clk_gate_disable,
> +       .is_enabled =3D lgm_clk_gate_is_enabled,
> +};
> +
> +static struct clk_hw *
> +lgm_clk_register_gate(struct lgm_clk_provider *ctx,
> +                     const struct lgm_clk_branch *list)
> +{
> +       unsigned long flags, cflags =3D list->gate_flags;
> +       const char *pname =3D list->parent_names[0];
> +       struct device *dev =3D ctx->dev;
> +       u8 shift =3D list->gate_shift;
> +       struct clk_init_data init;
> +       struct lgm_clk_gate *gate;
> +       u32 reg =3D list->gate_off;
> +       struct clk_hw *hw;
> +       int ret;
> +
> +       gate =3D devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
> +       if (!gate)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D list->name;
> +       init.ops =3D &lgm_clk_gate_ops;
> +       init.flags =3D list->flags;
> +       init.parent_names =3D pname ? &pname : NULL;
> +       init.num_parents =3D pname ? 1 : 0;
> +
> +       gate->membase =3D ctx->membase;
> +       gate->lock =3D ctx->lock;
> +       gate->reg =3D reg;
> +       gate->shift =3D shift;
> +       gate->flags =3D cflags;
> +       gate->dev =3D dev;
> +       gate->hw.init =3D &init;
> +
> +       hw =3D &gate->hw;
> +       ret =3D clk_hw_register(dev, hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       if (cflags & CLOCK_FLAG_VAL_INIT) {
> +               raw_spin_lock_irqsave(&gate->lock, flags);
> +               lgm_set_clk_val(gate->membase, reg, shift, 1, list->gate_=
val);
> +               raw_spin_unlock_irqrestore(&gate->lock, flags);
> +       }
> +
> +       return hw;
> +}
> +
> +int lgm_clk_register_branches(struct lgm_clk_provider *ctx,
> +                             const struct lgm_clk_branch *list,
> +                             unsigned int nr_clk)
> +{
> +       struct clk_hw *hw;
> +       unsigned int idx;
> +
> +       for (idx =3D 0; idx < nr_clk; idx++, list++) {
> +               switch (list->type) {
> +               case CLK_TYPE_FIXED:
> +                       hw =3D lgm_clk_register_fixed(ctx, list);
> +                       break;
> +               case CLK_TYPE_MUX:
> +                       hw =3D lgm_clk_register_mux(ctx, list);
> +                       break;
> +               case CLK_TYPE_DIVIDER:
> +                       hw =3D lgm_clk_register_divider(ctx, list);
> +                       break;
> +               case CLK_TYPE_FIXED_FACTOR:
> +                       hw =3D lgm_clk_register_fixed_factor(ctx, list);
> +                       break;
> +               case CLK_TYPE_GATE:
> +                       hw =3D lgm_clk_register_gate(ctx, list);
> +                       break;
> +               default:
> +                       dev_err(ctx->dev, "invalid clk type\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (IS_ERR(hw)) {
> +                       dev_err(ctx->dev,
> +                               "register clk: %s, type: %u failed!\n",
> +                               list->name, list->type);
> +                       return -EIO;
> +               }
> +               lgm_clk_add_lookup(ctx, hw, list->id);
> +       }
> +
> +       return 0;
> +}
> +
> +static unsigned long
> +lgm_clk_ddiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +       struct lgm_clk_ddiv *ddiv =3D to_lgm_clk_ddiv(hw);
> +       unsigned int div0, div1, exdiv;
> +       unsigned long flags;
> +       u64 prate;
> +
> +       raw_spin_lock_irqsave(&ddiv->lock, flags);
> +       div0 =3D lgm_get_clk_val(ddiv->membase, ddiv->reg,
> +                              ddiv->shift0, ddiv->width0) + 1;
> +       div1 =3D lgm_get_clk_val(ddiv->membase, ddiv->reg,
> +                              ddiv->shift1, ddiv->width1) + 1;
> +       exdiv =3D lgm_get_clk_val(ddiv->membase, ddiv->reg,
> +                               ddiv->shift2, ddiv->width2);
> +       raw_spin_unlock_irqrestore(&ddiv->lock, flags);
> +
> +       prate =3D (u64)parent_rate;
> +       do_div(prate, div0);
> +       do_div(prate, div1);
> +
> +       if (exdiv) {
> +               do_div(prate, ddiv->div);
> +               prate *=3D ddiv->mult;
> +       }
> +
> +       return (unsigned long)prate;

Drop the cast.

> +}
> +
> +static int lgm_clk_ddiv_enable(struct clk_hw *hw)
> +{
> +       struct lgm_clk_ddiv *ddiv =3D to_lgm_clk_ddiv(hw);
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&ddiv->lock, flags);
> +       lgm_set_clk_val(ddiv->membase, ddiv->reg, ddiv->shift_gate,
> +                       ddiv->width_gate, 1);
> +       raw_spin_unlock_irqrestore(&ddiv->lock, flags);
> +       return 0;
> +}
> +
> +static void lgm_clk_ddiv_disable(struct clk_hw *hw)
> +{
> +       struct lgm_clk_ddiv *ddiv =3D to_lgm_clk_ddiv(hw);
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&ddiv->lock, flags);
> +       lgm_set_clk_val(ddiv->membase, ddiv->reg, ddiv->shift_gate,
> +                       ddiv->width_gate, 0);
> +       raw_spin_unlock_irqrestore(&ddiv->lock, flags);
> +}
> +
> +static int
> +lgm_clk_get_ddiv_val(u32 div, u32 *ddiv1, u32 *ddiv2)
> +{
> +       u32 idx, temp;
> +
> +       *ddiv1 =3D 1;
> +       *ddiv2 =3D 1;
> +
> +       if (div > MAX_DIVIDER_VAL)
> +               div =3D MAX_DIVIDER_VAL;
> +
> +       if (div > 1) {
> +               for (idx =3D 2; idx <=3D MAX_DDIV_REG; idx++) {
> +                       temp =3D DIV_ROUND_UP_ULL((u64)div, idx);
> +                       if ((div % idx =3D=3D 0) && (temp <=3D MAX_DDIV_R=
EG))

Please drop useless parenthesis.

> +                               break;
> +               }
> +
> +               if (idx > MAX_DDIV_REG)
> +                       return -EINVAL;
> +
> +               *ddiv1 =3D temp;
> +               *ddiv2 =3D idx;
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +lgm_clk_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
> +                     unsigned long prate)
> +{
> +       struct lgm_clk_ddiv *ddiv =3D to_lgm_clk_ddiv(hw);
> +       u32 div, ddiv1, ddiv2;
> +       unsigned long flags;
> +
> +       div =3D DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
> +
> +       raw_spin_lock_irqsave(&ddiv->lock, flags);
> +       if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
> +               div =3D DIV_ROUND_CLOSEST_ULL((u64)div, 5);
> +               div =3D div * 2;
> +       }
> +       raw_spin_unlock_irqrestore(&ddiv->lock, flags);

Does the math need to be inside the spinlock? Should probably not have
any spinlock at all and just read it with lgm_get_clk_val() and trust
that the hardware will return us something sane?

> +
> +       if (div <=3D 0)
> +               return -EINVAL;
> +
> +       if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2))
> +               return -EINVAL;
> +
> +       raw_spin_lock_irqsave(&ddiv->lock, flags);
> +       lgm_set_clk_val(ddiv->membase, ddiv->reg, ddiv->shift0, ddiv->wid=
th0,
> +                       ddiv1 - 1);
> +
> +       lgm_set_clk_val(ddiv->membase, ddiv->reg,  ddiv->shift1, ddiv->wi=
dth1,
> +                       ddiv2 - 1);

Can this not be combined? lgm_set_clk_val is sort of obfuscating the
code. Please consider inlining it and then holding the spinlock across
this entire function while doing the read/modify/write.

> +       raw_spin_unlock_irqrestore(&ddiv->lock, flags);

Add a newline here.

> +       return 0;
> +}
> +
> +static long
> +lgm_clk_ddiv_round_rate(struct clk_hw *hw, unsigned long rate,
> +                       unsigned long *prate)
> +{
> +       struct lgm_clk_ddiv *ddiv =3D to_lgm_clk_ddiv(hw);
> +       u32 div, ddiv1, ddiv2;
> +       unsigned long flags;
> +       u64 rate64 =3D rate;
> +
> +       div =3D DIV_ROUND_CLOSEST_ULL((u64)*prate, rate);
> +
> +       /* if predivide bit is enabled, modify div by factor of 2.5 */
> +       raw_spin_lock_irqsave(&ddiv->lock, flags);
> +       if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
> +               div =3D div * 2;
> +               div =3D DIV_ROUND_CLOSEST_ULL((u64)div, 5);
> +       }
> +       raw_spin_unlock_irqrestore(&ddiv->lock, flags);
> +
> +       if (div <=3D 0)
> +               return *prate;
> +
> +       if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2) !=3D 0) {

Please drop { and } on this if

> +               if (lgm_clk_get_ddiv_val(div + 1, &ddiv1, &ddiv2) !=3D 0)
> +                       return -EINVAL;
> +       }
> +
> +       rate64 =3D *prate;
> +       do_div(rate64, ddiv1);
> +       do_div(rate64, ddiv2);
> +
> +       /* if predivide bit is enabled, modify rounded rate by factor of =
2.5 */
> +       raw_spin_lock_irqsave(&ddiv->lock, flags);
> +       if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
> +               rate64 =3D rate64 * 2;
> +               rate64 =3D DIV_ROUND_CLOSEST_ULL(rate64, 5);
> +       }
> +       raw_spin_unlock_irqrestore(&ddiv->lock, flags);
> +
> +       return (unsigned long)rate64;

Why cast it? The return statement does that for you.

> +}
> +
> +
> +const static struct clk_ops lgm_clk_ddiv_ops =3D {

static const.

> +       .recalc_rate =3D lgm_clk_ddiv_recalc_rate,
> +       .enable =3D lgm_clk_ddiv_enable,
> +       .disable =3D lgm_clk_ddiv_disable,
> +       .set_rate =3D lgm_clk_ddiv_set_rate,
> +       .round_rate =3D lgm_clk_ddiv_round_rate,
> +};
> +
> +int lgm_clk_register_ddiv(struct lgm_clk_provider *ctx,
> +                         const struct lgm_clk_ddiv_data *list,
> +                         unsigned int nr_clk)
> +{
> +       struct device *dev =3D ctx->dev;
> +       struct clk_init_data init;
> +       struct lgm_clk_ddiv *ddiv;
> +       struct clk_hw *hw;
> +       unsigned int idx;
> +       int ret;
> +
> +       for (idx =3D 0; idx < nr_clk; idx++, list++) {
> +               ddiv =3D NULL;
> +               ddiv =3D devm_kzalloc(dev, sizeof(*ddiv), GFP_KERNEL);
> +               if (!ddiv)
> +                       return -ENOMEM;
> +
> +               memset(&init, 0, sizeof(init));
> +               init.name =3D list->name;
> +               init.ops =3D &lgm_clk_ddiv_ops;
> +               init.flags =3D list->flags;
> +               init.parent_names =3D list->parent_name;
> +               init.num_parents =3D 1;
> +
> +               ddiv->membase =3D ctx->membase;
> +               ddiv->lock =3D ctx->lock;
> +               ddiv->reg =3D list->reg;
> +               ddiv->shift0 =3D list->shift0;
> +               ddiv->width0 =3D list->width0;
> +               ddiv->shift1 =3D list->shift1;
> +               ddiv->width1 =3D list->width1;
> +               ddiv->shift_gate =3D list->shift_gate;
> +               ddiv->width_gate =3D list->width_gate;
> +               ddiv->shift2 =3D list->ex_shift;
> +               ddiv->width2 =3D list->ex_width;
> +               ddiv->flags =3D list->div_flags;
> +               ddiv->mult =3D 2;
> +               ddiv->div =3D 5;
> +               ddiv->dev =3D dev;
> +               ddiv->hw.init =3D &init;
> +
> +               hw =3D &ddiv->hw;
> +               ret =3D clk_hw_register(dev, hw);
> +               if (ret) {
> +                       dev_err(dev, "register clk: %s failed!\n", list->=
name);
> +                       return -EIO;

Why not return ret?

> +               }
> +
> +               lgm_clk_add_lookup(ctx, hw, list->id);
> +       }
> +
> +       return 0;
> +}
> +
> +struct lgm_clk_provider *__init
> +lgm_clk_init(struct device *dev, unsigned int nr_clks)

This function does almost nothing. Can it be inlined at the call site?


> +{
> +       struct lgm_clk_provider *ctx;
> +
> +       ctx =3D devm_kzalloc(dev, struct_size(ctx, clk_data.hws, nr_clks),
> +                          GFP_KERNEL);
> +       if (!ctx)
> +               return ERR_PTR(-ENOMEM);
> +
> +       ctx->clk_data.num =3D nr_clks;
> +
> +       return ctx;
> +}
> diff --git a/drivers/clk/x86/clk-cgu.h b/drivers/clk/x86/clk-cgu.h
> new file mode 100644
> index 000000000000..fd1fd0a71bc2
> --- /dev/null
> +++ b/drivers/clk/x86/clk-cgu.h
> @@ -0,0 +1,309 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright(c) 2019 Intel Corporation.
> + * Zhu YiXin <yixin.zhu@intel.com>
> + * Rahul Tanwar <rahul.tanwar@intel.com>
> + */
> +
> +#ifndef __CLK_CGU_H
> +#define __CLK_CGU_H
> +
> +struct lgm_clk_mux {
> +       struct clk_hw hw;
> +       struct device *dev;
> +       void __iomem *membase;
> +       unsigned int reg;
> +       u8 shift;
> +       u8 width;
> +       unsigned long flags;
> +       raw_spinlock_t lock;
> +};
> +
> +struct lgm_clk_divider {
> +       struct clk_hw hw;
> +       struct device *dev;
> +       void __iomem *membase;
> +       unsigned int reg;
> +       u8 shift;
> +       u8 width;
> +       u8 shift_gate;
> +       u8 width_gate;
> +       unsigned long flags;
> +       const struct clk_div_table *table;
> +       raw_spinlock_t lock;
> +};
> +
> +struct lgm_clk_ddiv {
> +       struct clk_hw hw;
> +       struct device *dev;
> +       void __iomem *membase;
> +       unsigned int reg;
> +       u8 shift0;
> +       u8 width0;
> +       u8 shift1;
> +       u8 width1;
> +       u8 shift2;
> +       u8 width2;
> +       u8 shift_gate;
> +       u8 width_gate;
> +       unsigned int mult;
> +       unsigned int div;
> +       unsigned long flags;
> +       raw_spinlock_t lock;
> +};
> +
> +struct lgm_clk_gate {
> +       struct clk_hw hw;
> +       struct device *dev;

These all have dev pointers, is it necessary? In theory we can have a
clk_hw API that gets the dev pointer out for you if you want it, now
that we store the dev pointer when a clk registers

> +       void __iomem *membase;
> +       unsigned int reg;
> +       u8 shift;
> +       unsigned long flags;
> +       raw_spinlock_t lock;
> +};
> +
> +enum lgm_clk_type {
> +       CLK_TYPE_FIXED,
> +       CLK_TYPE_MUX,
> +       CLK_TYPE_DIVIDER,
> +       CLK_TYPE_FIXED_FACTOR,
> +       CLK_TYPE_GATE,
> +       CLK_TYPE_NONE,
> +};
> +
> +/**
> + * struct lgm_clk_provider
> + * @membase: IO mem base address for CGU.
> + * @np: device node
> + * @dev: device
> + * @clk_data: array of hw clocks and clk number.
> + */
> +struct lgm_clk_provider {
> +       void __iomem *membase;
> +       struct device_node *np;
> +       struct device *dev;
> +       struct clk_hw_onecell_data clk_data;
> +       raw_spinlock_t lock;
> +};
> +
> +enum pll_type {
> +       TYPE_ROPLL,
> +       TYPE_LJPLL,
> +       TYPE_NONE,

Is this used? Remove it if not.

> +};
> +
> +struct lgm_clk_pll {
> +       struct clk_hw hw;
> +       struct device *dev;
> +       void __iomem *membase;
> +       unsigned int reg;
> +       unsigned long flags;
> +       enum pll_type type;
> +       raw_spinlock_t lock;
> +};
> +
> +/**
> + * struct lgm_pll_clk_data
> + * @id: platform specific id of the clock.
> + * @name: name of this pll clock.
> + * @parent_names: name of the parent clock.
> + * @num_parents: number of parents.
> + * @flags: optional flags for basic clock.
> + * @type: platform type of pll.
> + * @reg: offset of the register.
> + */
> +struct lgm_pll_clk_data {
> +       unsigned int id;
> +       const char *name;
> +       const char *const *parent_names;

Can you use the new way of specifying clk parents instead of using plain
strings? Reminder to self, write that document.

> +       u8 num_parents;
> +       unsigned long flags;
> +       enum pll_type type;
> +       int reg;
> +};
> +
> +#define LGM_PLL(_id, _name, _pnames, _flags,           \
> +               _reg, _type)                            \
> +       {                                               \
> +               .id             =3D _id,                  \
> +               .name           =3D _name,                \
> +               .parent_names   =3D _pnames,              \
> +               .num_parents    =3D ARRAY_SIZE(_pnames),  \
> +               .flags          =3D _flags,               \
> +               .reg            =3D _reg,                 \
> +               .type           =3D _type,                \
> +       }
> +
> +struct lgm_clk_ddiv_data {
> +       unsigned int id;
> +       const char *name;
> +       const char *const *parent_name;
> +       u8 flags;
> +       unsigned long div_flags;
> +       unsigned int reg;
> +       u8 shift0;
> +       u8 width0;
> +       u8 shift1;
> +       u8 width1;
> +       u8 shift_gate;
> +       u8 width_gate;
> +       u8 ex_shift;
> +       u8 ex_width;
> +};
> +
> +#define LGM_DDIV(_id, _name, _pname, _flags, _reg,             \
> +                _shft0, _wdth0, _shft1, _wdth1,                \
> +                _shft_gate, _wdth_gate, _xshft, _df)           \
> +       {                                                       \
> +               .id             =3D _id,                          \
> +               .name           =3D _name,                        \
> +               .parent_name    =3D (const char *[]) { _pname },  \
> +               .flags          =3D _flags,                       \
> +               .reg            =3D _reg,                         \
> +               .shift0         =3D _shft0,                       \
> +               .width0         =3D _wdth0,                       \
> +               .shift1         =3D _shft1,                       \
> +               .width1         =3D _wdth1,                       \
> +               .shift_gate     =3D _shft_gate,                   \
> +               .width_gate     =3D _wdth_gate,                   \
> +               .ex_shift       =3D _xshft,                       \
> +               .ex_width       =3D 1,                            \
> +               .div_flags      =3D _df,                          \
> +       }
> +
> +struct lgm_clk_branch {
> +       unsigned int id;
> +       enum lgm_clk_type type;
> +       const char *name;
> +       const char *const *parent_names;
> +       u8 num_parents;
> +       unsigned long flags;
> +       unsigned int mux_off;
> +       u8 mux_shift;
> +       u8 mux_width;
> +       unsigned long mux_flags;
> +       unsigned int mux_val;
> +       unsigned int div_off;
> +       u8 div_shift;
> +       u8 div_width;
> +       u8 div_shift_gate;
> +       u8 div_width_gate;
> +       unsigned long div_flags;
> +       unsigned int div_val;
> +       const struct clk_div_table *div_table;
> +       unsigned int gate_off;
> +       u8 gate_shift;
> +       unsigned long gate_flags;
> +       unsigned int gate_val;
> +       unsigned int mult;
> +       unsigned int div;
> +};
> +
> +/* clock flags definition */
> +#define CLOCK_FLAG_VAL_INIT    BIT(16)
> +#define GATE_CLK_HW            BIT(17)
> +#define GATE_CLK_SW            BIT(18)
> +#define MUX_CLK_SW             GATE_CLK_SW

Why do these bits start at 16? What does _HW and _SW mean? Is there
hardware control of clks?

> +
> +#define LGM_MUX(_id, _name, _pname, _f, _reg,                  \
> +               _shift, _width, _cf, _v)                        \
> +       {                                                       \
> +               .id             =3D _id,                          \
> +               .type           =3D CLK_TYPE_MUX,                 \
> +               .name           =3D _name,                        \
> +               .parent_names   =3D _pname,                       \
> +               .num_parents    =3D ARRAY_SIZE(_pname),           \
> +               .flags          =3D _f,                           \
> +               .mux_off        =3D _reg,                         \
> +               .mux_shift      =3D _shift,                       \
> +               .mux_width      =3D _width,                       \
> +               .mux_flags      =3D _cf,                          \
> +               .mux_val        =3D _v,                           \
> +       }
> +
> +#define LGM_DIV(_id, _name, _pname, _f, _reg, _shift, _width,  \
> +               _shift_gate, _width_gate, _cf, _v, _dtable)     \
> +       {                                                       \
> +               .id             =3D _id,                          \
> +               .type           =3D CLK_TYPE_DIVIDER,             \
> +               .name           =3D _name,                        \
> +               .parent_names   =3D (const char *[]) { _pname },  \
> +               .num_parents    =3D 1,                            \
> +               .flags          =3D _f,                           \
> +               .div_off        =3D _reg,                         \
> +               .div_shift      =3D _shift,                       \
> +               .div_width      =3D _width,                       \
> +               .div_shift_gate =3D _shift_gate,                  \
> +               .div_width_gate =3D _width_gate,                  \
> +               .div_flags      =3D _cf,                          \
> +               .div_val        =3D _v,                           \
> +               .div_table      =3D _dtable,                      \
> +       }
> +
> +#define LGM_GATE(_id, _name, _pname, _f, _reg,                 \
> +                _shift, _cf, _v)                               \
> +       {                                                       \
> +               .id             =3D _id,                          \
> +               .type           =3D CLK_TYPE_GATE,                \
> +               .name           =3D _name,                        \
> +               .parent_names   =3D (const char *[]) { _pname },  \
> +               .num_parents    =3D !_pname ? 0 : 1,              \
> +               .flags          =3D _f,                           \
> +               .gate_off       =3D _reg,                         \
> +               .gate_shift     =3D _shift,                       \
> +               .gate_flags     =3D _cf,                          \
> +               .gate_val       =3D _v,                           \
> +       }
> +
> +#define LGM_FIXED(_id, _name, _pname, _f, _reg,                        \
> +                 _shift, _width, _cf, _freq, _v)               \
> +       {                                                       \
> +               .id             =3D _id,                          \
> +               .type           =3D CLK_TYPE_FIXED,               \
> +               .name           =3D _name,                        \
> +               .parent_names   =3D (const char *[]) { _pname },  \
> +               .num_parents    =3D !_pname ? 0 : 1,              \
> +               .flags          =3D _f,                           \
> +               .div_off        =3D _reg,                         \
> +               .div_shift      =3D _shift,                       \
> +               .div_width      =3D _width,                       \
> +               .div_flags      =3D _cf,                          \
> +               .div_val        =3D _v,                           \
> +               .mux_flags      =3D _freq,                        \
> +       }
> +
> +#define LGM_FIXED_FACTOR(_id, _name, _pname, _f, _reg,         \
> +                        _shift, _width, _cf, _v, _m, _d)       \
> +       {                                                       \
> +               .id             =3D _id,                          \
> +               .type           =3D CLK_TYPE_FIXED_FACTOR,        \
> +               .name           =3D _name,                        \
> +               .parent_names   =3D (const char *[]) { _pname },  \
> +               .num_parents    =3D 1,                            \
> +               .flags          =3D _f,                           \
> +               .div_off        =3D _reg,                         \
> +               .div_shift      =3D _shift,                       \
> +               .div_width      =3D _width,                       \
> +               .div_flags      =3D _cf,                          \
> +               .div_val        =3D _v,                           \
> +               .mult           =3D _m,                           \
> +               .div            =3D _d,                           \
> +       }
> +
> +void lgm_set_clk_val(void *membase, u32 reg,
> +                    u8 shift, u8 width, u32 set_val);
> +u32 lgm_get_clk_val(void *membase, u32 reg, u8 shift, u8 width);
> +void lgm_clk_add_lookup(struct lgm_clk_provider *ctx,
> +                       struct clk_hw *hw, unsigned int id);
> +struct lgm_clk_provider *lgm_clk_init(struct device *dev,
> +                                     unsigned int nr_clks);
> +int lgm_clk_register_branches(struct lgm_clk_provider *ctx,
> +                             const struct lgm_clk_branch *list,
> +                             unsigned int nr_clk);
> +int lgm_clk_register_plls(struct lgm_clk_provider *ctx,
> +                         const struct lgm_pll_clk_data *list,
> +                         unsigned int nr_clk);
> +int lgm_clk_register_ddiv(struct lgm_clk_provider *ctx,
> +                         const struct lgm_clk_ddiv_data *list,
> +                         unsigned int nr_clk);
> +#endif /* __CLK_CGU_H */
> diff --git a/drivers/clk/x86/clk-lgm.c b/drivers/clk/x86/clk-lgm.c
> new file mode 100644
> index 000000000000..a36b03b57231
> --- /dev/null
> +++ b/drivers/clk/x86/clk-lgm.c
> @@ -0,0 +1,466 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + * Zhu YiXin <yixin.zhu@intel.com>
> + * Rahul Tanwar <rahul.tanwar@intel.com>
> + */
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>

If it's builtin only then module.h isn't needed.

> +#include <linux/spinlock.h>
> +#include <dt-bindings/clock/intel,lgm-clk.h>
> +#include "clk-cgu.h"
> +
> +#define PLL_DIV_WIDTH          4
> +#define PLL_DDIV_WIDTH         3
> +
> +/* Gate0 clock shift */
> +#define G_C55_SHIFT            7
> +#define G_QSPI_SHIFT           9
> +#define G_EIP197_SHIFT         11
> +#define G_VAULT130_SHIFT       12
> +#define G_TOE_SHIFT            13
> +#define G_SDXC_SHIFT           14
> +#define G_EMMC_SHIFT           15
> +#define G_SPIDBG_SHIFT         17
> +#define G_DMA3_SHIFT           28
> +
> +/* Gate1 clock shift */
> +#define G_DMA0_SHIFT           0
> +#define G_LEDC0_SHIFT          1
> +#define G_LEDC1_SHIFT          2
> +#define G_I2S0_SHIFT           3
> +#define G_I2S1_SHIFT           4
> +#define G_EBU_SHIFT            5
> +#define G_PWM_SHIFT            6
> +#define G_I2C0_SHIFT           7
> +#define G_I2C1_SHIFT           8
> +#define G_I2C2_SHIFT           9
> +#define G_I2C3_SHIFT           10
> +
> +#define G_SSC0_SHIFT           12
> +#define G_SSC1_SHIFT           13
> +#define G_SSC2_SHIFT           14
> +#define G_SSC3_SHIFT           15
> +
> +#define G_GPTC0_SHIFT          17
> +#define G_GPTC1_SHIFT          18
> +#define G_GPTC2_SHIFT          19
> +#define G_GPTC3_SHIFT          20
> +
> +#define G_ASC0_SHIFT           22
> +#define G_ASC1_SHIFT           23
> +#define G_ASC2_SHIFT           24
> +#define G_ASC3_SHIFT           25
> +
> +#define G_PCM0_SHIFT           27
> +#define G_PCM1_SHIFT           28
> +#define G_PCM2_SHIFT           29
> +
> +/* Gate2 clock shift */
> +#define G_PCIE10_SHIFT         1
> +#define G_PCIE11_SHIFT         2
> +#define G_PCIE30_SHIFT         3
> +#define G_PCIE31_SHIFT         4
> +#define G_PCIE20_SHIFT         5
> +#define G_PCIE21_SHIFT         6
> +#define G_PCIE40_SHIFT         7
> +#define G_PCIE41_SHIFT         8
> +
> +#define G_XPCS0_SHIFT          10
> +#define G_XPCS1_SHIFT          11
> +#define G_XPCS2_SHIFT          12
> +#define G_XPCS3_SHIFT          13
> +#define G_SATA0_SHIFT          14
> +#define G_SATA1_SHIFT          15
> +#define G_SATA2_SHIFT          16
> +#define G_SATA3_SHIFT          17
> +
> +/* Gate3 clock shift */
> +#define G_ARCEM4_SHIFT         0
> +#define G_IDMAR1_SHIFT         2
> +#define G_IDMAT0_SHIFT         3
> +#define G_IDMAT1_SHIFT         4
> +#define G_IDMAT2_SHIFT         5
> +
> +#define G_PPV4_SHIFT           8
> +#define G_GSWIPO_SHIFT         9
> +#define G_CQEM_SHIFT           10
> +#define G_XPCS5_SHIFT          14
> +#define G_USB1_SHIFT           25
> +#define G_USB2_SHIFT           26
> +
> +
> +/* Register definition */
> +#define CGU_PLL0CZ_CFG0                0x000
> +#define CGU_PLL0CM0_CFG0       0x020
> +#define CGU_PLL0CM1_CFG0       0x040
> +#define CGU_PLL0B_CFG0         0x060
> +#define CGU_PLL1_CFG0          0x080
> +#define CGU_PLL2_CFG0          0x0A0
> +#define CGU_PLLPP_CFG0         0x0C0
> +#define CGU_LJPLL3_CFG0                0x0E0
> +#define CGU_LJPLL4_CFG0                0x100
> +#define CGU_C55_PCMCR          0x18C
> +#define CGU_PCMCR              0x190
> +#define CGU_IF_CLK1            0x1A0
> +#define CGU_IF_CLK2            0x1A4
> +#define CGU_GATE0              0x300
> +#define CGU_GATE1              0x310
> +#define CGU_GATE2              0x320
> +#define CGU_GATE3              0x310
> +
> +#define PLL_DIV(x)             ((x) + 0x04)
> +#define PLL_SSC(x)             ((x) + 0x10)
> +
> +#define CLK_NR_CLKS            (LGM_GCLK_USB2 + 1)
> +
> +/*
> + * Below table defines the pair's of regval & effective dividers.
> + * It's more efficient to provide an explicit table due to non-linear
> + * relation between values.
> + */
> +static const struct clk_div_table pll_div[] =3D {
> +       { .val =3D 0, .div =3D 1 },
> +       { .val =3D 1, .div =3D 2 },
> +       { .val =3D 2, .div =3D 3 },
> +       { .val =3D 3, .div =3D 4 },
> +       { .val =3D 4, .div =3D 5 },
> +       { .val =3D 5, .div =3D 6 },
> +       { .val =3D 6, .div =3D 8 },
> +       { .val =3D 7, .div =3D 10 },
> +       { .val =3D 8, .div =3D 12 },
> +       { .val =3D 9, .div =3D 16 },
> +       { .val =3D 10, .div =3D 20 },
> +       { .val =3D 11, .div =3D 24 },
> +       { .val =3D 12, .div =3D 32 },
> +       { .val =3D 13, .div =3D 40 },
> +       { .val =3D 14, .div =3D 48 },
> +       { .val =3D 15, .div =3D 64 },
> +       {}
> +};
> +
> +static const struct clk_div_table dcl_div[] =3D {
> +       { .val =3D 0, .div =3D 6  },
> +       { .val =3D 1, .div =3D 12 },
> +       { .val =3D 2, .div =3D 24 },
> +       { .val =3D 3, .div =3D 32 },
> +       { .val =3D 4, .div =3D 48 },
> +       { .val =3D 5, .div =3D 96 },
> +       {}

I guess 'div' being equal to 0 is the terminator?

> +};
> +
> +enum lgm_plls {
> +       PLL0CZ, PLL0CM0, PLL0CM1, PLL0B, PLL1, PLL2, PLLPP, LJPLL3, LJPLL4
> +};

What is the point of this enum? Please remove it.

> +
> +static const char *const pll_p[] __initconst =3D { "osc" };
> +static const char *const pllcm_p[] __initconst =3D { "cpu_cm" };
> +static const char *const emmc_p[] __initconst =3D { "emmc4", "noc4" };
> +static const char *const sdxc_p[] __initconst =3D { "sdxc3", "sdxc2" };
> +static const char *const pcm_p[] __initconst =3D { "v_docsis", "dcl" };
> +static const char *const cbphy_p[] __initconst =3D { "dd_serdes", "dd_pc=
ie" };
> +
> +static const struct lgm_pll_clk_data lgm_pll_clks[] __initconst =3D {

Drop __initconst on everything.

> +       [PLL0CZ] =3D LGM_PLL(LGM_CLK_PLL0CZ, "pll0cz", pll_p, CLK_IS_CRIT=
ICAL,
> +                          CGU_PLL0CZ_CFG0, TYPE_ROPLL),
> +       [PLL0CM0] =3D LGM_PLL(LGM_CLK_PLL0CM0, "pll0cm0", pllcm_p, CLK_IS=
_CRITICAL,
> +                           CGU_PLL0CM0_CFG0, TYPE_ROPLL),
> +       [PLL0CM1] =3D LGM_PLL(LGM_CLK_PLL0CM1, "pll0cm1", pllcm_p, CLK_IS=
_CRITICAL,
> +                           CGU_PLL0CM1_CFG0, TYPE_ROPLL),
> +       [PLL0B] =3D LGM_PLL(LGM_CLK_PLL0B, "pll0b", pll_p, CLK_IS_CRITICA=
L,
> +                         CGU_PLL0B_CFG0, TYPE_ROPLL),
> +       [PLL1] =3D LGM_PLL(LGM_CLK_PLL1, "pll1", pll_p, 0, CGU_PLL1_CFG0,
> +                        TYPE_ROPLL),
> +       [PLL2] =3D LGM_PLL(LGM_CLK_PLL2, "pll2", pll_p, CLK_IS_CRITICAL,
> +                        CGU_PLL2_CFG0, TYPE_ROPLL),
> +       [PLLPP] =3D LGM_PLL(LGM_CLK_PLLPP, "pllpp", pll_p, 0, CGU_PLLPP_C=
FG0,
> +                         TYPE_ROPLL),
> +       [LJPLL3] =3D LGM_PLL(LGM_CLK_LJPLL3, "ljpll3", pll_p, 0, CGU_LJPL=
L3_CFG0,
> +                          TYPE_LJPLL),
> +       [LJPLL4] =3D LGM_PLL(LGM_CLK_LJPLL4, "ljpll4", pll_p, 0, CGU_LJPL=
L4_CFG0,
> +                          TYPE_LJPLL),
> +};
> +
> +static const struct lgm_clk_branch lgm_branch_clks[] __initconst =3D {

Drop __initconst.

> +       LGM_DIV(LGM_CLK_PP_HW, "pp_hw", "pllpp", 0, PLL_DIV(CGU_PLLPP_CFG=
0),
> +               0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_PP_UC, "pp_uc", "pllpp", 0, PLL_DIV(CGU_PLLPP_CFG=
0),
> +               4, PLL_DIV_WIDTH, 25, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_PP_FXD, "pp_fxd", "pllpp", 0, PLL_DIV(CGU_PLLPP_C=
FG0),
> +               8, PLL_DIV_WIDTH, 26, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_PP_TBM, "pp_tbm", "pllpp", 0, PLL_DIV(CGU_PLLPP_C=
FG0),
> +               12, PLL_DIV_WIDTH, 27, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_DDR, "ddr", "pll2", CLK_IS_CRITICAL,

Please add a comment in the code about why a clk is marked critical.
Please make it meaningful so we remember later on why it's this way.

> +               PLL_DIV(CGU_PLL2_CFG0), 0, PLL_DIV_WIDTH, 24, 1, 0, 0,
> +               pll_div),
> +       LGM_DIV(LGM_CLK_CM, "cpu_cm", "pll0cz", 0, PLL_DIV(CGU_PLL0CZ_CFG=
0),
> +               0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
> +
> +       LGM_DIV(LGM_CLK_IC, "cpu_ic", "pll0cz", CLK_IS_CRITICAL,
> +               PLL_DIV(CGU_PLL0CZ_CFG0), 4, PLL_DIV_WIDTH, 25,
> +               1, 0, 0, pll_div),
> +
> +       LGM_DIV(LGM_CLK_SDXC3, "sdxc3", "pll0cz", 0, PLL_DIV(CGU_PLL0CZ_C=
FG0),
> +               8, PLL_DIV_WIDTH, 26, 1, 0, 0, pll_div),
> +
> +       LGM_DIV(LGM_CLK_CPU0, "cm0", "pll0cm0",
> +               (CLK_IGNORE_UNUSED|CLK_IS_CRITICAL), PLL_DIV(CGU_PLL0CM0_=
CFG0),
> +               0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_CPU1, "cm1", "pll0cm1",
> +               (CLK_IGNORE_UNUSED|CLK_IS_CRITICAL), PLL_DIV(CGU_PLL0CM1_=
CFG0),
> +               0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_NGI, "ngi", "pll0b",
> +               (CLK_IGNORE_UNUSED|CLK_IS_CRITICAL), PLL_DIV(CGU_PLL0B_CF=
G0),
> +               0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_NOC4, "noc4", "pll0b",
> +               (CLK_IGNORE_UNUSED|CLK_IS_CRITICAL), PLL_DIV(CGU_PLL0B_CF=
G0),
> +               4, PLL_DIV_WIDTH, 25, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_SW, "switch", "pll0b", 0, PLL_DIV(CGU_PLL0B_CFG0),
> +               8, PLL_DIV_WIDTH, 26, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_QSPI, "qspi", "pll0b", 0, PLL_DIV(CGU_PLL0B_CFG0),
> +               12, PLL_DIV_WIDTH, 27, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_CT, "v_ct", "pll1", 0, PLL_DIV(CGU_PLL1_CFG0),
> +               0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_DSP, "v_dsp", "pll1", 0, PLL_DIV(CGU_PLL1_CFG0),
> +               8, PLL_DIV_WIDTH, 26, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_VIF, "v_ifclk", "pll1", 0, PLL_DIV(CGU_PLL1_CFG0),
> +               12, PLL_DIV_WIDTH, 27, 1, 0, 0, pll_div),
> +
> +       LGM_FIXED_FACTOR(LGM_CLK_EMMC4, "emmc4", "sdxc3", 0,  0,
> +                        0, 0, 0, 0, 1, 4),
> +       LGM_FIXED_FACTOR(LGM_CLK_SDXC2, "sdxc2", "noc4", 0,  0,
> +                        0, 0, 0, 0, 1, 4),
> +       LGM_MUX(LGM_CLK_EMMC, "emmc", emmc_p, 0, CGU_IF_CLK1,
> +               0, 1, CLK_MUX_ROUND_CLOSEST, 0),
> +       LGM_MUX(LGM_CLK_SDXC, "sdxc", sdxc_p, 0, CGU_IF_CLK1,
> +               1, 1, CLK_MUX_ROUND_CLOSEST, 0),
> +       LGM_FIXED(LGM_CLK_OSC, "osc", NULL, 0, 0, 0, 0, 0, 40000000, 0),
> +       LGM_FIXED(LGM_CLK_SLIC, "slic", NULL, 0, CGU_IF_CLK1,
> +                 8, 2, CLOCK_FLAG_VAL_INIT, 8192000, 2),
> +       LGM_FIXED(LGM_CLK_DOCSIS, "v_docsis", NULL, 0, 0, 0, 0, 0, 160000=
00, 0),
> +       LGM_DIV(LGM_CLK_DCL, "dcl", "v_ifclk", 0, CGU_PCMCR,
> +               25, 3, 0, 0, 0, 0, dcl_div),
> +       LGM_MUX(LGM_CLK_PCM, "pcm", pcm_p, 0, CGU_C55_PCMCR,
> +               0, 1, CLK_MUX_ROUND_CLOSEST, 0),
> +       LGM_FIXED_FACTOR(LGM_CLK_DDR_PHY, "ddr_phy", "ddr",
> +                        CLK_IGNORE_UNUSED, 0,
> +                        0, 0, 0, 0, 2, 1),
> +       LGM_FIXED_FACTOR(LGM_CLK_PONDEF, "pondef", "dd_pool",
> +                        CLK_SET_RATE_PARENT, 0, 0, 0, 0, 0, 1, 2),
> +       LGM_MUX(LGM_CLK_CBPHY0, "cbphy0", cbphy_p, 0, 0,
> +               0, 0, MUX_CLK_SW | CLK_MUX_ROUND_CLOSEST, 0),
> +       LGM_MUX(LGM_CLK_CBPHY1, "cbphy1", cbphy_p, 0, 0,
> +               0, 0, MUX_CLK_SW | CLK_MUX_ROUND_CLOSEST, 0),
> +       LGM_MUX(LGM_CLK_CBPHY2, "cbphy2", cbphy_p, 0, 0,
> +               0, 0, MUX_CLK_SW | CLK_MUX_ROUND_CLOSEST, 0),
> +       LGM_MUX(LGM_CLK_CBPHY3, "cbphy3", cbphy_p, 0, 0,
> +               0, 0, MUX_CLK_SW | CLK_MUX_ROUND_CLOSEST, 0),
> +
> +       LGM_GATE(LGM_GCLK_C55, "g_c55", NULL, 0, CGU_GATE0,
> +                G_C55_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_QSPI, "g_qspi", "qspi", 0, CGU_GATE0,
> +                G_QSPI_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_EIP197, "g_eip197", NULL, 0, CGU_GATE0,
> +                G_EIP197_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_VAULT, "g_vault130", NULL, 0, CGU_GATE0,
> +                G_VAULT130_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_TOE, "g_toe", NULL, 0, CGU_GATE0,
> +                G_TOE_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_SDXC, "g_sdxc", "sdxc", 0, CGU_GATE0,
> +                G_SDXC_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_EMMC, "g_emmc", "emmc", 0, CGU_GATE0,
> +                G_EMMC_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_SPI_DBG, "g_spidbg", NULL, 0, CGU_GATE0,
> +                G_SPIDBG_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_DMA3, "g_dma3", NULL, 0, CGU_GATE0,
> +                G_DMA3_SHIFT, GATE_CLK_HW, 0),
> +
> +       LGM_GATE(LGM_GCLK_DMA0, "g_dma0", NULL, 0, CGU_GATE1,
> +                G_DMA0_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_LEDC0, "g_ledc0", NULL, 0, CGU_GATE1,
> +                G_LEDC0_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_LEDC1, "g_ledc1", NULL, 0, CGU_GATE1,
> +                G_LEDC1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_I2S0, "g_i2s0", NULL, 0, CGU_GATE1,
> +                G_I2S0_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_I2S1, "g_i2s1", NULL, 0, CGU_GATE1,
> +                G_I2S1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_EBU, "g_ebu", NULL, 0, CGU_GATE1,
> +                G_EBU_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PWM, "g_pwm", NULL, 0, CGU_GATE1,
> +                G_PWM_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_I2C0, "g_i2c0", NULL, 0, CGU_GATE1,
> +                G_I2C0_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_I2C1, "g_i2c1", NULL, 0, CGU_GATE1,
> +                G_I2C1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_I2C2, "g_i2c2", NULL, 0, CGU_GATE1,
> +                G_I2C2_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_I2C3, "g_i2c3", NULL, 0, CGU_GATE1,
> +                G_I2C3_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_SSC0, "g_ssc0", "noc4", 0, CGU_GATE1,
> +                G_SSC0_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_SSC1, "g_ssc1", "noc4", 0, CGU_GATE1,
> +                G_SSC1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_SSC2, "g_ssc2", "noc4", 0, CGU_GATE1,
> +                G_SSC2_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_SSC3, "g_ssc3", "noc4", 0, CGU_GATE1,
> +                G_SSC3_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_GPTC0, "g_gptc0", "noc4", 0, CGU_GATE1,
> +                G_GPTC0_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_GPTC1, "g_gptc1", "noc4", 0, CGU_GATE1,
> +                G_GPTC1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_GPTC2, "g_gptc2", "noc4", 0, CGU_GATE1,
> +                G_GPTC2_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_GPTC3, "g_gptc3", "osc", 0, CGU_GATE1,
> +                G_GPTC3_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_ASC0, "g_asc0", "noc4", 0, CGU_GATE1,
> +                G_ASC0_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_ASC1, "g_asc1", "noc4", 0, CGU_GATE1,
> +                G_ASC1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_ASC2, "g_asc2", "noc4", 0, CGU_GATE1,
> +                G_ASC2_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_ASC3, "g_asc3", "osc", 0, CGU_GATE1,
> +                G_ASC3_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PCM0, "g_pcm0", NULL, 0, CGU_GATE1,
> +                G_PCM0_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PCM1, "g_pcm1", NULL, 0, CGU_GATE1,
> +                G_PCM1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PCM2, "g_pcm2", NULL, 0, CGU_GATE1,
> +                G_PCM2_SHIFT, GATE_CLK_HW, 0),
> +
> +       LGM_GATE(LGM_GCLK_PCIE10, "g_pcie10", NULL, 0, CGU_GATE2,
> +                G_PCIE10_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PCIE11, "g_pcie11", NULL, 0, CGU_GATE2,
> +                G_PCIE11_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PCIE30, "g_pcie30", NULL, 0, CGU_GATE2,
> +                G_PCIE30_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PCIE31, "g_pcie31", NULL, 0, CGU_GATE2,
> +                G_PCIE31_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PCIE20, "g_pcie20", NULL, 0, CGU_GATE2,
> +                G_PCIE20_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PCIE21, "g_pcie21", NULL, 0, CGU_GATE2,
> +                G_PCIE21_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PCIE40, "g_pcie40", NULL, 0, CGU_GATE2,
> +                G_PCIE40_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PCIE41, "g_pcie41", NULL, 0, CGU_GATE2,
> +                G_PCIE41_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_XPCS0, "g_xpcs0", NULL, 0, CGU_GATE2,
> +                G_XPCS0_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_XPCS1, "g_xpcs1", NULL, 0, CGU_GATE2,
> +                G_XPCS1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_XPCS2, "g_xpcs2", NULL, 0, CGU_GATE2,
> +                G_XPCS2_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_XPCS3, "g_xpcs3", NULL, 0, CGU_GATE2,
> +                G_XPCS3_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_SATA0, "g_sata0", NULL, 0, CGU_GATE2,
> +                G_SATA0_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_SATA1, "g_sata1", NULL, 0, CGU_GATE2,
> +                G_SATA1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_SATA2, "g_sata2", NULL, 0, CGU_GATE2,
> +                G_SATA2_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_SATA3, "g_sata3", NULL, 0, CGU_GATE2,
> +                G_SATA3_SHIFT, GATE_CLK_HW, 0),
> +
> +       LGM_GATE(LGM_GCLK_ARCEM4, "g_arcem4", NULL, 0, CGU_GATE3,
> +                G_ARCEM4_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_IDMAR1, "g_idmar1", NULL, 0, CGU_GATE3,
> +                G_IDMAR1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_IDMAT0, "g_idmat0", NULL, 0, CGU_GATE3,
> +                G_IDMAT0_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_IDMAT1, "g_idmat1", NULL, 0, CGU_GATE3,
> +                G_IDMAT1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_IDMAT2, "g_idmat2", NULL, 0, CGU_GATE3,
> +                G_IDMAT2_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_PPV4, "g_ppv4", NULL, 0, CGU_GATE3,
> +                G_PPV4_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_GSWIPO, "g_gswipo", "switch", 0, CGU_GATE3,
> +                G_GSWIPO_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_CQEM, "g_cqem", "switch", CLK_IS_CRITICAL, CGU_=
GATE3,
> +                G_CQEM_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_XPCS5, "g_xpcs5", NULL, 0, CGU_GATE3,
> +                G_XPCS5_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_USB1, "g_usb1", NULL, 0, CGU_GATE3,
> +                G_USB1_SHIFT, GATE_CLK_HW, 0),
> +       LGM_GATE(LGM_GCLK_USB2, "g_usb2", NULL, 0, CGU_GATE3,
> +                G_USB2_SHIFT, GATE_CLK_HW, 0),
> +};
> +
> +
> +static const struct lgm_clk_ddiv_data lgm_ddiv_clks[] __initconst =3D {

Drop __initconst.

> +       LGM_DDIV(LGM_CLK_CML, "dd_cml", "ljpll3", 0,
> +                PLL_DIV(CGU_LJPLL3_CFG0), 0, PLL_DDIV_WIDTH,
> +                3, PLL_DDIV_WIDTH, 24, 1, 29, 0),
> +       LGM_DDIV(LGM_CLK_SERDES, "dd_serdes", "ljpll3", 0,
> +                PLL_DIV(CGU_LJPLL3_CFG0), 6, PLL_DDIV_WIDTH,
> +                9, PLL_DDIV_WIDTH, 25, 1, 28, 0),
> +       LGM_DDIV(LGM_CLK_POOL, "dd_pool", "ljpll3", 0,
> +                PLL_DIV(CGU_LJPLL3_CFG0), 12, PLL_DDIV_WIDTH,
> +                15, PLL_DDIV_WIDTH, 26, 1, 28, 0),
> +       LGM_DDIV(LGM_CLK_PTP, "dd_ptp", "ljpll3", 0,
> +                PLL_DIV(CGU_LJPLL3_CFG0), 18, PLL_DDIV_WIDTH,
> +                21, PLL_DDIV_WIDTH, 27, 1, 28, 0),
> +       LGM_DDIV(LGM_CLK_PCIE, "dd_pcie", "ljpll4", 0,
> +                PLL_DIV(CGU_LJPLL4_CFG0), 0, PLL_DDIV_WIDTH,
> +                3, PLL_DDIV_WIDTH, 24, 1, 29, 0),
> +};
> +
> +static int __init lgm_cgu_probe(struct platform_device *pdev)

Drop __init.

> +{
> +       struct lgm_clk_provider *ctx;
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *np =3D dev->of_node;
> +       int ret;
> +
> +       ctx =3D lgm_clk_init(dev, CLK_NR_CLKS);
> +       if (IS_ERR(ctx))
> +               return PTR_ERR(ctx);
> +
> +       ctx->membase =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(ctx->membase))
> +               return PTR_ERR(ctx->membase);
> +
> +       ctx->np =3D np;
> +       ctx->dev =3D dev;
> +       raw_spin_lock_init(&ctx->lock);

Why is it a raw spinlock?

> +
> +       ret =3D lgm_clk_register_plls(ctx, lgm_pll_clks,
> +                                   ARRAY_SIZE(lgm_pll_clks));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D lgm_clk_register_branches(ctx, lgm_branch_clks,
> +                                       ARRAY_SIZE(lgm_branch_clks));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D lgm_clk_register_ddiv(ctx, lgm_ddiv_clks,
> +                                   ARRAY_SIZE(lgm_ddiv_clks));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                         &ctx->clk_data);
> +       if (ret)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, ctx);

Why? Does anything use it? If not, please remove.

> +       return 0;
> +}
> +
> +static const struct of_device_id of_lgm_cgu_match[] =3D {
> +       {.compatible =3D "intel,cgu-lgm"},

Please put space around { and }

> +       {}
> +};
> +
> +static struct platform_driver lgm_cgu_driver __refdata =3D {

Drop __refdata.

> +       .probe =3D lgm_cgu_probe,
> +       .driver =3D {
> +                  .name =3D "cgu-lgm",
> +                  .of_match_table =3D of_lgm_cgu_match,
> +       },
> +};
> +
> +builtin_platform_driver(lgm_cgu_driver);
