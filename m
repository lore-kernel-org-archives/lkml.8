Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F113C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3808E208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgFRUjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:39:03 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48815 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbgFRUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:00 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:38:56 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 52378B2659;
        Thu, 18 Jun 2020 16:38:59 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 01/51] objtool: Factor out reasons to build objtool
Date:   Thu, 18 Jun 2020 13:37:47 -0700
Message-ID: <6ac0671bef706812b1751a7a04d1854e9586e890.1592510545.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1592510545.git.mhelsley@vmware.com>
References: <cover.1592510545.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the reasons to build and run objtool are:
	Stack validation (objtool subcmds: orc + check)
	Orc data generation (objtool subcmds: orc)
	Code analysis (objtool subcmds: check)

Since the reasons are varied and the stack validation step is
skipped with a warning if libelf is missing, the logic of
Kconfig and the Makefiles is somewhat messy and will only get
messier the more subcommands objtool supports. In preparation
for adding new subcommands, break up the current configurations
such as CONFIG_STACK_VALIDATION, CONFIG_UNWINDER_ORC, etc.
so that we translate them into the objtool subcommands that we
need to build into objtool and whether the objtool pass is
optional (SKIP_STACK_VALIDATION=1).

This allows us to greatly simplify the objtool Makefile so
that the arch-dependence of the subcommands can be encoded in
the usual place, arch/Kconfig, rather than a bunch of
per-supported-arch ifdef blocks in tools/objtool/Makefile.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 Makefile               | 15 ++++++++-------
 arch/Kconfig           | 23 +++++++++++++++++++++++
 arch/x86/Kconfig.debug |  1 +
 lib/Kconfig.debug      |  1 +
 tools/objtool/Makefile |  5 +++--
 5 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index ae5d8220f431..cf731709ebe7 100644
--- a/Makefile
+++ b/Makefile
@@ -1051,18 +1051,19 @@ mod_sign_cmd = true
 endif
 export mod_sign_cmd
 
+ifdef CONFIG_OBJTOOL_SUBCMDS
 HOST_LIBELF_LIBS = $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
-
-ifdef CONFIG_STACK_VALIDATION
-  has_libelf := $(call try-run,\
+has_libelf := $(call try-run,\
 		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
-  ifeq ($(has_libelf),1)
-    objtool_target := tools/objtool FORCE
-  else
+ifeq ($(has_libelf),1)
+  objtool_target := tools/objtool FORCE
+else
+  ifdef CONFIG_STACK_VALIDATION
     SKIP_STACK_VALIDATION := 1
     export SKIP_STACK_VALIDATION
   endif
-endif
+endif # has_libelf
+endif # CONFIG_OBJTOOL_SUBCMDS
 
 PHONY += prepare0
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..4919412031eb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -767,6 +767,29 @@ config HAVE_STACK_VALIDATION
 	  Architecture supports the 'objtool check' host tool command, which
 	  performs compile-time stack metadata validation.
 
+config OBJTOOL_SUBCMD_CHECK
+	bool
+	select OBJTOOL_SUBCMDS
+	help
+	  Run the 'objtool check' host tool command, which
+	  performs compile-time stack metadata validation.
+
+config OBJTOOL_SUBCMD_ORC
+	bool
+	select OBJTOOL_SUBCMDS
+	help
+	  Run the 'objtool orc' host tool command, which collects information
+	  enabling reliable runtime kernel stack traces.
+
+config OBJTOOL_SUBCMDS
+	bool
+	default n
+	help
+	  Other configurations require running objtool host tool commands.
+	  For example, stack validation is available on the architecture
+	  (HAVE_STACK_VALIDATION=y) and has been enabled (STACK_VALIDATION=y)
+	  which selects OBJTOOL_SUBCMD_CHECK and OBJTOOL_SUBCMDS
+
 config HAVE_RELIABLE_STACKTRACE
 	bool
 	help
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 0dd319e6e5b4..4f2d596505c1 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -241,6 +241,7 @@ config UNWINDER_ORC
 	bool "ORC unwinder"
 	depends on X86_64
 	select STACK_VALIDATION
+	select OBJTOOL_SUBCMD_ORC
 	help
 	  This option enables the ORC (Oops Rewind Capability) unwinder for
 	  unwinding kernel stack traces.  It uses a custom data format which is
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d74ac0fd6b2d..e38e6cb22aa5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -386,6 +386,7 @@ config FRAME_POINTER
 config STACK_VALIDATION
 	bool "Compile-time stack metadata validation"
 	depends on HAVE_STACK_VALIDATION
+	select OBJTOOL_SUBCMD_CHECK
 	default n
 	help
 	  Add compile-time checks to validate stack metadata, including frame
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 7770edcda3a0..aa0c6d3d2d46 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../scripts/Makefile.include
 include ../scripts/Makefile.arch
+include $(OUTPUT)/../../include/config/auto.conf
 
 # always use the host compiler
 ifneq ($(LLVM),)
@@ -47,8 +48,8 @@ CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
 AWK = awk
 
-SUBCMD_CHECK := n
-SUBCMD_ORC := n
+SUBCMD_CHECK := $(CONFIG_OBJTOOL_SUBCMD_CHECK)
+SUBCMD_ORC := $(CONFIG_OBJTOOL_SUBCMD_ORC)
 
 ifeq ($(SRCARCH),x86)
 	SUBCMD_CHECK := y
-- 
2.20.1

