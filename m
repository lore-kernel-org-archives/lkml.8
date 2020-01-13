Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB6DC33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF20206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbgAMDsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 22:48:35 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:38606 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbgAMDse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 22:48:34 -0500
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id CD0458AA05;
        Mon, 13 Jan 2020 11:48:28 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P25811T139966185199360S1578887298528581_;
        Mon, 13 Jan 2020 11:48:28 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a46402c84bd3a5dcc572e49ce2c0273b>
X-RL-SENDER: jeffy.chen@rock-chips.com
X-SENDER: cjf@rock-chips.com
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Jeffy Chen <jeffy.chen@rock-chips.com>
To:     linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Douglas Anderson <dianders@chromium.org>, sudeep.holla@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, dietmar.eggemann@arm.com,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2] arch_topology: Adjust initial CPU capacities with current freq
Date:   Mon, 13 Jan 2020 11:48:15 +0800
Message-Id: <20200113034815.25924-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU freqs are not supposed to change before cpufreq policies
properly registered, meaning that they should be used to calculate the
initial CPU capacities.

Doing this helps choosing the best CPU during early boot, especially
for the initramfs decompressing.

There's no functional changes for non-clk CPU DVFS mechanism.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2:
Fix u64 div compile error on 32-bit platforms, and be compatible with
non-clk CPU DVFS mechanism.

 drivers/base/arch_topology.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1eb81f113786..54a48dfafd2f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -94,7 +94,7 @@ static void update_topology_flags_workfn(struct work_struct *work)
 	update_topology = 0;
 }
 
-static u32 capacity_scale;
+static DEFINE_PER_CPU(u32, freq_factor) = 1;
 static u32 *raw_capacity;
 
 static int free_raw_capacity(void)
@@ -108,17 +108,23 @@ static int free_raw_capacity(void)
 void topology_normalize_cpu_scale(void)
 {
 	u64 capacity;
+	u64 capacity_scale;
 	int cpu;
 
 	if (!raw_capacity)
 		return;
 
-	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
+	capacity_scale = 1;
 	for_each_possible_cpu(cpu) {
-		pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
-			 cpu, raw_capacity[cpu]);
-		capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
-			/ capacity_scale;
+		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
+		capacity_scale = max(capacity, capacity_scale);
+	}
+
+	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
+	for_each_possible_cpu(cpu) {
+		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
+		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
+			capacity_scale);
 		topology_set_cpu_scale(cpu, capacity);
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
 			cpu, topology_get_cpu_scale(cpu));
@@ -127,6 +133,7 @@ void topology_normalize_cpu_scale(void)
 
 bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 {
+	struct clk *cpu_clk;
 	static bool cap_parsing_failed;
 	int ret;
 	u32 cpu_capacity;
@@ -146,10 +153,22 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 				return false;
 			}
 		}
-		capacity_scale = max(cpu_capacity, capacity_scale);
 		raw_capacity[cpu] = cpu_capacity;
 		pr_debug("cpu_capacity: %pOF cpu_capacity=%u (raw)\n",
 			cpu_node, raw_capacity[cpu]);
+
+		/*
+		 * Update freq_factor for calculating early boot cpu capacities.
+		 * For non-clk CPU DVFS mechanism, there's no way to get the
+		 * frequency value now, assuming they are running at the same
+		 * frequency (by keeping the initial freq_factor value).
+		 */
+		cpu_clk = of_clk_get(cpu_node, 0);
+		if (!PTR_ERR_OR_ZERO(cpu_clk))
+			per_cpu(freq_factor, cpu) =
+				clk_get_rate(cpu_clk) / 1000;
+
+		clk_put(cpu_clk);
 	} else {
 		if (raw_capacity) {
 			pr_err("cpu_capacity: missing %pOF raw capacity\n",
@@ -188,11 +207,8 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
-	for_each_cpu(cpu, policy->related_cpus) {
-		raw_capacity[cpu] = topology_get_cpu_scale(cpu) *
-				    policy->cpuinfo.max_freq / 1000UL;
-		capacity_scale = max(raw_capacity[cpu], capacity_scale);
-	}
+	for_each_cpu(cpu, policy->related_cpus)
+		per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
-- 
2.11.0



