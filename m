Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C1AC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE2120CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="F0r6WWZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgBYR65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:58:57 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39815 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731248AbgBYR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:58:47 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E04E323059;
        Tue, 25 Feb 2020 18:58:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582653525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+cE7/ATdYUr32XspEcbhvNydKCX9kBGmSCPvglvjs8=;
        b=F0r6WWZHqU3eG2ijJgPOL1KCn8tb5abVKJywGF3x2qz1Qis9dWCMe7dcZ5uk2112cY+QOb
        Gy978UuLAvOsSSrZIkXpKoRIAj5PAACwqCTPIeZ6C50jUc1fnalLJd/Ni4UKJilMbvGRpT
        c3fFXVNMozSxYySclei5UGIYMxZyiEc=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH 3/3] arm64: dts: ls1028a: sl28: add support for variant 2
Date:   Tue, 25 Feb 2020 18:57:56 +0100
Message-Id: <20200225175756.29508-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225175756.29508-1-michael@walle.cc>
References: <20200225175756.29508-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: E04E323059
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.968];
         DKIM_SIGNED(0.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.4:email,0.0.0.5:email];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is support for the Felix switch this variant can also be
added. It features two external ports ethernet ports which are connected
to the internal switch core. No direct connection to any of the enetc's
is supported.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../fsl-ls1028a-kontron-sl28-var2.dts         | 68 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0d36c6e64574..c04bfa72d83e 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-kbox-a-230-ls.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var2.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var3-ads2.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var4.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
new file mode 100644
index 000000000000..0a34ff682027
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Device Tree file for the Kontron SMARC-sAL28 board.
+ *
+ * This is for the network variant 2 which has two ethernet ports. These
+ * ports are connected to the internal switch.
+ *
+ * Copyright (C) 2020 Michael Walle <michael@walle.cc>
+ *
+ */
+
+/dts-v1/;
+#include "fsl-ls1028a-kontron-sl28.dts"
+
+/ {
+	model = "Kontron SMARC-sAL28 (TSN-on-module)";
+	compatible = "kontron,sl28-var2", "kontron,sl28", "fsl,ls1028a";
+};
+
+&enetc_mdio_pf3 {
+	phy0: ethernet-phy@5 {
+		reg = <0x5>;
+		eee-broken-1000t;
+		eee-broken-100tx;
+	};
+
+	phy1: ethernet-phy@4 {
+		reg = <0x4>;
+		eee-broken-1000t;
+		eee-broken-100tx;
+	};
+};
+
+&enetc_port0 {
+	status = "disabled";
+	/*
+	 * In the base device tree the PHY was registered in the mdio
+	 * subnode as it is PHY for this port. On this module this PHY
+	 * is connected to a switch port instead and registered above.
+	 * Therefore, delete the mdio subnode as well as the phy-handle
+	 * property here.
+	 */
+	/delete-property/ phy-handle;
+	/delete-node/ mdio;
+};
+
+&enetc_port2 {
+	status = "okay";
+};
+
+&mscc_felix_port0 {
+	label = "gbe0";
+	phy-handle = <&phy0>;
+	phy-mode = "sgmii";
+	status = "okay";
+};
+
+&mscc_felix_port1 {
+	label = "gbe1";
+	phy-handle = <&phy1>;
+	phy-mode = "sgmii";
+	status = "okay";
+};
+
+&mscc_felix_port4 {
+	ethernet = <&enetc_port2>;
+	status = "okay";
+};
-- 
2.20.1

