Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11BDC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D01C20732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgDJTgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:36:51 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:17465 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbgDJTgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:36:51 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:36:45 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id C41E440BB1;
        Fri, 10 Apr 2020 12:36:49 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 07/36] objtool: Make recordmcount into mcount subcmd
Date:   Fri, 10 Apr 2020 12:35:30 -0700
Message-ID: <7135a1b2e83afab0b73ad8a2b6d0762da73c8779.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than a standalone executable merge recordmcount as a sub command
of objtool. This is a small step towards cleaning up recordmcount and
eventually saving ELF code with objtool.

For the initial step all that's required is a bit of Makefile changes
and invoking the former main() function from recordmcount.c because the
subcommand code uses similar function arguments as main when dispatching.

objtool ignores some object files that tracing does not, specifically
those with OBJECT_FILES_NON_STANDARD Makefile variables. For this reason
we keep the recordmcount_dep separate from the objtool_dep. When using
objtool mcount we can also, like the other objtool invocations, just
depend on the binary rather than the source the binary is built from.

Subsequent patches will gradually convert recordmcount to use
more and more of libelf/objtool's ELF accessor code. This will both
clean up recordmcount to be more easily readable and remove
recordmcount's crude accessor wrapping code.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 Documentation/dontdiff              |  2 +-
 Documentation/trace/ftrace.rst      |  6 ++--
 Makefile                            |  6 ++--
 arch/arm64/include/asm/ftrace.h     |  2 +-
 arch/x86/include/asm/ftrace.h       |  2 +-
 kernel/trace/Kconfig                |  2 +-
 scripts/Makefile.build              | 21 +++++------
 scripts/sorttable.h                 |  2 +-
 tools/objtool/Build                 |  3 +-
 tools/objtool/Makefile              | 12 +------
 tools/objtool/arch/missing/Build    |  1 +
 tools/objtool/arch/missing/mcount.c | 16 +++++++++
 tools/objtool/builtin-mcount.c      | 56 +++++++++++++++++++++++++++++
 tools/objtool/builtin.h             |  2 ++
 tools/objtool/mcount.h              | 14 ++++++++
 tools/objtool/objtool.c             |  1 +
 tools/objtool/recordmcount.c        | 32 +++++------------
 17 files changed, 122 insertions(+), 58 deletions(-)
 create mode 100644 tools/objtool/arch/missing/mcount.c
 create mode 100644 tools/objtool/builtin-mcount.c
 create mode 100644 tools/objtool/mcount.h

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 72fc2e9e2b63..d7e0ec691e02 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -211,7 +211,7 @@ r420_reg_safe.h
 r600_reg_safe.h
 randomize_layout_hash.h
 randomize_layout_seed.h
-recordmcount
+objtool
 relocs
 rlim_names.h
 rn50_reg_safe.h
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 9adefcc3c7a8..6b9fc7cad543 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2684,8 +2684,8 @@ every kernel function, produced by the -pg switch in gcc),
 starts of pointing to a simple return. (Enabling FTRACE will
 include the -pg switch in the compiling of the kernel.)
 
-At compile time every C file object is run through the
-recordmcount program (located in the tools/objtool directory). This
+At compile time every C file object is run through objtool's
+mcount subcommand (located in the tools/objtool directory). This
 program will parse the ELF headers in the C object to find all
 the locations in the .text section that call mcount. Starting
 with gcc version 4.6, the -mfentry has been added for x86, which
@@ -2699,7 +2699,7 @@ can be traced.
 
 A section called "__mcount_loc" is created that holds
 references to all the mcount/fentry call sites in the .text section.
-The recordmcount program re-links this section back into the
+Running "objtool mcount" re-links this section back into the
 original object. The final linking stage of the kernel will add all these
 references into a single table.
 
diff --git a/Makefile b/Makefile
index c91342953d9e..d160720637e8 100644
--- a/Makefile
+++ b/Makefile
@@ -831,11 +831,11 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
 KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 ifdef CONFIG_DYNAMIC_FTRACE
 	ifdef CONFIG_HAVE_C_RECORDMCOUNT
-		BUILD_C_RECORDMCOUNT := y
-		export BUILD_C_RECORDMCOUNT
+		USE_OBJTOOL_MCOUNT := y
+		export USE_OBJTOOL_MCOUNT
 	endif
 endif
