Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9D5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A05C20709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgEPPKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgEPPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 11:10:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7747C05BD09;
        Sat, 16 May 2020 08:10:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZySD-0000sF-6V; Sat, 16 May 2020 17:10:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A78281C0440;
        Sat, 16 May 2020 17:10:19 +0200 (CEST)
Date:   Sat, 16 May 2020 15:10:19 -0000
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Rename validate_xstate_header() to
 validate_user_xstate_header()
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512145444.15483-2-yu-cheng.yu@intel.com>
References: <20200512145444.15483-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158964181958.17951.3167904104306469285.tip-bot2@tip-bot2>
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

Commit-ID:     5274e6c172c47241534e970df26a522497086624
Gitweb:        https://git.kernel.org/tip/5274e6c172c47241534e970df26a522497086624
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 12 May 2020 07:54:35 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 12 May 2020 20:20:32 +02:00

x86/fpu/xstate: Rename validate_xstate_header() to validate_user_xstate_header()

The function validate_xstate_header() validates an xstate header coming
from userspace (PTRACE or sigreturn). To make it clear, rename it to
validate_user_xstate_header().

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200512145444.15483-2-yu-cheng.yu@intel.com
---
 arch/x86/include/asm/fpu/xstate.h | 2 +-
 arch/x86/kernel/fpu/regset.c      | 2 +-
 arch/x86/kernel/fpu/signal.c      | 2 +-
 arch/x86/kernel/fpu/xstate.c      | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index c6136d7..fc4db51 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -56,6 +56,6 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-extern int validate_xstate_header(const struct xstate_header *hdr);
+int validate_user_xstate_header(const struct xstate_header *hdr);
 
 #endif
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index d652b93..bd1d064 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -139,7 +139,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	} else {
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xsave, 0, -1);
 		if (!ret)
-			ret = validate_xstate_header(&xsave->header);
+			ret = validate_user_xstate_header(&xsave->header);
 	}
 
 	/*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 400a05e..585e365 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -366,7 +366,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			ret = __copy_from_user(&fpu->state.xsave, buf_fx, state_size);
 
 			if (!ret && state_size > offsetof(struct xregs_state, header))
-				ret = validate_xstate_header(&fpu->state.xsave.header);
+				ret = validate_user_xstate_header(&fpu->state.xsave.header);
 		}
 		if (ret)
 			goto err_out;
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 32b153d..8ed6439 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -472,7 +472,7 @@ int using_compacted_format(void)
 }
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_xstate_header(const struct xstate_header *hdr)
+int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
 	if (hdr->xfeatures & (~xfeatures_mask | XFEATURE_MASK_SUPERVISOR))
@@ -1147,7 +1147,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 
 	memcpy(&hdr, kbuf + offset, size);
 
-	if (validate_xstate_header(&hdr))
+	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
 	for (i = 0; i < XFEATURE_MAX; i++) {
@@ -1201,7 +1201,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	if (__copy_from_user(&hdr, ubuf + offset, size))
 		return -EFAULT;
 
-	if (validate_xstate_header(&hdr))
+	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
 	for (i = 0; i < XFEATURE_MAX; i++) {
