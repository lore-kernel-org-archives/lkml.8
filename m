Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3D7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461D5207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590563175;
	bh=Bnwio/T0f8/rO+4l0ETfUXCahBdmz6vzX2tvqweK3c4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=M+EDLXawP/CzvUrYJ/bOcr/axCxKBRYqJGj5pBkUJYfjklXxZEPWm7hAoqWrajMrv
	 F+E9AoCF73dT8fPCzYHyssf0x7y2FXxXLEO4aPc5yiJXqC50BXw/3nNZtxB0Hb1f3D
	 B/8MMG/jHZcW5tHd3AEhSJl9hlLhaVpr/b1lOPBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgE0HGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgE0HGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:06:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85A65206F1;
        Wed, 27 May 2020 07:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590563173;
        bh=Bnwio/T0f8/rO+4l0ETfUXCahBdmz6vzX2tvqweK3c4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oF/iNegV3lDmsHA8jl2XuOdgHsm3ArbmfhqDo4tj/ixgr/8+hjuVwgK2omrt1GHqK
         lftYRB6EtnDGNvsW0OlYmy8Cp4c40r1rRUvQnh70Y1+AmlskJw2okPi3Ha7N8yyMaB
         MuI4eAKk/rPw1yzcI9NKh9tcdk+KZvcMyWAF4ovE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a1efabae8d7df30c987bff10544c2071e906e07a.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech> <a1efabae8d7df30c987bff10544c2071e906e07a.1587742492.git-series.maxime@cerno.tech>
Subject: Re: [PATCH v2 25/91] clk: bcm: Add BCM2711 DVP driver
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
Date:   Wed, 27 May 2020 00:06:12 -0700
Message-ID: <159056317280.88029.13256292035418533462@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-04-24 08:34:06)
> The HDMI block has a block that controls clocks and reset signals to the
> HDMI0 and HDMI1 controllers.
>=20
> Let's expose that through a clock driver implementing a clock and reset
> provider.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

> diff --git a/drivers/clk/bcm/clk-bcm2711-dvp.c b/drivers/clk/bcm/clk-bcm2=
711-dvp.c
> new file mode 100644
> index 000000000000..c1c4b5857d32
> --- /dev/null
> +++ b/drivers/clk/bcm/clk-bcm2711-dvp.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2020 Cerno
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
[...]
> +
> +static int clk_dvp_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *data;
> +       struct resource *res;
> +       struct clk_dvp *dvp;
> +       void __iomem *base;
> +       int ret;
> +
> +       dvp =3D devm_kzalloc(&pdev->dev, sizeof(*dvp), GFP_KERNEL);
> +       if (!dvp)
> +               return -ENOMEM;
> +       platform_set_drvdata(pdev, dvp);
> +
> +       dvp->data =3D devm_kzalloc(&pdev->dev,
> +                                struct_size(dvp->data, hws, NR_CLOCKS),
> +                                GFP_KERNEL);
> +       if (!dvp->data)
> +               return -ENOMEM;
> +       data =3D dvp->data;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base =3D devm_ioremap_resource(&pdev->dev, res);

devm_platform_ioremap_resource()?

> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
