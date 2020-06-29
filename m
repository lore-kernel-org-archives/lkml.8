Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1101C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BD82063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593456034;
	bh=lTTyTKp2tnmquFcsNq5+ReqbndcL5tQpxX5n04EmKg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EKwqfROMH8eD9z7U5LiQbecptJ0DT7uQ4/rwKnqqxYjSGmTZ+JWoc59AGVYk/RvD7
	 wHsgG2ujGf1As8uGmOLGY2CjBHKsEvxNjBB5M67F/IF+OYyooQ8oj+648g1Lcrk3q2
	 oNQ1i9vg98BKFa/0NaCqVO4AjfVedJINM4LY4fxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgF2Skd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgF2SkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:21 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9249523343;
        Mon, 29 Jun 2020 08:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418543;
        bh=lTTyTKp2tnmquFcsNq5+ReqbndcL5tQpxX5n04EmKg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIXnTVclnOLzWhqMwlZEeXtUHfKlInmCrPzVPoiuvQNDxrpMXkUAQoWQ9ZUILAKRd
         4JKNV3KCk1V5yrI2UWQaEciDSj18o35mf9xTx0GHubwlX0iKkW3E8t6Pu9pHrqk54o
         VN8G0rgHtjWGjCDIutnCriTdqSuEeA2T+FxdGTTw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] arm64: dts: alpine: Align GIC nodename with dtschema
Date:   Mon, 29 Jun 2020 10:15:34 +0200
Message-Id: <20200629081535.13502-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629081535.13502-1-krzk@kernel.org>
References: <20200629081535.13502-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    gic@f0100000: $nodename:0:
        'gic@f0100000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/al/alpine-v2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/al/alpine-v2.dtsi b/arch/arm64/boot/dts/al/alpine-v2.dtsi
index d5e7e2bb4e6c..de2eaf77b1ff 100644
--- a/arch/arm64/boot/dts/al/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/al/alpine-v2.dtsi
@@ -113,7 +113,7 @@
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		gic: gic@f0100000 {
+		gic: interrupt-controller@f0100000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
 			      <0x0 0xf0280000 0x0 0x200000>,	/* GICR */
-- 
2.17.1

