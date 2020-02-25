Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156CEC35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57E52176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="GZzzv5Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgBYR6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:58:48 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:36989 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730762AbgBYR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:58:46 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5370023058;
        Tue, 25 Feb 2020 18:58:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582653524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8/7NKL09SHsuEl1uHYny7QPYQ0m0GW+NScMr4x+hvo=;
        b=GZzzv5FmuD9LdgdjEmlpFHDuYp1yHFY1UUoWjJBmrFmBFt5FY0GUIGs0N+7chI7eEPhde7
        Gt5lgQYO24fCT8guHYBuEr8g6iCEPqlAVTO4OBmiquGB6ZrdgStKk7H46fsrb8JOWC92Vo
        F5QPZwcg96lTCHc+qRbz9JhXF8heQAQ=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH 2/3] arm64: dts: ls1028a: sl28: expose switch ports in KBox A-230-LS
Date:   Tue, 25 Feb 2020 18:57:55 +0100
Message-Id: <20200225175756.29508-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225175756.29508-1-michael@walle.cc>
References: <20200225175756.29508-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 5370023058
X-Spamd-Result: default: False [6.40 / 15.00];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         NEURAL_SPAM(0.00)[0.961];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.57:email,0.0.0.10:email,0.0.0.9:email,0.0.0.8:email,0.0.0.7:email];
         MID_CONTAINS_FROM(1.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KBox A-230-LS supports four external ports which are connected to
the internal switch of the LS1028A via QSGMII. Now that the Felix switch
is supported, add these ports in the device tree.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
index 32f6c80414bc..4e30558485b0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
@@ -18,6 +18,29 @@
 		     "kontron,sl28", "fsl,ls1028a";
 };
 
+&enetc_mdio_pf3 {
+	/* BCM54140 QSGMII quad PHY */
+	qsgmii_phy0: ethernet-phy@7 {
+		reg = <7>;
+	};
+
+	qsgmii_phy1: ethernet-phy@8 {
+		reg = <8>;
+	};
+
+	qsgmii_phy2: ethernet-phy@9 {
+		reg = <9>;
+	};
+
+	qsgmii_phy3: ethernet-phy@10 {
+		reg = <10>;
+	};
+};
+
+&enetc_port2 {
+	status = "okay";
+};
+
 &i2c3 {
 	eeprom@57 {
 		compatible = "atmel,24c32";
@@ -25,3 +48,40 @@
 		pagesize = <32>;
 	};
 };
+
+&mscc_felix_port0 {
+	label = "swp0";
+	managed = "in-band-status";
+	phy-handle = <&qsgmii_phy0>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&mscc_felix_port1 {
+	label = "swp1";
+	managed = "in-band-status";
+	phy-handle = <&qsgmii_phy1>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&mscc_felix_port2 {
+	label = "swp2";
+	managed = "in-band-status";
+	phy-handle = <&qsgmii_phy2>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&mscc_felix_port3 {
+	label = "swp3";
+	managed = "in-band-status";
+	phy-handle = <&qsgmii_phy3>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&mscc_felix_port4 {
+	ethernet = <&enetc_port2>;
+	status = "okay";
+};
-- 
2.20.1

