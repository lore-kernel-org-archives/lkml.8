Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0861DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19F520FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389570AbgE0PEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389378AbgE0PEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:04:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623A8C05BD1E;
        Wed, 27 May 2020 08:04:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdxbV-0006L0-T1; Wed, 27 May 2020 17:04:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 605D71C00ED;
        Wed, 27 May 2020 17:04:25 +0200 (CEST)
Date:   Wed, 27 May 2020 15:04:25 -0000
From:   "tip-bot2 for Matt Helsley" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Enable compilation of objtool for all
 architectures
Cc:     Julien Thierry <jthierry@redhat.com>,
        Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159059186521.17951.16748738134055814508.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0decf1f8de919782b152daf9c991967a2bac54f0
Gitweb:        https://git.kernel.org/tip/0decf1f8de919782b152daf9c991967a2bac54f0
Author:        Matt Helsley <mhelsley@vmware.com>
AuthorDate:    Tue, 19 May 2020 13:55:33 -07:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 20 May 2020 09:17:28 -05:00

objtool: Enable compilation of objtool for all architectures

Objtool currently only compiles for x86 architectures. This is
fine as it presently does not support tooling for other
architectures. However, we would like to be able to convert other
kernel tools to run as objtool sub commands because they too
process ELF object files. This will allow us to convert tools
such as recordmcount to use objtool's ELF code.

Since much of recordmcount's ELF code is copy-paste code to/from
a variety of other kernel tools (look at modpost for example) this
means that if we can convert recordmcount we can convert more.

We define weak definitions for subcommand entry functions and other weak
definitions for shared functions critical to building existing
subcommands. These return 127 when the command is missing which signify
tools that do not exist on all architectures.  In this case the "check"
and "orc" tools do not exist on all architectures so we only add them
for x86. Future changes adding support for "check", to arm64 for
example, can then modify the SUBCMD_CHECK variable when building for
arm64.

Objtool is not currently wired in to KConfig to be built for other
architectures because it's not needed for those architectures and
there are no commands it supports other than those for x86. As more
command support is enabled on various architectures the necessary
KConfig changes can be made (e.g. adding "STACK_VALIDATION") to
trigger building objtool.

[ jpoimboe: remove aliases, add __weak macro, add error messages ]

Cc: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Matt Helsley <mhelsley@vmware.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/Build           | 13 +++++++----
 tools/objtool/Makefile        | 10 +++++++++-
 tools/objtool/arch.h          |  4 ++-
 tools/objtool/builtin-check.c |  2 +-
 tools/objtool/builtin-orc.c   |  3 +--
 tools/objtool/check.c         |  4 +--
 tools/objtool/check.h         |  4 +---
 tools/objtool/objtool.h       |  5 ++++-
 tools/objtool/orc.h           | 18 +---------------
 tools/objtool/orc_dump.c      |  3 ++-
 tools/objtool/orc_gen.c       |  1 +-
 tools/objtool/weak.c          | 40 ++++++++++++++++++++++++++++++++++-
 12 files changed, 73 insertions(+), 34 deletions(-)
 delete mode 100644 tools/objtool/orc.h
 create mode 100644 tools/objtool/weak.c

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 66f44f5..b7222d5 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -1,11 +1,16 @@
 objtool-y += arch/$(SRCARCH)/
+
+objtool-y += weak.o
+
+objtool-$(SUBCMD_CHECK) += check.o
+objtool-$(SUBCMD_CHECK) += special.o
+objtool-$(SUBCMD_ORC) += check.o
+objtool-$(SUBCMD_ORC) += orc_gen.o
+objtool-$(SUBCMD_ORC) += orc_dump.o
+
 objtool-y += builtin-check.o
 objtool-y += builtin-orc.o
-objtool-y += check.o
-objtool-y += orc_gen.o
-objtool-y += orc_dump.o
 objtool-y += elf.o
-objtool-y += special.o
 objtool-y += objtool.o
 
 objtool-y += libstring.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 6b91388..7770edc 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -46,6 +46,16 @@ elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E -
 CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
 AWK = awk
