Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA5CC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD9624699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fziPaJiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgB1MVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:21:54 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:51540 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgB1MVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:21:54 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 01SCL1XW004922;
        Fri, 28 Feb 2020 21:21:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 01SCL1XW004922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582892461;
        bh=5ghtF6rUXJoiM/O0pSdOPbN8zT8QLZE6M+wi9C8WvuQ=;
        h=From:To:Cc:Subject:Date:From;
        b=fziPaJiTtPI95odVNEvQiZwh8s7oczRhLsT5hqopZ3uiv6cDdWMsA3X6vrfPcRN1q
         /CBKto9+TVaymE8VKI1Zo6/XBRjZ4WwsI5B4wX9+c7idW7xZ/riZmSuJUhCfLgzQvt
         ATGgfvyGt9x8jHWUKuT6IbJh6S/bk70XCi8YNjCO+vGV3cq6NSSktF6DfQSxfPko91
         SSIx0FoGG9VZscnKpRR0GngO7bN8IInMH3AzfDDo0ko+Q2GVtC7UkHm5FvcHmz0iwg
         Y9Njh2cyoov0cjD3J6O2L9qz3jEZxuffJl09jY7qCnH+3n4qAhaKow1R3fZqHIi6la
         KoLdFwIDfHckA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: uniphier: Add one more generic compatible string for I2C EEPROM
Date:   Fri, 28 Feb 2020 21:20:55 +0900
Message-Id: <20200228122055.17008-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 73f9de0c7f5d ("ARM: dts: uniphier: Add generic compatible string
for I2C EEPROM") did not touch this node.

Add the compatible string prefixed "atmel," so that this matches to the
OF table.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ref-daughter.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-ref-daughter.dtsi b/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
index 04e60c295319..a11897669c26 100644
--- a/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
+++ b/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
@@ -7,7 +7,7 @@
 
 &i2c0 {
 	eeprom@50 {
-		compatible = "microchip,24lc128";
+		compatible = "microchip,24lc128", "atmel,24c128";
 		reg = <0x50>;
 		pagesize = <64>;
 	};
-- 
2.17.1

