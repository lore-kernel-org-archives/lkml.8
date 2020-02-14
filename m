Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6061C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49972086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405542AbgBNSYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:24:44 -0500
Received: from foss.arm.com ([217.140.110.172]:43234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405530AbgBNSYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:24:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F24B101E;
        Fri, 14 Feb 2020 10:24:39 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3DA03F68E;
        Fri, 14 Feb 2020 10:24:37 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 02/10] x86/resctrl: Remove max_delay
Date:   Fri, 14 Feb 2020 18:23:53 +0000
Message-Id: <20200214182401.39008-3-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214182401.39008-1-james.morse@arm.com>
References: <20200214182401.39008-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max_delay is used by x86's rdt_get_mem_config() as a local variable.
Remove it, replacing it with a local variable.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 8 ++++----
 arch/x86/kernel/cpu/resctrl/internal.h | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 89049b343c7a..7d295ae620bb 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -254,16 +254,16 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 {
 	union cpuid_0x10_3_eax eax;
 	union cpuid_0x10_x_edx edx;
-	u32 ebx, ecx;
+	u32 ebx, ecx, max_delay;
 
 	cpuid_count(0x00000010, 3, &eax.full, &ebx, &ecx, &edx.full);
 	r->num_closid = edx.split.cos_max + 1;
-	r->membw.max_delay = eax.split.max_delay + 1;
+	max_delay = eax.split.max_delay + 1;
 	r->default_ctrl = MAX_MBA_BW;
 	if (ecx & MBA_IS_LINEAR) {
 		r->membw.delay_linear = true;
-		r->membw.min_bw = MAX_MBA_BW - r->membw.max_delay;
-		r->membw.bw_gran = MAX_MBA_BW - r->membw.max_delay;
+		r->membw.min_bw = MAX_MBA_BW - max_delay;
+		r->membw.bw_gran = MAX_MBA_BW - max_delay;
 	} else {
 		if (!rdt_get_mb_table(r))
 			return false;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 90ca6a090c77..3e3ba85843c4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -361,8 +361,6 @@ struct rdt_cache {
 
 /**
  * struct rdt_membw - Memory bandwidth allocation related data
- * @max_delay:		Max throttle delay. Delay is the hardware
- *			representation for memory bandwidth.
  * @min_bw:		Minimum memory bandwidth percentage user can request
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
@@ -370,7 +368,6 @@ struct rdt_cache {
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
  */
 struct rdt_membw {
-	u32		max_delay;
 	u32		min_bw;
 	u32		bw_gran;
 	u32		delay_linear;
-- 
2.24.1

