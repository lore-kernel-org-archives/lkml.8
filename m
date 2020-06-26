Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016C3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99462082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593158763;
	bh=gmkim/r0nxh4WfZmg5wugI0xjsg1UmiR9dvIH/UOImU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WZaTbz/F75uUWLewITSfe9CETlDds3S6I1TqcoiXl6HbLd+wxD4sCn0tEGtP7/tK6
	 89bryvnrSZqo8ACPAiZGkz21GCWQ2MZigDojz0+lXQawyXFm5xp3y3F+loMzCQc8py
	 9QWHqFPDBbBBMK3VEZj6mqeXATFpPtWxrLYk85Yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgFZIGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729174AbgFZIF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:05:56 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A83E2082E;
        Fri, 26 Jun 2020 08:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158756;
        bh=gmkim/r0nxh4WfZmg5wugI0xjsg1UmiR9dvIH/UOImU=;
        h=From:To:Cc:Subject:Date:From;
        b=ytbmvAwBpwC7IDmgiTxkutp4QIl0DH5YUlHkFvjkpd8WtYGVNTs/vnSYOtvaX3DpD
         d+ODcLAvwbVqiF04gG+hPACWkp4w4k7LbxNe+RyBLVJUBfDTOemAhFBLdUeD8dOcjk
         vQKfiCiZ5oUCRed8jPYL0JBaPt1Yw2sCY1UVwGzM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: ste: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:05:52 +0200
Message-Id: <20200626080552.3627-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache: $nodename:0: 'l2-cache' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi          | 2 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 3e10da3f8fd3..05fd544b06c1 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -260,7 +260,7 @@
 			reg = <0x80150000 0x2000>;
 		};
 
-		L2: l2-cache {
+		L2: cache-controller {
 			compatible = "arm,pl310-cache";
 			reg = <0xa0412000 0x1000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index f78b4eabd68c..4f38aeecadb3 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -15,7 +15,7 @@
 		    <0x08000000 0x04000000>;
 	};
 
-	L2: l2-cache {
+	L2: cache-controller {
 		compatible = "arm,l210-cache";
 		reg = <0x10210000 0x1000>;
 		interrupt-parent = <&vica>;
-- 
2.17.1

