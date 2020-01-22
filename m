Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3B2C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF19224687
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686118;
	bh=5KGiFtPDCtBNnlUpwuwCkTLUluovlgdstuOfe64TrN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1GDdsteYD7fUtxos11uNGRjGtqQ2X+34CJh8qnGA7o9x7bTyDBPk4QunHFN+80H7w
	 t8fEhUdMO78BW/f+CxgjTohdUNtNzVrqO4z5v5mkOzBbZYqaJm+UvYUSTilVEln0m8
	 Ox3kTs6i3D6i0I7N7CJIdJ1iUmf0KL55xbvbqXec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbgAVJl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:41:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387624AbgAVJlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:41:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E1B2467B;
        Wed, 22 Jan 2020 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686109;
        bh=5KGiFtPDCtBNnlUpwuwCkTLUluovlgdstuOfe64TrN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqxmtY+ldXtHWWjliep7jkBTe0NEd/yVRmzkgx50ZCL8wmDHY0Lv4RCEA7yq355XI
         mYrooXZOQNm+HCXAjzyYKThvUnXNnI7RRCX0vK5XykvFbhK8fFn8BUEqz9wkPy/V9Z
         j10x6r51XEDXCV8MNL68i4cPn0ZdvdORkgrWYEr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 4.19 047/103] ARM: dts: imx6qdl: Add Engicam i.Core 1.5 MX6
Date:   Wed, 22 Jan 2020 10:29:03 +0100
Message-Id: <20200122092810.874280626@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacopo Mondi <jacopo@jmondi.org>

commit 37c045d25e90038682b845de0a1db43c8301694d upstream.

The 1.5 version of Engicam's i.Core MX6 CPU module features a different clock
provider for the ethernet's PHY interface. Adjust the FEC ptp clock to
reference CLK_ENET_REF clock source, and set SION bit of
MX6QDL_PAD_GPIO_16__ENET_REF_CLK to adjust the input path of that pin.

The newly introduced imx6ql-icore-1.5.dtsi allows to collect in a single
place differences between version '1.0' and '1.5' of the module.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Cc: Daniel Díaz <daniel.diaz@linaro.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi |   34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Jacopo Mondi <jacopo@jmondi.org>
+ */
+
+#include "imx6qdl-icore.dtsi"
+
+&iomuxc {
+	pinctrl_enet: enetgrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0b0
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
+			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0
+			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b0b0
+		>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+	clocks = <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET_REF>;
+	phy-mode = "rmii";
+	status = "okay";
+};


