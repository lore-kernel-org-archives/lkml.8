Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BC1C2D0E1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75B521D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599762843;
	bh=/lCqompaU4J7OaqiXkk9Bzxz+r9grKwZNR9v6cvgsyw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UAR5Um5xN09Fa6lz/95p76tcpmqLL+5TZvdJpFNaiFSVDUukrkRuATcb7S/8mLJv7
	 KxGjC2R0CkZlgfJiY1lHJWtQb31SAl1cnm0uReEOHtJ9iLYdDPkzXUywLaptqAtoBf
	 gTLTTHlhe5N7UW9RxyV4JEdWDjiezpjDWIvURNc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgIJSdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgIJSXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:23:24 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F3D21D79;
        Thu, 10 Sep 2020 18:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599762175;
        bh=/lCqompaU4J7OaqiXkk9Bzxz+r9grKwZNR9v6cvgsyw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AKXO5lYZFQ3OaPM1xxM98DhEuqohj3wAhu7BH++n/ylW5Q67e2feOTKisKYuJLShv
         r3mquNIAoCvEHbTd0gmYReYUcxgyX1GMQ1uX8FwdrfWezo6tQlS3t0wy79IoIEWNhA
         moTQxMBlsidNS+fcICPMvvxiJ3rsNxvtlqGQh8k4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wolfram@the-dreams.de>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: i2c: imx-lpi2c: Fix i.MX 8QXP compatible matching
Date:   Thu, 10 Sep 2020 20:22:42 +0200
Message-Id: <20200910182244.5815-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910182244.5815-1-krzk@kernel.org>
References: <20200910182244.5815-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX 8QXP DTSes use two compatibles so update the binding to fix
dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: i2c@5a820000:
    compatible: ['fsl,imx8qxp-lpi2c', 'fsl,imx7ulp-lpi2c'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/i2c/i2c-imx-lpi2c.yaml        | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
index 918535b33384..8b088a34a8e6 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
@@ -14,10 +14,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx7ulp-lpi2c
-      - fsl,imx8qxp-lpi2c
-      - fsl,imx8qm-lpi2c
+    oneOf:
+      - enum:
+          - fsl,imx7ulp-lpi2c
+          - fsl,imx8qm-lpi2c
+      - items:
+          - const: fsl,imx8qxp-lpi2c
+          - const: fsl,imx7ulp-lpi2c
 
   '#address-cells': true
   '#size-cells': true
-- 
2.17.1

