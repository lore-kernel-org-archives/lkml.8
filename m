Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BD5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0889206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgG3HaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:30:07 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37426 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgG3HaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:30:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3885D2011E0;
        Thu, 30 Jul 2020 09:30:05 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BA3420021B;
        Thu, 30 Jul 2020 09:30:05 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A41D20341;
        Thu, 30 Jul 2020 09:30:04 +0200 (CEST)
Date:   Thu, 30 Jul 2020 10:30:04 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 10/17] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTRL
Message-ID: <20200730073004.r2d2prwlocqclpz3@fsr-ub1664-175>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
 <1596024483-21482-11-git-send-email-abel.vesa@nxp.com>
 <159605218106.1360974.17212937588367161697@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159605218106.1360974.17212937588367161697@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-29 12:49:41, Stephen Boyd wrote:
> Quoting Abel Vesa (2020-07-29 05:07:56)
> > diff --git a/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml b/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
> > new file mode 100644
> > index 00000000..036d3d3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only)
> > +%YAML 1.2
> > +---
> > +$id: https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Ffsl%2Cimx-blk-ctrl.yaml%23&amp;data=02%7C01%7Cabel.vesa%40nxp.com%7C30d7fec624c44b4f85e108d833f88a5e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637316489861505079&amp;sdata=63jhxp1rw%2BMYPlc%2BhwSjOwBvN%2Fikf5PXUKGjEXD5agM%3D&amp;reserved=0
> > +$schema: https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=02%7C01%7Cabel.vesa%40nxp.com%7C30d7fec624c44b4f85e108d833f88a5e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637316489861505079&amp;sdata=9%2FLcFRkMHXx1%2FHsEfFyhNmI73hDC2GUu2s%2BE9EQTUSE%3D&amp;reserved=0
> [...]
> > +
> > +examples:
> > +  - |
> > +    audio-blk-ctrl: blk-ctrl@30e20000 {
> 
> clock-controller@30e20000 {

Will change in the new version.

> 
> > +       compatible = "fsl,imx8mp-blk-ctrl", "syscon";
> > +       reg = <0x30e20000 0x10000>;
> > +       power-domains = <&audiomix_pd>;
> > +
> > +       #clock-cells = <1>;
> > +       #reset-cells = <1>;
> > +    };
