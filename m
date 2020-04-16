Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21CCC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFBB206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438046AbgDPHCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437790AbgDPHCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:02:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB76C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:02:38 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jOyXY-0005qT-Tq; Thu, 16 Apr 2020 09:02:24 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jOyXX-0003M3-SP; Thu, 16 Apr 2020 09:02:23 +0200
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
Subject: [PATCH v5 0/4] mainline Protonic boards
Date:   Thu, 16 Apr 2020 09:02:18 +0200
Message-Id: <20200416070222.12181-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.26.0.rc2
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

Oleksij Rempel (4):
  ARM: dts: add Protonic PRTI6Q board
  ARM: dts: add Protonic WD2 board
  ARM: dts: add Protonic VT7 board
  ARM: dts: add Protonic RVT board

 .../devicetree/bindings/arm/fsl.yaml          |   4 +
 arch/arm/boot/dts/Makefile                    |   4 +
 arch/arm/boot/dts/imx6dl-prtrvt.dts           | 203 +++++++
 arch/arm/boot/dts/imx6dl-prtvt7.dts           | 473 +++++++++++++++
 arch/arm/boot/dts/imx6q-prti6q.dts            | 550 ++++++++++++++++++
 arch/arm/boot/dts/imx6q-prtwd2.dts            | 188 ++++++
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi         | 185 ++++++
 7 files changed, 1607 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-prtrvt.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-prtvt7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-prti6q.dts
 create mode 100644 arch/arm/boot/dts/imx6q-prtwd2.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-prti6q.dtsi

-- 
2.26.0.rc2

