Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B2AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945B920663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VliOYdrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbgGANtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbgGANtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:49:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B685CC08C5C1;
        Wed,  1 Jul 2020 06:49:01 -0700 (PDT)
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0D3A7556;
        Wed,  1 Jul 2020 15:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593611340;
        bh=S8TQ71TulTFVrL2Q9zX8NQ+PuGr/u92GnJGOwJrQiwI=;
        h=From:To:Cc:Subject:Date:From;
        b=VliOYdrXr2sKPCqJSh4YoJzsM8dwmiUS8vf/kCrxHAg3hromhADuzZVpsyniQ1Amm
         9XOcQGi0KI3Nw8nnYMH0MHJ/cFaYC4SIEnT0z3il6xRVVIRY+ewHUMqZjIgEJqFfNx
         JFTHrl6RXUWGdNIcSZIZv5yTQmQGnOx7n1i5b9DM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     devicetree@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: phy: zynqmp-psgtr: Fix example's numbers of cells in reg
Date:   Wed,  1 Jul 2020 16:48:53 +0300
Message-Id: <20200701134853.30656-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT examples are by default compiled in a parent that has
 #address-cells and #size-cells both set to 1. Fix the example
accordingly, even if it doesn't match the actual hardware, as this is
the recommended practice for DT bindings examples.

Fixes: cea0f76a483d ("dt-bindings: phy: Add DT bindings for Xilinx ZynqMP PSGTR PHY")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
index 09e3cde7ebca..04d5654efb38 100644
--- a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
+++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
@@ -94,8 +94,8 @@ examples:
   - |
     phy: phy@fd400000 {
         compatible = "xlnx,zynqmp-psgtr-v1.1";
-        reg = <0x0 0xfd400000 0x0 0x40000>,
-              <0x0 0xfd3d0000 0x0 0x1000>;
+        reg = <0xfd400000 0x40000>,
+              <0xfd3d0000 0x1000>;
         reg-names = "serdes", "siou";
         clocks = <&refclks 3>, <&refclks 2>, <&refclks 0>;
         clock-names = "ref1", "ref2", "ref3";
-- 
Regards,

Laurent Pinchart

