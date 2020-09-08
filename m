Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB48DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882E6206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbgIHR4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:56:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:15879 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731222AbgIHRza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:55:30 -0400
IronPort-SDR: rGv7BcOiLMt6h83qndJHvR600Yj8FvvQBe5fNOTTW+G1RxECr34TEQyvNqFZNa7ly/HYCzoI/s
 i4ZlIoV8Jv/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="176252048"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="176252048"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:27 -0700
IronPort-SDR: 3lVLJ6Fr9VYHdfjBmUke2txwCLQ2s1xCK08IQZJlnMccjS8+A0wiBZHq3P0aAi01xmck9/fObr
 WcvSqrZI5gPg==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="480125748"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:26 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] x86/mce: Stop mce_reign() from re-computing severity for every CPU
Date:   Tue,  8 Sep 2020 10:55:12 -0700
Message-Id: <20200908175519.14223-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200908175519.14223-1-tony.luck@intel.com>
References: <20200908175519.14223-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in:

commit 20d51a426fe9 ("x86/mce: Reuse one of the u16 padding fields in 'struct mce'")

a field was added to "struct mce" to save the computed error severity.

Make use of this in mce_reign() to avoid re-computing the severity
for every CPU.

In the case where we panic, we do still need one call to mce_severity to
provide the correct message giving the reason for the panic.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f43a78bde670..fb6b5f64f7e6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -872,7 +872,6 @@ static void mce_reign(void)
 	struct mce *m = NULL;
 	int global_worst = 0;
 	char *msg = NULL;
-	char *nmsg = NULL;
 
 	/*
 	 * This CPU is the Monarch and the other CPUs have run
@@ -880,12 +879,10 @@ static void mce_reign(void)
 	 * Grade the severity of the errors of all the CPUs.
 	 */
 	for_each_possible_cpu(cpu) {
-		int severity = mce_severity(&per_cpu(mces_seen, cpu),
-					    mca_cfg.tolerant,
-					    &nmsg, true);
-		if (severity > global_worst) {
-			msg = nmsg;
-			global_worst = severity;
+		struct mce *mtmp = &per_cpu(mces_seen, cpu);
+
+		if (mtmp->severity > global_worst) {
+			global_worst = mtmp->severity;
 			m = &per_cpu(mces_seen, cpu);
 		}
 	}
@@ -895,8 +892,11 @@ static void mce_reign(void)
 	 * This dumps all the mces in the log buffer and stops the
 	 * other CPUs.
 	 */
-	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3)
+	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
+		/* call mce_severity() to get "msg" for panic */
+		mce_severity(m, mca_cfg.tolerant, &msg, true);
 		mce_panic("Fatal machine check", m, msg);
+	}
 
 	/*
 	 * For UC somewhere we let the CPU who detects it handle it.
-- 
2.21.1

