Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C4FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3177206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wu/Pattq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETOQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:16:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53666 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726439AbgETOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589984171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/xFaPOI/Q/3j+lKwnr4//8SjMG1/ths1TyHlaw6iw50=;
        b=Wu/PattqeojO7HDNNKONk3uz6nAr8z5yI4xXNf5BMglqw2/p5tmEH2wYNuBPHvR1Dd5O9s
        L/jEzVA2lKZr1B6L88qe7QXVHGR078B2O65OGX3jcC/kjZt+A+bxDgiucMx5/lopfjwGc/
        8nt3jZ0XGymdnRTQo7m9+2X0TX+04eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-EftPdd04PnOmMhR_Vet6Zw-1; Wed, 20 May 2020 10:16:09 -0400
X-MC-Unique: EftPdd04PnOmMhR_Vet6Zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC25919057A2;
        Wed, 20 May 2020 14:16:07 +0000 (UTC)
Received: from treble (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E93CF2E18C;
        Wed, 20 May 2020 14:16:06 +0000 (UTC)
Date:   Wed, 20 May 2020 09:16:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] objtool: Enable compilation of objtool for all
 architectures
Message-ID: <20200520141604.npsaelrakozqzur6@treble>
References: <cover.1589913349.git.mhelsley@vmware.com>
 <96252a8eee50710f4fe115ca516f0e6058b9f66b.1589913349.git.mhelsley@vmware.com>
 <20200519211829.p2d454nz3h3mdxsa@treble>
 <20200519214637.GS9040@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200519214637.GS9040@rlwimi.vmware.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 02:46:37PM -0700, Matt Helsley wrote:
> On Tue, May 19, 2020 at 04:18:29PM -0500, Josh Poimboeuf wrote:
> > On Tue, May 19, 2020 at 01:55:33PM -0700, Matt Helsley wrote:
> > > +const char __attribute__ ((weak)) *objname;
> > > +
> > > +int missing_check(const char *_objname, bool orc)
> > > +{
> > > +	return 127;
> > > +}
> > > +
> > > +int __attribute__ ((weak, alias("missing_check"))) check(const char *_objname, bool orc);
> > > +
> > > +int missing_orc_dump(const char *_objname)
> > > +{
> > > +	return 127;
> > > +}
> > > +
> > > +int __attribute__ ((weak, alias("missing_orc_dump"))) orc_dump(const char *_objname);
> > > +
> > > +int __attribute__ ((weak)) create_orc(struct objtool_file *file)
> > > +{
> > > +	return 127;
> > > +}
> > > +
> > > +int __attribute__ ((weak)) create_orc_sections(struct objtool_file *file)
> > > +{
> > > +	return 127;
> > > +}
> > 
> > I think the aliased "missing_" functions are no longer needed, right?
> > i.e. can we just have weak versions of check() and orc_dump()?
> 
> Oops, Yeah, we can remove those aliases. I can fix and resend this one if you
> like. 

I made that change along with Julien's suggestion, and also made a few
other changes to the weak file: a __weak macro and some error messages.

Does this look ok?

From: Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH] objtool: Enable compilation of objtool for all architectures

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
 tools/objtool/Build           | 13 ++++++++----
 tools/objtool/Makefile        | 10 +++++++++
 tools/objtool/arch.h          |  4 +++-
 tools/objtool/builtin-check.c |  2 +-
 tools/objtool/builtin-orc.c   |  3 +--
 tools/objtool/check.c         |  4 ++--
 tools/objtool/check.h         |  4 ----
 tools/objtool/objtool.h       |  5 +++++
 tools/objtool/orc.h           | 18 ----------------
 tools/objtool/orc_dump.c      |  3 ++-
 tools/objtool/orc_gen.c       |  1 -
 tools/objtool/weak.c          | 40 +++++++++++++++++++++++++++++++++++
 12 files changed, 73 insertions(+), 34 deletions(-)
 delete mode 100644 tools/objtool/orc.h
 create mode 100644 tools/objtool/weak.c

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 66f44f5cd2a6..b7222d5cc7bc 100644
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
index 6b91388aecbb..7770edcda3a0 100644
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
index cd118eb4248a..eda15a5a285e 100644
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
index be42b716166b..7a44174967b5 100644
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
index 5f7cc6157edd..b1dfe2007962 100644
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
index 7a47ff9d39f7..63d65a702900 100644
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
index 3b59a1cbcff5..906b5210f7ca 100644
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
index d89616b2ca39..528028a66816 100644
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
index ee2832221e62..000000000000
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
index ba4cbb1cdd63..fca46e006fc2 100644
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
index 9d2bf2daaaa6..c9549988121a 100644
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
index 000000000000..3c703811a2bc
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
+#define UNSUPPORTED(cmd)						\
+({									\
+	fprintf(stderr, "error: objtool: " cmd " not implemented\n");	\
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
-- 
2.21.1


