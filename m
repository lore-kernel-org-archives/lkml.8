Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E14C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCAE420786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgGHQkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:40:13 -0400
Received: from foss.arm.com ([217.140.110.172]:51246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730630AbgGHQkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:40:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8F711B3;
        Wed,  8 Jul 2020 09:40:08 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A62783F68F;
        Wed,  8 Jul 2020 09:40:06 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v5 04/10] x86/resctrl: use container_of() in delayed_work handlers
Date:   Wed,  8 Jul 2020 16:39:23 +0000
Message-Id: <20200708163929.2783-5-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708163929.2783-1-james.morse@arm.com>
References: <20200708163929.2783-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mbm_handle_overflow() and cqm_handle_limbo() are both provided with
the domain's work_struct when called, but use get_domain_from_cpu()
to find the domain, along with the appropriate error handling.

container_of() saves some list walking and bitmap testing, use that
instead.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d6b92d7487a7..54dffe574e67 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -477,19 +477,13 @@ void cqm_handle_limbo(struct work_struct *work)
 	mutex_lock(&rdtgroup_mutex);
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3];
-	d = get_domain_from_cpu(cpu, r);
-
-	if (!d) {
-		pr_warn_once("Failure to get domain for limbo worker\n");
-		goto out_unlock;
-	}
+	d = container_of(work, struct rdt_domain, cqm_limbo.work);
 
 	__check_limbo(d, false);
 
 	if (has_busy_rmid(r, d))
 		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
 
-out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
@@ -519,10 +513,7 @@ void mbm_handle_overflow(struct work_struct *work)
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3];
-
-	d = get_domain_from_cpu(cpu, r);
-	if (!d)
-		goto out_unlock;
+	d = container_of(work, struct rdt_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mbm_update(r, d, prgrp->mon.rmid);
-- 
2.20.1

