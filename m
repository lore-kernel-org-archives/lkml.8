Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF30C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56C320658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693657;
	bh=drw5bpymsEmzse0AQE94EHwiijtRpGBgXRZNsFvsyBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RqmF6ExKUT9ipGlpyqPC5ZaciMPtHlN/7+fkV45J52X/f4nwK8xQI2lbhKR8rm9ds
	 IL/boouVDBOvchE2+G7fr5e1ogsPIfsXqAgw+TQ8mMOxLTMmD8cCk5JmkTMqdn7JvT
	 PJGDMQ8BqXsMIjMdwS72O5PPQG1Vb97w3Wn8rhUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbgHQTrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729284AbgHQPUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:20:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF22207D3;
        Mon, 17 Aug 2020 15:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677637;
        bh=drw5bpymsEmzse0AQE94EHwiijtRpGBgXRZNsFvsyBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtsR1JUMNT499cD2twGshw68ZqI/6QZrpE+HKihyXOjS+maSgafJH7KKts+wcgcye
         hZ5SqhAXwByrTTaGekmFfmVHRJHc7RRy/BGheohTl6t5ABZ8kQYu7mLucW7q9Sv9x8
         qK8+FUx07WlJuVvLAmTJKNfzfrUEgfAZYvmXksrU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 024/464] ARM: exynos: MCPM: Restore big.LITTLE cpuidle support
Date:   Mon, 17 Aug 2020 17:09:37 +0200
Message-Id: <20200817143834.914697956@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit ea9dd8f61c8a890843f68e8dc0062ce78365aab8 ]

Call exynos_cpu_power_up(cpunr) unconditionally. This is needed by the
big.LITTLE cpuidle driver and has no side-effects on other code paths.

The additional soft-reset call during little core power up has been added
to properly boot all cores on the Exynos5422-based boards with secure
firmware (like Odroid XU3/XU4 family). This however broke big.LITTLE
CPUidle driver, which worked only on boards without secure firmware (like
Peach-Pit/Pi Chromebooks). Apply the workaround only when board is
running under secure firmware.

Fixes: 833b5794e330 ("ARM: EXYNOS: reset Little cores when cpu is up")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-exynos/mcpm-exynos.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
index 9a681b421ae11..cd861c57d5adf 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -26,6 +26,7 @@
 #define EXYNOS5420_USE_L2_COMMON_UP_STATE	BIT(30)
 
 static void __iomem *ns_sram_base_addr __ro_after_init;
+static bool secure_firmware __ro_after_init;
 
 /*
  * The common v7_exit_coherency_flush API could not be used because of the
@@ -58,15 +59,16 @@ static void __iomem *ns_sram_base_addr __ro_after_init;
 static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
 {
 	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
+	bool state;
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
 		cluster >= EXYNOS5420_NR_CLUSTERS)
 		return -EINVAL;
 
-	if (!exynos_cpu_power_state(cpunr)) {
-		exynos_cpu_power_up(cpunr);
-
+	state = exynos_cpu_power_state(cpunr);
+	exynos_cpu_power_up(cpunr);
+	if (!state && secure_firmware) {
 		/*
 		 * This assumes the cluster number of the big cores(Cortex A15)
 		 * is 0 and the Little cores(Cortex A7) is 1.
@@ -258,6 +260,8 @@ static int __init exynos_mcpm_init(void)
 		return -ENOMEM;
 	}
 
+	secure_firmware = exynos_secure_firmware_available();
+
 	/*
 	 * To increase the stability of KFC reset we need to program
 	 * the PMU SPARE3 register
-- 
2.25.1



