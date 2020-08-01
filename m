Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0FDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 15:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3FE2071E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596294115;
	bh=MGNluP/9a7NuKGLRcBQR/ggshEl8NQsTVywMrBmelYk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2vM+OdWAwlz6GjT6XfaDf5mznyTGlIdTKT7xkpWfkAv/WvHaTP4IYdJilw0SdhF1p
	 rD1GRjMixh3sg7myA3i+Xbt+0nsmPoouuUcQhx98e3utAXhxM4FmjpSyo5T6F5E/aK
	 GZHV54B3AQ7UnaAfVdwiajJpSiBxNr8zqYSx8W5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHAPBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 11:01:54 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:53478 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHAPBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 11:01:53 -0400
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 071F0q51015446;
        Sun, 2 Aug 2020 00:00:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 071F0q51015446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1596294053;
        bh=iB+4Axh/LScTu6iv9y46G7fJslW+Ej8Wjx6mPd1aNvk=;
        h=From:To:Cc:Subject:Date:From;
        b=c0JKLZBNUX/vFZqw09nlPS+4PAOgo05+nSaDmnRBC+w4C4BBIOPD1P/14Qky4UvOa
         y1RzB7zGuMTnS39bGaAB1SjW/zO2DrKJ6qcVxOvUd3LJAVMWoYph0ZPUadt+CSyJa/
         hNSnC3z5Ew5NXQ+zid0xZRDgLm4kpVHTo40YOy6Vu0E89mE+Up1sgKm1jQz6Orz/b7
         7nAntrZOgykP7Ea4zi2Kf4EgLpri8bOhGzwWZQ29sR5DHylnPsAO0WGctyBR+Gt48R
         dbj0TrN4vJOjv6+IPYIYFPOZbWeqrFkSFZnlqzBe6yL+BI89hOQXcwux6aFhUXivMz
         j1GV0bHAKVbeQ==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        kasan-dev@googlegroups.com
Subject: [PATCH 1/2] kbuild: include scripts/Makefile.* only when relevant CONFIG is enabled
Date:   Sun,  2 Aug 2020 00:00:49 +0900
Message-Id: <20200801150050.767038-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the top Makefile includes all of scripts/Makefile.<feature>
even if the associated CONFIG option is disabled.

Do not include unneeded Makefiles in order to slightly optimize the
parse stage.

Include $(include-y), and ignore $(include-).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile               | 16 +++++++++-------
 scripts/Makefile.kcov  |  4 ----
 scripts/Makefile.kcsan |  4 ----
 scripts/Makefile.ubsan |  3 ---
 4 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index ebf4d3ce492c..483456d5dd3e 100644
--- a/Makefile
+++ b/Makefile
@@ -745,9 +745,6 @@ endif
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
 KBUILD_CFLAGS	+= $(call cc-option,-fno-allow-store-data-races)
 
-include scripts/Makefile.kcov
-include scripts/Makefile.gcc-plugins
-
 ifdef CONFIG_READABLE_ASM
 # Disable optimizations that make assembler listings hard to read.
 # reorder blocks reorders the control in the function
@@ -948,10 +945,15 @@ ifdef CONFIG_RETPOLINE
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif
 
-include scripts/Makefile.kasan
-include scripts/Makefile.extrawarn
-include scripts/Makefile.ubsan
-include scripts/Makefile.kcsan
+# include additional Makefiles when needed
+include-y			:= scripts/Makefile.extrawarn
+include-$(CONFIG_KASAN)		+= scripts/Makefile.kasan
+include-$(CONFIG_KCSAN)		+= scripts/Makefile.kcsan
+include-$(CONFIG_UBSAN)		+= scripts/Makefile.ubsan
+include-$(CONFIG_KCOV)		+= scripts/Makefile.kcov
+include-$(CONFIG_GCC_PLUGINS)	+= scripts/Makefile.gcc-plugins
+
+include $(addprefix $(srctree)/, $(include-y))
 
 # Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
 KBUILD_CPPFLAGS += $(KCPPFLAGS)
diff --git a/scripts/Makefile.kcov b/scripts/Makefile.kcov
index 52b113302443..67e8cfe3474b 100644
--- a/scripts/Makefile.kcov
+++ b/scripts/Makefile.kcov
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifdef CONFIG_KCOV
-
 kcov-flags-$(CONFIG_CC_HAS_SANCOV_TRACE_PC)	+= -fsanitize-coverage=trace-pc
 kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)	+= -fsanitize-coverage=trace-cmp
 kcov-flags-$(CONFIG_GCC_PLUGIN_SANCOV)		+= -fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so
 
 export CFLAGS_KCOV := $(kcov-flags-y)
-
-endif
diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index bd4da1af5953..2b0743e6566e 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_KCSAN
-
 # GCC and Clang accept backend options differently. Do not wrap in cc-option,
 # because Clang accepts "--param" even if it is unused.
 ifdef CONFIG_CC_IS_CLANG
@@ -15,5 +13,3 @@ CFLAGS_KCSAN := -fsanitize=thread \
 	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
 	$(call cc-option,$(call cc-param,tsan-instrument-read-before-write=1)) \
 	$(call cc-param,tsan-distinguish-volatile=1)
-
-endif # CONFIG_KCSAN
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 5b15bc425ec9..27348029b2b8 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_UBSAN
-
 ifdef CONFIG_UBSAN_ALIGNMENT
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=alignment)
 endif
@@ -26,4 +24,3 @@ endif
       # -fsanitize=* options makes GCC less smart than usual and
       # increase number of 'maybe-uninitialized false-positives
       CFLAGS_UBSAN += $(call cc-option, -Wno-maybe-uninitialized)
-endif
-- 
2.25.1

