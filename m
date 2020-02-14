Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB05C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766892086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394890AbgBNSYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:24:50 -0500
Received: from foss.arm.com ([217.140.110.172]:43270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405540AbgBNSYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:24:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A87A1113E;
        Fri, 14 Feb 2020 10:24:43 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 598F03F68E;
        Fri, 14 Feb 2020 10:24:42 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 04/10] x86/resctrl: use container_of() in delayed_work handlers
Date:   Fri, 14 Feb 2020 18:23:55 +0000
Message-Id: <20200214182401.39008-5-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214182401.39008-1-james.morse@arm.com>
References: <20200214182401.39008-1-james.morse@arm.com>
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
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index af549df38ec6..a02a7f886a0a 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -476,19 +476,13 @@ void cqm_handle_limbo(struct work_struct *work)
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
 
@@ -516,9 +510,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	if (!static_branch_likely(&rdt_mon_enable_key))
 		goto out_unlock;
 
-	d = get_domain_from_cpu(cpu, &rdt_resources_all[RDT_RESOURCE_L3]);
-	if (!d)
-		goto out_unlock;
+	d = container_of(work, struct rdt_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mbm_update(d, prgrp->mon.rmid);
-- 
2.24.1

