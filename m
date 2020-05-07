Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2075C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0062082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgEGP6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:58:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:33248 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgEGP6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:58:15 -0400
IronPort-SDR: 8ZNZfHpNyQk9cxLl51mxR5d+FzwiJFETorbkOhr4ASUDM5L7pu5mx/sW2nq8yM4Menj8Gb5SxD
 3jFixHdRnAiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 08:58:14 -0700
IronPort-SDR: DKvZ4Y0WgUj+jR3xUIP422g2bmkjshteb4SkyARNZKL0Quu5rjeQkDchpgfiS12QyN/4Nqsnat
 ELe7RVZCn1xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="249326305"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga007.jf.intel.com with ESMTP; 07 May 2020 08:58:14 -0700
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
Subject: [PATCH v3 07/10] x86/fpu/xstate: Update copy_kernel_to_xregs_err() for XSAVES supervisor states
Date:   Thu,  7 May 2020 08:58:16 -0700
Message-Id: <20200507155816.26059-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200328164307.17497-8-yu-cheng.yu@intel.com>
References: <20200328164307.17497-8-yu-cheng.yu@intel.com>
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
3. copy_kernel_to_xregs_err() mistakenly used XRSTOR only.  Fixed it.

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

