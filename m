Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEFDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C99B214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0Rdzrwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgA1Wg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:36:27 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44384 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgA1WgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:36:21 -0500
Received: by mail-qv1-f68.google.com with SMTP id n8so7075757qvg.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OghplwU/tPhbSguv+TUOhHr2qr6XCiHT707bOgXEuSc=;
        b=O0RdzrwmfEH8uV6RdRU4C4h2M1E/wqsv11ZV3zenr2bD1mpDgnrxullmq3C1wF5tGu
         IiMrSYRWA/s18yzBA2U1EQDCzg8BLLeOahc9JivymAYeEG8DDQpKnjgqUy9iglV54qv3
         ckBJez1p2rhSu527bd/DXm8xqBhOjufU9J9oMRLn+wQzBGMTo58nRwWJCXoqN4+ihvMO
         tNplAuPjc8GkoJZerog/r5/XdPWjYH6ykEuFLeb8v8YqhEfHcOsFvGpWXv3qN97/e74n
         yYb31KMeNxeIw5xT/cLoZstD7THgaeTFQb5v43F8D8Dm5UmcEoNbamDjTXGCNJzaQJTe
         e6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OghplwU/tPhbSguv+TUOhHr2qr6XCiHT707bOgXEuSc=;
        b=InD6U/qm7ZWbG7ESfag/K1/EFGVBu140u5RVj0sBowXYjIeAeEiG9gi0KVlC3N/3Od
         ar9KCepL9ST8uLNeD/1OO3AYu1KYPU9/C/W1DFS4LkLViycSPYMfE/bpp1j516O+PO/t
         zMsymcZyxxyNTRKvS5hK4FVMeGzd24FLkhgrFPd9x5E3HE8gCWwZIHEaDxOWT2V4NaNV
         Zn8ZnQswCrYXTZ5rybm0IrZTG61ulX9ALktacnOLpBmwmw6AZf4+U+BWrxwwdp5HK3ax
         IcpV0q2ieNFIgl1WDICwlt1bR2iFrvUnnOSmZESaR9YJprCPjICSa0MFtgyzB3PlPNoD
         m1mg==
X-Gm-Message-State: APjAAAWEitrk0+HhyX2sTHWkFxmM4i/ZHNLCdrqAiUd+3xnRzDfV+jzQ
        rCkbyYpvYQ4skWCU1OHtUlokIQ==
X-Google-Smtp-Source: APXvYqwNXRE2Jx9Q8G0Z1gI7LMYYb3v1Z+iO1SHbRzn+/LiMnHF+yluwec0nkednp9lpRme8JmKy1Q==
X-Received: by 2002:a0c:ef0f:: with SMTP id t15mr25139569qvr.123.1580250980156;
        Tue, 28 Jan 2020 14:36:20 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 124sm13014259qko.11.2020.01.28.14.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2020 14:36:19 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v9 6/8] thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
Date:   Tue, 28 Jan 2020 17:36:05 -0500
Message-Id: <1580250967-4386-7-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
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

