Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD31C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 02:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E43B20673
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 02:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="XmkxPJ7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XRFMe2OQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgDKCO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 22:14:27 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58531 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbgDKCO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 22:14:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AFAC35C00FD;
        Fri, 10 Apr 2020 22:14:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 10 Apr 2020 22:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=j5pB8Ra39tC+eZN6i8d9UiFa/0
        b8JKjS85bs3hoKRRw=; b=XmkxPJ7sPF0fK0xEGEqhjzass4zi8FLISvQujuHHvm
        4RQBVh/vE4NFwdzeyf/YBJCtF2eIifTZTPSJCw7RmNlPj/U27f8I/4fPVRs0LjF3
        cUqzWYfnoKKzUkbzHn4JlqbYyJsec/574xLlcH9TIyVnJpo+T7IfM/y2phTpagRw
        KdG6Xyo+5dKsi04Nxa/Tey1KylnMMKWNsa9kV/8HgIS4dPgZmTNygf3UfYNOdar5
        lvD1NTYHYg3l+HwQBJpBCob9ChD5mPKFsx9gajcX6WCgjSkoSbvGIgPo8V9IUc/t
        V5qleoPpmMAa2fM8resWUIoyJ0O7y5glGfx6mtpubw6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=j5pB8Ra39tC+eZN6i
        8d9UiFa/0b8JKjS85bs3hoKRRw=; b=XRFMe2OQczfMDsVD4f1OVQgfJz3yoDIof
        b3XrW7k4TT2wjyNh8A9UsV1rcpUia6Zkbcsa7k3AOkZX3z1B4mSyAU+lolGIgNVj
        R15bUgrbvDetwr2do2c1zIXqJ85BFiMcF+wMK5CaH8RgS0nuXCiDwdRtp9iz0/5/
        vPBTUTDZW96EvkmXOZseXBtlNcnRmEME3OmOVGENBaOdXBPHfc+uZWaO2Bsh71ns
        QbZWVMs+ohjgDKa4C0U9zxPPOg6TrmHiR7Gog5ekXwsOm6uUE6U4Z0nSu6p9l2WI
        cIwh21xYk2G0NEblDXZZM4NJd2FTvhbSs9f0jfRaYb+FRYOaCcL6A==
X-ME-Sender: <xms:ASiRXoMEK3RWnkv_EnCWJdQQZuPNnhj2TeIxEyEdwQzLoktbsu1NWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvdefgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptehnughrvgifucfl
    vghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucfkphepudegrddvrddutdekrddugeelnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurd
    gruh
X-ME-Proxy: <xmx:ASiRXmGkvwxmM08FokquGazgmN-xRXc1ush9ykXloxMkHUM-BngaxA>
    <xmx:ASiRXhn6SwYAO4eUblMsohb96P73BqPEe4YuKxlOvVuZaQQwt6cJ5g>
    <xmx:ASiRXpeVWceYEVX3yAL8GJsVuq3BClaf4bCjXaKLS1a01o72SDVopA>
    <xmx:AiiRXpc820gD4Lf7LpJbplPrApFsLAK3TBEKfD9ovkmnSFuVYBuoLQ>
Received: from localhost.localdomain (ppp14-2-108-149.adl-apt-pir-bras32.tpg.internode.on.net [14.2.108.149])
        by mail.messagingengine.com (Postfix) with ESMTPA id 29B063060062;
        Fri, 10 Apr 2020 22:14:21 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        Vijay Khemka <vijaykhemka@fb.com>
Subject: [PATCH v2] ARM: dts: aspeed: Change KCS nodes to v2 binding
Date:   Sat, 11 Apr 2020 11:44:58 +0930
Message-Id: <20200411021458.8837-1-andrew@aj.id.au>
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
v1[1] was an out-of-date patch that used the old slave-reg property to define
the device address in the LPC IO space. In v2 of the driver series[2] we agreed
to make the property aspeed-specific on the back some quirks of the hardware.

v2 of this patch updates the tiogapass dts to use the upstream
'aspeed,lpc-io-reg' property instead of 'slave-reg'. I discovered the mismatch
when I started to tidy up the various branches I have lying around for the
ASPEED DT cleanups.

[1] https://lore.kernel.org/linux-arm-kernel/20200411013514.15950-1-andrew@aj.id.au/
[2] https://lore.kernel.org/linux-arm-kernel/8aec8994bbe1186d257b0a712e13cf914c5ebe35.1576462051.git-series.andrew@aj.id.au/

 .../dts/aspeed-bmc-facebook-tiogapass.dts     |  4 ++--
 arch/arm/boot/dts/aspeed-g5.dtsi              | 24 +++++++++----------
 arch/arm/boot/dts/aspeed-g6.dtsi              | 23 +++++++++---------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 6b88c7f26bf7..2d44d9ad4e40 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -113,13 +113,13 @@
 &kcs2 {
 	// BMC KCS channel 2
 	status = "okay";
-	kcs_addr = <0xca8>;
+	aspeed,lpc-io-reg = <0xca8>;
 };
 
 &kcs3 {
 	// BMC KCS channel 3
 	status = "okay";
-	kcs_addr = <0xca2>;
+	aspeed,lpc-io-reg = <0xca2>;
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

