Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED3C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D494F21741
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgCFOm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53844 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgCFOmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB6-0006Kw-Sz; Fri, 06 Mar 2020 15:42:17 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D075A1C21DD;
        Fri,  6 Mar 2020 15:42:08 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:08 -0000
From:   "tip-bot2 for Thara Gopinath" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200222005213.3873-9-thara.gopinath@linaro.org>
References: <20200222005213.3873-9-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <158350572857.28353.7469807947344049697.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f12e4f66ab6a31f17da386b682e5fec87ae46537
Gitweb:        https://git.kernel.org/tip/f12e4f66ab6a31f17da386b682e5fec87ae46537
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Fri, 21 Feb 2020 19:52:12 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:21 +01:00

thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping

Thermal governors can request for a CPU's maximum supported frequency to
be capped in case of an overheat event. This in turn means that the
maximum capacity available for tasks to run on the particular CPU is
reduced. Delta between the original maximum capacity and capped maximum
capacity is known as thermal pressure. Enable cpufreq cooling device to
update the thermal pressure in event of a capped maximum frequency.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200222005213.3873-9-thara.gopinath@linaro.org
---
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
