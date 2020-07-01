Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D07420760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgGANEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730729AbgGANET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:04:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E50C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 06:04:19 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jqcOk-0003Cb-4F; Wed, 01 Jul 2020 15:03:34 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jqcOj-0002Nq-BU; Wed, 01 Jul 2020 15:03:33 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v9 0/5] mainline Protonic boards
Date:   Wed,  1 Jul 2020 15:03:25 +0200
Message-Id: <20200701130330.9089-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v9:
- rebase against kernel v5.8-rc3
- prti6q: set index to default-brightness-level
- prti6q: remove regulator-always-on
- prti6q: rename mux_ssi1 and mux_pins3 to mux-ssi1, mux-pins3
- prti6q: move can1 node out of dtsi and fix alphabetical order
- prti6q: fix reg value for rgmii_phy
- prti6q: fix pinctrl_can2 and pinctrl_can1
- vt7: fix fsl,mode
- vt7: rename mux_ssi1 and mux_pins3 to mux-ssi1, mux-pins3
- vt7: remove regulator-always-on
- wd2: remove pm-ignore-notify, it is not implemented and documented
- wd2: remove duplicate non-removable

changes v8:
- resend

changes v7:
- VT7: reorder node alphabetically
- VT7: rename "reg_12v_bl: regulator-bl-12v" to "reg_bl_12v0: regulator-bl-12v0"
- VT7: remove panel and TS nodes. This drivers are currently not
  mainline.
- prti6q.dtsi: move reg_1v8 to prti6q.dts
- prti6q.dtsi: remove pinctrl from the can1 node. It is done on almost
  every board file.

changes v6:
- move fsl.yaml changes to separate patch
- remove partitions, they are provided by the bootloader
- update flash compatible
- rename can3 to can
- fix fsl,mode
- fix interrupt in the wlan node on PRTI6Q

changes v5:
- PRTI6Q: remove status from the pwm-backlight node
- drop the vendor-prefixes patch, it is already taken by Rob
- add Reviewed-by: Rob Herring <robh@kernel.org>

changes v4:
- VT7: fix typo

changes v3:
- move compatible to the start of node
- move status to the end
- use generic names in compatible
- refactor dts/dtsi
- use alphabet order for pinctrl and phandels
- remove unused or currently not supported nodes

changes v2:
- squash PRTI6Q patches

Oleksij Rempel (5):
  dt-bindings: arm: fsl: add different Protonic boards
  ARM: dts: add Protonic PRTI6Q board
  ARM: dts: add Protonic WD2 board
  ARM: dts: add Protonic VT7 board
  ARM: dts: add Protonic RVT board

 .../devicetree/bindings/arm/fsl.yaml          |   4 +
 arch/arm/boot/dts/Makefile                    |   4 +
 arch/arm/boot/dts/imx6dl-prtrvt.dts           | 184 ++++++
 arch/arm/boot/dts/imx6dl-prtvt7.dts           | 410 +++++++++++++
 arch/arm/boot/dts/imx6q-prti6q.dts            | 542 ++++++++++++++++++
 arch/arm/boot/dts/imx6q-prtwd2.dts            | 188 ++++++
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi         | 163 ++++++
 7 files changed, 1496 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-prtrvt.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-prtvt7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-prti6q.dts
 create mode 100644 arch/arm/boot/dts/imx6q-prtwd2.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-prti6q.dtsi

-- 
2.27.0

