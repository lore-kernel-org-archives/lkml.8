Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105DFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA072082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596052183;
	bh=kgm0JlvFgRf7tVCIEqwijHYXXH+scApjMY/q/UXbwHg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=JUs8VpATzbeG4XMqSVGjK8IW7wUOtP9w7q2VKxxnR0Qgb0E7y2FBwNYCnL4rAasWf
	 pfOVDpJPVJuNxmo3CU7oqHwZTlu3VCl3pbEHNVXlDClLQwxWk9CZS6UrxT6QHbYxmx
	 6iKruIwBuDz4R5KTftFAnqCUgF+VCE57dotCkEfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgG2Ttm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2Ttm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:49:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B00820809;
        Wed, 29 Jul 2020 19:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596052182;
        bh=kgm0JlvFgRf7tVCIEqwijHYXXH+scApjMY/q/UXbwHg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bAgD7mH9IAP9wh6bHX2puCDRtHu4SZ+vLCgLGn6boejt+GUQv8jpXa6OAFexOn2wQ
         O+MCFzQu4uBXjnJECpnyjo1MsbpC+LA4W5Q9GHiSlZHma32GLGXD9q2CUP71KWWzJD
         7d0h4UrcyHNb8/yqJUIAEDvNHbhGRS0Scv3mv4CY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1596024483-21482-11-git-send-email-abel.vesa@nxp.com>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com> <1596024483-21482-11-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH 10/17] Documentation: bindings: clk: Add bindings for i.MX BLK_CTRL
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 29 Jul 2020 12:49:41 -0700
Message-ID: <159605218106.1360974.17212937588367161697@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2020-07-29 05:07:56)
> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yam=
l b/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
> new file mode 100644
> index 00000000..036d3d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fsl,imx-blk-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
[...]
> +
> +examples:
> +  - |
> +    audio-blk-ctrl: blk-ctrl@30e20000 {

clock-controller@30e20000 {

> +       compatible =3D "fsl,imx8mp-blk-ctrl", "syscon";
> +       reg =3D <0x30e20000 0x10000>;
> +       power-domains =3D <&audiomix_pd>;
> +
> +       #clock-cells =3D <1>;
> +       #reset-cells =3D <1>;
> +    };
