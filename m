Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008E8C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7DD20797
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599231208;
	bh=bjAz7YHJmR0xoTdAVB4K1GtWMTGGPiLOn6zcDC3zJ0I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HZxN5qpeMOjE3lmE/BN9b6B4p4embwq+MbOxZ9ATmhxU6AJnaVY1diLze1NVeFv/K
	 I0zXAUvA1tykvxLxuoQywdoH83LWKCb7aof3VfMM3jeWryRpEPiYgO28vrLqmaNkqV
	 6IUhStf+suiKHC4hjRPxQH3sAsoVVBTLJ8KdT9K8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgIDOx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730160AbgIDOxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:53:24 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E45132074D;
        Fri,  4 Sep 2020 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231203;
        bh=bjAz7YHJmR0xoTdAVB4K1GtWMTGGPiLOn6zcDC3zJ0I=;
        h=From:To:Cc:Subject:Date:From;
        b=OAv7X5gvBUumvNAkExgshZaX36psIdv419CgbhfhwJ7fQbY5FiVYF21NTEErDw0Tg
         G+/tMjMmogShWIVJAFpeFef+9Ol6liSBRC6RheddUo7D9zP+mn59CwAz2LY2lSPNds
         NnRND0xnpZLpR7g2qfrUAP0hpnUGxoOU5IP8XxxU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 00/13] iMX 8 - Another round of cleanups
Date:   Fri,  4 Sep 2020 16:52:59 +0200
Message-Id: <20200904145312.10960-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an another round of cleanups of i.MX 8 DTS and binings.  No
dependencies.

Best regards,
Krzysztof

Krzysztof Kozlowski (13):
  dt-bindings: power: fsl,imx-gpcv2: Document interrupt controller
    properties
  dt-bindings: display: bridge: nwl-dsi: Add common properties
  dt-bindings: arm: fsl: Fix matching Purism Librem5 phones
  dt-bindings: gpu: vivante,gc: Add common properties
  dt-bindings: gpu: vivante,gc: Remove trailing whitespace
  dt-bindings: mfd: rohm,bd71837-pmic: Add common properties
  dt-bindings: mfd: rohm,bd71847-pmic: Add common clock-names
  arm64: dts: imx8mm-var-som-symphony: Use newer interrupts property
  arm64: dts: imx8mp-evk: Align pin configuration group names with
    schema
  arm64: dts: imx8mq: Add missing interrupts to GPC
  arm64: dts: imx8mq-librem5: Align regulator names with schema
  arm64: dts: imx8mq-librem5: Drop interrupt-names in PMIC
  arm64: dts: imx8mq-librem5: Add interrupt-names to ti,tps6598x

 .../devicetree/bindings/arm/fsl.yaml          | 10 ++++--
 .../bindings/display/bridge/nwl-dsi.yaml      |  4 +++
 .../devicetree/bindings/gpu/vivante,gc.yaml   |  9 +++++-
 .../bindings/mfd/rohm,bd71837-pmic.yaml       |  6 ++++
 .../bindings/mfd/rohm,bd71847-pmic.yaml       |  3 ++
 .../bindings/power/fsl,imx-gpcv2.yaml         |  4 +++
 .../dts/freescale/imx8mm-var-som-symphony.dts |  2 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 12 +++----
 .../dts/freescale/imx8mq-librem5-devkit.dts   |  1 -
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 32 +++++++++----------
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  1 +
 11 files changed, 57 insertions(+), 27 deletions(-)

-- 
2.17.1

