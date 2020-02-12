Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D38CC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A8D2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581518517;
	bh=wEVnPEVadN4OH26RQpKYiCbNPRhH3AiT5vcHEXJsjMs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QvjC2j/dqGAKJ0zpJmeY4TfbIrqgD64M7fw4AWyas55LgznfA9bsmc0zvhm1cFlYA
	 oNqamrgRGH+Ok+JpZXwhIaV6m3ZKuLtrxubUj/Ud7HXhElAICCd/eb95KY8bXDabPA
	 GLGAlBRwNCURoaovupn8/ye6WtzgjmGzajy7vmkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBLOl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:41:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgBLOl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:41:56 -0500
Received: from localhost.localdomain (unknown [213.195.124.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3101B20661;
        Wed, 12 Feb 2020 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581518515;
        bh=wEVnPEVadN4OH26RQpKYiCbNPRhH3AiT5vcHEXJsjMs=;
        h=From:To:Cc:Subject:Date:From;
        b=nottaYilZg9Z91uAkWMe2KVCa1QXM0EQaD0qoO53IYtKop0a3W52t+3Idv3zBo0/D
         PD1YqBppqcgdlpOOdADzxM0Vy6ls+xB6uUqK2mmPLqdE2p66GgJik71QAyjxqoquhq
         fk06ImDaAdSDGd7GL1FM0xsCZh/8lfn+QbS+h+xU=
From:   matthias.bgg@kernel.org
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 1/2] ARM: dts: mediatek: rename scpsys nodes to power-controller
Date:   Wed, 12 Feb 2020 15:41:44 +0100
Message-Id: <20200212144145.25407-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The nodes with name scpsys actually implement a power-controller.
Rename the nodes to match the bindings description.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 arch/arm/boot/dts/mt2701.dtsi | 2 +-
 arch/arm/boot/dts/mt7623.dtsi | 2 +-
 arch/arm/boot/dts/mt7629.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 51e1305c6471..2093b38d6e6d 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -148,7 +148,7 @@ syscfg_pctl_a: syscfg@10005000 {
 		reg = <0 0x10005000 0 0x1000>;
 	};
 
-	scpsys: scpsys@10006000 {
+	scpsys: power-controller@10006000 {
 		compatible = "mediatek,mt2701-scpsys", "syscon";
 		#power-domain-cells = <1>;
 		reg = <0 0x10006000 0 0x1000>;
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index a79f0b6c3429..f76b4a3c34b9 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -268,7 +268,7 @@ syscfg_pctl_a: syscfg@10005000 {
 		reg = <0 0x10005000 0 0x1000>;
 	};
 
-	scpsys: scpsys@10006000 {
+	scpsys: power-controller@10006000 {
 		compatible = "mediatek,mt7623-scpsys",
 			     "mediatek,mt2701-scpsys",
 			     "syscon";
diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
index 867b88103b9d..60787632e4a1 100644
--- a/arch/arm/boot/dts/mt7629.dtsi
+++ b/arch/arm/boot/dts/mt7629.dtsi
@@ -90,7 +90,7 @@ pericfg: syscon@10002000 {
 			#clock-cells = <1>;
 		};
 
-		scpsys: scpsys@10006000 {
+		scpsys: power-controller@10006000 {
 			compatible = "mediatek,mt7629-scpsys",
 				     "mediatek,mt7622-scpsys";
 			#power-domain-cells = <1>;
-- 
2.24.1

