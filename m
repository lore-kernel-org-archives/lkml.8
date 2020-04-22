Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1905AC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB49020767
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587580732;
	bh=4RCEebdN3SKWIn8s+iOr8Vy+art0cBYVk74ItwVQ2+A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=SpXNkX4T2BfCEb2c1ohuhcLap8hDXVgb+AsWS4Prwz7H6ds/FLkhgzRXnowND1CgA
	 jBAEySV0OFS0W7np2JvobhoBiXhQwH7WSlraGc6XJrQpXaiVVqV6vGMNvMV+7b8547
	 MQ/jFuW3W/rATtrVjHXy7romFqzFflxf/bnSwipo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgDVSiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgDVSiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:38:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F2232075A;
        Wed, 22 Apr 2020 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587580730;
        bh=4RCEebdN3SKWIn8s+iOr8Vy+art0cBYVk74ItwVQ2+A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IsPzmCPmtlUBuzteTciUbcrZ+myoeIhym7uyO31Lm1heXh91RcZXgoFM2GesTo2/x
         lNfd2eyXs4cvWB3UVN+kaxMPF0qyl1tUL/AUfOgRnGqugkQR2mx1WUiBLT79VZErhA
         PZFpoXbBaICpEeWotJvbvVzT3gUvp6le2EDMvnzU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1586937773-5836-10-git-send-email-abel.vesa@nxp.com>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com> <1586937773-5836-10-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH v3 09/13] clk: imx: Add audiomix clock controller support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Lee Jones <lee.jones@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 22 Apr 2020 11:38:49 -0700
Message-ID: <158758072945.163502.17393357985434075011@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2020-04-15 01:02:49)
> diff --git a/drivers/clk/imx/clk-audiomix.c b/drivers/clk/imx/clk-audiomi=
x.c
> new file mode 100644
> index 00000000..aa48b06
> --- /dev/null
> +++ b/drivers/clk/imx/clk-audiomix.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2019 NXP.
> + */
> +
> +#include <dt-bindings/clock/imx8mp-clock.h>
> +#include <linux/clk.h>

Include <linux/clk-provider.h> because this is a clk provider.

> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>

Is this include used?

> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "clk.h"
> +
> +static int shared_count_pdm;
> +static struct clk_hw **hws;
> +static struct clk_hw_onecell_data *clk_hw_data;
> +static uint32_t audiomix_clk_saved_regs[14];
> +static struct clk *clk_audio_root;
> +static struct clk *clk_audio_ahb;
> +static struct clk *clk_audio_axi_div;
> +
> +static const struct imx_pll14xx_rate_table imx_audiomix_sai_pll_tbl[] =
=3D {
> +       PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
> +};
> +
> +static const struct imx_pll14xx_clk imx_audiomix_sai_pll =3D {
> +       .type =3D PLL_1443X,
> +       .rate_table =3D imx_audiomix_sai_pll_tbl,
> +};
> +
> +static const char * const imx_sai_mclk2_sels[] =3D {"sai1", "sai2", "sai=
3", "dummy",
> +                                       "sai5", "sai6", "sai7", "dummy",
> +                                       "dummy", "dummy", "dummy",
> +                                       "dummy", "dummy", "dummy", "dummy=
"};
> +static const char * const imx_sai1_mclk1_sels[] =3D {"sai1", "dummy", };
> +static const char * const imx_sai2_mclk1_sels[] =3D {"sai2", "dummy", };
> +static const char * const imx_sai3_mclk1_sels[] =3D {"sai3", "dummy", };
> +static const char * const imx_sai5_mclk1_sels[] =3D {"sai5", "dummy", };
> +static const char * const imx_sai6_mclk1_sels[] =3D {"sai6", "dummy", };
> +static const char * const imx_sai7_mclk1_sels[] =3D {"sai7", "dummy", };
> +static const char * const imx_pdm_sels[] =3D {"pdm", "sai_pll_div2", "du=
mmy", "dummy" };
> +static const char * const imx_sai_pll_ref_sels[] =3D {"osc_24m", "dummy"=
, "dummy", "dummy", };
> +static const char * const imx_sai_pll_bypass_sels[] =3D {"sai_pll", "sai=
_pll_ref_sel", };
> +
> +static int imx_audiomix_clk_probe(struct platform_device *pdev)
[..]
> +
> +       /* unbypass the pll */
> +       clk_hw_set_parent(hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS],
> +                               hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL]);
> +
> +       imx_check_clk_hws(hws, IMX8MP_CLK_AUDIOMIX_END);
> +
> +       of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> +                               clk_hw_data);

What if this fails?

> +
> +       return 0;
> +}
> +
> +static const struct of_device_id imx_audiomix_clk_of_match[] =3D {
> +       { .compatible =3D "fsl,imx8mp-audiomix-clk" },
> +       { /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_audiomix_clk_of_match);
> +
> +

Nitpick: Remove double newline?

> +static struct platform_driver imx_audiomix_clk_driver =3D {
> +       .probe =3D imx_audiomix_clk_probe,
> +       .driver =3D {
> +               .name =3D "imx-audiomix-clk",
> +               .of_match_table =3D of_match_ptr(imx_audiomix_clk_of_matc=
h),

Add suppress_bind_attr here so that this can't be removed from
userspace?

> +       },
> +};
> +module_platform_driver(imx_audiomix_clk_driver);
