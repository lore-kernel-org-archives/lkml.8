Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880B2C2D0F2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C50A21D79
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgC3UiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:38:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:58520 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgC3UiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:38:04 -0400
IronPort-SDR: VnGpjThGL5JwfsyaNhsrFPOBCI5r60uTcImYnRl3+aF7wpEew3OYFEFz01MFprQJ6QiqEgW8qv
 GNG+psn/dtyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 13:38:04 -0700
IronPort-SDR: CSSoTcScmVyPfUPOOfY3YTLN4JfQ2LiwNlB2QAn9UO0ffbWgKcWZRt0i4Q2gqsAMKLfRElPSQA
 soFSCKE/xZRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="242143905"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2020 13:38:03 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 7/7] x86/process: Clear PASID state for a newly forked/cloned thread
Date:   Mon, 30 Mar 2020 12:33:08 -0700
Message-Id: <1585596788-193989-8-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PASID state has to be cleared on forks, since the child has a
different address space. The PASID is also cleared for thread clone. While
it would be correct to inherit the PASID in this case, it is unknown
whether the new task will use ENQCMD. Giving it the PASID "just in case"
would have the downside of increased context switch overhead to setting
the PASID MSR.

Since #GP faults have to be handled on any threads that were created before
the PASID was assigned to the mm of the process, newly created threads
might as well be treated in a consistent way.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/process.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 87de18c64cf5..cefdc8f7fc13 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -122,6 +122,16 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
 		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
 }
 
+/* Clear PASID MSR/state for the forked/cloned thread. */
+static void clear_task_pasid(struct task_struct *task)
+{
+	/*
+	 * Clear the xfeatures bit in the PASID state so that the MSR will be
+	 * initialized to its init state (0) by XRSTORS.
+	 */
+	task->thread.fpu.state.xsave.header.xfeatures &= ~XFEATURE_MASK_PASID;
+}
+
 int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 		    unsigned long arg, struct task_struct *p, unsigned long tls)
 {
@@ -175,6 +185,9 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
+	if (static_cpu_has(X86_FEATURE_ENQCMD))
+		clear_task_pasid(p);
+
 	/* Set a new TLS for the child thread? */
 	if (clone_flags & CLONE_SETTLS)
 		ret = set_new_tls(p, tls);
-- 
2.19.1

