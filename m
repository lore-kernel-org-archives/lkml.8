Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5948C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1C620720
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 10:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HqmEWCRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgGLKGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 06:06:55 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5760 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgGLKGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 06:06:54 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0ae04f0000>; Sun, 12 Jul 2020 03:05:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 12 Jul 2020 03:06:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 12 Jul 2020 03:06:54 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 12 Jul
 2020 10:06:53 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 12 Jul 2020 10:06:54 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.75.246]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0ae0bc0001>; Sun, 12 Jul 2020 03:06:53 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/2] cpufreq: tegra186: Fix initial frequency
Date:   Sun, 12 Jul 2020 11:06:44 +0100
Message-ID: <20200712100645.13927-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594548303; bh=efSfznaHRVOLPOniFGgvlT8Fr3h/o5mTkr8QrJEVayo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=HqmEWCRmNF6QaGG4iBINeBvBO7pjoiu4upmffuxhYh9vCgKecx95JbhuArhBIQSB8
         FUujT2hTtPVPoPsNShBlI/O4E3mHVljRHXmK70nMVDi0ivnBqlRweO2ZmqBZJHYDSQ
         gz78o2MpSpFgL8HsurGCd0PidH1tGzE9apZmDV/S3Kbf1ZRPiV9PJouXNs5qPI1wnA
         YmpLkBoNfhfRvQQ3krPn1ZCuNIi8S5OxhQs8gw7VAN8oMcnBFhSMGZiJw6wRK9/c15
         K6BJybO3FSvhSoCraWu1qXJcz+LwWdFfAUb0S7Y48WlP/UCsfVwUBNBjbKN2v8+Xk1
         vQGJp1NqfHpbA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6cc3d0e9a097 ("cpufreq: tegra186: add
CPUFREQ_NEED_INITIAL_FREQ_CHECK flag") fixed CPUFREQ support for
Tegra186 but as a consequence the following warnings are now seen on
boot ...

 cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 2035200 KHz
 cpufreq: cpufreq_online: CPU1: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU1: Unlisted initial frequency changed to: 2035200 KHz
 cpufreq: cpufreq_online: CPU2: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU2: Unlisted initial frequency changed to: 2035200 KHz
 cpufreq: cpufreq_online: CPU3: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU3: Unlisted initial frequency changed to: 2035200 KHz
 cpufreq: cpufreq_online: CPU4: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU4: Unlisted initial frequency changed to: 2035200 KHz
 cpufreq: cpufreq_online: CPU5: Running at unlisted freq: 0 KHz
 cpufreq: cpufreq_online: CPU5: Unlisted initial frequency changed to: 2035200 KHz

Although we could fix this by adding a 'get' operator for the Tegra186
CPUFREQ driver, there is really little point because the CPUFREQ on
Tegra186 is set by writing a value stored in the frequency table to a
register and we just need to set the initial frequency. So for Tegra186
the simplest way to fix this is read the register that sets the
frequency for each CPU and set the initial frequency when initialising
the CPUFREQ driver.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 3d2f143748ef..c44190ce3f03 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -59,6 +59,7 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 		struct tegra186_cpufreq_cluster *cluster = &data->clusters[i];
 		const struct tegra186_cpufreq_cluster_info *info =
 			cluster->info;
+		u32 edvd_val;
 		int core;
 
 		for (core = 0; core < ARRAY_SIZE(info->cpus); core++) {
@@ -71,6 +72,13 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 		policy->driver_data =
 			data->regs + info->offset + EDVD_CORE_VOLT_FREQ(core);
 		policy->freq_table = cluster->table;
+
+		edvd_val = readl(policy->driver_data);
+
+		for (i = 0; cluster->table[i].frequency != CPUFREQ_TABLE_END; i++) {
+			if (cluster->table[i].driver_data == edvd_val)
+				policy->cur = cluster->table[i].frequency;
+		}
 		break;
 	}
 
-- 
2.17.1

