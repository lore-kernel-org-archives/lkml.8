Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B70FC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3B324680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgANKrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:47:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:15619 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgANKrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:47:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 02:47:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="248013848"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jan 2020 02:47:12 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, robh@kernel.org
Cc:     kishon@ti.com, devicetree@vger.kernel.org,
        cheol.yong.kim@intel.com, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1] dt-bindings: phy: Fix for intel,lgm-emmc-phy.yaml build error
Date:   Tue, 14 Jan 2020 18:47:10 +0800
Message-Id: <20200114104710.23135-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

This patch fixes the devicetree binding yaml build errors
in linux-next kernel Error: Documentation/devicetree/bindings/
phy/intel,lgm-emmc-phy.example.dts:21.19-20
syntax error FATAL ERROR: Unable to parse input tree

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Reported-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/intel,lgm-emmc-phy.yaml       | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
index ff7959c21af0..d9bd2e47dfe7 100644
--- a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
@@ -16,10 +16,7 @@ description: |+
   The eMMC PHY node should be the child of a syscon node with the
   required property:
 
-  - compatible:         Should be one of the following:
-                        "intel,lgm-syscon", "syscon"
-  - reg:
-      maxItems: 1
+  should be compatible strings are - "intel,lgm-syscon", "syscon"
 
 properties:
   compatible:
@@ -34,6 +31,12 @@ properties:
   clocks:
     maxItems: 1
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
 required:
   - "#phy-cells"
   - compatible
@@ -45,8 +48,10 @@ examples:
     sysconf: chiptop@e0200000 {
       compatible = "intel,lgm-syscon", "syscon";
       reg = <0xe0200000 0x100>;
+      #address-cells = <1>;
+      #size-cells = <1>;
 
-      emmc-phy: emmc-phy@a8 {
+      emmc_phy: emmc_phy@a8 {
         compatible = "intel,lgm-emmc-phy";
         reg = <0x00a8 0x10>;
         clocks = <&emmc>;
-- 
2.11.0

