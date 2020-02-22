Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85800C35672
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D8A24650
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 07:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgBVHAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 02:00:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbgBVHAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 02:00:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01M6xVMk011747
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 02:00:15 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubx5mtb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 02:00:15 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Sat, 22 Feb 2020 07:00:12 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Feb 2020 07:00:10 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01M709W956819884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 07:00:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5BE4AE056;
        Sat, 22 Feb 2020 07:00:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97FD3AE059;
        Sat, 22 Feb 2020 07:00:06 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.88.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 22 Feb 2020 07:00:06 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        peterz@infradead.org, dsmythies@telus.net,
        daniel.lezcano@linaro.org, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, psampat@linux.ibm.com,
        pratik.sampat@in.ibm.com, pratik.r.sampat@gmail.com
Subject: [RFC 1/1] Weighted approach to gather and use history in TEO governor
Date:   Sat, 22 Feb 2020 12:30:02 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200222070002.12897-1-psampat@linux.ibm.com>
References: <20200222070002.12897-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022207-0016-0000-0000-000002E93399
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022207-0017-0000-0000-0000334C5603
Message-Id: <20200222070002.12897-2-psampat@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-22_01:2020-02-21,2020-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002220061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complementing the current self correcting window algorithm, an alternate
approach is devised to leverage lifetime history with constant overhead

Each CPU maintains a matrix wherein each idle state maintains a
probability distribution.

The probability distribution is nothing but a n*n matrix, where
n = drv->state_count.
Each entry in the array signifies a weight for that row.
The weights can vary from the range [0-10000].

For example:
state_mat[1][2] = 3000 means that previously when state 1 was selected,
the probability that state 2 will occur is 30%.
The trailing zeros correspond to having more resolution while increasing
or reducing the weights for correction.

Initially the weights are distributed in a way such that the index of
that state in question has a higher probability of choosing itself, as
we have no reason to believe otherwise yet. Initial bias to itself is
70% and the rest 30% is equally distributed to the rest of the states.

Selection of an idle state:
When the TEO governor chooses an idle state, the probability
distribution for that state is looked at. A weighted random number
generator is used using the weights as bias to choose the next idle
state. The algorithm leans to choose that or a shallower state than that
for its next prediction

Correction of the probability distribution:
On wakeup, the weights are updated. The state which it should have woken
up with (could be the hit / miss / early hit state) is increased in
weight by the "LEARNING_RATE" % and the rest of the states for that
index are reduced by the same factor.
The LEARNING RATE is experimentally chosen to be 5 %
---
 drivers/cpuidle/governors/teo.c | 95 +++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index de7e706efd46..8060c287f5e4 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -50,6 +50,7 @@
 #include <linux/kernel.h>
 #include <linux/sched/clock.h>
 #include <linux/tick.h>
+#include <linux/random.h>
 
 /*
  * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
@@ -64,6 +65,12 @@
  */
 #define INTERVALS	8
 
