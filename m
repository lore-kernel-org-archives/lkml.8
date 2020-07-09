Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA37AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B59B2070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJWpSWZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgGIGwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgGIGwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:52:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF60CC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 23:52:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so574759pgf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xi0IjXZT0vlAn+aLE/RD/PtWZze7khXZnjoaecCKN1M=;
        b=jJWpSWZ0U1zA1yILc3YaBGQs7u1fLp3eg6M+JC6uPvP26eNchIerrsO8/U0B7XZKc5
         3nHVMfK78KaQSwJsKScWm/1BI0cBmhgknmhpfvtHN8luFokG5nMn7gEG7MD8n8xSVvMt
         nu4Fs40ttO/wMoOti/Cuwqk1ZH4IDhoKTKSPlmDNk9ykwC5vH/1G/fo0Jm1YgBO4xKsU
         Q62jQpaDESE46iJpl2Y5n7aBPLWYlo5HcwnKlAyLtbB9ttMCG8BAMcHCl+Cv4I7SaBd7
         AfGeE5vufhYP5jAKVMFk7OUw3IIlASsJikFyLu+nD7uS6F/f63y+7YGvggxOuFE/fCXJ
         /BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xi0IjXZT0vlAn+aLE/RD/PtWZze7khXZnjoaecCKN1M=;
        b=CIkcKoXCsYa+YUvDRw2fjoeYtmGBEQbhc8LzGQCs+NWCjzdLf+fX4M9PPen/qA9+cR
         yhIEpwv/M9oInu5twXkuV3XEDL1nAf2M5xTDqZIkvB22zWVvxOgGeye37myQ3Vhq9ge5
         q3by7UHTxHFV0Ge2btClAlopIJtdURzButJO+hKtYeizCFXLL3LES6rMadBdsw3riAgn
         R1AJQ4fhlMep1cHUJbLo3rChPhAnBGX2rHSwFnjwNxsU085MTtY6Q8il9J2mNx/w0qJg
         W+WOLG+jXyeP6XIHLRcbSRS5b2ZJ0qy56HWzYyQjeeJl6Y6ewNm4vSoRb/jn0JJFjx0z
         Mx6A==
X-Gm-Message-State: AOAM532xblOxSd6m21/sgS0/TWst7khzZ+zlJ6Oz5ohxMHxe4WkTydUS
        mzFOLsISvawgMWOTBcM6LVh5yO8JBIQ=
X-Google-Smtp-Source: ABdhPJyakv2z/Yj0ViE4yrP6D4rSzJtc+69r45BNRWe9J9ut1E1xICUdWAeLHyU5Zig+MEgceti5Zw==
X-Received: by 2002:a63:20d:: with SMTP id 13mr53135099pgc.166.1594277574260;
        Wed, 08 Jul 2020 23:52:54 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id p127sm1710281pfb.17.2020.07.08.23.52.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 23:52:53 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: topology: Don't support AMU without cpufreq
Date:   Thu,  9 Jul 2020 12:22:45 +0530
Message-Id: <a710fc4e4e0f1d2e561320130b99bcb5167d73b4.1594277563.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit cd0ed03a8903 ("arm64: use activity monitors for frequency
invariance"), mentions that:

  "if CONFIG_CPU_FREQ is not enabled, the use of counters is
   enabled on all CPUs only if all possible CPUs correctly support
   the necessary counters"

But that's not really true as validate_cpu_freq_invariance_counters()
fails if max_freq_hz is returned as 0 (in case there is no policy for
the CPU). And the AMUs won't be supported in that case.

Make the code reflect this reality.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/kernel/topology.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 0801a0f3c156..b7da372819fc 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -187,14 +187,13 @@ static int validate_cpu_freq_invariance_counters(int cpu)
 	return 0;
 }
 
-static inline bool
-enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
+static inline void update_amu_fie_cpus(int cpu, cpumask_var_t valid_cpus)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 
 	if (!policy) {
 		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
-		return false;
+		return;
 	}
 
 	if (cpumask_subset(policy->related_cpus, valid_cpus))
@@ -202,8 +201,6 @@ enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
 			   amu_fie_cpus);
 
 	cpufreq_cpu_put(policy);
-
-	return true;
 }
 
 static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
@@ -212,7 +209,6 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
 static int __init init_amu_fie(void)
 {
 	cpumask_var_t valid_cpus;
-	bool have_policy = false;
 	int ret = 0;
 	int cpu;
 
@@ -228,18 +224,9 @@ static int __init init_amu_fie(void)
 		if (validate_cpu_freq_invariance_counters(cpu))
 			continue;
 		cpumask_set_cpu(cpu, valid_cpus);
-		have_policy |= enable_policy_freq_counters(cpu, valid_cpus);
+		update_amu_fie_cpus(cpu, valid_cpus);
 	}
 
-	/*
-	 * If we are not restricted by cpufreq policies, we only enable
-	 * the use of the AMU feature for FIE if all CPUs support AMU.
-	 * Otherwise, enable_policy_freq_counters has already enabled
-	 * policy cpus.
-	 */
-	if (!have_policy && cpumask_equal(valid_cpus, cpu_present_mask))
-		cpumask_or(amu_fie_cpus, amu_fie_cpus, valid_cpus);
-
 	if (!cpumask_empty(amu_fie_cpus)) {
 		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
 			cpumask_pr_args(amu_fie_cpus));
-- 
2.25.0.rc1.19.g042ed3e048af

