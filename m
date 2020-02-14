Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE75BC3B1B9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2682086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394954AbgBNSY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:24:57 -0500
Received: from foss.arm.com ([217.140.110.172]:43326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389038AbgBNSYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:24:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09B1D106F;
        Fri, 14 Feb 2020 10:24:50 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF8713F68E;
        Fri, 14 Feb 2020 10:24:48 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 07/10] x86/resctrl: Add arch_needs_linear to explain AMD/Intel MBA difference
Date:   Fri, 14 Feb 2020 18:23:58 +0000
Message-Id: <20200214182401.39008-8-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214182401.39008-1-james.morse@arm.com>
References: <20200214182401.39008-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The configuration values user-space provides to the resctrl filesystem
are ABI. To make this work on another architecture we want to move all
the ABI bits out of /arch/x86 and under /fs.

To do this, the differences between AMD and Intel CPUs needs to be
explained to resctrl via resource properties, instead of function
pointers that let the arch code accept subtly different values on
different platforms/architectures.

For MBA, Intel CPUs reject configuration attempts for non-linear
resources, whereas AMD ignore this field as its MBA resource is never
linear. To merge the parse/validate functions we need to explain
this difference.

Add arch_needs_linear to indicate the arch code needs the linear
property to be true to configure this resource. AMD can set this
and delay_linear to false. Intel can set arch_needs_linear
to true to keep the existing "No support for non-linear MB domains"
error message for affected platforms.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        | 3 +++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 8 +++++++-
 arch/x86/kernel/cpu/resctrl/internal.h    | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7d295ae620bb..f022dc823c53 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -260,6 +260,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	r->num_closid = edx.split.cos_max + 1;
 	max_delay = eax.split.max_delay + 1;
 	r->default_ctrl = MAX_MBA_BW;
+	r->membw.arch_needs_linear = true;
 	if (ecx & MBA_IS_LINEAR) {
 		r->membw.delay_linear = true;
 		r->membw.min_bw = MAX_MBA_BW - max_delay;
@@ -267,6 +268,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	} else {
 		if (!rdt_get_mb_table(r))
 			return false;
+		r->membw.arch_needs_linear = false;
 	}
 	r->data_width = 3;
 
@@ -288,6 +290,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
+	r->membw.arch_needs_linear = false;
 
 	r->membw.min_bw = 0;
 	r->membw.bw_gran = 1;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 055c8613b531..db8e6c0cadb1 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -33,6 +33,12 @@ static bool bw_validate_amd(char *buf, unsigned long *data,
 	unsigned long bw;
 	int ret;
 
+	/* temporary: always false on AMD */
+	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
+		rdt_last_cmd_puts("No support for non-linear MB domains\n");
+		return false;
+	}
+
 	ret = kstrtoul(buf, 10, &bw);
 	if (ret) {
 		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
@@ -82,7 +88,7 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	/*
 	 * Only linear delay values is supported for current Intel SKUs.
 	 */
-	if (!r->membw.delay_linear) {
+	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
 		rdt_last_cmd_puts("No support for non-linear MB domains\n");
 		return false;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3e3ba85843c4..1fa692c54e15 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -363,6 +363,7 @@ struct rdt_cache {
  * struct rdt_membw - Memory bandwidth allocation related data
  * @min_bw:		Minimum memory bandwidth percentage user can request
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
+ * @arch_needs_linear:  True if we can't configure non-linear resources
  * @delay_linear:	True if memory B/W delay is in linear scale
  * @mba_sc:		True if MBA software controller(mba_sc) is enabled
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
@@ -371,6 +372,7 @@ struct rdt_membw {
 	u32		min_bw;
 	u32		bw_gran;
 	u32		delay_linear;
+	bool		arch_needs_linear;
 	bool		mba_sc;
 	u32		*mb_map;
 };
-- 
2.24.1

