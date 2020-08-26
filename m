Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8FDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FD4214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHZSio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:38:44 -0400
Received: from foss.arm.com ([217.140.110.172]:50130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbgHZSiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:38:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B68A113E;
        Wed, 26 Aug 2020 11:38:19 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D28A63F71F;
        Wed, 26 Aug 2020 11:38:17 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 3/6] ARM: dts: broadcom: Fix SP804 node
Date:   Wed, 26 Aug 2020 19:38:01 +0100
Message-Id: <20200826183805.19369-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826183805.19369-1-andre.przywara@arm.com>
References: <20200826183805.19369-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT binding for SP804 requires to have an "arm,primecell" compatible
string.
Add this string so that the Linux primecell bus driver picks the device
up and activates the clock.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 0346ea621f0f..1333ef8be0a2 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -368,7 +368,7 @@
 		};
 
 		ccbtimer0: timer@34000 {
-			compatible = "arm,sp804";
+			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x34000 0x1000>;
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

