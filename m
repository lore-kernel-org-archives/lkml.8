Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CCAC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72446206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584061267;
	bh=uy2OXM73oGUesqzxIxuGWbUgIsrh1BViYety9ik44ic=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ma4Q9XrO7Yleaeb1KPPsqi52dZPB/vtadnthRhbhgp/6YZviL4kRUhlN1CZMa8wc3
	 plte2Z2Ry3yr69LCsgLtbk7OVGWVCcGxo8siF8NAUgtPmDmslSf0zOkAEDdozYtxrV
	 lvAhZ4cjX97lSwc46paycucClsx8pBgRECMtBDl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCMBBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgCMBBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:01:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F27620637;
        Fri, 13 Mar 2020 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584061260;
        bh=uy2OXM73oGUesqzxIxuGWbUgIsrh1BViYety9ik44ic=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=we+k4V9lzqruvFLtqWB8xUS0uM6m3loDgI5ykV4MA6/qVEsIJ4FoazOCXo3sheqUs
         sSKld74yTBvSmF5NmECSVX8YJNH4g3t/aBR1ZtUykLsz32eEIE+ryxDzeM84gJG5DM
         QEyHcbC3597nFJuFP5EtLRoNe3Ed4HeJBOFGX4NI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6dd6bd48e894c1e8ee85c29a30ba1b18041d83c4.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <6dd6bd48e894c1e8ee85c29a30ba1b18041d83c4.1582533919.git-series.maxime@cerno.tech>
Subject: Re: [PATCH 27/89] clk: bcm: Add BCM2711 DVP driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Eric Anholt <eric@anholt.net>, Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Thu, 12 Mar 2020 18:00:59 -0700
Message-ID: <158406125965.149997.13919203635322854760@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-02-24 01:06:29)
> diff --git a/drivers/clk/bcm/clk-bcm2711-dvp.c b/drivers/clk/bcm/clk-bcm2=
711-dvp.c
> new file mode 100644
> index 000000000000..f4773cc92724
> --- /dev/null
> +++ b/drivers/clk/bcm/clk-bcm2711-dvp.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2020 Cerno
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/reset/reset-simple.h>
> +
> +#define DVP_HT_RPI_SW_INIT     0x04
> +#define DVP_HT_RPI_MISC_CONFIG 0x08
> +
> +#define NR_CLOCKS      2
> +#define NR_RESETS      6
> +
> +struct clk_dvp {
> +       struct clk                      *clks[NR_CLOCKS];
> +       struct clk_onecell_data         clk_data;
> +       struct reset_simple_data        reset;
> +};
> +
> +static int clk_dvp_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       struct clk_dvp *dvp;
> +       void __iomem *base;
> +       const char *parent;
> +       int ret;
> +
> +       dvp =3D devm_kzalloc(&pdev->dev, sizeof(*dvp), GFP_KERNEL);
> +       if (!dvp)
> +               return -ENOMEM;
> +       platform_set_drvdata(pdev, dvp);
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       dvp->reset.rcdev.owner =3D THIS_MODULE;
> +       dvp->reset.rcdev.nr_resets =3D NR_RESETS;
> +       dvp->reset.rcdev.ops =3D &reset_simple_ops;
> +       dvp->reset.rcdev.of_node =3D pdev->dev.of_node;
> +       dvp->reset.membase =3D base + DVP_HT_RPI_SW_INIT;
> +       spin_lock_init(&dvp->reset.lock);
> +
> +       ret =3D reset_controller_register(&dvp->reset.rcdev);
> +       if (ret)
> +               return ret;
> +
> +       parent =3D of_clk_get_parent_name(pdev->dev.of_node, 0);
> +       if (!parent)
> +               goto unregister_reset;
> +
> +       dvp->clks[0] =3D clk_register_gate(&pdev->dev, "hdmi0-108MHz",
> +                                        parent, CLK_IS_CRITICAL,
> +                                        base + DVP_HT_RPI_MISC_CONFIG, 3,
> +                                        CLK_GATE_SET_TO_DISABLE, &dvp->r=
eset.lock);
> +       if (IS_ERR(dvp->clks[0])) {
> +               ret =3D PTR_ERR(dvp->clks[0]);
> +               goto unregister_reset;
> +       }
> +
> +       dvp->clks[1] =3D clk_register_gate(&pdev->dev, "hdmi1-108MHz",
> +                                        parent, CLK_IS_CRITICAL,
> +                                        base + DVP_HT_RPI_MISC_CONFIG, 4,
> +                                        CLK_GATE_SET_TO_DISABLE, &dvp->r=
eset.lock);

Can we use clk_hw APIs, document why CLK_IS_CRITICAL, and use something
like clk_hw_register_gate_parent_data() so that we don't have to use
of_clk_get_parent_name() above?


> +       if (IS_ERR(dvp->clks[1])) {
> +               ret =3D PTR_ERR(dvp->clks[1]);
> +               goto unregister_clk0;
> +       }
> +
> +       dvp->clk_data.clks =3D dvp->clks;
> +       dvp->clk_data.clk_num =3D NR_CLOCKS;
> +       of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,
> +                           &dvp->clk_data);

This can fail. Please recover. Also, please use clk_hw based APIs.

> +
> +       return 0;
> +
> +
> +unregister_clk0:
> +       clk_unregister_gate(dvp->clks[0]);
> +
> +unregister_reset:
> +       reset_controller_unregister(&dvp->reset.rcdev);
> +       return ret;
> +};
> +
> +static int clk_dvp_remove(struct platform_device *pdev)
> +{
> +       struct clk_dvp *dvp =3D platform_get_drvdata(pdev);
> +
> +       clk_unregister_gate(dvp->clks[1]);
> +       clk_unregister_gate(dvp->clks[0]);
> +       reset_controller_unregister(&dvp->reset.rcdev);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id clk_dvp_dt_ids[] =3D {
> +       { .compatible =3D "brcm,brcm2711-dvp", },
> +       { /* sentinel */ },

Please drop comma after this so we can't put anything after lest it
cause a compiler error.

> +};
> +
> +static struct platform_driver clk_dvp_driver =3D {
> +       .probe  =3D clk_dvp_probe,
> +       .remove =3D clk_dvp_remove,
> +       .driver =3D {
> +               .name           =3D "brcm2711-dvp",
> +               .of_match_table =3D clk_dvp_dt_ids,
> +       },
> +};
> +module_platform_driver(clk_dvp_driver);
> --=20
> git-series 0.9.1
