Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D36C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3C02072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgFBTw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:52:57 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36854 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728087AbgFBTut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:50:49 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:50:47 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 0AB2640BF0;
        Tue,  2 Jun 2020 12:50:47 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 02/32] objtool: Make recordmcount into mcount subcmd
Date:   Tue, 2 Jun 2020 12:49:55 -0700
Message-ID: <0d44e0b1b8ebce4af8b90f73e351a003ef016005.1591125127.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1591125127.git.mhelsley@vmware.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
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
eventually sharing  ELF code with objtool.

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
 Documentation/dontdiff          |  2 +-
 Documentation/trace/ftrace.rst  |  6 ++--
 Makefile                        |  9 ++++--
 arch/arm64/include/asm/ftrace.h |  2 +-
 arch/x86/include/asm/ftrace.h   |  2 +-
 kernel/trace/Kconfig            |  2 +-
 scripts/Makefile.build          | 19 +++++++------
 scripts/sorttable.h             |  2 +-
 tools/objtool/Build             |  4 +--
 tools/objtool/Makefile          | 48 +++++++++++++++++++++++--------
 tools/objtool/builtin-mcount.c  | 50 +++++++++++++++++++++++++++++++++
 tools/objtool/builtin.h         |  2 ++
 tools/objtool/objtool.c         |  1 +
 tools/objtool/objtool.h         |  1 +
 tools/objtool/recordmcount.c    | 36 +++++++-----------------
 tools/objtool/weak.c            |  5 ++++
 16 files changed, 131 insertions(+), 60 deletions(-)
 create mode 100644 tools/objtool/builtin-mcount.c

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
index d353a0a65a71..99a4d8c61bdb 100644
--- a/Makefile
+++ b/Makefile
@@ -842,12 +842,12 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
 KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 ifdef CONFIG_DYNAMIC_FTRACE
 	ifdef CONFIG_HAVE_C_RECORDMCOUNT
-		BUILD_C_RECORDMCOUNT := y
-		export BUILD_C_RECORDMCOUNT
+		USE_OBJTOOL_MCOUNT := y
+		export USE_OBJTOOL_MCOUNT
 		objtool_target := tools/objtool FORCE
 	endif
 endif
-endif
+endif # CONFIG_FUNCTION_TRACER
 
 # We trigger additional mismatches with less inlining
 ifdef CONFIG_DEBUG_SECTION_MISMATCH
@@ -1168,6 +1168,9 @@ ifneq ($(has_libelf),1)
   ifdef CONFIG_UNWINDER_ORC
 	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
 	@false
+  else ifdef USE_OBJTOOL_MCOUNT
+	@echo "error: Cannot generate tracing metadata for CONFIG_DYNAMIC_FTRACE, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+	@false
   else
     ifeq ($(SKIP_STACK_VALIDATION),1)
 	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
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
index 84b9449be080..c849f3818369 100644
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
index 743647005f64..ae74647b06fa 100644
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
index d753facdb943..ab0aa6088039 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -163,22 +163,23 @@ endif
 
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
+recordmcount_dep = $(objtree)/tools/objtool/objtool	\
+			 $(wildcard include/config/ftrace/mcount/record.h)
 else
 sub_cmd_record_mcount = perl $(srctree)/tools/objtool/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
@@ -186,8 +187,8 @@ sub_cmd_record_mcount = perl $(srctree)/tools/objtool/recordmcount.pl "$(ARCH)"
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
 	"$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
-recordmcount_source := $(srctree)/tools/objtool/recordmcount.pl
-endif # BUILD_C_RECORDMCOUNT
+recordmcount_dep = $(srctree)/tools/objtool/recordmcount.pl
+endif # USE_OBJTOOL_MCOUNT
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
 endif # CC_USING_RECORD_MCOUNT
@@ -263,7 +264,7 @@ cmd_undef_syms = echo
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
index 4d399aff76de..f4f0515d4f91 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -7,9 +7,11 @@ objtool-$(SUBCMD_CHECK) += special.o
 objtool-$(SUBCMD_ORC) += check.o
 objtool-$(SUBCMD_ORC) += orc_gen.o
 objtool-$(SUBCMD_ORC) += orc_dump.o
+objtool-$(SUBCMD_MCOUNT) += recordmcount.o
 
 objtool-y += builtin-check.o
 objtool-y += builtin-orc.o
+objtool-y += builtin-mcount.o
 objtool-y += elf.o
 objtool-y += objtool.o
 
