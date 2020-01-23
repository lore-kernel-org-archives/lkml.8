Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AB6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AF72253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgAWKPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:15:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:33492 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgAWKPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:15:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 02:15:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,353,1574150400"; 
   d="scan'208";a="245346845"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 23 Jan 2020 02:15:01 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     robh@kernel.org, linux-kernel@vger.kernel.org
Cc:     cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [RESEND-PATCH v1] dt-bindings: phy: Fix for intel,lgm-emmc-phy.yaml build error
Date:   Thu, 23 Jan 2020 18:14:59 +0800
Message-Id: <20200123101459.32356-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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
 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
index ff7959c21af0..e9d3593526f6 100644
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
@@ -45,12 +42,13 @@ examples:
     sysconf: chiptop@e0200000 {
       compatible = "intel,lgm-syscon", "syscon";
       reg = <0xe0200000 0x100>;
+      #address-cells = <1>;
+      #size-cells = <1>;
 
-      emmc-phy: emmc-phy@a8 {
+      emmcphy: emmcphy@a8 {
         compatible = "intel,lgm-emmc-phy";
         reg = <0x00a8 0x10>;
         clocks = <&emmc>;
         #phy-cells = <0>;
       };
     };
-...
-- 
2.11.0

