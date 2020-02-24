Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A69C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77F62072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="BKZdz9HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBXLvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:51:01 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:36193 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgBXLvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:51:01 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DEA2422F00;
        Mon, 24 Feb 2020 12:50:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582545059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AGoftlXtPDkl6tdoN4g4nLlzfqZ5fb+l68Uc8F12Pnk=;
        b=BKZdz9HMC+by7IJBwDLcq7etejsomdPgSJDWZUxFdRgtDW0aDmVaBErBhsFLyj3TSlE5Bb
        8a56/4veaOOn1UewHFAjIdg/LNkByuC5W8LUxW/xxd7Rcay78IUz6ipCIjKTGsqmBwhOjf
        LEYZg2/Lv0btJqKLwKgtXgths71xFCk=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028: sl28: explicitly enable network ports
Date:   Mon, 24 Feb 2020 12:50:52 +0100
Message-Id: <20200224115052.27328-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: DEA2422F00
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.776];
         DKIM_SIGNED(0.00)[];
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

Since commit b9213899d2b0 ("arm64: dts: ls1028a: disable all enetc ports
by default") all the network ports are disabled by default. This makes
sense, but now we have to enable them explicitly in the boards. Do so
for the sl28 module.

Since we are at it. Make sure the second port is only enabled for the
variant 4 of the module. Variant 3 has only one network port.

Signed-off-by: Michael Walle <michael@walle.cc>
---

This patch actually superseeds the following:
  https://lore.kernel.org/linux-devicetree/20200220180919.6069-1-michael@walle.cc/

 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
index f659e89face8..df212ed5bb94 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
@@ -21,6 +21,7 @@
 &enetc_port1 {
 	phy-handle = <&phy1>;
 	phy-connection-type = "rgmii-id";
+	status = "okay";
 
 	mdio {
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index d221ed471cde..e6ad2f64e64e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -35,6 +35,7 @@
 &enetc_port0 {
 	phy-handle = <&phy0>;
 	phy-connection-type = "sgmii";
+	status = "okay";
 
 	mdio {
 		#address-cells = <1>;
-- 
2.20.1

