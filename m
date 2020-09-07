Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76880C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38ADD2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599503670;
	bh=jv39r1U7DdD4Gxwu418julyKl9pGw0WYN+K8mXoXWbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ngm3fIUY4yfJ0kQco3fvU96aG3KrDamg6iwdhp8+/ZWmEQjzkjmaHtOnmMEC0jutP
	 qiJqR6VD00Gtp41C8koRtrNjPP68cWM51+9QAl78ndbW+jp1WkxMrXj9YXUIFic+zu
	 IR+VpVusUcv6az8NIHVIt3Mrf7uCC2gKk/P06BFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgIGSdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:33:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbgIGSdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:33:31 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834842087D;
        Mon,  7 Sep 2020 18:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599503611;
        bh=jv39r1U7DdD4Gxwu418julyKl9pGw0WYN+K8mXoXWbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XHAe2xTfirLIMz4TkT22OYIuzHx4XD0/rzd45ZnAO1Dq3qsnqL6VDGM8dkQD38RjM
         15z7n6r7Ve6FO4OtOB2fiiNinkBwAJjKOVZ4+g9TiapfpmQL7a7wH8ZNo1+DABVTb9
         4EM8AYqNjL0J1XT10Kg+udCng0ZnfAEYdtAkQorE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lihua Yao <ylhuajnu@outlook.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 02/11] ARM: dts: s3c6410: move fixed clocks under root node in Mini6410
Date:   Mon,  7 Sep 2020 20:33:04 +0200
Message-Id: <20200907183313.29234-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907183313.29234-1-krzk@kernel.org>
References: <20200907183313.29234-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixed clocks are kept under dedicated 'clocks' node but this causes
multiple dtschema warnings:

  clocks: $nodename:0: 'clocks' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
  clocks: #size-cells:0:0: 0 is not one of [1, 2]
  clocks: oscillator@0:reg:0: [0] is too short
  clocks: oscillator@1:reg:0: [1] is too short
  clocks: 'ranges' is a required property
  oscillator@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c6410-mini6410.dts | 30 ++++++++++----------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 1aeac33b0d34..75067dbcf7e8 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -28,26 +28,18 @@
 		bootargs = "console=ttySAC0,115200n8 earlyprintk rootwait root=/dev/mmcblk0p1";
 	};
 
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		fin_pll: oscillator@0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			clock-frequency = <12000000>;
-			clock-output-names = "fin_pll";
-			#clock-cells = <0>;
-		};
+	fin_pll: oscillator-0 {
+		compatible = "fixed-clock";
+		clock-frequency = <12000000>;
+		clock-output-names = "fin_pll";
+		#clock-cells = <0>;
+	};
 
-		xusbxti: oscillator@1 {
-			compatible = "fixed-clock";
-			reg = <1>;
-			clock-output-names = "xusbxti";
-			clock-frequency = <48000000>;
-			#clock-cells = <0>;
-		};
+	xusbxti: oscillator-1 {
+		compatible = "fixed-clock";
+		clock-output-names = "xusbxti";
+		clock-frequency = <48000000>;
+		#clock-cells = <0>;
 	};
 
 	srom-cs1@18000000 {
-- 
2.17.1

