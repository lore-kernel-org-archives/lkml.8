Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876F4C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC71207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgEPPKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 11:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgEPPK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 11:10:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388A7C05BD09;
        Sat, 16 May 2020 08:10:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZyS9-0000rP-Uo; Sat, 16 May 2020 17:10:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 383DB1C0493;
        Sat, 16 May 2020 17:10:17 +0200 (CEST)
Date:   Sat, 16 May 2020 15:10:17 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Update copy_kernel_to_xregs_err() for
 supervisor states
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512145444.15483-8-yu-cheng.yu@intel.com>
References: <20200512145444.15483-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158964181711.17951.16653133815092461493.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     c95473e175dd1234b7440daa6eb2670ebf529653
Gitweb:        https://git.kernel.org/tip/c95473e175dd1234b7440daa6eb2670ebf529653
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Tue, 12 May 2020 07:54:41 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 May 2020 16:46:43 +02:00

x86/fpu/xstate: Update copy_kernel_to_xregs_err() for supervisor states

The function copy_kernel_to_xregs_err() uses XRSTOR which can work with
standard or compacted format without supervisor xstates. However, when
supervisor xstates are present, XRSTORS must be used. Fix it by using
XRSTORS when supervisor state handling is enabled.

I also considered if there were additional cases where XRSTOR might be
mistakenly called instead of XRSTORS.  There are only three XRSTOR sites
in the kernel:

1. copy_kernel_to_xregs_booting(), already switches between XRSTOR and
   XRSTORS based on X86_FEATURE_XSAVES.

2. copy_user_to_xregs(), which *needs* XRSTOR because it is copying from
   userspace and must never copy supervisor state with XRSTORS.

3. copy_kernel_to_xregs_err() mistakenly used XRSTOR only.  Fix it.

 [ bp: Massage commit message. ]

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20200512145444.15483-8-yu-cheng.yu@intel.com
---
 arch/x86/include/asm/fpu/internal.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a42fcb4..42159f4 100644
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
