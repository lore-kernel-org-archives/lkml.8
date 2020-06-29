Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5970C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B37A206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459237;
	bh=dFJc4RSIx1riUoySHDk4MsDch7GYOxIOeYDc1FtDpHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zgCqKSmxeYYlRLrcINLKZwfdReX18vTfljbUBARxD3tlWrtAa6osHYwD9O8Gpwx8i
	 ZY2cvHFHgmLnNWSXDyEhYedJDuqgcrG7uNMFO2CZdaBwJnrjsMBfnvNPali+8P8LHy
	 nGprI7hHxvCL/NogVJxdFV9VwfyZxqa6ZgVyW+/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgF2Td4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733260AbgF2Tdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:33:50 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE9A20786;
        Mon, 29 Jun 2020 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593459230;
        bh=dFJc4RSIx1riUoySHDk4MsDch7GYOxIOeYDc1FtDpHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFTphCwsWP1gPmwdEZ2LAE2oJ6Xjq4APHvUYk7Iag1wa0MB/NZaROELVjj4F0vKlR
         3OxsIUdveAntbpruENkwqJAR9HILVBJLA4fGqOc1PwJ1jsSMA0Tc+ClsBzajHqVR64
         uuReBlCLISY20JLhAxC8s9eqpRMt1dBI0f2ocFsQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [RFT 2/3] arm64: dts: exynos: Add unit address to soc node on Exynos5433
Date:   Mon, 29 Jun 2020 21:33:37 +0200
Message-Id: <20200629193338.29540-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200629193338.29540-1-krzk@kernel.org>
References: <20200629193338.29540-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add @0 unit address to 'soc' node match its 'reg' property and silence
DTC warning:

    Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 6721966140f4..ebe089469b5f 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -256,7 +256,7 @@
 		cpu_on = <0xC4000003>;
 	};
 
-	soc: soc {
+	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.17.1

