Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0193C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9AD2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598633342;
	bh=Wwkz9ubdC4d89Hl6z0P8S1t5VHI9tjmoy/T0n7UH+bM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JzKgGtADe7uCoYklinaVMnNMNiuLlj9Z0En+5DEqHAJZuCv4G6MiYBvP4RTLDMqmO
	 cww0boYG95LhjBd+3SqfCVsoJYdStSLJEDtwXNU5os21vYIsvU77aNMzsjgGVzsZdQ
	 RDP81sUJaA2CsX26La1Lsfk/CtbF0ivqburFiO4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgH1QtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgH1QtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:49:00 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E51920848;
        Fri, 28 Aug 2020 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633340;
        bh=Wwkz9ubdC4d89Hl6z0P8S1t5VHI9tjmoy/T0n7UH+bM=;
        h=From:To:Cc:Subject:Date:From;
        b=gkc/VRi2gUW3RgoERRpYudU0O5VRe+yQbUrx/D57d/pzQ7TjVGDdGDsXwbUvoWOrF
         H6r6VK8WPq9W1m+Ewx9tDO0MWuoKRPbUjxwry4LF8wHXcXbwRt3P0QQ46ZZ8ws22/d
         f4SRaz7RSIJ26cGHSv6TTjHfgZogZwaqBdC1oh9k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 00/19] arm64: dts: imx8: Align pins and regulators with dtschema
Date:   Fri, 28 Aug 2020 18:47:31 +0200
Message-Id: <20200828164750.10377-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a v2 of my second batch of i.MX8 DTS and bindings cleanup. It's
rebased on top of first batch [1] although it is independent.

1. For arm64/dts patches: to avoid any conflicts, better to apply
   on top of [1].
2. dt-bindings patches: independend, can be applied by Rob or subsystem
   maintainers.


Changes since v1:
=================
1. Address few comments - see individual patches.

[1] https://lore.kernel.org/lkml/20200825193536.7332-1-krzk@kernel.org/


Best regards,
Krzysztof


Krzysztof Kozlowski (19):
  dt-bindings: mfd: rohm,bd71847-pmic: Correct clock properties
    requirements
  dt-bindings: mtd: gpmi-nand: Fix matching of clocks on different SoCs
  arm64: dts: imx8mm-beacon-kit: Add missing build through Makefile
  arm64: dts: imx8mm-beacon-som: Align regulator names with schema
  arm64: dts: imx8mm-beacon-som: Fix atmel,24c64 EEPROM compatible
  arm64: dts: imx8mm-beacon: Align pin configuration group names with
    schema
  arm64: dts: imx8mm-evk: Align regulator names with schema
  arm64: dts: imx8mm-evk: Add 32.768 kHz clock to PMIC
  arm64: dts: imx8mm-evk: Align pin configuration group names with
    schema
  arm64: dts: imx8mm-ddr4-evk: Align pin configuration group names with
    schema
  arm64: dts: imx8mn-ddr4-evk: Align regulator names with schema
  arm64: dts: imx8mn-evk: Align pin configuration group names with
    schema
  arm64: dts: imx8mq-evk: Align pin configuration group names with
    schema
  arm64: dts: imx8mq-librem5-devkit: Align pin configuration group names
    with schema
  arm64: dts: imx8mq-phanbell: Align pin configuration group names with
    schema
  arm64: dts: imx8mq-pico-pi: Align pin configuration group names with
    schema
  arm64: dts: imx8mq-sr-som: Align pin configuration group names with
    schema
  arm64: dts: imx8mq-hummingboard-pulse: Align pin configuration group
    names with schema
  arm64: dts: imx8qxp-colibri: Align pin configuration group names with
    schema

 .../bindings/mfd/rohm,bd71847-pmic.yaml       |  9 ++-
 .../devicetree/bindings/mtd/gpmi-nand.yaml    | 76 +++++++++++++++----
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../freescale/imx8mm-beacon-baseboard.dtsi    |  8 +-
 .../boot/dts/freescale/imx8mm-beacon-som.dtsi | 36 ++++-----
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 40 +++++-----
 .../boot/dts/freescale/imx8mn-ddr4-evk.dts    | 24 +++---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 14 ++--
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  2 +-
 .../freescale/imx8mq-hummingboard-pulse.dts   |  8 +-
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 12 +--
 .../boot/dts/freescale/imx8mq-phanbell.dts    | 12 +--
 .../boot/dts/freescale/imx8mq-pico-pi.dts     | 12 +--
 .../boot/dts/freescale/imx8mq-sr-som.dtsi     |  4 +-
 .../boot/dts/freescale/imx8qxp-colibri.dtsi   |  8 +-
 15 files changed, 161 insertions(+), 105 deletions(-)

-- 
2.17.1

