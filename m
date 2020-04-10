Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4250DC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC1C20769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgDJTgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:36:45 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:55137 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbgDJTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:36:45 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:36:40 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 1626EB2C87;
        Fri, 10 Apr 2020 15:36:44 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 06/36] objtool: Prepare to merge recordmcount
Date:   Fri, 10 Apr 2020 12:35:29 -0700
Message-ID: <d6dc160104731b30b364d9f9fb78261736f44d4e.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
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
 scripts/.gitignore                         |  1 -
 scripts/Makefile                           |  1 -
 scripts/Makefile.build                     | 11 ++++++-----
 tools/objtool/.gitignore                   |  1 +
 tools/objtool/Build                        |  2 ++
 tools/objtool/Makefile                     | 13 ++++++++++++-
 {scripts => tools/objtool}/recordmcount.c  |  0
 {scripts => tools/objtool}/recordmcount.h  |  0
 {scripts => tools/objtool}/recordmcount.pl |  0
 11 files changed, 24 insertions(+), 11 deletions(-)
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
index 5e75802b1a44..f0f869364e5a 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -9,7 +9,6 @@ HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
 always-$(CONFIG_BUILD_BIN2C)			+= bin2c
 always-$(CONFIG_KALLSYMS)			+= kallsyms
-always-$(BUILD_C_RECORDMCOUNT)			+= recordmcount
 always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
 always-$(CONFIG_ASN1)				+= asn1_compiler
 always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a1730d42e5f3..5bc668dbfb61 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -175,18 +175,19 @@ endif
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
index e372cddd86e0..35385b1bf313 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -27,3 +27,5 @@ $(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
 $(OUTPUT)librbtree.o: ../lib/rbtree.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+recordmcount-y += recordmcount.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index ee08aeff30a1..e9cbf8728e67 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -25,6 +25,12 @@ OBJTOOL_IN := $(OBJTOOL)-in.o
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
@@ -45,16 +51,21 @@ include $(srctree)/tools/build/Makefile.include
 $(OBJTOOL_IN): fixdep FORCE
 	@$(MAKE) $(build)=objtool
 
+$(RECORDMCOUNT_IN): fixdep FORCE
+	@$(MAKE) $(build)=recordmcount
+
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
 	@$(CONFIG_SHELL) ./sync-check.sh
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

