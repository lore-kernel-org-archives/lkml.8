Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF738C35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8064A206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RK5gwiuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBVAwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:52:39 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42916 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgBVAw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:52:28 -0500
Received: by mail-qv1-f66.google.com with SMTP id dc14so1794918qvb.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p98CUcx71WuQUXfbK29pwYzUrkAutx1lZcDJt+p+2C0=;
        b=RK5gwiuzd8mbfs3DxPIt8ns0qWRUrb6cGtSIH/KMj1riAyGQ6mSHAqtuIWk8HXk/qX
         MJ/el423LkdNl5y9sDgoRRu718ZWFkQnd3ivNr5cSC72gZgQ+38K80Sa3mlE2pq3mqCu
         PC5+FbtRk6ALLlRYkrH0IQhx8RaT5sC71/EGKkW07I9+dg81YRFopmXT64kxGTAbLpYU
         AHHkyFf8BpkqeU5kwYlthxx3q3qsno/UrzFzapzB1RpOBhKlogyrlPVMwp7QEwee5HyO
         kj1UVYvCO9GIo78aik7VNJOiEU1ltpGkdzhNRhs23jKjTkztjiYsUf8X0AXdWSWH6b3X
         7/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p98CUcx71WuQUXfbK29pwYzUrkAutx1lZcDJt+p+2C0=;
        b=WX2GQdH8SmvFc0YblvZxdnDskSWc/4impy2Gfn+2KpLkdTWggNqW+BSB4KX+vYP2L6
         PxVbDhz+W4HO+9y7q2Lsm1JUqte6FVUzvQT7n0yOs3XMoeo38RUkQE2vU9LuOPkPaGAS
         DWf9cwgExlBBbcKh4v1m8Wd+FDGG4BMviCZCAzfHiYSN8fPDIsbaJIluPKCMfy2AXA00
         35k8oUS26mWatcyfn7FCYhhvzXWZWytGyiWJ0GkKMDhIOXdiSY9KYNCCbnSFNJ5wfiDv
         lTA6FlDFJu9wT/zt3/KtT2f7qO+GmyAr7IG0iaXeNnrjXLZovRli9ljFtYFfBEbc2Cqz
         y6FQ==
X-Gm-Message-State: APjAAAVkqvi7U9qUXjvqf4+aKtOizCy/QEV+nFYNhvo4oeMIC5P4rdu2
        DWSOPSnjMcqRLr6S14NO5LXpHg==
X-Google-Smtp-Source: APXvYqwJ6Mrd1sOciRepdsM1BISRCwpVtORTJ6wkT2r5W8dKurM1RbqVDpsoLvijL9de/UNeQsNMJw==
X-Received: by 2002:ad4:58a8:: with SMTP id ea8mr32484103qvb.93.1582332746682;
        Fri, 21 Feb 2020 16:52:26 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 12sm359559qkj.136.2020.02.21.16.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:52:26 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v10 8/9] thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
Date:   Fri, 21 Feb 2020 19:52:12 -0500
Message-Id: <20200222005213.3873-9-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222005213.3873-1-thara.gopinath@linaro.org>
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index fe83d7a210d4..4ae8c856c88e 100644
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
2.20.1

