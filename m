Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6447C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77187206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YeN2wkd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgDGLNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:13:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42508 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbgDGLNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=EERUli1mua+BUZZR7dTWluOlG7HZQbwICdu9Og1crjA=; b=YeN2wkd6NQzzXsBrPfnKVWREI/
        Tyr2nMIWAJ7cEda/jxtMkihEChZ5ebmoORndXl+rAFGO9NhzEYU3fc9ka3hdk+hfxukRHw4ogOT+j
        vDkspXmo3OyR8+RO6rCH0mSHg1zXRECmqBgBQssyHlxzQZI6uvzscFVfIniXJal/nhN+Mt1CHTi+V
        /W6wyiQIimI7X4xjY0YePEgAi5lYy65LCYVIuA+3fhOpfNKmyMOf/h207c2POv4tFFpQLz0wNWMUh
        +NwNPioo38dGm48BHXfzvm2/+GWvCIEys38EL/ALfhhz9OCiPSx/Z+fTew1T09XhZI5HGNJOMjoyv
        iKPzXE/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLm9m-0007DO-OF; Tue, 07 Apr 2020 11:12:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 430083010C8;
        Tue,  7 Apr 2020 13:12:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1D75F28565C0D; Tue,  7 Apr 2020 13:12:36 +0200 (CEST)
Message-Id: <20200407111007.198738828@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 07 Apr 2020 13:02:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, peterz@infradead.org, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com, rostedt@goodmis.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: [PATCH 1/4] module: Expose load_info to arch module loader code
References: <20200407110236.930134290@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jessica Yu <jeyu@kernel.org>

The x86 module loader wants to check the value of a modinfo flag
(sld_safe), before proceeding to scan the module text for VMX
instructions. Unfortunately the arch module code currently does not have
access to load_info, but we can easily expose that via moduleloader.h,
which every arch module code must already include.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200406160420.14407-1-jeyu@kernel.org
---

 include/linux/moduleloader.h | 20 ++++++++++++++++++++
 kernel/module-internal.h     | 23 -----------------------
 kernel/module_signing.c      |  2 +-
 3 files changed, 21 insertions(+), 24 deletions(-)

Index: linux-2.6/include/linux/moduleloader.h
===================================================================
--- linux-2.6.orig/include/linux/moduleloader.h
+++ linux-2.6/include/linux/moduleloader.h
@@ -6,6 +6,26 @@
 #include <linux/module.h>
 #include <linux/elf.h>
 
+struct load_info {
+	const char *name;
+	/* pointer to module in temporary copy, freed at end of load_module() */
+	struct module *mod;
+	Elf_Ehdr *hdr;
+	unsigned long len;
+	Elf_Shdr *sechdrs;
+	char *secstrings, *strtab;
+	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
+	struct _ddebug *debug;
+	unsigned int num_debug;
+	bool sig_ok;
+#ifdef CONFIG_KALLSYMS
+	unsigned long mod_kallsyms_init_off;
+#endif
+	struct {
+		unsigned int sym, str, mod, vers, info, pcpu;
+	} index;
+};
+
 /* These may be implemented by architectures that need to hook into the
  * module loader code.  Architectures that don't need to do anything special
  * can just rely on the 'weak' default hooks defined in kernel/module.c.
Index: linux-2.6/kernel/module-internal.h
===================================================================
--- linux-2.6.orig/kernel/module-internal.h
+++ linux-2.6/kernel/module-internal.h
@@ -5,27 +5,4 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
-#include <linux/elf.h>
-#include <asm/module.h>
-
-struct load_info {
-	const char *name;
-	/* pointer to module in temporary copy, freed at end of load_module() */
-	struct module *mod;
-	Elf_Ehdr *hdr;
-	unsigned long len;
-	Elf_Shdr *sechdrs;
-	char *secstrings, *strtab;
-	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
-	struct _ddebug *debug;
-	unsigned int num_debug;
-	bool sig_ok;
-#ifdef CONFIG_KALLSYMS
-	unsigned long mod_kallsyms_init_off;
-#endif
-	struct {
-		unsigned int sym, str, mod, vers, info, pcpu;
-	} index;
-};
-
 extern int mod_verify_sig(const void *mod, struct load_info *info);
Index: linux-2.6/kernel/module_signing.c
===================================================================
--- linux-2.6.orig/kernel/module_signing.c
+++ linux-2.6/kernel/module_signing.c
@@ -8,11 +8,11 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/module_signature.h>
 #include <linux/string.h>
 #include <linux/verification.h>
 #include <crypto/public_key.h>
-#include "module-internal.h"
 
 /*
  * Verify the signature on a module.


