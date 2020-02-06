Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06BCC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F4C217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580987698;
	bh=oKSH5/XEvKb7FCMlrXnlx2H529bmxqZ5nEC/5MnwBd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EDit6uLWc7ba5z3I72F+vRFnrAyXf1+xhF4LKomdLHqX5Shkt7T8S36Ve50WBPtNn
	 OKx+kXRUP9WqPO6BjVk0JcfMLTYD7PaNehL2dNlq8jGhqG6ZWTCsl6hiXzaGHtACiR
	 bKEfsUwiv/xarxopTi3WFeMtSiQA5yA/W1J10xuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgBFLO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:14:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgBFLO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:14:57 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2A6321741;
        Thu,  6 Feb 2020 11:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580987697;
        bh=oKSH5/XEvKb7FCMlrXnlx2H529bmxqZ5nEC/5MnwBd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x/2he1kJLxWTa/JU54kmcFXSYKkXmrlhU0cZVqrZm0iTXP9EgIp0M8/LBkHLsLeT/
         5BEOJcom+EvSVkZdaHO4j7KjoRZ/b5rCTpaAFaMzvHPJjgR/MilEwcGsSizZrDrcey
         EVIkVrLmRZQQ4S+lp0iacKGJGyFZf3MG1TsSnvQw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] bootconfig: Remove unneeded CONFIG_LIBXBC
Date:   Thu,  6 Feb 2020 20:14:53 +0900
Message-Id: <158098769281.939.16293492056419481105.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAMuHMdWx4FmrGaefwkEBMGqCmJUSYxtAfkmFc7HM++fab2U-cw@mail.gmail.com>
References: <CAMuHMdWx4FmrGaefwkEBMGqCmJUSYxtAfkmFc7HM++fab2U-cw@mail.gmail.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is no user except CONFIG_BOOT_CONFIG and no plan
to use it from other functions, CONFIG_LIBXBC can be removed
and we can use CONFIG_BOOT_CONFIG directly.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/Kconfig |    1 -
 lib/Kconfig  |    3 ---
 lib/Makefile |    2 +-
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

