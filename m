Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1CAC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65E224649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583793367;
	bh=FfEWrDlIYCsGBsRT3CR2tIbG3qThGe8CArNWYnsrkZg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=izqz4XH5hooQi7yRGMb8ek8EscOrd6m1L2o1uS0bswqE2pEh2XlYQbfcu1r9VHOCk
	 RrJlm58Lh6Px2mXqW89w+UXsaux41CTgRjOVZ4DO/GMV/3WROuzMKX2VDzhVtugnnx
	 Ik3hSiQf0ryzpxZnYJ8q/7XdMXaXLHA+uHM27ZxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgCIWgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgCIWgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:36:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660B820637;
        Mon,  9 Mar 2020 22:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583793364;
        bh=FfEWrDlIYCsGBsRT3CR2tIbG3qThGe8CArNWYnsrkZg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=z7y+CYR933Pq7jvSApgXup7eSqsUnk+ED7ruS/Muz82EcuqAz3Fo0WawlyPQNaKUu
         IQ3IpkNBFiw7yl55P+dU56kuexQiJzRM7tnKsk/SdMcCQDhMPWicw69hYRdMqij7/N
         zRcyiKZZb72p5eCA1gCWYJXVI5Q/gFc8TTssed38=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309171653.27630-4-dinguyen@kernel.org>
References: <20200309171653.27630-1-dinguyen@kernel.org> <20200309171653.27630-4-dinguyen@kernel.org>
Subject: Re: [PATCHv2 3/3] clk: socfpga: agilex: add clock driver for the Agilex platform
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-clk@vger.kernel.org
Date:   Mon, 09 Mar 2020 15:36:03 -0700
Message-ID: <158379336357.149997.6959209555707153578@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2020-03-09 10:16:53)
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index f4169cc2fd31..d9ddc0bd91c0 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -18,6 +18,7 @@ endif
> =20
>  # hardware specific clock types
>  # please keep this section sorted lexicographically by file path name
> +obj-$(CONFIG_ARCH_AGILEX)              +=3D socfpga/

This is not sorted by file path name.

>  obj-$(CONFIG_MACH_ASM9260)             +=3D clk-asm9260.o
>  obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)    +=3D clk-axi-clkgen.o
>  obj-$(CONFIG_ARCH_AXXIA)               +=3D clk-axm5516.o
> diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-a=
gilex.c
> new file mode 100644
> index 000000000000..6789892085db
> --- /dev/null
> +++ b/drivers/clk/socfpga/clk-agilex.c
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019, Intel Corporation
> + */
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/clock/agilex-clock.h>
> +
> +#include "stratix10-clk.h"
[...]
> +static const struct clk_parent_data emac_mux[] =3D {
> +       { .name =3D "emaca_free_clk", },
> +       { .name =3D "emacb_free_clk", },
> +};

Why no newlines between structures?

> +static const struct clk_parent_data noc_mux[] =3D {
> +       { .name =3D "noc_free_clk", },
> +       { .name =3D "boot_clk", },
> +};

As stated before, please use actual pointers for clks within the
controller and use .fw_name for clks outside of the controller.