-endif
+endif # CONFIG_FUNCTION_TRACER
 
 # We trigger additional mismatches with less inlining
 ifdef CONFIG_DEBUG_SECTION_MISMATCH
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 91fa4baa1a93..5fd71bf592d5 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -62,7 +62,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 		return addr + AARCH64_INSN_SIZE;
 	/*
 	 * addr is the address of the mcount call instruction.
-	 * recordmcount does the necessary offset calculation.
+	 * "objtool mcount" does the necessary offset calculation.
 	 */
 	return addr;
 }
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 85be2f506272..4beb3c446910 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -23,7 +23,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	/*
 	 * addr is the address of the mcount call instruction.
-	 * recordmcount does the necessary offset calculation.
+	 * "objtool mcount" does the necessary offset calculation.
 	 */
 	return addr;
 }
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 402eef84c859..e46376e61be8 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -59,7 +59,7 @@ config HAVE_NOP_MCOUNT
 config HAVE_C_RECORDMCOUNT
 	bool
 	help
-	  C version of recordmcount available?
+	  C version of objtool mcount available?
 
 config TRACER_MAX_TRACE
 	bool
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 5bc668dbfb61..fdd2ded80f1e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -164,22 +164,22 @@ endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
 ifndef CC_USING_RECORD_MCOUNT
-# compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
-ifdef BUILD_C_RECORDMCOUNT
+# The compiler does not support generation of the __mcount_loc section.
+# Generate it manually with "objtool mcount record" or recordmcount.pl
+ifdef USE_OBJTOOL_MCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
 endif
 # Due to recursion, we must skip empty.o.
 # The empty.o file is created in the make process in order to determine
 # the target endianness and word size. It is made before all other C
-# files, including recordmcount.
+# files, including objtool.
 sub_cmd_record_mcount =					\
 	if [ $(@) != "scripts/mod/empty.o" ]; then	\
-		$(objtree)/tools/objtool/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
+		$(objtree)/tools/objtool/objtool mcount record $(RECORDMCOUNT_FLAGS) "$(@)";	\
 	fi;
 
-recordmcount_source := $(srctree)/tools/objtool/recordmcount.c \
-		    $(srctree)/tools/objtool/recordmcount.h
+recordmcount_dep := $(objtree)/tools/objtool/objtool
 else
 sub_cmd_record_mcount = perl $(srctree)/tools/objtool/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
@@ -187,8 +187,8 @@ sub_cmd_record_mcount = perl $(srctree)/tools/objtool/recordmcount.pl "$(ARCH)"
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
 	"$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
-recordmcount_source := $(srctree)/tools/objtool/recordmcount.pl
-endif # BUILD_C_RECORDMCOUNT
+recordmcount_dep := $(srctree)/tools/objtool/recordmcount.pl
+endif # USE_OBJTOOL_MCOUNT
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
 endif # CC_USING_RECORD_MCOUNT
@@ -232,7 +232,8 @@ endif # CONFIG_STACK_VALIDATION
 # Rebuild all objects when objtool changes, or is enabled/disabled.
 objtool_dep = $(objtool_obj)					\
 	      $(wildcard include/config/orc/unwinder.h		\
-			 include/config/stack/validation.h)
+			 include/config/stack/validation.h	\
+			 include/config/ftrace/mcount/record.h)
 
 ifdef CONFIG_TRIM_UNUSED_KSYMS
 cmd_gen_ksymdeps = \
@@ -264,7 +265,7 @@ cmd_undef_syms = echo
 endif
 
 # Built-in and composite module parts
-$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
+$(obj)/%.o: $(src)/%.c $(recordmcount_dep) $(objtool_dep) FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a2baa2fefb13..986aa3414cf6 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -11,7 +11,7 @@
  * Some of code was taken out of arch/x86/kernel/unwind_orc.c, written by:
  * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
  *
- * Some of this code was taken out of recordmcount.h written by:
+ * Some of this code was taken out of objtool mcount written by:
  *
  * Copyright 2009 John F. Reiser <jreiser@BitWagon.com>. All rights reserved.
  * Copyright 2010 Steven Rostedt <srostedt@redhat.com>, Red Hat Inc.
diff --git a/tools/objtool/Build b/tools/objtool/Build
index 35385b1bf313..c68cc8d42a1f 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -2,6 +2,7 @@ objtool-y += arch/missing/
 objtool-y += arch/$(SRCARCH)/
 objtool-y += builtin-check.o
 objtool-y += builtin-orc.o
+objtool-y += builtin-mcount.o recordmcount.o
 objtool-y += elf.o
 objtool-y += objtool.o
 
