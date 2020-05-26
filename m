Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3262C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11E52084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbgEZNlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:41:32 -0400
Received: from foss.arm.com ([217.140.110.172]:51050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389022AbgEZNl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:41:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB5F1FB;
        Tue, 26 May 2020 06:41:25 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4691B3F6C4;
        Tue, 26 May 2020 06:41:24 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v4 08/10] x86/resctrl: Merge AMD/Intel parse_bw() calls
Date:   Tue, 26 May 2020 14:40:57 +0100
Message-Id: <20200526134059.1690-9-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200526134059.1690-1-james.morse@arm.com>
References: <20200526134059.1690-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've explained arch_needs_linear to resctrl, the parse_bw()
calls are almost the same between AMD and Intel.

The difference is '!is_mba_sc()', which is not checked on AMD. This
will always be true on AMD CPUs as mba_sc cannot be enabled as
is_mba_linear() is false.

Removing this duplication means user-space visible behaviour and
error messages are not validated or generated in different places.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by : Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        |  3 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 57 +----------------------
 arch/x86/kernel/cpu/resctrl/internal.h    |  6 +--
 3 files changed, 5 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c6b73b0ee070..223e5b90bcfd 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -168,6 +168,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.name			= "MB",
 		.domains		= domain_init(RDT_RESOURCE_MBA),
 		.cache_level		= 3,
+		.parse_ctrlval		= parse_bw,
 		.format_str		= "%d=%*u",
 		.fflags			= RFTYPE_RES_MB,
 	},
@@ -926,7 +927,6 @@ static __init void rdt_init_res_defs_intel(void)
 		else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
 			r->msr_update = mba_wrmsr_intel;
-			r->parse_ctrlval = parse_bw_intel;
 		}
 	}
 }
@@ -946,7 +946,6 @@ static __init void rdt_init_res_defs_amd(void)
 		else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_BW_BASE;
 			r->msr_update = mba_wrmsr_amd;
-			r->parse_ctrlval = parse_bw_amd;
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index e3bcd77add2b..b0e24cb6f85c 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -21,59 +21,6 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-/*
- * Check whether MBA bandwidth percentage value is correct. The value is
- * checked against the minimum and maximum bandwidth values specified by
- * the hardware. The allocated bandwidth percentage is rounded to the next
- * control step available on the hardware.
- */
-static bool bw_validate_amd(char *buf, unsigned long *data,
-			    struct rdt_resource *r)
-{
-	unsigned long bw;
-	int ret;
-
-	/* temporary: always false on AMD */
-	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
-		rdt_last_cmd_puts("No support for non-linear MB domains\n");
-		return false;
-	}
-
-	ret = kstrtoul(buf, 10, &bw);
-	if (ret) {
-		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
-		return false;
-	}
-
-	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
-		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
-				    r->membw.min_bw, r->default_ctrl);
-		return false;
-	}
-
-	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
-	return true;
-}
-
-int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
-		 struct rdt_domain *d)
-{
-	unsigned long bw_val;
-
-	if (d->have_new_ctrl) {
-		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
-		return -EINVAL;
-	}
-
-	if (!bw_validate_amd(data->buf, &bw_val, r))
-		return -EINVAL;
-
-	d->new_ctrl = bw_val;
-	d->have_new_ctrl = true;
-
-	return 0;
-}
-
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
@@ -110,8 +57,8 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
-		   struct rdt_domain *d)
+int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+	     struct rdt_domain *d)
 {
 	unsigned long bw_val;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index cc72ba415c3d..242cbdb8f2df 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -470,10 +470,8 @@ struct rdt_resource {
 
 int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	      struct rdt_domain *d);
-int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
-		   struct rdt_domain *d);
-int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
-		 struct rdt_domain *d);
+int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+	     struct rdt_domain *d);
 
 extern struct mutex rdtgroup_mutex;
 
-- 
2.19.1

