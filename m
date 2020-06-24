Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F469C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A34520E65
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bviMzmtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390703AbgFXLrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbgFXLq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:46:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAF5C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 04:46:58 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a930055750ecb74485dbb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9300:5575:ecb:7448:5dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C45281EC03D2;
        Wed, 24 Jun 2020 13:46:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592999216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yajTFC479EK0FWSLSqouxxcYwq+e/O7pKtFICq9PPmY=;
        b=bviMzmtYUYik0jhshNBAeEq9BYDif0kDWo+RZzC/zoI2DQq+L7vYaYEAb/UygiSfdZWC35
        VizOsBSYwkJQELSLIUkjFagRmmp+nlPifYeGeZO6zFaxwkh31R6ZfIbZ8igkXVFVABByO8
        Ow5kWvcvqGgx6QfeifklL1YPBNfhGQs=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petteri Aimonen <jpa@kernelbug.mail.kapsi.fi>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
Date:   Wed, 24 Jun 2020 13:46:45 +0200
Message-Id: <20200624114646.28953-2-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200624114646.28953-1-bp@alien8.de>
References: <20200624114646.28953-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petteri Aimonen <jpa@git.mail.kapsi.fi>

Previously, kernel floating point code would run with the MXCSR control
register value last set by userland code by the thread that was active
on the CPU core just before kernel call. This could affect calculation
results if rounding mode was changed, or a crash if a FPU/SIMD exception
was unmasked.

Restore MXCSR to the kernel's default value.

 [ bp: Carve out from a bigger patch by Petteri, add feature check, add
   FNINIT call too (amluto). ]

Signed-off-by: Petteri Aimonen <jpa@git.mail.kapsi.fi>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=207979
---
 arch/x86/include/asm/fpu/internal.h | 5 +++++
 arch/x86/kernel/fpu/core.c          | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 42159f45bf9c..845e7481ab77 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -623,6 +623,11 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
  * MXCSR and XCR definitions:
  */
 
+static inline void ldmxcsr(u32 mxcsr)
+{
+	asm volatile("ldmxcsr %0" :: "m" (mxcsr));
+}
+
 extern unsigned int mxcsr_feature_mask;
 
 #define XCR_XFEATURE_ENABLED_MASK	0x00000000
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 06c818967bb6..15247b96c6ea 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -101,6 +101,12 @@ void kernel_fpu_begin(void)
 		copy_fpregs_to_fpstate(&current->thread.fpu);
 	}
 	__cpu_invalidate_fpregs_state();
+
+	if (boot_cpu_has(X86_FEATURE_XMM))
+		ldmxcsr(MXCSR_DEFAULT);
+
+	if (boot_cpu_has(X86_FEATURE_FPU))
+		asm volatile ("fninit");
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 
-- 
2.21.0

