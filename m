Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB0FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C20206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QLB6sM1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgG2HL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:11:56 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:34388 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgG2HLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:11:55 -0400
IronPort-SDR: AVp3gaivzzzzl2JHFvg8ICLn9xv8HviYjE1d4/OLWCTusIckjgdbEiZdgJTXmLVarPs9+kJi3X
 rUxVKD+RNkUpnwL8XBBssFIHfHfzKHsINLyRKwZyxUTAhClLpgkCTTqQVlJb2OvyZXVOzJQS0i
 MH6EbzW17tRyycm9pa3Bw7AcVzfqqnkyJw5W7on2741sSGV9Su531eP38iAZP20Q3MH/tkU13i
 3UBo+7qu4ykDygEc6r9SnQaZ6bli15++PRohPfH5f9gwB7k7NiRaH6MaOQsEot7pnvtcWp2VKs
 lAA=
X-IronPort-AV: E=Sophos;i="5.75,409,1589234400"; 
   d="scan'208";a="13271844"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 29 Jul 2020 09:11:52 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 29 Jul 2020 09:11:52 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 29 Jul 2020 09:11:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1596006712; x=1627542712;
  h=from:to:cc:subject:date:message-id;
  bh=BtYxpj2+8/qA423N/Jz69WmLdztTm35BUZOAUw+E2bM=;
  b=QLB6sM1FFRE/GMv56mLA2yFiw0bCTFHl1Jtnb90xxOT7izVHKi8eXtXy
   vOxzT0XL2KeRu1beTdmjS2BnNIysqGJvzIjGzwi/Ht7T+0RfnZkF2Rn7/
   y6tnvwFshMMEku/cNLxgyR+5QVRXAnHPZyNp166613I9UlUqAVztA7sym
   MsewMvr8sodMLayKGG+57t68VsO5uK+3I4ndr7GPEiOIJgwPirDSaqGa5
   YIAWo7xgWYSjY5oMbxOSlyHtWVe9SoCxdgY1FBqBVyEq6NqTuHcnabzdt
   QInHMkXT2CCWfgBAKbRvNMe78fnDyXntCiAxy7lo6AowS8JQGuhl742lh
   Q==;
IronPort-SDR: YY1tpxhdG/WNuJ5RVRCdSkuf7PLRIHm/FwaOvQWzmPwa7/7eaF5O/Xcc+Nnb6AL88F0kWSuU92
 ekT94rUfYgCIulauM2dnkQhoxK6UnkkiCe8WiYROnT8ZDoUlxp7pB8yKs7eOJXlYjmi7jtg8jy
 Y49srou4ypvu3ypNJ9r92/S1s9Iq4JfK0saZTmieMg2YX396n8clkoOnYdUHJqH5TvBfI9qjFl
 MJOz3XjNmTIqFf81B0O+YsAAJhQqh3P4dJtTWgF7DxahvbMcEq4WM4bLcoQAR1yem6yoKLiKWv
 4dM=
X-IronPort-AV: E=Sophos;i="5.75,409,1589234400"; 
   d="scan'208";a="13271843"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Jul 2020 09:11:52 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 883E3280065;
        Wed, 29 Jul 2020 09:11:52 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2] arm: dts: imx7: add QSPI
Date:   Wed, 29 Jul 2020 09:11:06 +0200
Message-Id: <20200729071106.8213-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for an update of the TQ-Systems TQMa7x/MBa7x DTS, add the
QSPI controller to imx7s.dtsi.

Based-on-patch-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2:
- renamed node and label
- reordered properties
(as suggested by Marco Felsch)


 arch/arm/boot/dts/imx7s.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1cfaf410aa43..22e4c38223bd 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1162,6 +1162,19 @@
 				status = "disabled";
 			};
 
+			qspi: qspi@30bb0000 {
+				compatible = "fsl,imx7d-qspi";
+				reg = <0x30bb0000 0x10000>, <0x60000000 0x10000000>;
+				reg-names = "QuadSPI", "QuadSPI-memory";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_QSPI_ROOT_CLK>,
+					<&clks IMX7D_QSPI_ROOT_CLK>;
+				clock-names = "qspi_en", "qspi";
+				status = "disabled";
+			};
+
 			sdma: sdma@30bd0000 {
 				compatible = "fsl,imx7d-sdma", "fsl,imx35-sdma";
 				reg = <0x30bd0000 0x10000>;
-- 
2.17.1

