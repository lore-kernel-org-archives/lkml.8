Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5ABC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430F6214DB
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GzV7Wrcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgBVGpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 01:45:34 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:58913 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBVGpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 01:45:32 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 01M6ik5Q005982;
        Sat, 22 Feb 2020 15:44:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 01M6ik5Q005982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582353888;
        bh=XNADDpgXs/F1tHD7+GUzG3MoPh7/+PucFfzMncSuySI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzV7Wrcvqbq348pmivGRJEKMuTHuMo8cZbl/BH7zPvJVHHDYZ2KzlxmspN+NnmMYu
         e6MepJJplhg0eRguJQHWc/lDfXqCx1ixrM87T+D0s5xZwQqq3q/U3sZCHFq+qu4+nQ
         udVFeboUTgAtgk6geSY4L2O4svHcRZg8YDW8IWRBH3Yk2GZaZeFU+5pfGUPUpcOHvD
         O8lMAhLmAdrGZk4Fsr9mu6CwSl2TLg2bViMabpqKuYABHWZDaYcOKSjoburugY/sri
         HXEJSski+KECEoPebMMSsynS0zN691JHGdw5k7Qj4WFpny2ZbN9EwMeXKXlciZeBto
         m2Xn5TCtZMrWQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/4] arm64: dts: uniphier: change SD/eMMC node names to follow json-schema
Date:   Sat, 22 Feb 2020 15:44:43 +0900
Message-Id: <20200222064445.14903-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222064445.14903-1-yamada.masahiro@socionext.com>
References: <20200222064445.14903-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the standard nodename pattern "^mmc(@.*)?$" defined in
Documentation/devicetree/bindings/mmc/mmc-controller.yaml

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 4 ++--
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 5b18bda9c5a6..7510db465f33 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -433,7 +433,7 @@
 			};
 		};
 
-		emmc: sdhc@5a000000 {
+		emmc: mmc@5a000000 {
 			compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
 			reg = <0x5a000000 0x400>;
 			interrupts = <0 78 4>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index f2dc5f695020..8d360c5cc32b 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -559,7 +559,7 @@
 			};
 		};
 
-		emmc: sdhc@5a000000 {
+		emmc: mmc@5a000000 {
 			compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
 			reg = <0x5a000000 0x400>;
 			interrupts = <0 78 4>;
@@ -578,7 +578,7 @@
 			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
 		};
 
-		sd: sdhc@5a400000 {
+		sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v3.1.1";
 			status = "disabled";
 			reg = <0x5a400000 0x800>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 73e7e1203b09..d51b0735917c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -353,7 +353,7 @@
 			};
 		};
 
-		emmc: sdhc@5a000000 {
+		emmc: mmc@5a000000 {
 			compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
 			reg = <0x5a000000 0x400>;
 			interrupts = <0 78 4>;
@@ -372,7 +372,7 @@
 			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
 		};
 
-		sd: sdhc@5a400000 {
+		sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v3.1.1";
 			status = "disabled";
 			reg = <0x5a400000 0x800>;
-- 
2.17.1

