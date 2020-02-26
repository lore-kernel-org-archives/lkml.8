Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AAFC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC5921927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="L60+bemg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgBZEAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:00:19 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:18619 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgBZEAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:00:18 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 01Q3xIx0016581;
        Wed, 26 Feb 2020 12:59:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 01Q3xIx0016581
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582689559;
        bh=DxG0zADp8KolfWngeax0Hh9tmHwKWNQ5hpD9lSOxcV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L60+bemgBLH64lI+ORU8zKNbWZm7G9LYBG2MlvGo2QxmclJF9wkzpVW0u+jhJUXzm
         l/qaENwHhD/NWc9IfAwbmZe8n09OtEKSUF+TuhXxDYsWkuOIyh6qtbIDlAx1IJb9rL
         11ltu0+9WEbyS30B7zQQmv2yGetw4zomRL9J6fUg7iEmy9sC5WdToSUh++h7BbdXV1
         RtI1L8oX0v/yRxl2J/tlrIS+f2v2Gz5W4+aBrjhHn9ttnrzQO5z1/cJ/sOiuOuYsSv
         OLP9nlR2iLhP5wEk7z9NaEEddhTEjXoTv3Iz8ZS9Dikvft8rppHonUScOCFTcbJzfd
         6+p4+dmF/5xdw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: uniphier: rename NAND node names to follow json-schema
Date:   Wed, 26 Feb 2020 12:59:14 +0900
Message-Id: <20200226035914.23582-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226035914.23582-1-yamada.masahiro@socionext.com>
References: <20200226035914.23582-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the standard nodename pattern "^nand-controller(@.*)?" defined
in Documentation/devicetree/bindings/mtd/nand-controller.yaml

Otherwise, after the dt-binding is converted to json-schema,
'make ARCH=arm64 dtbs_check' will show a warning like this:

  nand@68000000: $nodename:0: 'nand@68000000' does not match '^nand-controller(@.*)?'

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 2e53daca9f5c..d61da3a62712 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -621,7 +621,7 @@
 			};
 		};
 
-		nand: nand@68000000 {
+		nand: nand-controller@68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
 			reg-names = "nand_data", "denali_reg";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index be984200a70e..98f0f4eb0649 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -925,7 +925,7 @@
 			socionext,syscon = <&soc_glue>;
 		};
 
-		nand: nand@68000000 {
+		nand: nand-controller@68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
 			reg-names = "nand_data", "denali_reg";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 994fea7b12c1..4c6cd3ec541d 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -783,7 +783,7 @@
 			socionext,syscon = <&soc_glue>;
 		};
 
-		nand: nand@68000000 {
+		nand: nand-controller@68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
 			reg-names = "nand_data", "denali_reg";
-- 
2.17.1

