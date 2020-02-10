Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12605C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCB920838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgBJOpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728261AbgBJOpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E28214DB;
        Mon, 10 Feb 2020 14:45:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j1AJb-001VyA-E2; Mon, 10 Feb 2020 09:45:35 -0500
Message-Id: <20200210144535.314738306@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 10 Feb 2020 09:44:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 2/4] bootconfig: Remove unneeded CONFIG_LIBXBC
References: <20200210144455.531096382@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since there is no user except CONFIG_BOOT_CONFIG and no plan
to use it from other functions, CONFIG_LIBXBC can be removed
and we can use CONFIG_BOOT_CONFIG directly.

Link: http://lkml.kernel.org/r/158098769281.939.16293492056419481105.stgit@devnote2

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/Kconfig | 1 -
 lib/Kconfig  | 3 ---
 lib/Makefile | 2 +-
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9506299a53e3..4a672c6629d0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1218,7 +1218,6 @@ endif
 config BOOT_CONFIG
 	bool "Boot config support"
 	depends on BLK_DEV_INITRD
-	select LIBXBC
 	default y
 	help
 	  Extra boot config allows system admin to pass a config file as
diff --git a/lib/Kconfig b/lib/Kconfig
index 10012b646009..6e790dc55c5b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -566,9 +566,6 @@ config DIMLIB
 config LIBFDT
 	bool
 
-config LIBXBC
-	bool
-
 config OID_REGISTRY
 	tristate
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 75a64d2552a2..74c1223828c1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -228,7 +228,7 @@ $(foreach file, $(libfdt_files), \
 	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
 
-lib-$(CONFIG_LIBXBC) += bootconfig.o
+lib-$(CONFIG_BOOT_CONFIG) += bootconfig.o
 
 obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
 obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
-- 
2.24.1


