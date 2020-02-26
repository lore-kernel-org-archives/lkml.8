Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A79C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9B721927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="u3e8N9Wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgBZEAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:00:17 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:18549 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBZEAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:00:17 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 01Q3xIwx016581;
        Wed, 26 Feb 2020 12:59:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 01Q3xIwx016581
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582689558;
        bh=XDrBIXByfZ2yAmtZPGX/C8p4s5ZOw7AEPyyzLDKdN2A=;
        h=From:To:Cc:Subject:Date:From;
        b=u3e8N9Wii46h8XMIwcPQOR1pfajS6bTdVu5PoDLvzg84URiIenjUiy+I7fGvBb2FJ
         bi/Mg+Ry9pNIRD7AwVWYqpkFhHt7wRer8RayCdZL2c4Xwkbc1+b4LAOzikYvh5YPQc
         uJ+/WBeZsq1bdEK97F92wYEVkfZ57y0pxPFomSqRdnJeSlgq3+DZpWMcdQlB9m9B8/
         fNcwZHdhAYccn4yA4cK2nb1CF1C96nmr8yzQeXIWSgQfmKjseZGIoDFLLMlmhgOdeh
         Js3L2JXwWhPIeS/zJdO01aRzzFwo3/aO6wimrP6X02dF5rHnU5VhRzcg/UnXDeXAyh
         uTagRccc8RuAQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: uniphier: rename NAND node names to follow json-schema
Date:   Wed, 26 Feb 2020 12:59:13 +0900
Message-Id: <20200226035914.23582-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the standard nodename pattern "^nand-controller(@.*)?" defined
in Documentation/devicetree/bindings/mtd/nand-controller.yaml

Otherwise, after the dt-binding is converted to json-schema,
'make ARCH=arm dtbs_check' will show a warning like this:

  nand@68000000: $nodename:0: 'nand@68000000' does not match '^nand-controller(@.*)?'

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 2 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi | 2 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi | 2 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 2 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 23b8fd627c00..197bee7d8b7f 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -398,7 +398,7 @@
 			};
 		};
 
-		nand: nand@68000000 {
+		nand: nand-controller@68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5a";
 			status = "disabled";
 			reg-names = "nand_data", "denali_reg";
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index eb06c353970f..b02bc8a6346b 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -588,7 +588,7 @@
 			};
 		};
 
-		nand: nand@68000000 {
+		nand: nand-controller@68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5a";
 			status = "disabled";
 			reg-names = "nand_data", "denali_reg";
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index c95eb44c816d..f84a43a10f38 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -453,7 +453,7 @@
 			};
 		};
 
-		nand: nand@68000000 {
+		nand: nand-controller@68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
 			reg-names = "nand_data", "denali_reg";
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index c054d0175df9..989b2a241822 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -761,7 +761,7 @@
 			};
 		};
 
-		nand: nand@68000000 {
+		nand: nand-controller@68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
 			reg-names = "nand_data", "denali_reg";
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index a05061038e78..fbfd25050a04 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -402,7 +402,7 @@
 			};
 		};
 
-		nand: nand@68000000 {
+		nand: nand-controller@68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5a";
 			status = "disabled";
 			reg-names = "nand_data", "denali_reg";
-- 
2.17.1

