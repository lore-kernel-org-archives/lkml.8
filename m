Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF783C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9170D2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KWjkh1ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgCZTQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:16:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39293 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:16:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id f20so6473767qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 12:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkZLVjPlVie4I4Rn8nnFUQbiBk5glv6kvAdwJ0mlRmU=;
        b=KWjkh1iidsC9CvsBx8XrSVD6D3KtsKOBm4TNFAETuuAumhRktoy52+yqU0MCUxiaXN
         EXRTtmggkH0Zy9lN3kxk3wUuX7wwDdmoY1BWkV3OxVpxMFoIZdjpdeseIt4hkJAmmXFi
         hT2oa6nsxJYnyofql/Sy/TMlAh7ApmCufannY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkZLVjPlVie4I4Rn8nnFUQbiBk5glv6kvAdwJ0mlRmU=;
        b=miAb5tVAOe/rfRPYr79lBAjd6jjG3z9Y+/5TIdtPxsaR2TOcOabDoIpd3gCOGWDxQR
         zTXbYPv28UYcbzyYO38JSh+E860C5572STJU5hP4LUHjYss69L/bKpS+WVBey8oDi83s
         biGz35wDh0vxbE+4mStWdkeIhHBSP3sUd6lb6JO12J+MensfOAoHXzpJCa9DJrDga93y
         nW11H7msLDflBRTWvWcfUSvLzZU6HJ2/E/TamsylK9p4W35p5Ouy4WdHtlMATSIz6p3u
         17U3ubiJFGb2MIHE9XFFuPt/X0lzK1LJUXc+AhJNcMZ/eKTW1R2vQGQCdPh4x1wpqtrS
         2L6A==
X-Gm-Message-State: ANhLgQ39M54vgPx1UKtPIIhjwrSqElLxwSCU4HUu4kFaSvEAYwtOYWbb
        sQy9ngr7o7AB0dPv4CFL+/dYoCZa8no=
X-Google-Smtp-Source: ADFU+vse4j03u5+X5Suw00krwHsA4LUdZFcOSkFJHMTSTa4Jpa5gLSN7zsF+pszYbquHxpDl2SKpBg==
X-Received: by 2002:ac8:1bda:: with SMTP id m26mr10351438qtk.2.1585250188052;
        Thu, 26 Mar 2020 12:16:28 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c27sm1984244qkk.0.2020.03.26.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:16:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        jsbarnes@google.com, sonnyrao@google.com, vpillai@digitalocean.com,
        peterz@infradead.org, Guenter Roeck <groeck@chromium.org>,
        Waiman Long <longman@redhat.com>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
Date:   Thu, 26 Mar 2020 15:16:23 -0400
Message-Id: <20200326191623.129285-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This deliberately changes the behavior of the per-cpuset
cpus file to not be effected by hotplug. When a cpu is offlined,
it will be removed from the cpuset/cpus file. When a cpu is onlined,
if the cpuset originally requested that that cpu was part of the cpuset,
that cpu will be restored to the cpuset. The cpus files still
have to be hierachical, but the ranges no longer have to be out of
the currently online cpus, just the physically present cpus.

To show the problem:
 # echo '1-3' > cpuset.cpus
 # cat cpuset.cpus
 1-3
 # echo 0 > /sys/devices/system/cpu/cpu2/online
 # cat cpuset.cpus
 1,3
 # echo 1 > /sys/devices/system/cpu/cpu2/online
 # cat cpuset.cpus
 1,3

With patch, the last command outputs:
 # cat cpuset.cpus
 1-3

