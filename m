Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF770C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFF12075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598457639;
	bh=mqR6dbxEf9z3vf/e9zsd9vKuP/SWTci1RRRc7pR/mng=;
	h=From:To:Subject:Date:List-ID:From;
	b=brdwN5U70CgW0m6JrVj8Wh+//Db+GCOwmon9WTuNSs0bC2NLUJsyg5RIfb3N1RGh/
	 oOSft7IxQ4G2jO71RCaqUIEjdgUuJYp+2kjgaEEm9tyLZU96B5nZYAMycSJ7w/ftDM
	 0F4KB3Kx/owSwWNg1EHIdmsgV9NOqTQu4lWGzy5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHZQAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgHZQAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:00:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 841C92075E;
        Wed, 26 Aug 2020 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598457623;
        bh=mqR6dbxEf9z3vf/e9zsd9vKuP/SWTci1RRRc7pR/mng=;
        h=From:To:Subject:Date:From;
        b=ProeJqdfv5Yw8CPijUlTSYb0EnUgcSzUyhpu2A6OQozvdgQbiLbd1Fv7Ci/g32HI1
         p58z2hRxT22VlWtHVG+2HEsZOMCtGPc1qYsm2TNrTFwcUy7EIZl34RUz7LRpGWIclz
         LKie1y3TgY7p3GgLm84hW37yvq5md3NEbNMWyFS4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: s5pv210: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 18:00:15 +0200
Message-Id: <20200826160016.469-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index e84281e2561d..7dccdb364fcf 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -590,6 +590,7 @@ static struct notifier_block s5pv210_cpufreq_reboot_notifier = {
 
 static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct device_node *np;
 	int id, result = 0;
 
@@ -602,21 +603,14 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	 * cpufreq-dt driver.
 	 */
 	arm_regulator = regulator_get(NULL, "vddarm");
-	if (IS_ERR(arm_regulator)) {
-		if (PTR_ERR(arm_regulator) == -EPROBE_DEFER)
-			pr_debug("vddarm regulator not ready, defer\n");
-		else
-			pr_err("failed to get regulator vddarm\n");
-		return PTR_ERR(arm_regulator);
-	}
+	if (IS_ERR(arm_regulator))
+		return dev_err_probe(dev, PTR_ERR(arm_regulator),
+				     "failed to get regulator vddarm\n");
 
 	int_regulator = regulator_get(NULL, "vddint");
 	if (IS_ERR(int_regulator)) {
-		if (PTR_ERR(int_regulator) == -EPROBE_DEFER)
-			pr_debug("vddint regulator not ready, defer\n");
-		else
-			pr_err("failed to get regulator vddint\n");
-		result = PTR_ERR(int_regulator);
+		result = dev_err_probe(dev, PTR_ERR(int_regulator),
+				       "failed to get regulator vddint\n");
 		goto err_int_regulator;
 	}
 
-- 
2.17.1

