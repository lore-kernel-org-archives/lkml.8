Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9279C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CA2207D5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFBTuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:50:52 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36854 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbgFBTus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:50:48 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:50:46 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 4293540BEF;
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
Subject: [RFC][PATCH v4 01/32] objtool: Prepare to merge recordmcount
Date:   Tue, 2 Jun 2020 12:49:54 -0700
Message-ID: <4a71852d8ca0a245588159a6bbdc064619de91d9.1591125127.git.mhelsley@vmware.com>
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

Move recordmcount into the objtool directory. We keep this step separate
so changes which turn recordmcount into a subcommand of objtool don't
get obscured.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 Documentation/trace/ftrace-design.rst      |  4 ++--
 Documentation/trace/ftrace.rst             |  2 +-
 Makefile                                   | 15 +++++++++------
 scripts/.gitignore                         |  1 -
 scripts/Makefile                           |  1 -
 scripts/Makefile.build                     | 11 ++++++-----
 tools/objtool/.gitignore                   |  1 +
 tools/objtool/Build                        |  2 ++
 tools/objtool/Makefile                     | 13 ++++++++++++-
 {scripts => tools/objtool}/recordmcount.c  |  0
 {scripts => tools/objtool}/recordmcount.h  |  0
 {scripts => tools/objtool}/recordmcount.pl |  0
 12 files changed, 33 insertions(+), 17 deletions(-)
 rename {scripts => tools/objtool}/recordmcount.c (100%)
 rename {scripts => tools/objtool}/recordmcount.h (100%)
 rename {scripts => tools/objtool}/recordmcount.pl (100%)

diff --git a/Documentation/trace/ftrace-design.rst b/Documentation/trace/ftrace-design.rst
index a8e22e0db63c..dea8db5e79d0 100644
--- a/Documentation/trace/ftrace-design.rst
+++ b/Documentation/trace/ftrace-design.rst
@@ -261,7 +261,7 @@ You need very few things to get the syscalls tracing in an arch.
 HAVE_FTRACE_MCOUNT_RECORD
 -------------------------
 
-See scripts/recordmcount.pl for more info.  Just fill in the arch-specific
+See tools/objtool/recordmcount.pl for more info.  Just fill in the arch-specific
 details for how to locate the addresses of mcount call sites via objdump.
 This option doesn't make much sense without also implementing dynamic ftrace.
 
@@ -379,7 +379,7 @@ linux/ftrace.h for the functions::
 	ftrace_make_call()
 
 The rec->ip value is the address of the mcount call site that was collected
-by the scripts/recordmcount.pl during build time.
+by the tools/objtool/recordmcount.pl during build time.
 
 The last function is used to do runtime patching of the active tracer.  This
 will be modifying the assembly code at the location of the ftrace_call symbol
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 3b5614b1d1a5..9adefcc3c7a8 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2685,7 +2685,7 @@ starts of pointing to a simple return. (Enabling FTRACE will
 include the -pg switch in the compiling of the kernel.)
 
 At compile time every C file object is run through the
-recordmcount program (located in the scripts directory). This
+recordmcount program (located in the tools/objtool directory). This
 program will parse the ELF headers in the C object to find all
 the locations in the .text section that call mcount. Starting
 with gcc version 4.6, the -mfentry has been added for x86, which
diff --git a/Makefile b/Makefile
index 04f5662ae61a..d353a0a65a71 100644
--- a/Makefile
+++ b/Makefile
@@ -844,6 +844,7 @@ ifdef CONFIG_DYNAMIC_FTRACE
 	ifdef CONFIG_HAVE_C_RECORDMCOUNT
 		BUILD_C_RECORDMCOUNT := y
 		export BUILD_C_RECORDMCOUNT
+		objtool_target := tools/objtool FORCE
 	endif
 endif
 endif
@@ -1023,10 +1024,10 @@ endif
 export mod_sign_cmd
 
 HOST_LIBELF_LIBS = $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
