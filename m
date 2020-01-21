Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A94C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C064824655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgAUUUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:20:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:7229 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgAUUUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:20:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 12:20:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="307313113"
Received: from yyu32-desk.sc.intel.com ([143.183.136.51])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2020 12:20:04 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 7/8] x86/fpu/xstate: Update copy_kernel_to_xregs_err() for XSAVES supervisor states
Date:   Tue, 21 Jan 2020 12:18:42 -0800
Message-Id: <20200121201843.12047-8-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200121201843.12047-1-yu-cheng.yu@intel.com>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function copy_kernel_to_xregs_err() uses XRSTOR, which can work with
standard or compacted format without supervisor xstates.  However, when
supervisor xstates are present, XRSTORS must be used.  Fix it by using
XRSTORS when XSAVES is enabled.

I also considered if there were additional cases where XRSTOR might be
mistakenly called instead of XRSTORS.  There are only three XRSTOR sites
in kernel:

1. copy_kernel_to_xregs_booting(), already switches between XRSTOR and
   XRSTORS based on X86_FEATURE_XSAVES.
2. copy_user_to_xregs(), which *needs* XRSTOR because it is copying from
   userspace and must never copy supervisor state with XRSTORS.
3. copy_kernel_to_xregs_err() mistakenly used XRSTOR only.  Fixed in
   this patch.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/fpu/internal.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a42fcb4b690d..42159f45bf9c 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -400,7 +400,10 @@ static inline int copy_kernel_to_xregs_err(struct xregs_state *xstate, u64 mask)
 	u32 hmask = mask >> 32;
 	int err;
 
-	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
+	if (static_cpu_has(X86_FEATURE_XSAVES))
+		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
+	else
+		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
 
 	return err;
 }
-- 
2.21.0