> +
> +/* clocks in AO (always on) controller */
> +static const struct stratix10_pll_clock agilex_pll_clks[] =3D {
> +       { AGILEX_BOOT_CLK, "boot_clk", boot_mux, ARRAY_SIZE(boot_mux), 0,
> +         0x0},
> +       { AGILEX_MAIN_PLL_CLK, "main_pll", pll_mux, ARRAY_SIZE(pll_mux),
> +         0, 0x48},
> +       { AGILEX_PERIPH_PLL_CLK, "periph_pll", pll_mux, ARRAY_SIZE(pll_mu=
x),
> +         0, 0x9c},
> +};
> +
> +static const struct stratix10_perip_c_clock agilex_main_perip_c_clks[] =
=3D {
> +       { AGILEX_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0, =
0x58},
> +       { AGILEX_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0, =
0x5C},
> +       { AGILEX_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0, =
0x64},
> +       { AGILEX_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0, =
0x68},
> +       { AGILEX_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1,=
 0, 0xAC},
> +       { AGILEX_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1,=
 0, 0xB0},
> +       { AGILEX_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1,=
 0, 0xB8},
> +       { AGILEX_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1,=
 0, 0xBC},
> +};
> +
> +static const struct stratix10_perip_cnt_clock agilex_main_perip_cnt_clks=
[] =3D {
> +       { AGILEX_MPU_FREE_CLK, "mpu_free_clk", NULL, mpu_free_mux, ARRAY_=
SIZE(mpu_free_mux),
> +          0, 0x3C, 0, 0, 0},
> +       { AGILEX_NOC_FREE_CLK, "noc_free_clk", NULL, noc_free_mux, ARRAY_=
SIZE(noc_free_mux),
> +         0, 0x40, 0, 0, 1},
> +       { AGILEX_L4_SYS_FREE_CLK, "l4_sys_free_clk", "noc_free_clk", NULL=
, 1, 0,
> +         0, 4, 0, 0},
> +       { AGILEX_NOC_CLK, "noc_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux),
> +         0, 0, 0, 0x30, 1},
> +       { AGILEX_EMAC_A_FREE_CLK, "emaca_free_clk", NULL, emaca_free_mux,=
 ARRAY_SIZE(emaca_free_mux),
> +         0, 0xD4, 0, 0x88, 0},
> +       { AGILEX_EMAC_B_FREE_CLK, "emacb_free_clk", NULL, emacb_free_mux,=
 ARRAY_SIZE(emacb_free_mux),
> +         0, 0xD8, 0, 0x88, 1},
> +       { AGILEX_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", NULL, emac_ptp_f=
ree_mux,
> +         ARRAY_SIZE(emac_ptp_free_mux), 0, 0xDC, 0, 0x88, 2},
> +       { AGILEX_GPIO_DB_FREE_CLK, "gpio_db_free_clk", NULL, gpio_db_free=
_mux,
> +         ARRAY_SIZE(gpio_db_free_mux), 0, 0xE0, 0, 0x88, 3},
> +       { AGILEX_SDMMC_FREE_CLK, "sdmmc_free_clk", NULL, sdmmc_free_mux,
> +         ARRAY_SIZE(sdmmc_free_mux), 0, 0xE4, 0, 0x88, 4},
> +       { AGILEX_S2F_USER0_FREE_CLK, "s2f_user0_free_clk", NULL, s2f_usr0=
_free_mux,
> +         ARRAY_SIZE(s2f_usr0_free_mux), 0, 0xE8, 0, 0, 0},
> +       { AGILEX_S2F_USER1_FREE_CLK, "s2f_user1_free_clk", NULL, s2f_usr1=
_free_mux,
> +         ARRAY_SIZE(s2f_usr1_free_mux), 0, 0xEC, 0, 0x88, 5},
> +       { AGILEX_PSI_REF_FREE_CLK, "psi_ref_free_clk", NULL, psi_ref_free=
_mux,
> +         ARRAY_SIZE(psi_ref_free_mux), 0, 0xF0, 0, 0x88, 6},
> +};
> +
> +static const struct stratix10_gate_clock agilex_gate_clks[] =3D {
> +       { AGILEX_MPU_CLK, "mpu_clk", NULL, mpu_mux, ARRAY_SIZE(mpu_mux), =
0, 0x24,
> +         0, 0, 0, 0, 0x30, 0, 0},
> +       { AGILEX_MPU_PERIPH_CLK, "mpu_periph_clk", "mpu_clk", NULL, 1, 0,=
 0x24,
> +         0, 0, 0, 0, 0, 0, 4},
> +       { AGILEX_MPU_L2RAM_CLK, "mpu_l2ram_clk", "mpu_clk", NULL, 1, 0, 0=
x24,
> +         0, 0, 0, 0, 0, 0, 2},
> +       { AGILEX_L4_MAIN_CLK, "l4_main_clk", "noc_clk", NULL, 1, 0, 0x24,
> +         1, 0x44, 0, 2, 0, 0, 0},
> +       { AGILEX_L4_MP_CLK, "l4_mp_clk", "noc_clk", NULL, 1, 0, 0x24,
> +         2, 0x44, 8, 2, 0, 0, 0},
> +       { AGILEX_L4_SP_CLK, "l4_sp_clk", "noc_clk", NULL, 1, CLK_IS_CRITI=
CAL, 0x24,

Please comment in the code why CLK_IS_CRITICAL is used.

> +         3, 0x44, 16, 2, 0, 0, 0},
> +       { AGILEX_CS_AT_CLK, "cs_at_clk", "noc_clk", NULL, 1, 0, 0x24,
> +         4, 0x44, 24, 2, 0, 0, 0},
> +       { AGILEX_CS_TRACE_CLK, "cs_trace_clk", "noc_clk", NULL, 1, 0, 0x2=
4,
> +         4, 0x44, 26, 2, 0, 0, 0},
> +       { AGILEX_CS_PDBG_CLK, "cs_pdbg_clk", "cs_at_clk", NULL, 1, 0, 0x2=
4,
> +         4, 0x44, 28, 1, 0, 0, 0},
> +       { AGILEX_CS_TIMER_CLK, "cs_timer_clk", "noc_clk", NULL, 1, 0, 0x2=
4,
> +         5, 0, 0, 0, 0, 0, 0},
> +       { AGILEX_S2F_USER0_CLK, "s2f_user0_clk", NULL, s2f_usr0_mux, ARRA=
Y_SIZE(s2f_usr0_mux), 0, 0x24,
> +         6, 0, 0, 0, 0, 0, 0},
> +       { AGILEX_EMAC0_CLK, "emac0_clk", NULL, emac_mux, ARRAY_SIZE(emac_=
mux), 0, 0x7C,
> +         0, 0, 0, 0, 0x94, 26, 0},
> +       { AGILEX_EMAC1_CLK, "emac1_clk", NULL, emac_mux, ARRAY_SIZE(emac_=
mux), 0, 0x7C,
> +         1, 0, 0, 0, 0x94, 27, 0},
[..]
> +
> +static struct stratix10_clock_data *__socfpga_agilex_clk_init(struct pla=
tform_device *pdev,
> +                                                   int nr_clks)
> +{
> +       struct device_node *np =3D pdev->dev.of_node;
> +       struct device *dev =3D &pdev->dev;
> +       struct stratix10_clock_data *clk_data;
> +       struct clk **clk_table;
> +       struct resource *res;
> +       void __iomem *base;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base)) {
> +               pr_err("%s: failed to map clock registers\n", __func__);

ioremap fail usually prints an error message already. This is not
needed.

> +               return ERR_CAST(base);
> +       }
> +
> +       clk_data =3D devm_kzalloc(dev, sizeof(*clk_data), GFP_KERNEL);
> +       if (!clk_data)
> +               return ERR_PTR(-ENOMEM);
> +
> +       clk_data->base =3D base;
> +       clk_table =3D devm_kcalloc(dev, nr_clks, sizeof(*clk_table), GFP_=
KERNEL);
> +       if (!clk_table)
> +               return ERR_PTR(-ENOMEM);
> +
> +       clk_data->clk_data.clks =3D clk_table;
> +       clk_data->clk_data.clk_num =3D nr_clks;
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_da=
ta);

