Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6ACC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34022087D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796827;
	bh=PezkV/BBxdiRHsbfh2DW7duf8rwEieb1A2/fZcuH92g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=npdsA/3EKEgM+VBZz1cRG3gXY0vVBEcCDTXPGTdMQKCPNFdq+2A6YEXwVqcYWtXcy
	 DVkKUgm36zXLlIUEMinNqvWOtROlNZZGa51Q15Ewr7T+/0q/3w1Tm5E2pmXaDB4Yxk
	 gw4KvRN2IvCaiApAUAQiftRU5giXkN7eGSLI2ouA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH3OND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbgH3NyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B19E2087D;
        Sun, 30 Aug 2020 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795658;
        bh=PezkV/BBxdiRHsbfh2DW7duf8rwEieb1A2/fZcuH92g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQ1Lkc+DLVhD8zbiFFDJOxl7GM+sItk3JeIvbiuVnOlSS+bOju7ShyYxgAiB24FZT
         AP4wg9Q4xXyAp696G5OmGqLqCzrOH0FZrl227DmEIqgLAj5lIWa5hCPu1BjCyNiURz
         7Rf1idlvZ8lzpchlTez1Tv2/k1Mq9zNthWY84Q7I=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Denis GNUtoo Carikli" <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 08/33] ARM: dts: exynos: Add and enable 32 kHz modem clock in Galaxy I9100
Date:   Sun, 30 Aug 2020 15:51:35 +0200
Message-Id: <20200830135200.24304-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC has a 32768 Hz clock used by the modem which is implemented by
driver as a regulator.  Add and enable it to be sure modem get's its
signal.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index d63274c8539d..1d200a5e1b72 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -580,6 +580,11 @@
 				regulator-name = "EN32KHZ_AP";
 				regulator-always-on;
 			};
+
+			EN32KHZ_CP {
+				regulator-name = "EN32KHZ_CP";
+				regulator-always-on;
+			};
 		};
 	};
 };
-- 
2.17.1

