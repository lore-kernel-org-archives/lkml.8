Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD68C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6C420663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Pr9L49ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389780AbgF2UrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbgF2TNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697CEC0D941C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:01:05 -0700 (PDT)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4260C11FB;
        Mon, 29 Jun 2020 14:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593432063;
        bh=HfffLeIgzU0qJiONJ/2Mxb+8Ga1wUFsZEZw7+O8ivA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pr9L49tabM89y4Tjk3VmuOobocjgGrpAkmUL0k0BVTSCUOjAkPcK64RbL6jxKpIBJ
         boBg+Wz6n52KFTr1Py7lYS7SO4y9W3t+Lsv2F0/jKMNiZX6RELl9ekKxpkL7JpANxv
         VNa3X4Z/WeLchAhgWtNpjuAojQhtJBMqXOLvURso=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v9 3/3] arm64: dts: zynqmp: Add GTR transceivers
Date:   Mon, 29 Jun 2020 15:00:54 +0300
Message-Id: <20200629120054.29338-4-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629120054.29338-1-laurent.pinchart@ideasonboard.com>
References: <20200629120054.29338-1-laurent.pinchart@ideasonboard.com>
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
index 9174ddc76bdc..a0aad47b0ffc 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -13,6 +13,7 @@
  */
 
 #include <dt-bindings/power/xlnx-zynqmp-power.h>
+#include <dt-bindings/reset/xlnx-zynqmp-resets.h>
 
 / {
 	compatible = "xlnx,zynqmp";
@@ -558,6 +559,15 @@ pcie_intc: legacy-interrupt-controller {
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