What if this fails?

> +       return clk_data;
> +}
> +
> +static int agilex_clkmgr_init(struct platform_device *pdev)
> +{
> +       struct stratix10_clock_data *clk_data;
> +
> +       clk_data =3D __socfpga_agilex_clk_init(pdev, AGILEX_NUM_CLKS);
> +       if (IS_ERR(clk_data))
> +               return PTR_ERR(clk_data);
> +
> +       agilex_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_cl=
ks), clk_data);
> +
> +       agilex_clk_register_c_perip(agilex_main_perip_c_clks,
> +                                ARRAY_SIZE(agilex_main_perip_c_clks), cl=
k_data);
> +
> +       agilex_clk_register_cnt_perip(agilex_main_perip_cnt_clks,
> +                                  ARRAY_SIZE(agilex_main_perip_cnt_clks),
> +                                  clk_data);
> +
> +       agilex_clk_register_gate(agilex_gate_clks, ARRAY_SIZE(agilex_gate=
_clks),
> +                             clk_data);
> +       return 0;
> +}
> +
> +static int agilex_clkmgr_probe(struct platform_device *pdev)
> +{
> +       return  agilex_clkmgr_init(pdev);

Why not just put the contents of that here in probe?

> +}
> +
> +static const struct of_device_id agilex_clkmgr_match_table[] =3D {
> +       { .compatible =3D "intel,agilex-clkmgr",
> +         .data =3D agilex_clkmgr_init },
> +       { }
> +};
> +
> +static struct platform_driver agilex_clkmgr_driver =3D {
> +       .probe          =3D agilex_clkmgr_probe,
> +       .driver         =3D {
> +               .name   =3D "agilex-clkmgr",
> +               .suppress_bind_attrs =3D true,
> +               .of_match_table =3D agilex_clkmgr_match_table,
> +       },
> +};
> +
> +static int __init agilex_clk_init(void)
> +{
> +       return platform_driver_register(&agilex_clkmgr_driver);
> +}
> +core_initcall(agilex_clk_init);
> diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-=
pll-s10.c
> index bcd3f14e9145..17fe5bd2c0e1 100644
> --- a/drivers/clk/socfpga/clk-pll-s10.c
> +++ b/drivers/clk/socfpga/clk-pll-s10.c
> @@ -27,6 +31,27 @@
> =20
>  #define to_socfpga_clk(p) container_of(p, struct socfpga_pll, hw.hw)
> =20
> +static unsigned long agilex_clk_pll_recalc_rate(struct clk_hw *hwclk,
> +                                               unsigned long parent_rate)
> +{
> +       struct socfpga_pll *socfpgaclk =3D to_socfpga_clk(hwclk);
> +       unsigned long arefdiv, reg, mdiv;
> +       unsigned long long vco_freq;
> +
> +       /* read VCO1 reg for numerator and denominator */
> +       reg =3D readl(socfpgaclk->hw.reg);
> +       arefdiv =3D (reg & SOCFPGA_PLL_AREFDIV_MASK) >> SOCFPGA_PLL_REFDI=
V_SHIFT;
> +
> +       vco_freq =3D (unsigned long long)parent_rate / arefdiv;
> +
> +       /* Read mdiv and fdiv from the fdbck register */
> +       reg =3D readl(socfpgaclk->hw.reg + 0x24);
> +       mdiv =3D (reg & SOCFPGA_AGILEX_PLL_MDIV_MASK);

Please remove useless parenthesis.

> +
> +       vco_freq =3D (unsigned long long)vco_freq * mdiv;
> +       return (unsigned long)vco_freq;

Drop the cast, it's implicit.

> +}
> +
>  static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
>                                          unsigned long parent_rate)
>  {
> @@ -98,6 +123,12 @@ static int clk_pll_prepare(struct clk_hw *hwclk)
>         return 0;
>  }
> =20
> +static struct clk_ops agilex_clk_pll_ops =3D {

Can it be const?

> +       .recalc_rate =3D agilex_clk_pll_recalc_rate,
> +       .get_parent =3D clk_pll_get_parent,
> +       .prepare =3D clk_pll_prepare,
> +};
> +
>  static struct clk_ops clk_pll_ops =3D {

I guess this one could be const too, but in a different patch?

>         .recalc_rate =3D clk_pll_recalc_rate,
>         .get_parent =3D clk_pll_get_parent,
