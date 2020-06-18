Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6361C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC38B21927
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448068;
	bh=HyWkwtaU0/RoTtrJwEMQ2IOLdNbG66utKfyAaE3FH+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vwoGxWjUqT7uScz7offvql+ZxV5DpcIetm5HLbyIuG8SZN6fYdNKsaRRvhL4tXJQ2
	 ubgeWpTUNh9S+beqaMotofZKqhMlrRtIbPBwV/eieS6bNwerm1aNaNLBbt7RBS/2jF
	 RtTX9Y7npzhGqMAogejbz3iw0YNxqB0zYAGSPZSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgFRBM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbgFRBLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:11:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2062320B1F;
        Thu, 18 Jun 2020 01:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442702;
        bh=HyWkwtaU0/RoTtrJwEMQ2IOLdNbG66utKfyAaE3FH+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cUF3JzZ3cCUoQpbPWImubojPtFYTPfi8wT4uIpw20TjE8Kml/ZWFCnowBTIWQGPFW
         TFpNH9HMaYOtZ9rM+qnC56QpPjmVMWD1G9luDcpqo2RLK4pKxh7hEdRonrxXJiOKhE
         hAoPW0Gr8BB+mgwTkSL6RdUbY7lef8pmlQJy8gS8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.7 164/388] ARM: dts: aspeed: ast2600: Set arch timer always-on
Date:   Wed, 17 Jun 2020 21:04:21 -0400
Message-Id: <20200618010805.600873-164-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@linux.ibm.com>

[ Upstream commit c998f40f2ae6a48e93206e2c1ea0691479989611 ]

According to ASPEED, FTTMR010 is not intended to be used in the AST2600.
The arch timer should be used, but Linux doesn't enable high-res timers
without being assured that the arch timer is always on, so set that
property in the devicetree.

The FTTMR010 device is described by set to disabled.

This fixes highres timer support for AST2600.

Fixes: 2ca5646b5c2f ("ARM: dts: aspeed: Add AST2600 and EVB")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 0a29b3b57a9d..fd0e483737a0 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -65,6 +65,7 @@ timer {
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 		clocks = <&syscon ASPEED_CLK_HPLL>;
 		arm,cpu-registers-not-fw-configured;
+		always-on;
 	};
 
 	ahb {
@@ -368,6 +369,7 @@ timer: timer@1e782000 {
 						<&gic  GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB1>;
 				clock-names = "PCLK";
+				status = "disabled";
                         };
 
 			uart1: serial@1e783000 {
-- 
2.25.1

