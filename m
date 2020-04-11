Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD5C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC4920787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="fDkiFm5W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oMAMVJr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgDKBf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:35:27 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41405 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgDKBf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:35:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E82B65C0101;
        Fri, 10 Apr 2020 21:35:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 10 Apr 2020 21:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=lX5SGrlx6dPNxsuJN5NmbTk0p2
        Mtpif3mvePdQ+RePg=; b=fDkiFm5WzcUikKeixJo5ASn6AULPPD9mIrtmfzYDyl
        O0+NJ8BUM7srr96K9ZJz5bvnDSb/+PdyaeIqJOfn8FIWOPFzM2QLpdJhCjHhYodg
        a2JtfnryubnZPlR1TCsCJpWrFPsdyOkb5wySaUiBLZKnAwixen6YqXZmM+SlOHoK
        ywzhsbYlXA31yZyXLVmp95YH86BGilf9C/eVqxBu+JwqfBqDXQGld+EABGmBrD/l
        W4tA8S8zOXuZrXzBCwiUQ3O+XY9vGD0uGbhfkTLEsq6ErkPSuX8skYsPfp6dEmnV
        Cp5Awbio17LbN12670xx4cX2bXeVUbVw+/rNnQg9O8ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=lX5SGrlx6dPNxsuJN
        5NmbTk0p2Mtpif3mvePdQ+RePg=; b=oMAMVJr9Mcrr9Itvy/kOZSdI1t8goQB8R
        Jy45fP2X8qlCiaWP1Y8B+a86EhnxHfir1+xzLSeRCX5Ggpwk0jdG0zXC8oLD7XNa
        QEt8fFenp/OJ5rGQpltTuC7dF7qZnp0zvlGJNbnvXIfGp22QizDThL17x/4C79bm
        dY09Qy8QFr+y7upVHWIjWARtuRIsyl9MRU0cPcAjJFPNt7TUWAyHWqtmYu+pUJzA
        9XYuduzgyBvG6FuQ63tranvfSHyzRq2ma0XDy8cL5//V+TVQlFWFL9YIEzSQcLLr
        u/Ns7dfGPiucAXsz6Jp3ZDuPus+9+lp6zh0rex670jU+uppuV0oKQ==
X-ME-Sender: <xms:0x6RXtpWYErjWA3RCTC3an9Nm4rjOzU3Sxm9SvkzO4nTNhsjglQhjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvdefgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptehnughrvgifucfl
    vghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedugedrvddrud
    dtkedrudegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:0x6RXtDNhKx7xsCIS_nKcZKYtOf6dw1Zowk7geYxJQeYWH5KaIkm6g>
    <xmx:0x6RXmN2FrZtib9MQzUYRQS7Bx-dzwhW0kOOCfDMjVcb-93QcEzwVg>
    <xmx:0x6RXsnc-1SLoW684WZiKWpkSQz04TLmi-Gj9MTfj00Z4MEuxjHM-Q>
    <xmx:3R6RXtNuZJ681W7M1Uo85YksUUkbxhVrfWrb_cCIKvEOj9psWcWhGA>
Received: from localhost.localdomain (ppp14-2-108-149.adl-apt-pir-bras32.tpg.internode.on.net [14.2.108.149])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7B4673280059;
        Fri, 10 Apr 2020 21:35:08 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        Vijay Khemka <vijaykhemka@fb.com>
Subject: [PATCH] ARM: dts: aspeed: Change KCS nodes to v2 binding
Date:   Sat, 11 Apr 2020 11:05:14 +0930
Message-Id: <20200411013514.15950-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings for both g5 and g6 SoCs:

    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs1@0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:382.19-387.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs2@0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:388.19-393.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs3@0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:405.19-410.8: Warning (unit_address_vs_reg): /ahb/apb/lpc@1e789000/lpc-host@80/kcs4@0: node has a unit name, but no reg property
    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs1@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs2@0)
    arch/arm/boot/dts/aspeed-g5.dtsi:376.19-381.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs1@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs3@0)
    arch/arm/boot/dts/aspeed-g5.dtsi:382.19-387.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs2@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-bmc@0/kcs3@0)
    arch/arm/boot/dts/aspeed-g5.dtsi:405.19-410.8: Warning (unique_unit_address): /ahb/apb/lpc@1e789000/lpc-host@80/kcs4@0: duplicate unit-address (also used in node /ahb/apb/lpc@1e789000/lpc-host@80/lpc-ctrl@0)

