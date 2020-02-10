Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D2CC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D6A2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=deutnet.info header.i=@deutnet.info header.b="m3W/Raeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBJKgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:36:00 -0500
Received: from srv1.deutnet.info ([116.203.153.70]:47876 "EHLO
        srv1.deutnet.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBJKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=Message-Id:Date:Subject:Cc:To:From:in-reply-to;
         bh=bOY7jX8rG3pOG3yt5V1uKucUSrez7E/Av/IrONtwCDw=; b=m3W/RaebmnVwNjub8MBHn6jGR
        q00HfsVBeExPPMIzYMwW8oKYxtd9Gva4liWAVPEN95HWUYQ3uLEXBqi8fazQyMbXJUwfe9SpijC4U
        ZHQqMPq2y5mac7dOck4VlLeWnjsGZengUuok5AugikBKAWKQ/Y+KwhKWKXQrjOM5/EOkvAsD2gkWJ
        RJnEKBAaAY6xdhUTSLGTGjDUtGkvJhhGkZ+Ws4HpynhS4qnsowW6+fj0eqWZaph9yoE9mZ0Is4A4m
        bGwa6Y/zAy5Z5Dy3GFtFa6icD+Ps5Yra8EjpJBz57cMPNwXxceP/QDAoJXjOgOIOrATzS5UslbRfc
        hPvHbAdyw==;
Received: from [2001:bc8:3dc9::1] (helo=srv100.deutnet.info)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1j16Pz-0007nh-AO; Mon, 10 Feb 2020 11:35:55 +0100
Received: from agriveaux by srv100.deutnet.info with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1j16Py-00DTBT-VR; Mon, 10 Feb 2020 11:35:55 +0100
From:   agriveaux@deutnet.info
To:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        wens@csie.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        agriveaux@deutnet.info
Subject: [PATCH] ARM: dts: sun5i: Add dts for inet86v_rev2
Date:   Mon, 10 Feb 2020 11:35:52 +0100
Message-Id: <20200210103552.3210406-1-agriveaux@deutnet.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre GRIVEAUX <agriveaux@deutnet.info>

Add Inet 86V Rev 2 support, based upon Inet 86VS.

Missing things:
- Accelerometer (MXC6225X)
- Touchpanel (Sitronix SL1536)
- Nand (29F32G08CBACA)
- Camera (HCWY0308)

Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
---
 .../devicetree/bindings/arm/sunxi.yaml          |  5 +++++
 arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts   | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 327ce6730823..af0db1fe69c9 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -282,6 +282,11 @@ properties:
           - const: primux,inet86dz
           - const: allwinner,sun8i-a23
 
+      - description: iNet-86V Rev 02
+        items:
+          - const: primux,inet86v-rev2
+          - const: allwinner,sun5i-a13
+
       - description: iNet-9F Rev 03
         items:
           - const: inet-tek,inet9f-rev03
diff --git a/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
new file mode 100644
index 000000000000..9b4c5349f048
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 Alexandre Griveaux <agriveaux@deutnet.info>
+ *
+ * Minimal dts file for the iNet 86V
+ */
+
+/dts-v1/;
+
+#include "sun5i-a13.dtsi"
+#include "sun5i-reference-design-tablet.dtsi"
+
+/ {
+	model = "iNET 86V Rev 02";
+	compatible = "primux,inet86v-rev2", "allwinner,sun5i-a13";
+
+};
-- 
2.20.1

