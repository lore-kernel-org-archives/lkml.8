Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04493C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95A92075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360666;
	bh=bliEcMVKnd3LisxyVMV94nASjsWsxhu1Gq03tUP6WYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XkovlsiLqCcj1w/DYyqgQQn7R2qyS41XUtC6zYJqlKUB67kL6h3uw4jLJepDWnSoT
	 ZUEfKmuQl0ozrJYIVTwHuYbtmm2fpwAkEC1c8PiKN9UMmdjyA2dAl392tw0g1qk6iF
	 VRURcMCT343lp4BWxSZvBYspXBrGM78Juns5CQOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgDHPoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgDHPoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:44:25 -0400
Received: from linux-8ccs.suse.de (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B8F206F5;
        Wed,  8 Apr 2020 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360664;
        bh=bliEcMVKnd3LisxyVMV94nASjsWsxhu1Gq03tUP6WYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9CEEWgWqM+2CIZXusFR9nMVNYqNACFSljYP7gdMjiAg1p7o3HoL3OhUlCMzdd4TC
         /BBgLo4LrbZ5GrOAWJQd7KlzmQCYJU1Ba7SuRvbqngMYhEnY2zjww6smPvzX4/JzsU
         bYoBMEFmVZ3GUw80qXwBAW5ec3F+isTnJOtIwNNA=
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] module: break nested ARCH_HAS_STRICT_MODULE_RWX and STRICT_MODULE_RWX #ifdefs
Date:   Wed,  8 Apr 2020 17:43:23 +0200
Message-Id: <20200408154323.20631-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200408153249.GA26619@linux-8ccs>
References: <20200408153249.GA26619@linux-8ccs>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various frob_* and module_{enable,disable}_* functions are defined in a
CONFIG_ARCH_HAS_STRICT_MODULE_RWX ifdef block which also has a nested
CONFIG_STRICT_MODULE_RWX ifdef block within it. This is unecessary and
makes things hard to read. Not only that, this construction requires
redundant empty stubs for module_enable_nx(). I suspect this was
originally done for cosmetic reasons - to keep all the frob_* functions
in the same place, and all the module_{enable,disable}_* functions right
after, but as a result it made the code harder to read.

Make this more readable by unnesting the ifdef blocks and getting rid of
the redundant empty stubs.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index b88ec9cd2a7f..2b28f8bf2322 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1943,7 +1943,6 @@ static void mod_sysfs_teardown(struct module *mod)
 	mod_sysfs_fini(mod);
 }
 
-#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
 /*
  * LKM RO/NX protection: protect module's text/ro-data
  * from modification and any data from execution.
@@ -1957,6 +1956,14 @@ static void mod_sysfs_teardown(struct module *mod)
  *
  * These values are always page-aligned (as is base)
  */
+
+/*
+ * Since some arches are moving towards PAGE_KERNEL module allocations instead
+ * of PAGE_KERNEL_EXEC, keep frob_text() and module_enable_x() outside of the
+ * CONFIG_STRICT_MODULE_RWX block below because they are needed regardless of
+ * whether we are strict.
+ */
+#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
 static void frob_text(const struct module_layout *layout,
 		      int (*set_memory)(unsigned long start, int num_pages))
 {
@@ -1966,6 +1973,15 @@ static void frob_text(const struct module_layout *layout,
 		   layout->text_size >> PAGE_SHIFT);
 }
 
+static void module_enable_x(const struct module *mod)
+{
+	frob_text(&mod->core_layout, set_memory_x);
+	frob_text(&mod->init_layout, set_memory_x);
+}
+#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
+static void module_enable_x(const struct module *mod) { }
+#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
+
 #ifdef CONFIG_STRICT_MODULE_RWX
 static void frob_rodata(const struct module_layout *layout,
 			int (*set_memory)(unsigned long start, int num_pages))
@@ -2037,18 +2053,9 @@ static void module_enable_nx(const struct module *mod)
 }
 
 #else /* !CONFIG_STRICT_MODULE_RWX */
+/* module_{enable,disable}_ro() stubs are in module.h */
 static void module_enable_nx(const struct module *mod) { }
 #endif /*  CONFIG_STRICT_MODULE_RWX */
-static void module_enable_x(const struct module *mod)
-{
-	frob_text(&mod->core_layout, set_memory_x);
-	frob_text(&mod->init_layout, set_memory_x);
-}
-#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
-static void module_enable_nx(const struct module *mod) { }
-static void module_enable_x(const struct module *mod) { }
-#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
-
 
 #ifdef CONFIG_LIVEPATCH
 /*
-- 
2.16.4

