Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63C3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7639720719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D2hSFPOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbgDAWKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:10:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51694 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733182AbgDAWKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:10:40 -0400
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2C4F1E28;
        Thu,  2 Apr 2020 00:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1585779037;
        bh=m4io9vMcfz3TaImIe8GuwtNOerRyfAuyN51YzVVrUe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2hSFPOm+IXg83+pGcJLgJHr7fi4aS3bUt78szzCn9P3XUEvvVreTPvba/InhxH9O
         NvHchb45CaRiupmq2AMKJ55clR0Gu265sd8D6BQ3W9quboq214iiCImSSFvk7si6uU
         +tQ8Og8di/lXEfWzcYpPwpT+jVMnl02RyhA2uGV4=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v7 3/3] arm64: dts: zynqmp: Add GTR transceivers
Date:   Thu,  2 Apr 2020 01:10:25 +0300
Message-Id: <20200401221025.26087-4-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200401221025.26087-1-laurent.pinchart@ideasonboard.com>
References: <20200401221025.26087-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for the PS-GTR transceivers.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 2e284eb8d3c1..5e06e4c19d94 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -13,6 +13,7 @@
  */
 
 #include <dt-bindings/power/xlnx-zynqmp-power.h>
+#include <dt-bindings/reset/xlnx-zynqmp-resets.h>
 
 / {
 	compatible = "xlnx,zynqmp";
@@ -564,6 +565,15 @@ pcie_intc: legacy-interrupt-controller {
 			};
 		};
 
+		psgtr: phy@fd400000 {
+			compatible = "xlnx,zynqmp-psgtr-v1.1";
+			status = "disabled";
+			reg = <0x0 0xfd400000 0x0 0x40000>,
+			      <0x0 0xfd3d0000 0x0 0x1000>;
+			reg-names = "serdes", "siou";
+			#phy-cells = <4>;
+		};
+
 		rtc: rtc@ffa60000 {
 			compatible = "xlnx,zynqmp-rtc";
 			status = "disabled";
-- 
Regards,

Laurent Pinchart