+/*
+ * Percentage of the amount of weight to be shifted in the idle state weight
+ * distribution for correction
+ */
+#define LEARNING_RATE	5
+
 /**
  * struct teo_idle_state - Idle state data used by the TEO cpuidle governor.
  * @early_hits: "Early" CPU wakeups "matching" this state.
@@ -98,6 +105,8 @@ struct teo_idle_state {
  * @states: Idle states data corresponding to this CPU.
  * @interval_idx: Index of the most recent saved idle interval.
  * @intervals: Saved idle duration values.
+ * @state_mat: Each idle state maintains a weights corresponding to that
+ * state, storing the probablity distribution of occurance for that state
  */
 struct teo_cpu {
 	u64 time_span_ns;
@@ -105,6 +114,7 @@ struct teo_cpu {
 	struct teo_idle_state states[CPUIDLE_STATE_MAX];
 	int interval_idx;
 	u64 intervals[INTERVALS];
+	int state_mat[CPUIDLE_STATE_MAX][CPUIDLE_STATE_MAX];
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
@@ -117,7 +127,7 @@ static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
 static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
-	int i, idx_hit = -1, idx_timer = -1;
+	int i, idx_hit = -1, idx_timer = -1, idx = -1, last_idx = dev->last_state_idx;
 	u64 measured_ns;
 
 	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
@@ -183,16 +193,50 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 
 		if (idx_timer > idx_hit) {
 			misses += PULSE;
-			if (idx_hit >= 0)
+			idx = idx_timer;
+			if (idx_hit >= 0) {
 				cpu_data->states[idx_hit].early_hits += PULSE;
+				idx = idx_hit;
+			}
 		} else {
 			hits += PULSE;
+			idx = last_idx;
 		}
 
 		cpu_data->states[idx_timer].misses = misses;
 		cpu_data->states[idx_timer].hits = hits;
 	}
 
+	/*
+	 * Rearrange the weight distribution of the state, increase the weight
+	 * by the LEARNING RATE % for the idle state that was supposed to be
+	 * chosen and reduce by the same amount for rest of the states
+	 *
+	 * If the weights are greater than (100 - LEARNING_RATE) % or lesser
+	 * than LEARNING_RATE %, do not increase or decrease the confidence
+	 * respectively
+	 */
+	for (i = 0; i < drv->state_count; i++) {
+		unsigned int delta;
+
+		if (idx == -1)
+			break;
+		if (i ==  idx) {
+			delta = (LEARNING_RATE * cpu_data->state_mat[last_idx][i]) / 100;
+			if (cpu_data->state_mat[last_idx][i] + delta >=
+			    (100 - LEARNING_RATE) * 100)
+				continue;
+			cpu_data->state_mat[last_idx][i] += delta;
+			continue;
+		}
+		delta = (LEARNING_RATE * cpu_data->state_mat[last_idx][i]) /
+			((drv->state_count - 1) * 100);
+		if (cpu_data->state_mat[last_idx][i] - delta <=
+		    LEARNING_RATE * 100)
+			continue;
+		cpu_data->state_mat[last_idx][i] -= delta;
+	}
+
 	/*
 	 * Save idle duration values corresponding to non-timer wakeups for
 	 * pattern detection.
@@ -244,7 +288,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	u64 duration_ns;
 	unsigned int hits, misses, early_hits;
-	int max_early_idx, prev_max_early_idx, constraint_idx, idx, i;
+	int max_early_idx, prev_max_early_idx, constraint_idx, idx, i, og_idx;
 	ktime_t delta_tick;
 
 	if (dev->last_state_idx >= 0) {
@@ -374,10 +418,13 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	if (constraint_idx < idx)
 		idx = constraint_idx;
 
+	og_idx = idx;
+
 	if (idx < 0) {
 		idx = 0; /* No states enabled. Must use 0. */
 	} else if (idx > 0) {
-		unsigned int count = 0;
+		unsigned int count = 0, sum_weights = 0, weights_list[CPUIDLE_STATE_MAX];
+		int i, j = 0, rnd_wt, rnd_num = 0;
 		u64 sum = 0;
 
 		/*
@@ -412,6 +459,29 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 								       idx, avg_ns);
 			}
 		}
+		/*
+		 * In case, the recent history yields a shallower state, then
+		 * the probability distribution is looked at.
+		 * The weighted random number generator uses the weights as a
+		 * bias to choose the next idle state
+		 */
+		if (og_idx != idx) {
+			for (i = 0; i <= idx; i++) {
+				if (dev->states_usage[i].disable)
+					continue;
+				sum_weights += cpu_data->state_mat[idx][i];
+				weights_list[j++] = sum_weights;
+			}
+			get_random_bytes(&rnd_num, sizeof(rnd_num));
+			rnd_num = rnd_num % 100;
+			rnd_wt = (rnd_num * sum_weights) / 100;
+			for (i = 0; i < j; i++) {
+				if (rnd_wt < weights_list[i])
+					break;
+				rnd_wt -= weights_list[i];
+			}
+			idx = i;
+		}
 	}
 
 	/*
@@ -468,13 +538,28 @@ static int teo_enable_device(struct cpuidle_driver *drv,
 			     struct cpuidle_device *dev)
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
-	int i;
+	int i, j;
 
 	memset(cpu_data, 0, sizeof(*cpu_data));
 
 	for (i = 0; i < INTERVALS; i++)
 		cpu_data->intervals[i] = U64_MAX;
 
+	/*
+	 * Populate initial weights for each state
+	 * The stop state is initially more biased for itself.
+	 *
+	 * Currently the initial distribution of probabilities are 70%-30%.
+	 * The trailing 0s are for increased resolution.
+	 */
+	for (i = 0; i < drv->state_count; i++) {
+		for (j = 0; j < drv->state_count; j++) {
+			if (i == j)
+				cpu_data->state_mat[i][j] = 7000;
+			else
+				cpu_data->state_mat[i][j] = 3000 / (drv->state_count - 1);
+		}
+	}
 	return 0;
 }
 
-- 
2.17.1