+
+SUBCMD_CHECK := n
+SUBCMD_ORC := n
+
+ifeq ($(SRCARCH),x86)
+	SUBCMD_CHECK := y
+	SUBCMD_ORC := y
+endif
+
+export SUBCMD_CHECK SUBCMD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
 
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index cd118eb..eda15a5 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -8,9 +8,11 @@
 
 #include <stdbool.h>
 #include <linux/list.h>
-#include "elf.h"
+#include "objtool.h"
 #include "cfi.h"
 
+#include <asm/orc_types.h>
+
 enum insn_type {
 	INSN_JUMP_CONDITIONAL,
 	INSN_JUMP_UNCONDITIONAL,
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index be42b71..7a44174 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -16,7 +16,7 @@
 #include <subcmd/parse-options.h>
 #include <string.h>
 #include "builtin.h"
-#include "check.h"
+#include "objtool.h"
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
 
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index 5f7cc61..b1dfe20 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -14,8 +14,7 @@
 
 #include <string.h>
 #include "builtin.h"
-#include "check.h"
-
+#include "objtool.h"
 
 static const char *orc_usage[] = {
 	"objtool orc generate [<options>] file.o",
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7a47ff9..63d65a7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -7,10 +7,10 @@
 #include <stdlib.h>
 
 #include "builtin.h"
+#include "cfi.h"
+#include "arch.h"
 #include "check.h"
-#include "elf.h"
 #include "special.h"
-#include "arch.h"
 #include "warn.h"
 
 #include <linux/hashtable.h>
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 3b59a1c..906b521 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -7,10 +7,8 @@
 #define _CHECK_H
 
 #include <stdbool.h>
-#include "objtool.h"
 #include "cfi.h"
 #include "arch.h"
-#include "orc.h"
 
 struct insn_state {
 	struct cfi_state cfi;
@@ -47,8 +45,6 @@ struct instruction {
 	struct orc_entry orc;
 };
 
-int check(const char *objname, bool orc);
-
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
 
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index d89616b..528028a 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -19,4 +19,9 @@ struct objtool_file {
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
+int check(const char *objname, bool orc);
+int orc_dump(const char *objname);
+int create_orc(struct objtool_file *file);
+int create_orc_sections(struct objtool_file *file);
+
 #endif /* _OBJTOOL_H */
diff --git a/tools/objtool/orc.h b/tools/objtool/orc.h
deleted file mode 100644
index ee28322..0000000
--- a/tools/objtool/orc.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
- */
-
-#ifndef _ORC_H
-#define _ORC_H
-
-#include <asm/orc_types.h>
-
-struct objtool_file;
-
-int create_orc(struct objtool_file *file);
-int create_orc_sections(struct objtool_file *file);
-
-int orc_dump(const char *objname);
-
-#endif /* _ORC_H */
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index ba4cbb1..fca46e0 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -4,7 +4,8 @@
  */
 
 #include <unistd.h>
-#include "orc.h"
+#include <asm/orc_types.h>
+#include "objtool.h"
 #include "warn.h"
 
 static const char *reg_name(unsigned int reg)
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 9d2bf2d..c954998 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -6,7 +6,6 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "orc.h"
 #include "check.h"
 #include "warn.h"
 
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
new file mode 100644
index 0000000..942ea5e
--- /dev/null
+++ b/tools/objtool/weak.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Matt Helsley <mhelsley@vmware.com>
+ * Weak definitions necessary to compile objtool without
+ * some subcommands (e.g. check, orc).
+ */
+
+#include <stdbool.h>
+#include <errno.h>
+#include "objtool.h"
+
+#define __weak __attribute__((weak))
+
+#define UNSUPPORTED(name)						\
+({									\
+	fprintf(stderr, "error: objtool: " name " not implemented\n");	\
+	return ENOSYS;							\
+})
+
+const char __weak *objname;
+
+int __weak check(const char *_objname, bool orc)
+{
+	UNSUPPORTED("check subcommand");
+}
+
+int __weak orc_dump(const char *_objname)
+{
+	UNSUPPORTED("orc");
+}
+
+int __weak create_orc(struct objtool_file *file)
+{
+	UNSUPPORTED("orc");
+}
+
+int __weak create_orc_sections(struct objtool_file *file)
+{
+	UNSUPPORTED("orc");
+}