@@ -35,5 +37,3 @@ $(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
 $(OUTPUT)librbtree.o: ../lib/rbtree.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-
-recordmcount-y += recordmcount.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 285474a77fe9..ffef73f7f47e 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -31,12 +31,6 @@ OBJTOOL_IN := $(OBJTOOL)-in.o
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
@@ -55,13 +49,47 @@ AWK = awk
 
 SUBCMD_CHECK := n
 SUBCMD_ORC := n
+SUBCMD_MCOUNT := n
 
 ifeq ($(SRCARCH),x86)
 	SUBCMD_CHECK := y
 	SUBCMD_ORC := y
+	SUBCMD_MCOUNT := y
+endif
+
+ifeq ($(SRCARCH),arm)
+	SUBCMD_MCOUNT := y
+endif
+
+ifeq ($(SRCARCH),arm64)
+	SUBCMD_MCOUNT := y
+endif
+
+ifeq ($(SRCARCH),ia64)
+	SUBCMD_MCOUNT := y
+endif
+
+ifeq ($(SRCARCH),mips)
+	SUBCMD_MCOUNT := y
+endif
+
+ifeq ($(SRCARCH),powerpc)
+	SUBCMD_MCOUNT := y
+endif
+
+ifeq ($(SRCARCH),s390)
+	SUBCMD_MCOUNT := y
+endif
+
+ifeq ($(SRCARCH),sh)
+	SUBCMD_MCOUNT := y
+endif
+
+ifeq ($(SRCARCH),sparc)
+	SUBCMD_MCOUNT := y
 endif
 
-export SUBCMD_CHECK SUBCMD_ORC
+export SUBCMD_CHECK SUBCMD_ORC SUBCMD_MCOUNT
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
 
@@ -69,20 +97,16 @@ $(OBJTOOL_IN): fixdep FORCE
 	@$(CONFIG_SHELL) ./sync-check.sh
 	@$(MAKE) $(build)=objtool
 
-$(RECORDMCOUNT_IN): fixdep FORCE
-	@$(MAKE) $(build)=recordmcount
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
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
 
diff --git a/tools/objtool/builtin-mcount.c b/tools/objtool/builtin-mcount.c
new file mode 100644
index 000000000000..4ffc105ab7bb
--- /dev/null
+++ b/tools/objtool/builtin-mcount.c
@@ -0,0 +1,50 @@
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
+#include "objtool.h"
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
index 85c979caa367..9c7331592fa7 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -12,5 +12,7 @@ extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
+extern bool is_cmd_mcount_available(void);
+extern int cmd_mcount(int argc, const char **argv);
 
 #endif /* _BUILTIN_H */
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 58fdda510653..b2d6b9fec7dd 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -35,6 +35,7 @@ static const char objtool_usage_string[] =
 static struct cmd_struct objtool_cmds[] = {
 	{"check",	cmd_check,	"Perform stack metadata validation on an object file" },
 	{"orc",		cmd_orc,	"Generate in-place ORC unwind tables for an object file" },
+	{"mcount",	cmd_mcount,	"Construct a table of locations of calls to mcount. Useful for ftrace."},
 };
 
 bool help;
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index 528028a66816..c6563aa9d921 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -21,6 +21,7 @@ struct objtool_file {
 
 int check(const char *objname, bool orc);
 int orc_dump(const char *objname);
+int record_mcount(int argc, const char **argv);
 int create_orc(struct objtool_file *file);
 int create_orc_sections(struct objtool_file *file);
 
diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 7225107a9aaf..601e83840085 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * recordmcount.c: construct a table of the locations of calls to 'mcount'
- * so that ftrace can find them quickly.
+ * Construct a table of the locations of calls to 'mcount' so that ftrace
+ * can find them quickly.
  * Copyright 2009 John F. Reiser <jreiser@BitWagon.com>.  All rights reserved.
  *
  * Restructured to fit Linux format, as well as other updates:
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
 
+#include "objtool.h"
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
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index 942ea5e8ac36..0c9161bb1612 100644
--- a/tools/objtool/weak.c
+++ b/tools/objtool/weak.c
@@ -29,6 +29,11 @@ int __weak orc_dump(const char *_objname)
 	UNSUPPORTED("orc");
 }
 
+int __weak record_mcount(int argc, const char **argv)
+{
+	UNSUPPORTED("mcount");
+}
+
 int __weak create_orc(struct objtool_file *file)
 {
 	UNSUPPORTED("orc");
-- 
2.20.1

