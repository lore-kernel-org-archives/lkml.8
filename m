Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D462FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4652075F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590545418;
	bh=VzxZlV/Fs6pRA9txugK1hJjbiHFSugjaDK5uuGksvnU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Z14/+z0qDbA/xCJDn6XoIxn0agjMjRwGu75m7nDJjckXb4XTeTjNr4WhOPpDe+epp
	 LOqbFVLu7CzTomE1i9SaaF4ZeuB02Cc/wt7qNDp0DGZIWU9dk0bNHhwXEERP6uiogQ
	 NgUNDvBEkam1BlaTUEcN0vZ0ZiezLDta43kfEcUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgE0CKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgE0CKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:10:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB6A22075F;
        Wed, 27 May 2020 02:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590545414;
        bh=VzxZlV/Fs6pRA9txugK1hJjbiHFSugjaDK5uuGksvnU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AnmhlQO2/VdB8Mj3YGGej6EMGhWpoYviGxwGV+UyfcyEcaestcurmihmHAog2Mnz0
         K471HdwsXBCeUMq+pcgF5d8ErQ33PHd9PpsFlCpoLgk6HBTathCx3TkJAVbK4db7cG
         KIg7/+Y0FRmBzYIWUl3HxIs5ptNXBwKUIiJ+hbkE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <42a4f71847714df482bacffdcd84341a4052800b.1587102634.git.rahul.tanwar@linux.intel.com>
References: <cover.1587102634.git.rahul.tanwar@linux.intel.com> <42a4f71847714df482bacffdcd84341a4052800b.1587102634.git.rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v8 2/2] clk: intel: Add CGU clock driver for a new SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        rtanwar <rahul.tanwar@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Tue, 26 May 2020 19:10:13 -0700
Message-ID: <159054541310.88029.5777794695153819198@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2020-04-16 22:54:47)
> diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
> new file mode 100644
> index 000000000000..802a7fa88535
> --- /dev/null
> +++ b/drivers/clk/x86/clk-cgu.c
> @@ -0,0 +1,636 @@
[...]
> +
> +static unsigned long
> +lgm_clk_ddiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +       struct lgm_clk_ddiv *ddiv =3D to_lgm_clk_ddiv(hw);
> +       unsigned int div0, div1, exdiv;
> +       unsigned long flags;
> +       u64 prate;
> +
> +       spin_lock_irqsave(&ddiv->lock, flags);

Is there any reason to take the lock here? We should be able to
calculate the new rate and not care what the values are "right now"
because they can change in the interim. Instead we should recalculate a
rate that is possible regardless of the current state of the clk.

