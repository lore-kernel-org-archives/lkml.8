Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8FCC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32D320772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbgDARv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:51:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:55330 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgDARv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:51:27 -0400
IronPort-SDR: FD4ocxqnE2HyBSbxIzY0KyKs3zFYUTounFIxP2GJj1Bht4c4RYDlhqTr/uZgPGj1tiszEOsY2D
 gsrSUMoWG+aQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 10:51:25 -0700
IronPort-SDR: hDh1jTOH5xpm107LcPPm3AmHZIsPCP0kJpXQTFixq/va4dHDSNUKl6nSb9LLKb7NGRFef/8fqv
 tos6sOAamakg==
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="422809394"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 10:51:25 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 2/2] x86/resctrl: Support CPUID enumeration of MBM counter width
Date:   Wed,  1 Apr 2020 10:51:02 -0700
Message-Id: <76dc65631c373e0c1c9f3e8aaa768f022a2c989c.1585763047.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1585763047.git.reinette.chatre@intel.com>
References: <cover.1585763047.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original Memory Bandwidth Monitoring (MBM) architectural
definition defines counters of up to 62 bits in the
IA32_QM_CTR MSR while the first-generation MBM implementation
uses statically defined 24 bit counters.

Expand the MBM CPUID enumeration properties to include the MBM
counter width. The previously unused EAX output register contains,
in bits [7:0], the MBM counter width encoded as an offset from
24 bits. Enumerating this property is only specified for Intel
CPUs. A vendor check is added to ensure original behavior is
maintained for AMD CPUs.

While eight bits are available for the counter width offset
IA32_QM_CTR MSR only supports 62 bit counters. A sanity check,
with warning printed when encountered, is added to ensure counters
cannot exceed the 62 bit limit.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

---
Dear Maintainers,

Because of the need for a vendor check there seems to be a few ways
in which enumerating this new MBM property can be implemented. While
this implementation seems to be the simplest it does introduce an
explicit vendor check into arch/x86/kernel/cpu/common.c where there
does not seem to be a precedent for such a change.

The goal is to support this correctly and I look forward to your
guidance on how the enable this feature correctly.

Regards,

Reinette

 arch/x86/include/asm/processor.h       | 1 +
 arch/x86/kernel/cpu/common.c           | 5 +++++
 arch/x86/kernel/cpu/resctrl/internal.h | 8 +++++++-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 8 +++++++-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 09705ccc393c..69d957486f25 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -115,6 +115,7 @@ struct cpuinfo_x86 {
 	/* Cache QoS architectural values: */
 	int			x86_cache_max_rmid;	/* max index */
 	int			x86_cache_occ_scale;	/* scale to bytes */
+	int			x86_cache_mbm_width_offset;
 	int			x86_power;
 	unsigned long		loops_per_jiffy;
 	/* cpuid returned max cores value: */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4cdb123ff66a..8552d2fadc15 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -856,6 +856,8 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 
 static void init_cqm(struct cpuinfo_x86 *c)
 {
+	c->x86_cache_mbm_width_offset = -1;
+
 	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
 		c->x86_cache_max_rmid  = -1;
 		c->x86_cache_occ_scale = -1;
@@ -875,6 +877,9 @@ static void init_cqm(struct cpuinfo_x86 *c)
 
 		c->x86_cache_max_rmid  = ecx;
 		c->x86_cache_occ_scale = ebx;
+		/* EAX contents is only defined for Intel CPUs */
+		if (c->x86_vendor == X86_VENDOR_INTEL)
+			c->x86_cache_mbm_width_offset = eax & 0xff;
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 28947c790faa..3a16d1c0ff40 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -31,7 +31,7 @@
 
 #define CQM_LIMBOCHECK_INTERVAL	1000
 
-#define MBM_CNTR_WIDTH			24
+#define MBM_CNTR_WIDTH_BASE		24
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
@@ -40,6 +40,12 @@
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
+/*
+ * With the above fields in use 62 bits remain in MSR_IA32_QM_CTR for
+ * data to be returned. The counter width is discovered from the hardware
+ * as an offset from MBM_CNTR_WIDTH_BASE.
+ */
+#define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
 
 
 struct rdt_fs_context {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index df964c03f6c6..837d7d012b7b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -618,12 +618,18 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 
 int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
+	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	unsigned int cl_size = boot_cpu_data.x86_cache_size;
 	int ret;
 
 	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
-	r->mbm_width = MBM_CNTR_WIDTH;
+	r->mbm_width = MBM_CNTR_WIDTH_BASE;
+
+	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
+		r->mbm_width += mbm_offset;
+	else if (mbm_offset > MBM_CNTR_WIDTH_OFFSET_MAX)
+		pr_warn("Ignoring impossible MBM counter offset\n");
 
 	/*
 	 * A reasonable upper limit on the max threshold is the number
-- 
2.21.0

