Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CA3C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289D62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394940AbgBNSYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:24:53 -0500
Received: from foss.arm.com ([217.140.110.172]:43308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405588AbgBNSYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:24:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6633101E;
        Fri, 14 Feb 2020 10:24:47 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9803D3F68E;
        Fri, 14 Feb 2020 10:24:46 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 06/10] x86/resctrl: Use is_closid_match() in more places
Date:   Fri, 14 Feb 2020 18:23:57 +0000
Message-Id: <20200214182401.39008-7-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214182401.39008-1-james.morse@arm.com>
References: <20200214182401.39008-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdtgroup_tasks_assigned() and show_rdt_tasks() loop over threads testing
for a CTRL/MON group match by closid/rmid with the provided rdtgrp.
Further down the file are helpers to do this, move these further up and
make use of them here.

These helpers additionally check for alloc/mon capable. This is harmless
as rdtgroup_mkdir() tests these capable flags before allowing the config
directories to be created.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 30 ++++++++++++--------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index fef09105cbe4..c84b1f355a9a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -592,6 +592,18 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	return ret;
 }
 
+static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
+{
+	return (rdt_alloc_capable &&
+	       (r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
+}
+
+static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
+{
+	return (rdt_mon_capable &&
+	       (r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
+}
+
 /**
  * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource group
  * @r: Resource group
@@ -607,8 +619,7 @@ int rdtgroup_tasks_assigned(struct rdtgroup *r)
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if ((r->type == RDTCTRL_GROUP && t->closid == r->closid) ||
-		    (r->type == RDTMON_GROUP && t->rmid == r->mon.rmid)) {
+		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
 			ret = 1;
 			break;
 		}
@@ -706,8 +717,7 @@ static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
 
 	rcu_read_lock();
 	for_each_process_thread(p, t) {
-		if ((r->type == RDTCTRL_GROUP && t->closid == r->closid) ||
-		    (r->type == RDTMON_GROUP && t->rmid == r->mon.rmid))
+		if (is_closid_match(t, r) || is_rmid_match(t, r))
 			seq_printf(s, "%d\n", t->pid);
 	}
 	rcu_read_unlock();
@@ -2231,18 +2241,6 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	return 0;
 }
 
-static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (rdt_alloc_capable &&
-		(r->type == RDTCTRL_GROUP) && (t->closid == r->closid));
-}
-
-static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (rdt_mon_capable &&
-		(r->type == RDTMON_GROUP) && (t->rmid == r->mon.rmid));
-}
-
 /*
  * Move tasks from one to the other group. If @from is NULL, then all tasks
  * in the systems are moved unconditionally (used for teardown).
-- 
2.24.1

