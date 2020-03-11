Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC734C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D82B20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="ofXpGRZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgCKHtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:49:41 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:50611 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgCKHth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:49:37 -0400
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5582723E7D;
        Wed, 11 Mar 2020 08:49:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583912975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8/7NKL09SHsuEl1uHYny7QPYQ0m0GW+NScMr4x+hvo=;
        b=ofXpGRZNLYW/b9NlkEARihxw62NCrPsE+3vsCCNUv7ujBGcmvbfnxWUW3yJgU5uHUnPegG
        RfaSCZfrGGUWQqmcv28BJlYF+kKqxyt2A84JOHs3D3OJUP5TghH9DYf6+0t8xM2UiIgoAr
        IoKucXLCmhhY2yPvD5bFFtlIVKrjrM0=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 3/4] arm64: dts: ls1028a: sl28: expose switch ports in KBox A-230-LS
Date:   Wed, 11 Mar 2020 08:49:28 +0100
Message-Id: <20200311074929.19569-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311074929.19569-1-michael@walle.cc>
References: <20200311074929.19569-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 5582723E7D
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.809];
         DKIM_SIGNED(0.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.57:email,0.0.0.8:email,0.0.0.10:email,0.0.0.7:email,0.0.0.9:email];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE];
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

