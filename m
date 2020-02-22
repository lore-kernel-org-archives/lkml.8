Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770ACC35672
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEFA2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XR5D3jco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBVGpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 01:45:31 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:58838 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgBVGpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 01:45:30 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 01M6ik5R005982;
        Sat, 22 Feb 2020 15:44:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 01M6ik5R005982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582353888;
        bh=QXIr1NM/lJU9Er4W0jdmoTXg2ZffC9oBy94sIlyO2tY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XR5D3jcocDCm9YhIeLHXopxKiDTCB/2+rBBzyxSk+UPE+Bgxrn69ysb/tsKaTgKPo
         Z/1CHjEFwc+RCEtmLrzR8lfcrkvQfNLBrmd3C3SxdFHFsqgIFDk+wX+lKh6dqRv5Mc
         ariH1fjTC+insOWB01MkaZXU/qcCkJtHvbL3shAXphwZ79aHRKxgs7F93D6uDNcPFE
         LE46V0YMAVG1m/c9vmcj1gs82X6EkgQw0dMG/F3Sl5FBVTKeKcA1gFMFWZzSZBqjdD
         3/9lqd7qDt+J3yZBoMEStXGziN8FPBSC7mowZOdvQd3/E1/UZdXOZ4978xyuL0HNoq
         OxatouZ+F6SoQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/4] ARM: dts: uniphier: rename aidet node names to follow json-schema
Date:   Sat, 22 Feb 2020 15:44:44 +0900
Message-Id: <20200222064445.14903-3-yamada.masahiro@socionext.com>
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

 arch/arm/boot/dts/uniphier-ld4.dtsi  | 2 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi | 2 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi | 2 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 2 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index f3a20dc0b22b..23b8fd627c00 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -375,7 +375,7 @@
 			interrupt-controller;
 		};
 
-		aidet: aidet@61830000 {
+		aidet: interrupt-controller@61830000 {
 			compatible = "socionext,uniphier-ld4-aidet";
 			reg = <0x61830000 0x200>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index e96b5796f0f8..eb06c353970f 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -426,7 +426,7 @@
 			};
 		};
 
-		aidet: aidet@5fc20000 {
+		aidet: interrupt-controller@5fc20000 {
 			compatible = "socionext,uniphier-pro4-aidet";
 			reg = <0x5fc20000 0x200>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index f794a0676760..c95eb44c816d 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -408,7 +408,7 @@
 			};
 		};
 
-		aidet: aidet@5fc20000 {
+		aidet: interrupt-controller@5fc20000 {
 			compatible = "socionext,uniphier-pro5-aidet";
 			reg = <0x5fc20000 0x200>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 04d6bef3a00f..c054d0175df9 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -508,7 +508,7 @@
 			};
 		};
 
-		aidet: aidet@5fc20000 {
+		aidet: interrupt-controller@5fc20000 {
 			compatible = "socionext,uniphier-pxs2-aidet";
 			reg = <0x5fc20000 0x200>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index beb1eac85436..a05061038e78 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -379,7 +379,7 @@
 			interrupt-controller;
 		};
 
-		aidet: aidet@61830000 {
+		aidet: interrupt-controller@61830000 {
 			compatible = "socionext,uniphier-sld8-aidet";
 			reg = <0x61830000 0x200>;
 			interrupt-controller;
-- 
2.17.1

