Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C74C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FC7208A9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbgEZNlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:41:15 -0400
Received: from foss.arm.com ([217.140.110.172]:50928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388887AbgEZNlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:41:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E6C4101E;
        Tue, 26 May 2020 06:41:12 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE0D43F6C4;
        Tue, 26 May 2020 06:41:10 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v4 02/10] x86/resctrl: Remove max_delay
Date:   Tue, 26 May 2020 14:40:51 +0100
Message-Id: <20200526134059.1690-3-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200526134059.1690-1-james.morse@arm.com>
References: <20200526134059.1690-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max_delay is used by x86's __get_mem_config_intel() as a local variable.
Remove it, replacing it with a local variable.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 8 ++++----
 arch/x86/kernel/cpu/resctrl/internal.h | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 12f967c6b603..e1fed3928b59 100644
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
index 1bb81cbdad5f..dd51e23e346b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -368,8 +368,6 @@ struct rdt_cache {
 
 /**
  * struct rdt_membw - Memory bandwidth allocation related data
- * @max_delay:		Max throttle delay. Delay is the hardware
- *			representation for memory bandwidth.
  * @min_bw:		Minimum memory bandwidth percentage user can request
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
@@ -377,7 +375,6 @@ struct rdt_cache {
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
  */
 struct rdt_membw {
-	u32		max_delay;
 	u32		min_bw;
 	u32		bw_gran;
 	u32		delay_linear;
-- 
2.19.1

