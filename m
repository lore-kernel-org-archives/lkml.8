Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A40C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA8B20709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgERNTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:19:48 -0400
Received: from foss.arm.com ([217.140.110.172]:40432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbgERNTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:19:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49E4B11FB;
        Mon, 18 May 2020 06:19:43 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EED1B3F305;
        Mon, 18 May 2020 06:19:41 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v3 06/10] x86/resctrl: Use is_closid_match() in more places
Date:   Mon, 18 May 2020 14:19:19 +0100
Message-Id: <20200518131924.7741-7-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200518131924.7741-1-james.morse@arm.com>
References: <20200518131924.7741-1-james.morse@arm.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 30 ++++++++++++--------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 24bdb52446aa..d3aa55e1380f 100644
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
@@ -2244,18 +2254,6 @@ static int reset_all_ctrls(struct rdt_resource *r)
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
2.19.1

