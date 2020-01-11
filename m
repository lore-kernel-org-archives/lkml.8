Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2758AC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38B6206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ham7ewAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgAKP7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 10:59:20 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41455 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbgAKP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:59:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id x129so4772629qke.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 07:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OghplwU/tPhbSguv+TUOhHr2qr6XCiHT707bOgXEuSc=;
        b=ham7ewAIx9vW+TQV9h/j3lhNQhOswY8Q9Uq8F5XxHeOx76r3u6DuqOkHxztUOpHKUs
         dIZseFKGTnhnLtdSNTMQo4a6HseQSHpl8EEo9hjc8SLyByxd8hESrX+j4wVTYleGmSCA
         mu08wEV1mG9TiZOrJg48w5z5FtABHQfhv1ffORZCvPBLwZYuZQ8SpaXkd0342f2NfF5b
         s/J9o5GA9tsTG0JJDpHPKRZtmFjYZuOhVJv9Ck0FvzyCyLdqs2VYqOuLfutWYAaeIlfw
         fK+jmARSwXza8z2VTMJ+LxB7iZlVqvR1EEmRxh3EJUCM8rNvs78wBySlQ0qD2EDzTpKP
         l47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OghplwU/tPhbSguv+TUOhHr2qr6XCiHT707bOgXEuSc=;
        b=Q5tl3pASpxZ1bwCkQBRGOfcZJMCL8Vb8OaAWuuCAHzzmAaoIVRgZd6wE5f0oHtE41w
         6u1BU82cBDFZIPDJc4YoYNRz+Uu8CTF7NjAjypT30E5jkjy1EjqkaJ0vl6bLq6p8UDIC
         P1dqPAdUkShujedZLMkZqHJTyzY1ERUS+WbQ2AAmcwF16f4lUTxt/8oY25xthXm/3pkh
         WDI/sxWVNn3hv7sb9K7avnqoRhQP6gdrGkDVl0aK88oyFZ0GViw+Xe4/aXOPZnx4V9Gd
         ZRImuAWGVGBWVvYsfQl0fj0JPJT0EA7F2NDijb7dqJWUZjxtGGv4TYe4htK/u2iVBxqm
         B6Qw==
X-Gm-Message-State: APjAAAWd0KdeVouocZlLXMP2xy+Fe7rgWZv7+S4IkyXeYiJ8y9s2Pvmh
        T+RK/EGeeHzM/fJ2SQBjSkmP/SCwpCo=
X-Google-Smtp-Source: APXvYqwT6Z3TqJ9JKBeiudLDwjvK79Td3ALfe8R1cHFaRi7LUhS/RH4xKKBPYS09pel/2S7oNhZm5w==
X-Received: by 2002:a37:a68f:: with SMTP id p137mr8495687qke.328.1578758357423;
        Sat, 11 Jan 2020 07:59:17 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id l49sm2843478qtk.7.2020.01.11.07.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Jan 2020 07:59:16 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v7 6/7] thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
Date:   Sat, 11 Jan 2020 10:59:05 -0500
Message-Id: <1578758346-507-7-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
References: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal governors can request for a cpu's maximum supported frequency to
be capped in case of an overheat event. This in turn means that the
maximum capacity available for tasks to run on the particular cpu is
reduced. Delta between the original maximum capacity and capped maximum
capacity is known as thermal pressure. Enable cpufreq cooling device to
update the thermal pressure in event of a capped maximum frequency.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v6->v7
	- Changed the input argument in arch_set_thermal_pressure from
	  capped capacity to delta capacity(thermal pressure) as per
	  Ionela's review comments. Hence the calculation for delta
	  capacity(thermal pressure) is moved to cpufreq_cooling.c.

 drivers/thermal/cpufreq_cooling.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index fe83d7a..4ae8c85 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -431,6 +431,10 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	struct cpumask *cpus;
+	unsigned int frequency;
+	unsigned long max_capacity, capacity;
+	int ret;
 
 	/* Request state should be less than max_level */
 	if (WARN_ON(state > cpufreq_cdev->max_level))
@@ -442,8 +446,19 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 
 	cpufreq_cdev->cpufreq_state = state;
 
-	return freq_qos_update_request(&cpufreq_cdev->qos_req,
-				get_state_freq(cpufreq_cdev, state));
+	frequency = get_state_freq(cpufreq_cdev, state);
+
+	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
+
+	if (ret > 0) {
+		cpus = cpufreq_cdev->policy->cpus;
+		max_capacity = arch_scale_cpu_capacity(cpumask_first(cpus));
+		capacity = frequency * max_capacity;
+		capacity /= cpufreq_cdev->policy->cpuinfo.max_freq;
+		arch_set_thermal_pressure(cpus, max_capacity - capacity);
+	}
+
+	return ret;
 }
 
 /* Bind cpufreq callbacks to thermal cooling device ops */
-- 
2.1.4

