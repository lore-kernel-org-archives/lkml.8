Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A9EC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5659B214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581361177;
	bh=6Fuu2gVWcWeVQb3DllydwL2YvE/R2OLUSoeNrJD6TuM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=wiDJhz9dbeBW+wJ5i1rSXfZOsr5SNwbYhAIVqM/66sUneMB09PvNm6vI085TYVYLJ
	 Vn111MDqslKKSidQPAb8nMv/ynU5uGHH1t8l9vv5AwrAbd5yI3m0F1aBdt9iGXcR1S
	 2W7wa5zzaxOvXMaxYw4ClbAJd7LRij+cGhiKdN7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBJS7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:59:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgBJS7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:59:36 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D5792085B;
        Mon, 10 Feb 2020 18:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581361175;
        bh=6Fuu2gVWcWeVQb3DllydwL2YvE/R2OLUSoeNrJD6TuM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cfaj5AfOXOxZ5wPsCw89VjpremlGDQ4RprFcdgRuw7UL9dYPF6iFlvco1LjxLAjdq
         JfAgOg1oSxwkLUYXg0FA+lJxpcglS5L9+v0ID2XvQRnDOri5CtyvkmzaYtrwfjrq08
         Zg0HjZ2OerZ0ozMMiYHFFKGq0uUHM2Pxs1rVqUAU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200207044425.32398-3-vigneshr@ti.com>
References: <20200207044425.32398-1-vigneshr@ti.com> <20200207044425.32398-3-vigneshr@ti.com>
Subject: Re: [PATCH v2 2/2] clk: keystone: Add new driver to handle syscon based clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Date:   Mon, 10 Feb 2020 10:59:34 -0800
Message-ID: <158136117429.94449.12421902020705390139@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vignesh Raghavendra (2020-02-06 20:44:25)
> diff --git a/drivers/clk/keystone/Kconfig b/drivers/clk/keystone/Kconfig
> index 38aeefb1e808..69ca3db1a99e 100644
> --- a/drivers/clk/keystone/Kconfig
> +++ b/drivers/clk/keystone/Kconfig
> @@ -26,3 +26,11 @@ config TI_SCI_CLK_PROBE_FROM_FW
>           This is mostly only useful for debugging purposes, and will
>           increase the boot time of the device. If you want the clocks pr=
obed
>           from firmware, say Y. Otherwise, say N.
> +
> +config TI_SYSCON_CLK
> +       tristate "Syscon based clock driver for K2/K3 SoCs"
> +       depends on (ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST) && OF
> +       default (ARCH_KEYSTONE || ARCH_K3)

Drop parenthesis. It's not useful. Also, not sure why OF is a build
dependency. Please drop it.

	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
	default ARCH_KEYSTONE || ARCH_K3

> +       help
> +         This adds clock driver support for syscon based gate
> +         clocks on TI's K2 and K3 SoCs.
> diff --git a/drivers/clk/keystone/Makefile b/drivers/clk/keystone/Makefile
> index d044de6f965c..0e426e648f7c 100644
> --- a/drivers/clk/keystone/Makefile
> +++ b/drivers/clk/keystone/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_COMMON_CLK_KEYSTONE)      +=3D pll.o gate.o
>  obj-$(CONFIG_TI_SCI_CLK)               +=3D sci-clk.o
> +obj-$(CONFIG_TI_SYSCON_CLK)            +=3D syscon-clk.o
> diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/sys=
con-clk.c
> new file mode 100644
> index 000000000000..42e7416371ff
> --- /dev/null
> +++ b/drivers/clk/keystone/syscon-clk.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +//

These last three comment lines should be normal kernel style. /* */

> +
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>

Is this used?

> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

Hopefully these two includes aren't needed.

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
[...]
> +
> +static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
> +{
> +       const struct ti_syscon_gate_clk_data *data, *p;
> +       struct clk_hw_onecell_data *hw_data;
> +       struct device *dev =3D &pdev->dev;
> +       struct regmap *regmap;
> +       int num_clks =3D 0;

Please don't initialize here.

> +       int i;
> +
> +       data =3D of_device_get_match_data(dev);

Use device_get_match_data() instead?

> +       if (!data)
> +               return -EINVAL;
> +
> +       regmap =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> +                                                "ti,tbclk-syscon");
> +       if (IS_ERR(regmap)) {
> +               if (PTR_ERR(regmap) =3D=3D -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +               dev_err(dev, "failed to find parent regmap\n");
> +               return PTR_ERR(regmap);
> +       }
> +
> +       for (p =3D data; p->name; p++)

Initialize num_clks here so we know it's a loop that's counting.

> +               num_clks++;
> +
> +       hw_data =3D devm_kzalloc(dev, struct_size(hw_data, hws, num_clks),
> +                              GFP_KERNEL);
> +       if (!hw_data)
> +               return -ENOMEM;
> +
> +       hw_data->num =3D num_clks;
> +
> +       for (i =3D 0; i < num_clks; i++) {
> +               hw_data->hws[i] =3D ti_syscon_gate_clk_register(dev, regm=
ap,
> +                                                             &data[i]);
> +               if (IS_ERR(hw_data->hws[i]))
> +                       dev_err(dev, "failed to register %s",

Add a newline?

> +                               data[i].name);

And we don't fail? So it really isn't a problem? Maybe dev_warn()
instead?

> +       }
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                          hw_data);
> +}
> +
> +#define TI_SYSCON_CLK_GATE(_name, _offset, _bit_idx)   \
> +       {                                               \
> +               .name =3D _name,                          \
> +               .offset =3D (_offset),                    \
> +               .bit_idx =3D (_bit_idx),                  \
> +       }
> +
> +static const struct ti_syscon_gate_clk_data am654_clk_data[] =3D {
> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk0", 0x0, 0),
> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk1", 0x4, 0),
> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk2", 0x8, 0),
> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk3", 0xc, 0),
> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk4", 0x10, 0),
> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk5", 0x14, 0),
> +       { /* Sentinel */ },
> +};
> +
> +static const struct of_device_id ti_syscon_gate_clk_ids[] =3D {
> +       {
> +               .compatible =3D "ti,am654-ehrpwm-tbclk",
> +               .data =3D &am654_clk_data,
> +       },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, ti_syscon_gate_clk_ids);
> +
> +static struct platform_driver ti_syscon_gate_clk_driver =3D {
> +       .probe =3D ti_syscon_gate_clk_probe,
> +       .driver =3D {
> +               .name =3D "ti-syscon-gate-clk",
> +               .of_match_table =3D ti_syscon_gate_clk_ids,
> +       },
> +};
> +

Nitpick: Drop the newline.

> +module_platform_driver(ti_syscon_gate_clk_driver);
> +