> +       div0 =3D lgm_get_clk_val(ddiv->membase, ddiv->reg,
> +                              ddiv->shift0, ddiv->width0) + 1;
> +       div1 =3D lgm_get_clk_val(ddiv->membase, ddiv->reg,
> +                              ddiv->shift1, ddiv->width1) + 1;
> +       exdiv =3D lgm_get_clk_val(ddiv->membase, ddiv->reg,
> +                               ddiv->shift2, ddiv->width2);
> +       spin_unlock_irqrestore(&ddiv->lock, flags);
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
> +       return prate;
> +}
[...]
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
> +       spin_lock_irqsave(&ddiv->lock, flags);
> +       if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
> +               div =3D div * 2;
> +               div =3D DIV_ROUND_CLOSEST_ULL((u64)div, 5);
> +       }
> +
> +       if (div <=3D 0) {
> +               spin_unlock_irqrestore(&ddiv->lock, flags);
> +               return *prate;
> +       }
> +
> +       if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2) !=3D 0) {
> +               if (lgm_clk_get_ddiv_val(div + 1, &ddiv1, &ddiv2) !=3D 0)=
 {
> +                       spin_unlock_irqrestore(&ddiv->lock, flags);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       rate64 =3D *prate;
> +       do_div(rate64, ddiv1);
> +       do_div(rate64, ddiv2);
> +
> +       /* if predivide bit is enabled, modify rounded rate by factor of =
2.5 */
> +       if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
> +               rate64 =3D rate64 * 2;
> +               rate64 =3D DIV_ROUND_CLOSEST_ULL(rate64, 5);
> +       }
> +       spin_unlock_irqrestore(&ddiv->lock, flags);

There's a lot of locking in here that can probably be tightened up.
Please look into only holding the spinlock as long as you need to.

> +
> +       return rate64;
> +}
> +
> +static const struct clk_ops lgm_clk_ddiv_ops =3D {
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
> +       struct clk_init_data init =3D {};
> +       struct lgm_clk_ddiv *ddiv;
> +       struct clk_hw *hw;
> +       unsigned int idx;
> +       int ret;
> +
> +       for (idx =3D 0; idx < nr_clk; idx++, list++) {
> +               ddiv =3D NULL;

Why assign to NULL?

> +               ddiv =3D devm_kzalloc(dev, sizeof(*ddiv), GFP_KERNEL);

And then assign to it?

> +               if (!ddiv)
> +                       return -ENOMEM;
> +
> +               memset(&init, 0, sizeof(init));

Maybe 'init' and 'ddiv' should declared inside the for loop so that
they're automatically allocated again each time through the loop. Then
it would avoid the memset call and we wouldn't worry about 'ddiv'
needing to be NULL?

> +               init.name =3D list->name;
> +               init.ops =3D &lgm_clk_ddiv_ops;
> +               init.flags =3D list->flags;
> +               init.parent_data =3D list->parent_data;
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
> +               ddiv->hw.init =3D &init;
> +
> +               hw =3D &ddiv->hw;
> +               ret =3D clk_hw_register(dev, hw);
> +               if (ret) {
> +                       dev_err(dev, "register clk: %s failed!\n", list->=
name);
> +                       return ret;
> +               }
> +               ctx->clk_data.hws[list->id] =3D hw;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/clk/x86/clk-cgu.h b/drivers/clk/x86/clk-cgu.h
> new file mode 100644
> index 000000000000..4e22bfb22312
> --- /dev/null
> +++ b/drivers/clk/x86/clk-cgu.h
> @@ -0,0 +1,335 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright(c) 2020 Intel Corporation.
> + * Zhu YiXin <yixin.zhu@intel.com>
> + * Rahul Tanwar <rahul.tanwar@intel.com>
> + */
> +
> +#ifndef __CLK_CGU_H
> +#define __CLK_CGU_H
> +
> +#include <linux/io.h>
> +
> +struct lgm_clk_mux {
> +       struct clk_hw hw;
> +       void __iomem *membase;
> +       unsigned int reg;
> +       u8 shift;
> +       u8 width;
> +       unsigned long flags;
> +       spinlock_t lock;
> +};
> +
> +struct lgm_clk_divider {
> +       struct clk_hw hw;
> +       void __iomem *membase;
> +       unsigned int reg;
> +       u8 shift;
> +       u8 width;
> +       u8 shift_gate;
> +       u8 width_gate;
> +       unsigned long flags;
> +       const struct clk_div_table *table;
> +       spinlock_t lock;
> +};
> +
> +struct lgm_clk_ddiv {
> +       struct clk_hw hw;
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
> +       spinlock_t lock;
> +};
> +
> +struct lgm_clk_gate {
> +       struct clk_hw hw;
> +       void __iomem *membase;
> +       unsigned int reg;
> +       u8 shift;
> +       unsigned long flags;
> +       spinlock_t lock;
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
> +       spinlock_t lock;
> +};
> +
> +enum pll_type {
> +       TYPE_ROPLL,
> +       TYPE_LJPLL,
> +       TYPE_NONE,
> +};
> +
> +struct lgm_clk_pll {
> +       struct clk_hw hw;
> +       void __iomem *membase;
> +       unsigned int reg;
> +       unsigned long flags;
> +       enum pll_type type;
> +       spinlock_t lock;
> +};
> +
> +/**
> + * struct lgm_pll_clk_data
> + * @id: platform specific id of the clock.
> + * @name: name of this pll clock.
> + * @parent_data: parent clock data.
> + * @num_parents: number of parents.
> + * @flags: optional flags for basic clock.
> + * @type: platform type of pll.
> + * @reg: offset of the register.
> + */
> +struct lgm_pll_clk_data {
> +       unsigned int id;
> +       const char *name;
> +       const struct clk_parent_data *parent_data;
> +       u8 num_parents;
> +       unsigned long flags;
> +       enum pll_type type;
> +       int reg;
> +};
> +
> +#define LGM_PLL(_id, _name, _pdata, _flags,            \
> +               _reg, _type)                            \
> +       {                                               \
> +               .id =3D _id,                              \
> +               .name =3D _name,                          \
> +               .parent_data =3D _pdata,                  \
> +               .num_parents =3D ARRAY_SIZE(_pdata),      \
> +               .flags =3D _flags,                        \
> +               .reg =3D _reg,                            \
> +               .type =3D _type,                          \
> +       }
> +
> +struct lgm_clk_ddiv_data {
> +       unsigned int id;
> +       const char *name;
> +       const struct clk_parent_data *parent_data;
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
> +               .id =3D _id,                                      \
> +               .name =3D _name,                                  \
> +               .parent_data =3D &(const struct clk_parent_data){ \
> +                       .fw_name =3D _pname,                      \
> +                       .name =3D _pname,                         \
> +               },                                              \
> +               .flags =3D _flags,                                \
> +               .reg =3D _reg,                                    \
> +               .shift0 =3D _shft0,                               \
> +               .width0 =3D _wdth0,                               \
> +               .shift1 =3D _shft1,                               \
> +               .width1 =3D _wdth1,                               \
> +               .shift_gate =3D _shft_gate,                       \
> +               .width_gate =3D _wdth_gate,                       \
> +               .ex_shift =3D _xshft,                             \
> +               .ex_width =3D 1,                                  \
> +               .div_flags =3D _df,                               \
> +       }
> +
> +struct lgm_clk_branch {
> +       unsigned int id;
> +       enum lgm_clk_type type;
> +       const char *name;
> +       const struct clk_parent_data *parent_data;
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
> +#define MUX_CLK_SW             BIT(17)
> +
> +#define LGM_MUX(_id, _name, _pdata, _f, _reg,          \
> +               _shift, _width, _cf, _v)                \
> +       {                                               \
> +               .id =3D _id,                              \
> +               .type =3D CLK_TYPE_MUX,                   \
> +               .name =3D _name,                          \
> +               .parent_data =3D _pdata,                  \
> +               .num_parents =3D ARRAY_SIZE(_pdata),      \
> +               .flags =3D _f,                            \
> +               .mux_off =3D _reg,                        \
> +               .mux_shift =3D _shift,                    \
> +               .mux_width =3D _width,                    \
> +               .mux_flags =3D _cf,                       \
> +               .mux_val =3D _v,                          \
> +       }
> +
> +#define LGM_DIV(_id, _name, _pname, _f, _reg, _shift, _width,  \
> +               _shift_gate, _width_gate, _cf, _v, _dtable)     \
> +       {                                                       \
> +               .id =3D _id,                                      \
> +               .type =3D CLK_TYPE_DIVIDER,                       \
> +               .name =3D _name,                                  \
> +               .parent_data =3D &(const struct clk_parent_data){ \
> +                       .fw_name =3D _pname,                      \
> +                       .name =3D _pname,                         \
> +               },                                              \
> +               .num_parents =3D 1,                               \
> +               .flags =3D _f,                                    \
> +               .div_off =3D _reg,                                \
> +               .div_shift =3D _shift,                            \
> +               .div_width =3D _width,                            \
> +               .div_shift_gate =3D _shift_gate,                  \
> +               .div_width_gate =3D _width_gate,                  \
> +               .div_flags =3D _cf,                               \
> +               .div_val =3D _v,                                  \
> +               .div_table =3D _dtable,                           \
> +       }
> +
> +#define LGM_GATE(_id, _name, _pname, _f, _reg,                 \
> +                _shift, _cf, _v)                               \
> +       {                                                       \
> +               .id =3D _id,                                      \
> +               .type =3D CLK_TYPE_GATE,                          \
> +               .name =3D _name,                                  \
> +               .parent_data =3D &(const struct clk_parent_data){ \
> +                       .fw_name =3D _pname,                      \
> +                       .name =3D _pname,                         \
> +               },                                              \
> +               .num_parents =3D !_pname ? 0 : 1,                 \
> +               .flags =3D _f,                                    \
> +               .gate_off =3D _reg,                               \
> +               .gate_shift =3D _shift,                           \
> +               .gate_flags =3D _cf,                              \
> +               .gate_val =3D _v,                                 \
> +       }
> +
> +#define LGM_FIXED(_id, _name, _pname, _f, _reg,                        \
> +                 _shift, _width, _cf, _freq, _v)               \
> +       {                                                       \
> +               .id =3D _id,                                      \
> +               .type =3D CLK_TYPE_FIXED,                         \
> +               .name =3D _name,                                  \
> +               .parent_data =3D &(const struct clk_parent_data){ \
> +                       .fw_name =3D _pname,                      \
> +                       .name =3D _pname,                         \
> +               },                                              \
> +               .num_parents =3D !_pname ? 0 : 1,                 \
> +               .flags =3D _f,                                    \
> +               .div_off =3D _reg,                                \
> +               .div_shift =3D _shift,                            \
> +               .div_width =3D _width,                            \
> +               .div_flags =3D _cf,                               \
> +               .div_val =3D _v,                                  \
> +               .mux_flags =3D _freq,                             \
> +       }
> +
> +#define LGM_FIXED_FACTOR(_id, _name, _pname, _f, _reg,         \
> +                        _shift, _width, _cf, _v, _m, _d)       \
> +       {                                                       \
> +               .id =3D _id,                                      \
> +               .type =3D CLK_TYPE_FIXED_FACTOR,                  \
> +               .name =3D _name,                                  \
> +               .parent_data =3D &(const struct clk_parent_data){ \
> +                       .fw_name =3D _pname,                      \
> +                       .name =3D _pname,                         \
> +               },                                              \
> +               .num_parents =3D 1,                               \
> +               .flags =3D _f,                                    \
> +               .div_off =3D _reg,                                \
> +               .div_shift =3D _shift,                            \
> +               .div_width =3D _width,                            \
> +               .div_flags =3D _cf,                               \
> +               .div_val =3D _v,                                  \
> +               .mult =3D _m,                                     \
> +               .div =3D _d,                                      \
> +       }
> +
> +static inline void lgm_set_clk_val(void __iomem *membase, u32 reg,
> +                                  u8 shift, u8 width, u32 set_val)
> +{
> +       u32 mask =3D (GENMASK(width - 1, 0) << shift);
> +       u32 regval;
> +
> +       regval =3D readl(membase + reg);
> +       regval =3D (regval & ~mask) | ((set_val << shift) & mask);
> +       writel(regval, membase + reg);
> +}
> +
> +static inline u32 lgm_get_clk_val(void __iomem *membase, u32 reg,
> +                                 u8 shift, u8 width)
> +{
> +       u32 mask =3D (GENMASK(width - 1, 0) << shift);
> +       u32 val;
> +
> +       val =3D readl(membase + reg);
> +       val =3D (val & mask) >> shift;
> +
> +       return val;
> +}
> +
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
> index 000000000000..ffbd2c425dc3
> --- /dev/null
> +++ b/drivers/clk/x86/clk-lgm.c
> @@ -0,0 +1,492 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Intel Corporation.
> + * Zhu YiXin <yixin.zhu@intel.com>
> + * Rahul Tanwar <rahul.tanwar@intel.com>
> + */
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
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
> +};
> +
> +static const struct clk_parent_data pll_p[] =3D {
> +       { .fw_name =3D "osc", .name =3D "osc" },
> +};
> +static const struct clk_parent_data pllcm_p[] =3D {
> +       { .fw_name =3D "cpu_cm", .name =3D "cpu_cm" },
> +};
> +static const struct clk_parent_data emmc_p[] =3D {
> +       { .fw_name =3D "emmc4", .name =3D "emmc4" },
> +       { .fw_name =3D "noc4", .name =3D "noc4" },
> +};
> +static const struct clk_parent_data sdxc_p[] =3D {
> +       { .fw_name =3D "sdxc3", .name =3D "sdxc3" },
> +       { .fw_name =3D "sdxc2", .name =3D "sdxc2" },
> +};
> +static const struct clk_parent_data pcm_p[] =3D {
> +       { .fw_name =3D "v_docsis", .name =3D "v_docsis" },
> +       { .fw_name =3D "dcl", .name =3D "dcl" },
> +};
> +static const struct clk_parent_data cbphy_p[] =3D {
> +       { .fw_name =3D "dd_serdes", .name =3D "dd_serdes" },
> +       { .fw_name =3D "dd_pcie", .name =3D "dd_pcie" },
> +};
> +
> +static const struct lgm_pll_clk_data lgm_pll_clks[] =3D {
> +       LGM_PLL(LGM_CLK_PLL0CZ, "pll0cz", pll_p, CLK_IGNORE_UNUSED,
> +               CGU_PLL0CZ_CFG0, TYPE_ROPLL),
> +       LGM_PLL(LGM_CLK_PLL0CM0, "pll0cm0", pllcm_p, CLK_IGNORE_UNUSED,
> +               CGU_PLL0CM0_CFG0, TYPE_ROPLL),
> +       LGM_PLL(LGM_CLK_PLL0CM1, "pll0cm1", pllcm_p, CLK_IGNORE_UNUSED,
> +               CGU_PLL0CM1_CFG0, TYPE_ROPLL),
> +       LGM_PLL(LGM_CLK_PLL0B, "pll0b", pll_p, CLK_IGNORE_UNUSED,
> +               CGU_PLL0B_CFG0, TYPE_ROPLL),
> +       LGM_PLL(LGM_CLK_PLL1, "pll1", pll_p, 0, CGU_PLL1_CFG0, TYPE_ROPLL=
),
> +       LGM_PLL(LGM_CLK_PLL2, "pll2", pll_p, CLK_IGNORE_UNUSED,
> +               CGU_PLL2_CFG0, TYPE_ROPLL),
> +       LGM_PLL(LGM_CLK_PLLPP, "pllpp", pll_p, 0, CGU_PLLPP_CFG0, TYPE_RO=
PLL),
> +       LGM_PLL(LGM_CLK_LJPLL3, "ljpll3", pll_p, 0, CGU_LJPLL3_CFG0, TYPE=
_LJPLL),
> +       LGM_PLL(LGM_CLK_LJPLL4, "ljpll4", pll_p, 0, CGU_LJPLL4_CFG0, TYPE=
_LJPLL),
> +};
> +
> +static const struct lgm_clk_branch lgm_branch_clks[] =3D {
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
> +       LGM_DIV(LGM_CLK_DDR, "ddr", "pll2", CLK_IGNORE_UNUSED,
> +               PLL_DIV(CGU_PLL2_CFG0), 0, PLL_DIV_WIDTH, 24, 1, 0, 0,
> +               pll_div),
> +       LGM_DIV(LGM_CLK_CM, "cpu_cm", "pll0cz", 0, PLL_DIV(CGU_PLL0CZ_CFG=
0),
> +               0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
> +
> +       LGM_DIV(LGM_CLK_IC, "cpu_ic", "pll0cz", CLK_IGNORE_UNUSED,
> +               PLL_DIV(CGU_PLL0CZ_CFG0), 4, PLL_DIV_WIDTH, 25,
> +               1, 0, 0, pll_div),
> +
> +       LGM_DIV(LGM_CLK_SDXC3, "sdxc3", "pll0cz", 0, PLL_DIV(CGU_PLL0CZ_C=
FG0),
> +               8, PLL_DIV_WIDTH, 26, 1, 0, 0, pll_div),
> +
> +       LGM_DIV(LGM_CLK_CPU0, "cm0", "pll0cm0",
> +               CLK_IGNORE_UNUSED, PLL_DIV(CGU_PLL0CM0_CFG0),
> +               0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
> +       LGM_DIV(LGM_CLK_CPU1, "cm1", "pll0cm1",
> +               CLK_IGNORE_UNUSED, PLL_DIV(CGU_PLL0CM1_CFG0),
> +               0, PLL_DIV_WIDTH, 24, 1, 0, 0, pll_div),
> +
> +       /*
> +        * Marking ngi_clk (next generation interconnect) and noc_clk
> +        * (network on chip peripheral clk) as critical clocks because
> +        * these are shared parent clock sources for many different
> +        * peripherals.
> +        */
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
> +                G_C55_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_QSPI, "g_qspi", "qspi", 0, CGU_GATE0,
> +                G_QSPI_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_EIP197, "g_eip197", NULL, 0, CGU_GATE0,
> +                G_EIP197_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_VAULT, "g_vault130", NULL, 0, CGU_GATE0,
> +                G_VAULT130_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_TOE, "g_toe", NULL, 0, CGU_GATE0,
> +                G_TOE_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_SDXC, "g_sdxc", "sdxc", 0, CGU_GATE0,
> +                G_SDXC_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_EMMC, "g_emmc", "emmc", 0, CGU_GATE0,
> +                G_EMMC_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_SPI_DBG, "g_spidbg", NULL, 0, CGU_GATE0,
> +                G_SPIDBG_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_DMA3, "g_dma3", NULL, 0, CGU_GATE0,
> +                G_DMA3_SHIFT, 0, 0),
> +
> +       LGM_GATE(LGM_GCLK_DMA0, "g_dma0", NULL, 0, CGU_GATE1,
> +                G_DMA0_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_LEDC0, "g_ledc0", NULL, 0, CGU_GATE1,
> +                G_LEDC0_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_LEDC1, "g_ledc1", NULL, 0, CGU_GATE1,
> +                G_LEDC1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_I2S0, "g_i2s0", NULL, 0, CGU_GATE1,
> +                G_I2S0_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_I2S1, "g_i2s1", NULL, 0, CGU_GATE1,
> +                G_I2S1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_EBU, "g_ebu", NULL, 0, CGU_GATE1,
> +                G_EBU_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PWM, "g_pwm", NULL, 0, CGU_GATE1,
> +                G_PWM_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_I2C0, "g_i2c0", NULL, 0, CGU_GATE1,
> +                G_I2C0_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_I2C1, "g_i2c1", NULL, 0, CGU_GATE1,
> +                G_I2C1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_I2C2, "g_i2c2", NULL, 0, CGU_GATE1,
> +                G_I2C2_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_I2C3, "g_i2c3", NULL, 0, CGU_GATE1,
> +                G_I2C3_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_SSC0, "g_ssc0", "noc4", 0, CGU_GATE1,
> +                G_SSC0_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_SSC1, "g_ssc1", "noc4", 0, CGU_GATE1,
> +                G_SSC1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_SSC2, "g_ssc2", "noc4", 0, CGU_GATE1,
> +                G_SSC2_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_SSC3, "g_ssc3", "noc4", 0, CGU_GATE1,
> +                G_SSC3_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_GPTC0, "g_gptc0", "noc4", 0, CGU_GATE1,
> +                G_GPTC0_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_GPTC1, "g_gptc1", "noc4", 0, CGU_GATE1,
> +                G_GPTC1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_GPTC2, "g_gptc2", "noc4", 0, CGU_GATE1,
> +                G_GPTC2_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_GPTC3, "g_gptc3", "osc", 0, CGU_GATE1,
> +                G_GPTC3_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_ASC0, "g_asc0", "noc4", 0, CGU_GATE1,
> +                G_ASC0_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_ASC1, "g_asc1", "noc4", 0, CGU_GATE1,
> +                G_ASC1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_ASC2, "g_asc2", "noc4", 0, CGU_GATE1,
> +                G_ASC2_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_ASC3, "g_asc3", "osc", 0, CGU_GATE1,
> +                G_ASC3_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PCM0, "g_pcm0", NULL, 0, CGU_GATE1,
> +                G_PCM0_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PCM1, "g_pcm1", NULL, 0, CGU_GATE1,
> +                G_PCM1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PCM2, "g_pcm2", NULL, 0, CGU_GATE1,
> +                G_PCM2_SHIFT, 0, 0),
> +
> +       LGM_GATE(LGM_GCLK_PCIE10, "g_pcie10", NULL, 0, CGU_GATE2,
> +                G_PCIE10_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PCIE11, "g_pcie11", NULL, 0, CGU_GATE2,
> +                G_PCIE11_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PCIE30, "g_pcie30", NULL, 0, CGU_GATE2,
> +                G_PCIE30_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PCIE31, "g_pcie31", NULL, 0, CGU_GATE2,
> +                G_PCIE31_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PCIE20, "g_pcie20", NULL, 0, CGU_GATE2,
> +                G_PCIE20_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PCIE21, "g_pcie21", NULL, 0, CGU_GATE2,
> +                G_PCIE21_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PCIE40, "g_pcie40", NULL, 0, CGU_GATE2,
> +                G_PCIE40_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PCIE41, "g_pcie41", NULL, 0, CGU_GATE2,
> +                G_PCIE41_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_XPCS0, "g_xpcs0", NULL, 0, CGU_GATE2,
> +                G_XPCS0_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_XPCS1, "g_xpcs1", NULL, 0, CGU_GATE2,
> +                G_XPCS1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_XPCS2, "g_xpcs2", NULL, 0, CGU_GATE2,
> +                G_XPCS2_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_XPCS3, "g_xpcs3", NULL, 0, CGU_GATE2,
> +                G_XPCS3_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_SATA0, "g_sata0", NULL, 0, CGU_GATE2,
> +                G_SATA0_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_SATA1, "g_sata1", NULL, 0, CGU_GATE2,
> +                G_SATA1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_SATA2, "g_sata2", NULL, 0, CGU_GATE2,
> +                G_SATA2_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_SATA3, "g_sata3", NULL, 0, CGU_GATE2,
> +                G_SATA3_SHIFT, 0, 0),
> +
> +       LGM_GATE(LGM_GCLK_ARCEM4, "g_arcem4", NULL, 0, CGU_GATE3,
> +                G_ARCEM4_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_IDMAR1, "g_idmar1", NULL, 0, CGU_GATE3,
> +                G_IDMAR1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_IDMAT0, "g_idmat0", NULL, 0, CGU_GATE3,
> +                G_IDMAT0_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_IDMAT1, "g_idmat1", NULL, 0, CGU_GATE3,
> +                G_IDMAT1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_IDMAT2, "g_idmat2", NULL, 0, CGU_GATE3,
> +                G_IDMAT2_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_PPV4, "g_ppv4", NULL, 0, CGU_GATE3,
> +                G_PPV4_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_GSWIPO, "g_gswipo", "switch", 0, CGU_GATE3,
> +                G_GSWIPO_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_CQEM, "g_cqem", "switch", 0, CGU_GATE3,
> +                G_CQEM_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_XPCS5, "g_xpcs5", NULL, 0, CGU_GATE3,
> +                G_XPCS5_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_USB1, "g_usb1", NULL, 0, CGU_GATE3,
> +                G_USB1_SHIFT, 0, 0),
> +       LGM_GATE(LGM_GCLK_USB2, "g_usb2", NULL, 0, CGU_GATE3,
> +                G_USB2_SHIFT, 0, 0),
> +};
> +
> +
> +static const struct lgm_clk_ddiv_data lgm_ddiv_clks[] =3D {
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
> +static inline struct lgm_clk_provider *
> +lgm_clk_init(struct device *dev, unsigned int nr_clks)
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
> +
> +static int lgm_cgu_probe(struct platform_device *pdev)
> +{
[...]
> +
> +       ctx->membase =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(ctx->membase))
> +               return PTR_ERR(ctx->membase);
> +
> +       ctx->np =3D np;
> +       ctx->dev =3D dev;
> +       spin_lock_init(&ctx->lock);
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

Are any of the clks unregistered on failure? It looks like devm_ isn't
used for registration so nothing can be undone? Please fix this in a
future patch.
