Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA66C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75342075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgEFSIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbgEFSIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:08:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF974C061A0F;
        Wed,  6 May 2020 11:08:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWOT6-0001F1-Pk; Wed, 06 May 2020 20:08:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5AEE31C0092;
        Wed,  6 May 2020 20:08:28 +0200 (CEST)
Date:   Wed, 06 May 2020 18:08:28 -0000
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Maintain MBM counter width per resource
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Ce36743b9800f16ce600f86b89127391f61261f23=2E15887?=
 =?utf-8?q?15690=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Ce36743b9800f16ce600f86b89127391f61261f23=2E158871?=
 =?utf-8?q?5690=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158878850832.8414.4980592784316571528.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     46637d4570e108d1f6721cfa2cca1d078882761a
Gitweb:        https://git.kernel.org/tip/46637d4570e108d1f6721cfa2cca1d078882761a
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 05 May 2020 15:36:16 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 May 2020 18:00:35 +02:00

x86/resctrl: Maintain MBM counter width per resource

The original Memory Bandwidth Monitoring (MBM) architectural
definition defines counters of up to 62 bits in the IA32_QM_CTR MSR,
and the first-generation MBM implementation uses 24 bit counters.
Software is required to poll at 1 second or faster to ensure that
data is retrieved before a counter rollover occurs more than once
under worst conditions.

As system bandwidths scale the software requirement is maintained with
the introduction of a per-resource enumerable MBM counter width.

In preparation for supporting hardware with an enumerable MBM counter
width the current globally static MBM counter width is moved to a
per-resource MBM counter width. Currently initialized to 24 always
to result in no functional change.

In essence there is one function, mbm_overflow_count() that needs to
know the counter width to handle rollovers. The static value
used within mbm_overflow_count() will be replaced with a value
discovered from the hardware. Support for learning the MBM counter
width from hardware is added in the change that follows.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/e36743b9800f16ce600f86b89127391f61261f23.1588715690.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  8 +++++---
 arch/x86/kernel/cpu/resctrl/internal.h    |  7 +++++--
 arch/x86/kernel/cpu/resctrl/monitor.c     | 21 +++++++++++++--------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 055c861..934c8fb 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -495,14 +495,16 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	return ret;
 }
 
-void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
-		    struct rdtgroup *rdtgrp, int evtid, int first)
+void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
+		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    int evtid, int first)
 {
 	/*
 	 * setup the parameters to send to the IPI to read the data.
 	 */
 	rr->rgrp = rdtgrp;
 	rr->evtid = evtid;
+	rr->r = r;
 	rr->d = d;
 	rr->val = 0;
 	rr->first = first;
@@ -539,7 +541,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		goto out;
 	}
 
-	mon_event_read(&rr, d, rdtgrp, evtid, false);
+	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
 	if (rr.val & RMID_VAL_ERROR)
 		seq_puts(m, "Error\n");
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3dd13f3..58b002c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -87,6 +87,7 @@ union mon_data_bits {
 
 struct rmid_read {
 	struct rdtgroup		*rgrp;
+	struct rdt_resource	*r;
 	struct rdt_domain	*d;
 	int			evtid;
 	bool			first;
@@ -460,6 +461,7 @@ struct rdt_resource {
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
+	unsigned int		mbm_width;
 	unsigned long		fflags;
 };
 
@@ -587,8 +589,9 @@ void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 				    unsigned int dom_id);
 void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 				    struct rdt_domain *d);
-void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
-		    struct rdtgroup *rdtgrp, int evtid, int first);
+void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
+		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    int evtid, int first);
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 773124b..df964c0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -214,9 +214,9 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr)
+static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 {
-	u64 shift = 64 - MBM_CNTR_WIDTH, chunks;
+	u64 shift = 64 - width, chunks;
 
 	chunks = (cur_msr << shift) - (prev_msr << shift);
 	return chunks >>= shift;
@@ -256,7 +256,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 		return 0;
 	}
 
-	chunks = mbm_overflow_count(m->prev_msr, tval);
+	chunks = mbm_overflow_count(m->prev_msr, tval, rr->r->mbm_width);
 	m->chunks += chunks;
 	m->prev_msr = tval;
 
@@ -278,7 +278,7 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
 		return;
 
-	chunks = mbm_overflow_count(m->prev_bw_msr, tval);
+	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
 	m->chunks_bw += chunks;
 	m->chunks = m->chunks_bw;
 	cur_bw = (chunks * r->mon_scale) >> 20;
@@ -433,11 +433,12 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	}
 }
 
-static void mbm_update(struct rdt_domain *d, int rmid)
+static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 {
 	struct rmid_read rr;
 
 	rr.first = false;
+	rr.r = r;
 	rr.d = d;
 
 	/*
@@ -510,6 +511,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	struct rdtgroup *prgrp, *crgrp;
 	int cpu = smp_processor_id();
 	struct list_head *head;
+	struct rdt_resource *r;
 	struct rdt_domain *d;
 
 	mutex_lock(&rdtgroup_mutex);
@@ -517,16 +519,18 @@ void mbm_handle_overflow(struct work_struct *work)
 	if (!static_branch_likely(&rdt_mon_enable_key))
 		goto out_unlock;
 
-	d = get_domain_from_cpu(cpu, &rdt_resources_all[RDT_RESOURCE_L3]);
+	r = &rdt_resources_all[RDT_RESOURCE_L3];
+
+	d = get_domain_from_cpu(cpu, r);
 	if (!d)
 		goto out_unlock;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mbm_update(d, prgrp->mon.rmid);
+		mbm_update(r, d, prgrp->mon.rmid);
 
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
-			mbm_update(d, crgrp->mon.rmid);
+			mbm_update(r, d, crgrp->mon.rmid);
 
 		if (is_mba_sc(NULL))
 			update_mba_bw(prgrp, d);
@@ -619,6 +623,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
+	r->mbm_width = MBM_CNTR_WIDTH;
 
 	/*
 	 * A reasonable upper limit on the max threshold is the number
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6276ae0..d7cb5ab 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2472,7 +2472,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 			goto out_destroy;
 
 		if (is_mbm_event(mevt->evtid))
-			mon_event_read(&rr, d, prgrp, mevt->evtid, true);
+			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
 	}
 	kernfs_activate(kn);
 	return 0;
