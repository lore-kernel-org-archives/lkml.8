Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A2DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E4D207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590546549;
	bh=YhyOLQZ3lG6PhFtaaTEo8SRrhB4AT+bwZDOiVXp2vqc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=GF+7X+brNThsO3+ZqflmtLhpxUSr2L0nDr2QQP8+Zgl5yqJ7XG12j0uHCM+vDAsDg
	 AdYsIx0lpalFZgDJU18DUEEC/g2l1t644m6TMGTAnEA+acLD5XxKcZLTlwy8OzuBU+
	 iLc9IImN00VYnR7lpKtPy9bM6qhZCdRoKa+SaeTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgE0C3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0C3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:29:07 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7A15207CB;
        Wed, 27 May 2020 02:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590546546;
        bh=YhyOLQZ3lG6PhFtaaTEo8SRrhB4AT+bwZDOiVXp2vqc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OILEbTIyH7PRImnc2FbROX72D4Gf4CtoOUmee0Go461O+bmJHeLjNyG0s8Vvw60ws
         9gBnlCkuY+n09H06leznxe670bYqMCXomNfWGG/jg3v9SFaYEL7DPrx82lHQhNamFD
         7FTR0YLonQ1HLzJfbgBLUBQCXrHwlaemvg+uHGyk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1590314686-11749-4-git-send-email-sivaprak@codeaurora.org>
References: <1590314686-11749-1-git-send-email-sivaprak@codeaurora.org> <1590314686-11749-4-git-send-email-sivaprak@codeaurora.org>
Subject: Re: [PATCH V5 3/8] clk: qcom: Add ipq apss pll driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Tue, 26 May 2020 19:29:06 -0700
Message-ID: <159054654603.88029.920557590088471867@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sivaprakash Murugesan (2020-05-24 03:04:41)
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-=
pll.c
> new file mode 100644
> index 0000000..aafdaa7
> --- /dev/null
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/module.h>

Sort the includes above, also add clk-provider.h because this is a clk
provider.

> +
> +#include "clk-alpha-pll.h"
> +
> +static const u8 ipq_pll_offsets[] =3D {
[...]
> +
> +static int apss_ipq_pll_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct regmap *regmap;
> +       struct resource *res;
> +       void __iomem *base;
> +       int ret;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(dev, res);

Use devm_platform_ioremap_resource()?

> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
> +                                               &ipq_pll_regmap_config);

Tabbing is off here. &ipq_pll_regmap_config should line up with the (
above.

> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