@@ -27,5 +28,3 @@ $(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
 $(OUTPUT)librbtree.o: ../lib/rbtree.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-
-recordmcount-y += recordmcount.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index e9cbf8728e67..5ab022c16d0f 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -25,12 +25,6 @@ OBJTOOL_IN := $(OBJTOOL)-in.o
 LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
 LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
 
-RECORDMCOUNT := $(OUTPUT)recordmcount
-RECORDMCOUNT_IN := $(RECORDMCOUNT)-in.o
-ifeq ($(BUILD_C_RECORDMCOUNT),y)
-all:  $(RECORDMCOUNT)
-endif
-
 all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
@@ -51,21 +45,17 @@ include $(srctree)/tools/build/Makefile.include
 $(OBJTOOL_IN): fixdep FORCE
 	@$(MAKE) $(build)=objtool
 
-$(RECORDMCOUNT_IN): fixdep FORCE
-	@$(MAKE) $(build)=recordmcount
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
 	@$(CONFIG_SHELL) ./sync-check.sh
 	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
 
-$(RECORDMCOUNT): $(RECORDMCOUNT_IN)
-	$(QUIET_LINK)$(CC) $(RECORDMCOUNT_IN) $(KBUILD_HOSTLDFLAGS) -o $@
 
 $(LIBSUBCMD): fixdep FORCE
 	$(Q)$(MAKE) -C $(SUBCMD_SRCDIR) OUTPUT=$(LIBSUBCMD_OUTPUT)
 
 clean:
-	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL) $(RECORDMCOUNT)
+	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT)arch/x86/inat-tables.c $(OUTPUT)fixdep
 
diff --git a/tools/objtool/arch/missing/Build b/tools/objtool/arch/missing/Build
index a2478db59484..5bfd8a600e35 100644
--- a/tools/objtool/arch/missing/Build
+++ b/tools/objtool/arch/missing/Build
@@ -1,3 +1,4 @@
 objtool-y += check.o
+objtool-y += mcount.o
 objtool-y += orc_gen.o
 objtool-y += orc_dump.o
diff --git a/tools/objtool/arch/missing/mcount.c b/tools/objtool/arch/missing/mcount.c
new file mode 100644
index 000000000000..53d403bb14f0
--- /dev/null
+++ b/tools/objtool/arch/missing/mcount.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Matt Helsley <mhelsley@vmware.com>
+ */
+
+#include <stdbool.h>
+#include "../../mcount.h"
+
+const char *objname;
+
+int missing_record_mcount(int argc, const char **argv)
+{
+	return 127;
+}
+
+int __attribute__ ((weak, alias("missing_record_mcount"))) record_mcount(int argc, const char **argv);
diff --git a/tools/objtool/builtin-mcount.c b/tools/objtool/builtin-mcount.c
new file mode 100644
index 000000000000..3f80615d366f
--- /dev/null
+++ b/tools/objtool/builtin-mcount.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * objtool mcount:
+ *
+ * This command analyzes a .o file and constructs a table of the locations of
+ * calls to 'mcount' useful to ftrace. We can optionally append this table to
+ * the object file ("objtool mcount record foo.o") or output it separately
+ * ("objtool mcount show"). The latter can be used to compare the expected
+ * callers of mcount to those actually found.
+ */
+
+#include <string.h>
+#include <subcmd/parse-options.h>
+#include "builtin.h"
+
+#include "mcount.h"
+
+static const char * const mcount_usage[] = {
+	"objtool mcount record [<options>] file.o [file2.o ...]",
+	NULL,
+};
+
+bool warn_on_notrace_sect;
+
+const static struct option mcount_options[] = {
+	OPT_BOOLEAN('w', "warn-on-notrace-section", &warn_on_notrace_sect,
+			"Emit a warning when a section omitting mcount "
+			"(possibly due to \"notrace\" marking) is encountered"),
+	OPT_END(),
+};
+
+bool is_cmd_mcount_available(void)
+{
+	return record_mcount != missing_record_mcount;
+}
+
+int cmd_mcount(int argc, const char **argv)
+{
+	argc--; argv++;
+	if (argc <= 0)
+		usage_with_options(mcount_usage, mcount_options);
+
+	if (!strncmp(argv[0], "record", 6)) {
+		argc = parse_options(argc, argv,
+				     mcount_options, mcount_usage, 0);
+		if (argc < 1)
+			usage_with_options(mcount_usage, mcount_options);
+
+		return record_mcount(argc, argv);
+	}
+
+	usage_with_options(mcount_usage, mcount_options);
+
+	return 0;
+}
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index 478558d38007..3e4123ac4a04 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -14,5 +14,7 @@ extern bool is_cmd_check_available(void);
 extern int cmd_check(int argc, const char **argv);
 extern bool is_cmd_orc_available(void);
 extern int cmd_orc(int argc, const char **argv);
