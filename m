Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D050BC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67FE2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LTJLxviy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBVGp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 01:45:29 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:58837 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgBVGp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 01:45:29 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 01M6ik5S005982;
        Sat, 22 Feb 2020 15:44:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 01M6ik5S005982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582353889;
        bh=QqGyHAeO/ubqw+w/CGTT6IeJ8TCbUiUiGrqEMAfnxi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTJLxviy0//6PBFHicl9ayUMniCHU2eba/TlzDSH/zXskm74nbSi1qOoY6VLNBwC5
         PFSgmku0BNeEYOan3HeY85X6gzU5RDQB+r8yI9WhgOWObiAduIm0p2aTzccXu2iQaJ
         ycyLpUJU3lX2eCWq8USB9t8glHCDvU1QzoMusnYu27k8Vzqjr5YmGCET9prTxaNIqy
         75X2fETzshvUHcqwFzPtZH82kORGdkSnWztOoc4FLiYIAD26PuhtI2ioQ9MePOb+9T
         NzL/ryQ88XD7hI2j5Ug4sC7QRRfhfNrCCBjg4d2534VNax99fPk+DJFKrnVKR1Ltzq
         Wcne4+TPzZ2bA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4/4] arm64: dts: uniphier: rename aidet node names to follow json-schema
Date:   Sat, 22 Feb 2020 15:44:45 +0900
Message-Id: <20200222064445.14903-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222064445.14903-1-yamada.masahiro@socionext.com>
References: <20200222064445.14903-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the standard nodename pattern "^interrupt-controller(@[0-9a-f,]+)*$"
defined in schemas/interrupt-controller.yaml of dt-schema.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 7510db465f33..2e53daca9f5c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -566,7 +566,7 @@
 			};
 		};
 
-		aidet: aidet@5fc20000 {
+		aidet: interrupt-controller@5fc20000 {
 			compatible = "socionext,uniphier-ld11-aidet";
 			reg = <0x5fc20000 0x200>;
 			interrupt-controller;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 8d360c5cc32b..be984200a70e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -664,7 +664,7 @@
 			};
 		};
 
-		aidet: aidet@5fc20000 {
+		aidet: interrupt-controller@5fc20000 {
 			compatible = "socionext,uniphier-ld20-aidet";
 			reg = <0x5fc20000 0x200>;
 			interrupt-controller;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index d51b0735917c..994fea7b12c1 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -462,7 +462,7 @@
 			};
 		};
 
-		aidet: aidet@5fc20000 {
+		aidet: interrupt-controller@5fc20000 {
 			compatible = "socionext,uniphier-pxs3-aidet";
 			reg = <0x5fc20000 0x200>;
 			interrupt-controller;
-- 
2.17.1

