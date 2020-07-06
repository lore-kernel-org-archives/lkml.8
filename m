Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB4AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC939206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594053507;
	bh=DgfkZ+s9nn+knasLNVmiO1p9yI0I/xouSYVyonb87rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DaTmybNl664qGPxtibK8ZoafhS7P106DmtWf0Zqm8p5w1pKO/XUiw0lUNDgo1rwKx
	 00KPML/NmEMSgz59XwyWJBdpmJkVs34KGJpjhjK6Dli2b9dy0aJGsyJIfYPpbY2m1S
	 DBAEZ4/z+4xsHxAAC2YACG+9VuvN0PZQQZMOQBfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgGFQi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbgGFQiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:38:24 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB2A320773;
        Mon,  6 Jul 2020 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594053503;
        bh=DgfkZ+s9nn+knasLNVmiO1p9yI0I/xouSYVyonb87rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KylFXHDt8y4aoO1gjMNDg3Kzz9zSbWgw0JJQ7R6wfE3H3mK/ixyljou5QS/IA5k5K
         NB+VtXgDw0G22MqZpqOvaGBdpzaxIy0XBTT+u8VEUSTMoxM40h/z1KAR2Dj/hh184P
         Vl2n7VP15zIpV5D3lh/rnZWeJXspUiOWP0ClJm18=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jsU8M-009VkI-8s; Mon, 06 Jul 2020 17:38:22 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH v2 4/4] arm64: Rework ARM_ERRATUM_1414080 handling
Date:   Mon,  6 Jul 2020 17:38:02 +0100
Message-Id: <20200706163802.1836732-5-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706163802.1836732-1-maz@kernel.org>
References: <20200706163802.1836732-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, catalin.marinas@arm.com, daniel.lezcano@linaro.org, vincenzo.frascino@arm.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current handling of erratum 1414080 has the side effect that
cntkctl_el1 can get changed for both 32 and 64bit tasks.

This isn't a problem so far, but if we ever need to mitigate another
of these errata on the 64bit side, we'd better keep the messing with
cntkctl_el1 local to 32bit tasks.

For that, make sure that on entering the kernel from a 32bit tasks,
userspace access to cntvct gets enabled, and disabled returning to
userspace, while it never gets changed for 64bit tasks.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/entry.S | 40 +++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 5304d193c79d..8f51f3273bc7 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -167,6 +167,19 @@ alternative_cb_end
 	stp	x28, x29, [sp, #16 * 14]
 
 	.if	\el == 0
+	.if	\regsize == 32
+	// If we come back from a 32bit task on a system affected by
+	// 1418040, let's reenable userspace access to the virtual counter.
+#ifdef CONFIG_ARM64_ERRATUM_1418040
+alternative_if_not ARM64_WORKAROUND_1418040
+	b	.L__entry_skip_wa_1418040\@
+alternative_else_nop_endif
+	mrs	x0, cntkctl_el1
+	orr	x0, x0, #2	// ARCH_TIMER_USR_VCT_ACCESS_EN
+	msr	cntkctl_el1, x0
+.L__entry_skip_wa_1418040\@:
+#endif
+	.endif
 	clear_gp_regs
 	mrs	x21, sp_el0
 	ldr_this_cpu	tsk, __entry_task, x20
@@ -318,7 +331,17 @@ alternative_else_nop_endif
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	msr	sp_el0, x23
 	tst	x22, #PSR_MODE32_BIT		// native task?
-	b.eq	3f
+	b.eq	4f
+
+#ifdef CONFIG_ARM64_ERRATUM_1418040
+alternative_if_not ARM64_WORKAROUND_1418040
+	b	3f
+alternative_else_nop_endif
+	mrs	x1, cntkctl_el1
+	bic	x1, x1, #2			// ARCH_TIMER_USR_VCT_ACCESS_EN
+	msr	cntkctl_el1, x1
+3:
+#endif
 
 #ifdef CONFIG_ARM64_ERRATUM_845719
 alternative_if ARM64_WORKAROUND_845719
@@ -330,22 +353,7 @@ alternative_if ARM64_WORKAROUND_845719
 #endif
 alternative_else_nop_endif
 #endif
-3:
-#ifdef CONFIG_ARM64_ERRATUM_1418040
-alternative_if_not ARM64_WORKAROUND_1418040
-	b	4f
-alternative_else_nop_endif
-	/*
-	 * if (x22.mode32 == cntkctl_el1.el0vcten)
-	 *     cntkctl_el1.el0vcten = ~cntkctl_el1.el0vcten
-	 */
-	mrs	x1, cntkctl_el1
-	eon	x0, x1, x22, lsr #3
-	tbz	x0, #1, 4f
-	eor	x1, x1, #2	// ARCH_TIMER_USR_VCT_ACCESS_EN
-	msr	cntkctl_el1, x1
 4:
-#endif
 	scs_save tsk, x0
 
 	/* No kernel C function calls after this as user keys are set. */
-- 
2.27.0

