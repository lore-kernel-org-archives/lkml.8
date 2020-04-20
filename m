Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2EBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF4821744
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="NwqsVU23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDTKbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:31:19 -0400
Received: from vps.xff.cz ([195.181.215.36]:53412 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTKbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1587378677; bh=/yBEOQg36NmTB26lwG9esRHwBVVu8AY1wtn2VnP7cZU=;
        h=From:To:Cc:Subject:Date:From;
        b=NwqsVU23pOZdrdNtM/TxIjsLxRszSZsNu4I7tPd1CyESi2GXRZ7Vm6ZPODjjvUgB7
         RRbLUbxzbXyQ393pRruYQbWBecGl/oapIgYDj1OIGfMZUIanelMIPI69Ze1dSYNncU
         EGnTh2JZncF1SA7sTFOkc/O6pB215RLpFG6ow1dw=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: allwinner: sun50i-a64: Add missing address/size-cells
Date:   Mon, 20 Apr 2020 12:31:13 +0200
Message-Id: <20200420103113.577969-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding specifies #address-cells and #size-cells should be present.
Without them present, dtc issues a warning because default for
#address-cells seems to be <2>:

arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1108.4-52:
  Warning (dma_ranges_format):
    /soc/dram-controller@1c62000:dma-ranges:
    "dma-ranges" property has invalid length (12 bytes)
    (parent #address-cells == 1, child #address-cells == 2,
    #size-cells == 1)

mbus #address-cells should be 1.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index cca4261089aa..61698094f450 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1105,6 +1105,8 @@ mbus: dram-controller@1c62000 {
 			compatible = "allwinner,sun50i-a64-mbus";
 			reg = <0x01c62000 0x1000>;
 			clocks = <&ccu 112>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 			dma-ranges = <0x00000000 0x40000000 0xc0000000>;
 			#interconnect-cells = <1>;
 		};
-- 
2.26.1

