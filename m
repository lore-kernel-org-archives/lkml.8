Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0D1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05EA72311B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QfqsPOEO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7/PjSq2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgHFRML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:12:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58930 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbgHFRKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:08 -0400
Date:   Thu, 06 Aug 2020 17:10:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWuB12Tkvbyicpk4HqqE975tqqLrqqA2GtHdwKepYjo=;
        b=QfqsPOEOuq/aq1ITtHegz8YmBFGYtHXcdBiGvmxqSHZaBmarzUZIbpnAFvOGFy+0pvSub3
        T41thEACUaWHusglQP5Ru94L7ZGf7N6nHWL0y2vnfB44fuxOPUXVl1pQNb1VV8jbQHqWUi
        z912oEu1DkPBqJfmxnLfoq3+FDYixIcarxGLW9UhrNofDL72ITfSrMIohqZf2Wgqi9RiHa
        9iPhYX4hoH+l7ccJp7uRquqSP9s4OyR3TKYx68YV4lZOnFekDbjnte+rtoKyfVyD47ntv2
        hNQHgXpBBrkrCEzWK/lz56oEsKUXaQ1qOfXwk8PK1N7h/zrIuSPSEXhlJsxnSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWuB12Tkvbyicpk4HqqE975tqqLrqqA2GtHdwKepYjo=;
        b=7/PjSq2q2reY32Iav6+xO/yFy4EUiO2rLi0gqFiz+rYhr0mbg8MN1qYs1q8Z77StQnjCtb
        EuOtYvmz71qI4SDw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu/xstate: Fix an xstate size check warning
 with architectural LBRs
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1595253051-75374-1-git-send-email-kan.liang@linux.intel.com>
References: <1595253051-75374-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159673380407.3192.2479353729110712986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ec8602b79088b0f3556d9c7a3a05313bc4e4a96f
Gitweb:        https://git.kernel.org/tip/ec8602b79088b0f3556d9c7a3a05313bc4e4a96f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 20 Jul 2020 06:50:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 17:11:59 +02:00

x86/fpu/xstate: Fix an xstate size check warning with architectural LBRs

An xstate size check warning is triggered on machines which support
Architectural LBRs.

    XSAVE consistency problem, dumping leaves
    WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:649 fpu__init_system_xstate+0x4d4/0xd0e
    Modules linked in:
    CPU: 0 PID: 0 Comm: swapper Not tainted intel-arch_lbr+
    RIP: 0010:fpu__init_system_xstate+0x4d4/0xd0e

The xstate size check routine, init_xstate_size(), compares the size
retrieved from the hardware with the size of task->fpu, which is
calculated by the software.

The size from the hardware is the total size of the enabled xstates in
XCR0 | IA32_XSS. Architectural LBR state is a dynamic supervisor
feature, which sets the corresponding bit in the IA32_XSS at boot time.
The size from the hardware includes the size of the Architectural LBR
state.

However, a dynamic supervisor feature doesn't allocate a buffer in the
task->fpu. The size of task->fpu doesn't include the size of the
Architectural LBR state. The mismatch will trigger the warning.

Three options as below were considered to fix the issue:

- Correct the size from the hardware by subtracting the size of the
  dynamic supervisor features.
  The purpose of the check is to compare the size CPU told with the size
  of the XSAVE buffer, which is calculated by the software. If the
  software mucks with the number from hardware, it removes the value of
  the check.
  This option is not a good option.

- Prevent the hardware from counting the size of the dynamic supervisor
  feature by temporarily removing the corresponding bits in IA32_XSS.
  Two extra MSR writes are required to flip the IA32_XSS. The option is
  not pretty, but it is workable. The check is only called once at early
  boot time. The synchronization or context-switching doesn't need to be
  worried.
  This option is implemented here.

- Remove the check entirely, because the check hasn't found any real
  problems. The option may be an alternative as option 2.
  This option is not implemented here.

Add a new function, get_xsaves_size_no_dynamic(), which retrieves the
total size without the dynamic supervisor features from the hardware.
The size will be used to compare with the size of task->fpu.

Fixes: f0dccc9da4c0 ("x86/fpu/xstate: Support dynamic supervisor feature for LBR")
Reported-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/r/1595253051-75374-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/kernel/fpu/xstate.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index be2a68a..6073e34 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -611,6 +611,10 @@ static void check_xstate_against_struct(int nr)
  * This essentially double-checks what the cpu told us about
  * how large the XSAVE buffer needs to be.  We are recalculating
  * it to be safe.
+ *
+ * Dynamic XSAVE features allocate their own buffers and are not
+ * covered by these checks. Only the size of the buffer for task->fpu
+ * is checked here.
  */
 static void do_extra_xstate_size_checks(void)
 {
@@ -673,6 +677,33 @@ static unsigned int __init get_xsaves_size(void)
 	return ebx;
 }
 
+/*
+ * Get the total size of the enabled xstates without the dynamic supervisor
+ * features.
+ */
+static unsigned int __init get_xsaves_size_no_dynamic(void)
+{
+	u64 mask = xfeatures_mask_dynamic();
+	unsigned int size;
+
+	if (!mask)
+		return get_xsaves_size();
+
+	/* Disable dynamic features. */
+	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
+
+	/*
+	 * Ask the hardware what size is required of the buffer.
+	 * This is the size required for the task->fpu buffer.
+	 */
+	size = get_xsaves_size();
+
+	/* Re-enable dynamic features so XSAVES will work on them again. */
+	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
+
+	return size;
+}
+
 static unsigned int __init get_xsave_size(void)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -710,7 +741,7 @@ static int __init init_xstate_size(void)
 	xsave_size = get_xsave_size();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		possible_xstate_size = get_xsaves_size();
+		possible_xstate_size = get_xsaves_size_no_dynamic();
 	else
 		possible_xstate_size = xsave_size;
 