Cc: Haiyue Wang <haiyue.wang@linux.intel.com>
Cc: Vijay Khemka <vijaykhemka@fb.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 .../dts/aspeed-bmc-facebook-tiogapass.dts     |  4 ++--
 arch/arm/boot/dts/aspeed-g5.dtsi              | 24 +++++++++----------
 arch/arm/boot/dts/aspeed-g6.dtsi              | 23 +++++++++---------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 6b88c7f26bf7..8b880003a838 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -113,13 +113,13 @@
 &kcs2 {
 	// BMC KCS channel 2
 	status = "okay";
-	kcs_addr = <0xca8>;
+	slave-reg = <0xca8>;
 };
 
 &kcs3 {
 	// BMC KCS channel 3
 	status = "okay";
-	kcs_addr = <0xca2>;
+	slave-reg = <0xca2>;
 };
 
 &gpio {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 284face7de2c..de7fd80b022a 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -445,22 +445,22 @@
 					#size-cells = <1>;
 					ranges = <0x0 0x0 0x80>;
 
-					kcs1: kcs1@0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs1: kcs@24 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
 						interrupts = <8>;
-						kcs_chan = <1>;
 						status = "disabled";
 					};
-					kcs2: kcs2@0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs2: kcs@28 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x28 0x1>, <0x34 0x1>, <0x40 0x1>;
 						interrupts = <8>;
-						kcs_chan = <2>;
 						status = "disabled";
 					};
-					kcs3: kcs3@0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs3: kcs@2c {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x2c 0x1>, <0x38 0x1>, <0x44 0x1>;
 						interrupts = <8>;
-						kcs_chan = <3>;
 						status = "disabled";
 					};
 				};
@@ -474,10 +474,10 @@
 					#size-cells = <1>;
 					ranges = <0x0 0x80 0x1e0>;
 
-					kcs4: kcs4@0 {
-						compatible = "aspeed,ast2500-kcs-bmc";
+					kcs4: kcs@94 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x94 0x1>, <0x98 0x1>, <0x9c 0x1>;
 						interrupts = <8>;
-						kcs_chan = <4>;
 						status = "disabled";
 					};
 
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 1ffc15177b79..f4113275a7f9 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -471,22 +471,23 @@
 					#size-cells = <1>;
 					ranges = <0x0 0x0 0x80>;
 
-					kcs1: kcs1@0 {
-						compatible = "aspeed,ast2600-kcs-bmc";
+					kcs1: kcs@24 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
 						interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 						kcs_chan = <1>;
 						status = "disabled";
 					};
-					kcs2: kcs2@0 {
-						compatible = "aspeed,ast2600-kcs-bmc";
+					kcs2: kcs@28 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x28 0x1>, <0x34 0x1>, <0x40 0x1>;
 						interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
-						kcs_chan = <2>;
 						status = "disabled";
 					};
-					kcs3: kcs3@0 {
-						compatible = "aspeed,ast2600-kcs-bmc";
+					kcs3: kcs@2c {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x2c 0x1>, <0x38 0x1>, <0x44 0x1>;
 						interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
-						kcs_chan = <3>;
 						status = "disabled";
 					};
 				};
@@ -500,10 +501,10 @@
 					#size-cells = <1>;
 					ranges = <0x0 0x80 0x1e0>;
 
-					kcs4: kcs4@0 {
-						compatible = "aspeed,ast2600-kcs-bmc";
+					kcs4: kcs@94 {
+						compatible = "aspeed,ast2500-kcs-bmc-v2";
+						reg = <0x94 0x1>, <0x98 0x1>, <0x9c 0x1>;
 						interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-						kcs_chan = <4>;
 						status = "disabled";
 					};
 
-- 
2.20.1

