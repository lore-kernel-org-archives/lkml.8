Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5DFC11D19
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1A42467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="raWdskTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgBTSJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:09:31 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:34671 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTSJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:09:30 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A042923D22;
        Thu, 20 Feb 2020 19:09:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582222167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M5O4L6RYqwsM70JomsUOhIa1qsHhuU7pmOJScmXHPuQ=;
        b=raWdskTuM3RHUqUu/w2KxcIHPQ+RpcwNdFE2KC63j47oDpNdNdkWIGr7vD+xZJEJw5OvnH
        EY0D0CehI22d7D6Y8XOO4AMIdxa3UqOFr1cLGPrhxX8T8XnfXYTk8miPUsN8fiK5FXCgKb
        ogED/A490j9jshqXl3haK8Hv563BrCs=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: freescale: sl28: disable unused network port
Date:   Thu, 20 Feb 2020 19:09:19 +0100
Message-Id: <20200220180919.6069-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: A042923D22
X-Spamd-Result: default: False [4.90 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM(0.00)[0.404];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default (and on variant 3) the second network port is not available.
Disable it. Now that its disabled, we have to explicitly enable it again
for board variant 4.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts     | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts   | 5 +++++
 2 files changed, 6 insertions(+)

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
index d221ed471cde..6b3e710f6a2b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -35,6 +35,7 @@
 &enetc_port0 {
 	phy-handle = <&phy0>;
 	phy-connection-type = "sgmii";
+	status = "okay";
 
 	mdio {
 		#address-cells = <1>;
@@ -48,6 +49,10 @@
 	};
 };
 
+&enetc_port1 {
+	status = "disabled";
+};
+
 &esdhc {
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
-- 
2.20.1

