Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A8FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BFF2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgDXKno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:43:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:18143 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgDXKnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:43:41 -0400
IronPort-SDR: 5fqVPSMhYsw1Lj/69+ezKqRIrNvytikxsKZzhCCHhNyqMknjRbkalLL5G3LINyYYTrJZHbCd/e
 Q/efRI7L2F9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 03:43:40 -0700
IronPort-SDR: 44ljB5D2GbRr2TC8bkgbVFcVdOgeAdsA4mySKntYe1NImqKNBMzmIgJHN6c0rWlu9eRa6dxzz9
 MONxo8ARDrHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="430726378"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 24 Apr 2020 03:43:37 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 3/4] dt-bindings: spi: Add support to Lightning Mountain SoC
Date:   Fri, 24 Apr 2020 18:42:32 +0800
Message-Id: <1f447a5ab8fee5bc9116ba70b0344193c9c6cc06.1587702428.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1587702428.git.eswara.kota@linux.intel.com>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1587702428.git.eswara.kota@linux.intel.com>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to SPI controller on Intel Atom based Lightning Mountain
SoC which reuses the Lantiq SPI controller IP.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 .../devicetree/bindings/spi/spi-lantiq-ssc.txt      | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt b/Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt
index ce3230c8e28d..76a3dd35f796 100644
--- a/Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt
+++ b/Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt
@@ -1,11 +1,17 @@
 Lantiq Synchronous Serial Controller (SSC) SPI master driver
 
 Required properties:
-- compatible: "lantiq,ase-spi", "lantiq,falcon-spi", "lantiq,xrx100-spi"
+- compatible: "lantiq,ase-spi", "lantiq,falcon-spi", "lantiq,xrx100-spi",
+  "intel,lgm-spi"
 - #address-cells: see spi-bus.txt
 - #size-cells: see spi-bus.txt
 - reg: address and length of the spi master registers
-- interrupts: should contain the "spi_rx", "spi_tx" and "spi_err" interrupt.
+- interrupts:
+  For compatible "intel,lgm-ssc" - the common interrupt number for
+  all of tx rx & err interrupts.
+       or
+  For rest of the compatibles, should contain the "spi_rx", "spi_tx" and
+  "spi_err" interrupt.
 
 
 Optional properties:
@@ -27,3 +33,14 @@ spi: spi@e100800 {
 	num-cs = <6>;
 	base-cs = <1>;
 };
+
+ssc0: spi@e0800000 {
+	compatible = "intel,lgm-spi";
+	reg = <0xe0800000 0x400>;
+	interrupt-parent = <&ioapic1>;
+	interrupts = <35 1>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&cgu0 LGM_CLK_NGI>, <&cgu0 LGM_GCLK_SSC0>;
+	clock-names = "freq", "gate";
+};
-- 
2.11.0

