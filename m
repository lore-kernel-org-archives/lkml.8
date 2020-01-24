Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7982DC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5143A20708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864031;
	bh=kdaLK7TWAv4kJn+2tqvtzU3CaNAhNXw+bMtGpViEYzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b0nINKp7rEPbgUM3dvqz5HrR8/nT6AVLylFNQrZMAIkhYyz/6JHz6C4Qb8RMWKb6p
	 JHyXghWIFGLimBhmMvU0md/l5wg/EOpEmy3BBvBkC9afhVuMfoOa0yrXMwVyzqu1iW
	 NOreP1vo4slLHomfvorAqZvsr4pbIHnJlVVzUGYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389423AbgAXLHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389083AbgAXLHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:07:07 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 172872077C;
        Fri, 24 Jan 2020 11:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864026;
        bh=kdaLK7TWAv4kJn+2tqvtzU3CaNAhNXw+bMtGpViEYzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNP6Yl8XoDl6beKXLaF4wRAPW3/z7sX7jAUB6bA+CMhm3S8X/2dA+G5NT3eq0z7yj
         x+42RDHA78OO5crLJpmgq5Jo4l1PoY51D8fCq8YkdwwxpAxqM8tIL4bCuO4w8HgqVq
         nyXlwpIBFn8bvPDTF1wLuSZb5F75Dwd8PW+BUzFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 151/639] arm64: dts: allwinner: h6: Move GIC device node fix base address ordering
Date:   Fri, 24 Jan 2020 10:25:21 +0100
Message-Id: <20200124093106.145118596@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 52d9bcb3d0de3fa1e07aff3800f857836d30410d ]

The GIC device node was placed out of order in the initial device tree
submission. Move it so the nodes are correctly sorted by base address
again.

Fixes: e54be32d0273 ("arm64: allwinner: h6: add the basical Allwinner H6 DTSI file")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index cfa5fffcf62b4..72813e7aefb8a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -101,17 +101,6 @@
 			#reset-cells = <1>;
 		};
 
-		gic: interrupt-controller@3021000 {
-			compatible = "arm,gic-400";
-			reg = <0x03021000 0x1000>,
-			      <0x03022000 0x2000>,
-			      <0x03024000 0x2000>,
-			      <0x03026000 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-		};
-
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
@@ -149,6 +138,17 @@
 			};
 		};
 
+		gic: interrupt-controller@3021000 {
+			compatible = "arm,gic-400";
+			reg = <0x03021000 0x1000>,
+			      <0x03022000 0x2000>,
+			      <0x03024000 0x2000>,
+			      <0x03026000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
 		mmc0: mmc@4020000 {
 			compatible = "allwinner,sun50i-h6-mmc",
 				     "allwinner,sun50i-a64-mmc";
-- 
2.20.1