+extern bool is_cmd_mcount_available(void);
+extern int cmd_mcount(int argc, const char **argv);
 
 #endif /* _BUILTIN_H */
diff --git a/tools/objtool/mcount.h b/tools/objtool/mcount.h
new file mode 100644
index 000000000000..1dae84b653e1
--- /dev/null
+++ b/tools/objtool/mcount.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Matt Helsley <mhelsley@vmware.com>
+ */
+
+#ifndef _MCOUNT_H
+#define _MCOUNT_H
+
+#include <stdbool.h>
+#include "objtool.h"
+
+int missing_record_mcount(int argc, const char **argv);
+int record_mcount(int argc, const char **argv);
+#endif /* _MCOUNT_H */
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index e901c40c76ef..2f2f6f81d0af 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -36,6 +36,7 @@ static const char objtool_usage_string[] =
 static struct cmd_struct objtool_cmds[] = {
 	{"check",	cmd_check,	"Perform stack metadata validation on an object file", is_cmd_check_available },
 	{"orc",		cmd_orc,	"Generate in-place ORC unwind tables for an object file", is_cmd_orc_available },
+	{"mcount",	cmd_mcount,	"Construct a table of locations of calls to mcount. Useful for ftrace.", is_cmd_mcount_available},
 };
 
 bool help;
diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 7225107a9aaf..f9844166fdaf 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -24,7 +24,6 @@
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
-#include <getopt.h>
 #include <elf.h>
 #include <fcntl.h>
 #include <stdio.h>
@@ -32,6 +31,8 @@
 #include <string.h>
 #include <unistd.h>
 
+#include "mcount.h"
+
 #ifndef EM_AARCH64
 #define EM_AARCH64	183
 #define R_AARCH64_NONE		0
@@ -47,7 +48,7 @@ static int mmap_failed; /* Boolean flag. */
 static char gpfx;	/* prefix for global symbol name (sometimes '_') */
 static struct stat sb;	/* Remember .st_size, etc. */
 static const char *altmcount;	/* alternate mcount symbol name */
-static int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
+extern int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
 static void *file_map;	/* pointer of the mapped file */
 static void *file_end;	/* pointer to the end of the mapped file */
 static int file_updated; /* flag to state file was changed */
@@ -488,7 +489,7 @@ static int do_file(char const *const fname)
 		goto out;
 	case ELFDATA2LSB:
 		if (*(unsigned char const *)&endian != 1) {
-			/* main() is big endian, file.o is little endian. */
+			/* objtool is big endian, file.o is little endian. */
 			w = w4rev;
 			w2 = w2rev;
 			w8 = w8rev;
@@ -501,7 +502,7 @@ static int do_file(char const *const fname)
 		break;
 	case ELFDATA2MSB:
 		if (*(unsigned char const *)&endian != 0) {
-			/* main() is little endian, file.o is big endian. */
+			/*  objtool is little endian, file.o is big endian. */
 			w = w4rev;
 			w2 = w2rev;
 			w8 = w8rev;
@@ -615,33 +616,16 @@ static int do_file(char const *const fname)
 	return rc;
 }
 
-int main(int argc, char *argv[])
+int record_mcount(int argc, const char **argv)
 {
 	const char ftrace[] = "/ftrace.o";
 	int ftrace_size = sizeof(ftrace) - 1;
 	int n_error = 0;  /* gcc-4.3.0 false positive complaint */
-	int c;
 	int i;
 
-	while ((c = getopt(argc, argv, "w")) >= 0) {
-		switch (c) {
-		case 'w':
-			warn_on_notrace_sect = 1;
-			break;
-		default:
-			fprintf(stderr, "usage: recordmcount [-w] file.o...\n");
-			return 0;
-		}
-	}
-
-	if ((argc - optind) < 1) {
-		fprintf(stderr, "usage: recordmcount [-w] file.o...\n");
-		return 0;
-	}
-
 	/* Process each file in turn, allowing deep failure. */
-	for (i = optind; i < argc; i++) {
-		char *file = argv[i];
+	for (i = 0; i < argc; i++) {
+		const char *file = argv[i];
 		int len;
 
 		/*
-- 
2.20.1

