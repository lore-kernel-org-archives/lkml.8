Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49655C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCD920773
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCSJPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:15:12 -0400
Received: from 8bytes.org ([81.169.241.247]:53144 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbgCSJOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:14:48 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9592EEDB; Thu, 19 Mar 2020 10:14:28 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 66/70] x86/head/64: Don't call verify_cpu() on starting APs
Date:   Thu, 19 Mar 2020 10:14:03 +0100
Message-Id: <20200319091407.1481-67-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319091407.1481-1-joro@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The APs are not ready to handle exceptions when verify_cpu() is called
in secondary_startup_64.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/realmode.h | 1 +
 arch/x86/kernel/head_64.S       | 1 +
 arch/x86/realmode/init.c        | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 6590394af309..5c97807c38a4 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -69,6 +69,7 @@ extern unsigned char startup_32_smp[];
 extern unsigned char boot_gdt[];
 #else
 extern unsigned char secondary_startup_64[];
+extern unsigned char secondary_startup_64_no_verify[];
 #endif
 
 static inline size_t real_mode_size_needed(void)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index b3acecdabd34..c935d6d07393 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -150,6 +150,7 @@ SYM_CODE_START(secondary_startup_64)
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
+SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
 	 * added to the initial pgdir entry that will be programmed into CR3.
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 1c5cbfd102d5..030c38268069 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -109,6 +109,12 @@ static void __init setup_real_mode(void)
 		trampoline_header->flags |= TH_FLAGS_SME_ACTIVE;
 
 	if (sev_es_active()) {
+		/*
+		 * Skip the call to verify_cpu() in secondary_startup_64 as it
+		 * will cause #VC exceptions when the AP can't handle them yet.
+		 */
+		trampoline_header->start = (u64) secondary_startup_64_no_verify;
+
 		if (sev_es_setup_ap_jump_table(real_mode_header))
 			panic("Failed to update SEV-ES AP Jump Table");
 	}
-- 
2.17.1