+has_libelf := $(call try-run,\
+		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
 
 ifdef CONFIG_STACK_VALIDATION
-  has_libelf := $(call try-run,\
-		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
   ifeq ($(has_libelf),1)
     objtool_target := tools/objtool FORCE
   else
@@ -1163,13 +1164,15 @@ uapi-asm-generic:
 
 PHONY += prepare-objtool
 prepare-objtool: $(objtool_target)
-ifeq ($(SKIP_STACK_VALIDATION),1)
-ifdef CONFIG_UNWINDER_ORC
+ifneq ($(has_libelf),1)
+  ifdef CONFIG_UNWINDER_ORC
 	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
 	@false
-else
+  else
+    ifeq ($(SKIP_STACK_VALIDATION),1)
 	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
-endif
+    endif
+  endif
 endif
 
 # Generate some files
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 0d1c8e217cd7..dafda6d2c306 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -2,7 +2,6 @@
 bin2c
 kallsyms
 unifdef
-recordmcount
 sorttable
 asn1_compiler
 extract-cert
diff --git a/scripts/Makefile b/scripts/Makefile
index 95ecf970c74c..d8d81de4f1cb 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -5,7 +5,6 @@
 
 always-$(CONFIG_BUILD_BIN2C)			+= bin2c
 always-$(CONFIG_KALLSYMS)			+= kallsyms
-always-$(BUILD_C_RECORDMCOUNT)			+= recordmcount
 always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
 always-$(CONFIG_ASN1)				+= asn1_compiler
 always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9fcbfac15d1d..d753facdb943 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -174,18 +174,19 @@ endif
 # files, including recordmcount.
 sub_cmd_record_mcount =					\
 	if [ $(@) != "scripts/mod/empty.o" ]; then	\
-		$(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
+		$(objtree)/tools/objtool/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
 	fi;
-recordmcount_source := $(srctree)/scripts/recordmcount.c \
-		    $(srctree)/scripts/recordmcount.h
+
+recordmcount_source := $(srctree)/tools/objtool/recordmcount.c \
+		    $(srctree)/tools/objtool/recordmcount.h
 else
-sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
+sub_cmd_record_mcount = perl $(srctree)/tools/objtool/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
 	"$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
-recordmcount_source := $(srctree)/scripts/recordmcount.pl
+recordmcount_source := $(srctree)/tools/objtool/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
diff --git a/tools/objtool/.gitignore b/tools/objtool/.gitignore
index 45cefda24c7b..ea441abcd1d3 100644
--- a/tools/objtool/.gitignore
+++ b/tools/objtool/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 arch/x86/lib/inat-tables.c
 objtool
+recordmcount
 fixdep
diff --git a/tools/objtool/Build b/tools/objtool/Build
index b7222d5cc7bc..4d399aff76de 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -35,3 +35,5 @@ $(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
 $(OUTPUT)librbtree.o: ../lib/rbtree.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+recordmcount-y += recordmcount.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 7770edcda3a0..285474a77fe9 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -31,6 +31,12 @@ OBJTOOL_IN := $(OBJTOOL)-in.o
 LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
 LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
 
+RECORDMCOUNT := $(OUTPUT)recordmcount
+RECORDMCOUNT_IN := $(RECORDMCOUNT)-in.o
+ifeq ($(BUILD_C_RECORDMCOUNT),y)
+all:  $(RECORDMCOUNT)
+endif
+
 all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
@@ -63,15 +69,20 @@ $(OBJTOOL_IN): fixdep FORCE
 	@$(CONFIG_SHELL) ./sync-check.sh
 	@$(MAKE) $(build)=objtool
 
+$(RECORDMCOUNT_IN): fixdep FORCE
+	@$(MAKE) $(build)=recordmcount
+
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
 	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
 
+$(RECORDMCOUNT): $(RECORDMCOUNT_IN)
+	$(QUIET_LINK)$(CC) $(RECORDMCOUNT_IN) $(KBUILD_HOSTLDFLAGS) -o $@
 
 $(LIBSUBCMD): fixdep FORCE
 	$(Q)$(MAKE) -C $(SUBCMD_SRCDIR) OUTPUT=$(LIBSUBCMD_OUTPUT)
 
 clean:
-	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
+	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL) $(RECORDMCOUNT)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT)arch/x86/inat-tables.c $(OUTPUT)fixdep
 
diff --git a/scripts/recordmcount.c b/tools/objtool/recordmcount.c
similarity index 100%
rename from scripts/recordmcount.c
rename to tools/objtool/recordmcount.c
diff --git a/scripts/recordmcount.h b/tools/objtool/recordmcount.h
similarity index 100%
rename from scripts/recordmcount.h
rename to tools/objtool/recordmcount.h
diff --git a/scripts/recordmcount.pl b/tools/objtool/recordmcount.pl
similarity index 100%
rename from scripts/recordmcount.pl
rename to tools/objtool/recordmcount.pl
-- 
2.20.1

