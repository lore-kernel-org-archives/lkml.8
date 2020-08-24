Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009D0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8516206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgHXJNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:13:14 -0400
Received: from 8bytes.org ([81.169.241.247]:37260 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730134AbgHXI4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:56:08 -0400
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de [79.242.187.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 55EA5F69;
        Mon, 24 Aug 2020 10:56:06 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Kees Cook <keescook@chromium.org>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 35/76] x86/head/64: Make fixup_pointer() static inline
Date:   Mon, 24 Aug 2020 10:54:30 +0200
Message-Id: <20200824085511.7553-36-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824085511.7553-1-joro@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Also move it to a header file so that it can be used in the idt code
to setup the early IDT.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200724160336.5435-35-joro@8bytes.org
---
 arch/x86/include/asm/setup.h | 10 ++++++++++
 arch/x86/kernel/head64.c     |  5 -----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 5c2fd05bd52c..8aa6ba0427b0 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -74,6 +74,16 @@ static inline void x86_ce4100_early_setup(void) { }
 extern struct boot_params boot_params;
 extern char _text[];
 
+/*
+ * This function is used in C code that runs while the kernel still runs on
+ * identity mapped addresses to get the correct address of kernel pointers in
+ * the identity mapping.
+ */
+static __always_inline void *fixup_pointer(void *ptr, unsigned long physaddr)
+{
+	return ptr - (void *)_text + (void *)physaddr;
+}
+
 static inline bool kaslr_enabled(void)
 {
 	return IS_ENABLED(CONFIG_RANDOMIZE_MEMORY) &&
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index b0ab5627900b..8703292a35e9 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -82,11 +82,6 @@ static struct desc_ptr startup_gdt_descr = {
 
 #define __head	__section(.head.text)
 
-static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
-{
-	return ptr - (void *)_text + (void *)physaddr;
-}
-
 static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
 {
 	return fixup_pointer(ptr, physaddr);
-- 
2.28.0