Cc: Dmitry Shmidt <dimitrysh@google.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: kernel-team@android.com
Cc: jsbarnes@google.com
Cc: sonnyrao@google.com
Cc: vpillai@digitalocean.com
Cc: peterz@infradead.org
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Greg Kerr <kerrnel@google.com>
(Original idea from Riley Andrews <riandrews@google.com> who has since
left Google).
(Joel: Forward ported from Android and ChromeOS trees to upstream,
adjusted slightly to handle the scheduling partitions work.)
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
This patch is in various kernel trees for > 3 years. Atleast 3
organizations using Linux need this patch to handle hotplug: Google's
Android and ChromeOS, DigitalOcean.

 kernel/cgroup/cpuset.c | 45 +++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58f5073acff7d..5eb1fb613d0a6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -105,6 +105,7 @@ struct cpuset {
 
 	/* user-configured CPUs and Memory Nodes allow to tasks */
 	cpumask_var_t cpus_allowed;
+	cpumask_var_t cpus_requested;
 	nodemask_t mems_allowed;
 
 	/* effective CPUs and Memory Nodes allow to tasks */
@@ -443,7 +444,7 @@ static void cpuset_update_task_spread_flag(struct cpuset *cs,
 
 static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
 {
-	return	cpumask_subset(p->cpus_allowed, q->cpus_allowed) &&
+	return	cpumask_subset(p->cpus_requested, q->cpus_requested) &&
 		nodes_subset(p->mems_allowed, q->mems_allowed) &&
 		is_cpu_exclusive(p) <= is_cpu_exclusive(q) &&
 		is_mem_exclusive(p) <= is_mem_exclusive(q);
@@ -459,12 +460,13 @@ static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
  */
 static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
 {
-	cpumask_var_t *pmask1, *pmask2, *pmask3;
+	cpumask_var_t *pmask1, *pmask2, *pmask3, *pmask4;
 
 	if (cs) {
 		pmask1 = &cs->cpus_allowed;
 		pmask2 = &cs->effective_cpus;
 		pmask3 = &cs->subparts_cpus;
+		pmask4 = &cs->cpus_requested;
 	} else {
 		pmask1 = &tmp->new_cpus;
 		pmask2 = &tmp->addmask;
@@ -480,8 +482,13 @@ static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (!zalloc_cpumask_var(pmask3, GFP_KERNEL))
 		goto free_two;
 
+	if (cs && !zalloc_cpumask_var(pmask4, GFP_KERNEL))
+		goto free_three;
+
 	return 0;
 
+free_three:
+	free_cpumask_var(*pmask3);
 free_two:
 	free_cpumask_var(*pmask2);
 free_one:
@@ -498,6 +505,7 @@ static inline void free_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
 {
 	if (cs) {
 		free_cpumask_var(cs->cpus_allowed);
+		free_cpumask_var(cs->cpus_requested);
 		free_cpumask_var(cs->effective_cpus);
 		free_cpumask_var(cs->subparts_cpus);
 	}
@@ -526,6 +534,7 @@ static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
 	}
 
 	cpumask_copy(trial->cpus_allowed, cs->cpus_allowed);
+	cpumask_copy(trial->cpus_requested, cs->cpus_requested);
 	cpumask_copy(trial->effective_cpus, cs->effective_cpus);
 	return trial;
 }
@@ -594,7 +603,8 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	cpuset_for_each_child(c, css, par) {
 		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
 		    c != cur &&
-		    cpumask_intersects(trial->cpus_allowed, c->cpus_allowed))
+		    cpumask_intersects(trial->cpus_requested,
+				       c->cpus_requested))
 			goto out;
 		if ((is_mem_exclusive(trial) || is_mem_exclusive(c)) &&
 		    c != cur &&
@@ -1056,10 +1066,11 @@ static void compute_effective_cpumask(struct cpumask *new_cpus,
 	if (parent->nr_subparts_cpus) {
 		cpumask_or(new_cpus, parent->effective_cpus,
 			   parent->subparts_cpus);
-		cpumask_and(new_cpus, new_cpus, cs->cpus_allowed);
+		cpumask_and(new_cpus, new_cpus, cs->cpus_requested);
 		cpumask_and(new_cpus, new_cpus, cpu_active_mask);
 	} else {
-		cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
+		cpumask_and(new_cpus, cs->cpus_requested,
+			    parent->effective_cpus);
 	}
 }
 
@@ -1482,27 +1493,29 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		return -EACCES;
 
 	/*
-	 * An empty cpus_allowed is ok only if the cpuset has no tasks.
+	 * An empty cpus_requested is ok only if the cpuset has no tasks.
 	 * Since cpulist_parse() fails on an empty mask, we special case
 	 * that parsing.  The validate_change() call ensures that cpusets
 	 * with tasks have cpus.
 	 */
 	if (!*buf) {
-		cpumask_clear(trialcs->cpus_allowed);
+		cpumask_clear(trialcs->cpus_requested);
 	} else {
-		retval = cpulist_parse(buf, trialcs->cpus_allowed);
+		retval = cpulist_parse(buf, trialcs->cpus_requested);
 		if (retval < 0)
 			return retval;
-
-		if (!cpumask_subset(trialcs->cpus_allowed,
-				    top_cpuset.cpus_allowed))
-			return -EINVAL;
 	}
 
+	if (!cpumask_subset(trialcs->cpus_requested, top_cpuset.cpus_requested))
+		return -EINVAL;
+
 	/* Nothing to do if the cpus didn't change */
-	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
+	if (cpumask_equal(cs->cpus_requested, trialcs->cpus_requested))
 		return 0;
 
+	cpumask_and(trialcs->cpus_allowed, trialcs->cpus_requested,
+		    cpu_active_mask);
+
 	retval = validate_change(cs, trialcs);
 	if (retval < 0)
 		return retval;
@@ -1528,6 +1541,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 
 	spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
+	cpumask_copy(cs->cpus_requested, trialcs->cpus_requested);
 
 	/*
 	 * Make sure that subparts_cpus is a subset of cpus_allowed.
@@ -2409,7 +2423,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 
 	switch (type) {
 	case FILE_CPULIST:
-		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->cpus_allowed));
+		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->cpus_requested));
 		break;
 	case FILE_MEMLIST:
 		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->mems_allowed));
@@ -2778,6 +2792,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cs->mems_allowed = parent->mems_allowed;
 	cs->effective_mems = parent->mems_allowed;
 	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
+	cpumask_copy(cs->cpus_requested, parent->cpus_requested);
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
 out_unlock:
@@ -2892,10 +2907,12 @@ int __init cpuset_init(void)
 	BUG_ON(percpu_init_rwsem(&cpuset_rwsem));
 
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_requested, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
+	cpumask_setall(top_cpuset.cpus_requested);
 	nodes_setall(top_cpuset.mems_allowed);
 	cpumask_setall(top_cpuset.effective_cpus);
 	nodes_setall(top_cpuset.effective_mems);
-- 
2.25.1.696.g5e7596f4ac-goog
