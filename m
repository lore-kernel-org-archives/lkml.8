Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222DBC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED28823B24
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgHOVno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:43:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:54798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgHOVno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:43:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 565B3B04C;
        Sat, 15 Aug 2020 10:07:10 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 3/6] x86/paravirt: use CONFIG_PARAVIRT_XXL instead of CONFIG_PARAVIRT
Date:   Sat, 15 Aug 2020 12:06:38 +0200
Message-Id: <20200815100641.26362-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200815100641.26362-1-jgross@suse.com>
References: <20200815100641.26362-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some code parts using CONFIG_PARAVIRT for Xen pvops related
issues instead of the more stringent CONFIG_PARAVIRT_XXL.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/entry/entry_64.S                | 4 ++--
 arch/x86/include/asm/fixmap.h            | 2 +-
 arch/x86/include/asm/required-features.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 70dea9337816..26fc9b42fadc 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -46,13 +46,13 @@
 .code64
 .section .entry.text, "ax"
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 SYM_CODE_START(native_usergs_sysret64)
 	UNWIND_HINT_EMPTY
 	swapgs
 	sysretq
 SYM_CODE_END(native_usergs_sysret64)
-#endif /* CONFIG_PARAVIRT */
+#endif /* CONFIG_PARAVIRT_XXL */
 
 /*
  * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 0f0dd645b594..77217bd292bd 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -99,7 +99,7 @@ enum fixed_addresses {
 	FIX_PCIE_MCFG,
 #endif
 #endif
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 	FIX_PARAVIRT_BOOTMAP,
 #endif
 #ifdef	CONFIG_X86_INTEL_MID
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index 6847d85400a8..3ff0d48469f2 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -54,7 +54,7 @@
 #endif
 
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 /* Paravirtualized systems may not have PSE or PGE available */
 #define NEED_PSE	0
 #define NEED_PGE	0
-- 
2.26.2

