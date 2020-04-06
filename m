Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36DCC2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F2421D94
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586189084;
	bh=L00ZAAyRSvCuvRMJNJwKNL2bzR9DRu4/YFAzVqmfZwU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=R0RbzsihjUx7eTzjQZyO5j0+m7ULc5Mk4utW+cvYk8RX+WNbqsEQNntvZV1e+eCXD
	 xUoGrV50z7G9loIy8/EAn6a5rtjku3wkURJC1nS/vER8X2trBp108fb6A/8VrX/w8I
	 DnyG6grINQ/yitV+2l3P78alCdLopmXr/qPcWP4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgDFQEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbgDFQEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:04:40 -0400
Received: from linux-8ccs.suse.de (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9FC22265;
        Mon,  6 Apr 2020 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586189080;
        bh=L00ZAAyRSvCuvRMJNJwKNL2bzR9DRu4/YFAzVqmfZwU=;
        h=From:To:Cc:Subject:Date:From;
        b=duQ7kAQ1XnHbc4ULmasMoaHWa5OKdZnMGKhICVc77O+1JDe1CZ6ZKdYeW44rIQGVP
         Qiw9X/v5lIpDn0of+n6fO8FIcBVoXA/LSWMzM3FwpkmOorCUM9HOtIcwNTSUdoogwz
         vGTGYKYuwBXrJfshxV8Q14jQ74DC5BfdbZ6PDFlk=
From:   Jessica Yu <jeyu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] module: expose load_info to arch module loader code
Date:   Mon,  6 Apr 2020 18:04:20 +0200
Message-Id: <20200406160420.14407-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 module loader wants to check the value of a modinfo flag
(sld_safe), before proceeding to scan the module text for VMX
instructions. Unfortunately the arch module code currently does not have
access to load_info, but we can easily expose that via moduleloader.h,
which every arch module code must already include.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

Does this help? You may also need to implement a new arch-specific hook
in check_modinfo() to check for sld_safe, and I guess we might need to
expose get_modinfo() too. I realize that the detect-VMX-modules patchset
[1] is still very much in-flight, so if you do end up needing this, feel
free to just add this patch to the patchset.

[1] http://lore.kernel.org/r/20200402123258.895628824@linutronix.de

 include/linux/moduleloader.h | 20 ++++++++++++++++++++
 kernel/module-internal.h     | 23 -----------------------
 kernel/module_signing.c      |  2 +-
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index ca92aea8a6bd..2ca0bb783d1e 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
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
diff --git a/kernel/module-internal.h b/kernel/module-internal.h
index 33783abc377b..98a873691f1b 100644
--- a/kernel/module-internal.h
+++ b/kernel/module-internal.h
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
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 9d9fc678c91d..2de41a3ab8a8 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
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
-- 
2.16.4

