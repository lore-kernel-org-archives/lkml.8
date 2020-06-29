Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463C6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27DF42073E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466265;
	bh=P4Y+FCT/+WCOx5YCwdsX3MXOEtmwwCaFhV7DU4kMtKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o7jxwC+9/GTsRnkg9c/ahDNND63PvwOeuWzZN5DSPE53zrEfATG/2yWDJBH72drzA
	 eZQ3nFdXRibWDBnjIDeWr42RQsn3HNejcVNVqaMDRObsN6tJg7ez9ZZejYal3D6hIj
	 BbWcIATtqkhJbKIIOLuNawQ87P8sOUDhhFQ6zNfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390945AbgF2VbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgF2SlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:20 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F9823356;
        Mon, 29 Jun 2020 08:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418545;
        bh=P4Y+FCT/+WCOx5YCwdsX3MXOEtmwwCaFhV7DU4kMtKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fh1HqOwJ9Z8Y/2rNYtoZQ9IDsjVKbXvY1kGz1lNPQBK+wYKWtNJ6YOIncMkGNNbJ/
         HgMb3XXmbbKuDOGxdkUvLBRDoVl81X1238wxtmyDJvp0800+ljgHdLPd8nNtZANxHO
         eWzLuFqmC9/GSf1qvvBz3OxfQZdI+/HujJ+BNDO0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] arm64: dts: alpine: Fix GIC unit address
Date:   Mon, 29 Jun 2020 10:15:35 +0200
Message-Id: <20200629081535.13502-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629081535.13502-1-krzk@kernel.org>
References: <20200629081535.13502-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node unit address should be the same as first address appearing in "reg"
property.  Fixes DTC warning:

    arch/arm64/boot/dts/al/alpine-v2.dtsi:116.38-126.5:
        Warning (simple_bus_reg): /soc/interrupt-controller@f0100000: simple-bus unit address format error, expected "f0200000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/al/alpine-v2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/al/alpine-v2.dtsi b/arch/arm64/boot/dts/al/alpine-v2.dtsi
index de2eaf77b1ff..4eb2cd14e00b 100644
--- a/arch/arm64/boot/dts/al/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/al/alpine-v2.dtsi
@@ -113,7 +113,7 @@
 				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		gic: interrupt-controller@f0100000 {
+		gic: interrupt-controller@f0200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
 			      <0x0 0xf0280000 0x0 0x200000>,	/* GICR */
-- 
2.17.1

