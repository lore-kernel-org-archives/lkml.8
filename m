Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8ABC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5291B2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="feefPtaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgDGQec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:34:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53930 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbgDGQe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:34:28 -0400
Received: from zn.tnic (p200300EC2F0B2700A94266E658FF3DDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:a942:66e6:58ff:3ddd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 678EF1EC0CE1;
        Tue,  7 Apr 2020 18:34:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586277267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=md4Cpx6eDOc5VjHal7YbC9+KEnNowmqmEj/zvh14Xkc=;
        b=feefPtaXRf6RGgJZWUqiNQWlyEnAPTSgKz6TeB6Bz/aWZBH05aJwKbN4a7sxIPDJ5hwbQN
        oNEVQhO5GMly+Lx5ZfyWM5vB+u8htoIxyQlDLpOCFCGNNP81OE9wAE5wf+cRFfyvxy3huk
        lOp9HWAiyDNzLrjw+kDJTpiDNWP7VFo=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 9/9] x86/mce: Fixup exception only for the correct MCEs
Date:   Tue,  7 Apr 2020 18:34:14 +0200
Message-Id: <20200407163414.18058-10-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200407163414.18058-1-bp@alien8.de>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200407163414.18058-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The severity grading code returns IN_KERNEL_RECOV error context for
errors which have happened in kernel space but from which the kernel can
recover. Whether the recovery can happen is determined by the exception
table entry having as handler ex_handler_fault() and which has been
declared at build time using _ASM_EXTABLE_FAULT().

IN_KERNEL_RECOV is used in mce_severity_intel() to lookup the
corresponding error severity in the severities table.

However, the mapping back from error severity to whether the error is
IN_KERNEL_RECOV is ambiguous and in the very paranoid case - which
might not be possible right now - but be better safe than sorry later,
an exception fixup could be attempted for another MCE whose address
is in the exception table and has the proper severity. Which would be
unfortunate, to say the least.

Therefore, mark such MCEs explicitly as MCE_IN_KERNEL_RECOV so that the
recovery attempt is done only for them.

Document the whole handling, while at it, as it is not trivial.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mce.h         |  1 +
 arch/x86/kernel/cpu/mce/core.c     | 15 +++++++++++++--
 arch/x86/kernel/cpu/mce/severity.c |  6 +++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 5f04a24f30ea..c598aaab071b 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -136,6 +136,7 @@
 #define	MCE_HANDLED_NFIT	BIT_ULL(3)
 #define	MCE_HANDLED_EDAC	BIT_ULL(4)
 #define	MCE_HANDLED_MCELOG	BIT_ULL(5)
+#define MCE_IN_KERNEL_RECOV	BIT_ULL(6)
 
 /*
  * This structure contains all data related to the MCE log.  Also
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4efe6c128887..02e1f165f148 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1331,8 +1331,19 @@ void notrace do_machine_check(struct pt_regs *regs, long error_code)
 		local_irq_disable();
 		ist_end_non_atomic();
 	} else {
-		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
-			mce_panic("Failed kernel mode recovery", &m, msg);
+		/*
+		 * Handle an MCE which has happened in kernel space but from
+		 * which the kernel can recover: ex_has_fault_handler() has
+		 * already verified that the rIP at which the error happened is
+		 * a rIP from which the kernel can recover (by jumping to
+		 * recovery code specified in _ASM_EXTABLE_FAULT()) and the
+		 * corresponding exception handler which would do that is the
+		 * proper one.
+		 */
+		if (m.kflags & MCE_IN_KERNEL_RECOV) {
+			if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
+				mce_panic("Failed kernel mode recovery", &m, msg);
+		}
 	}
 
 out_ist:
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 87bcdc6dc2f0..e1da619add19 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -213,8 +213,12 @@ static int error_context(struct mce *m)
 {
 	if ((m->cs & 3) == 3)
 		return IN_USER;
-	if (mc_recoverable(m->mcgstatus) && ex_has_fault_handler(m->ip))
+
+	if (mc_recoverable(m->mcgstatus) && ex_has_fault_handler(m->ip)) {
+		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
+	}
+
 	return IN_KERNEL;
 }
 
-- 
2.21.0

