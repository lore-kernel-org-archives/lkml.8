Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BF3C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446F020732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgDJTg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:36:29 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:55118 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726715AbgDJTg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:36:28 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:36:22 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id EE71EB2C7E;
        Fri, 10 Apr 2020 15:36:26 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 03/36] objtool: Enable compilation of objtool for all architectures
Date:   Fri, 10 Apr 2020 12:35:26 -0700
Message-ID: <a96d42818c7e8f2a8bd2e151b8c220193f4ae986.1586468801.git.mhelsley@vmware.com>
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

objtool currently only compiles for x86 architectures. This is
fine as it presently does not support tooling for other
architectures. However, we would like to be able to convert other
kernel tools to run as objtool sub commands because they too
process ELF object files. This will allow us to convert tools
such as recordmcount to use objtool's ELF code.

Since much of recordmcount's ELF code is copy-paste code to/from
a variety of other kernel tools (look at modpost for example) this
means that if we can convert recordmcount we can convert more.

We define a "missing" architecture which contains weak definitions
for tools that do not exist on all architectures. In this case the
"check" and "orc" tools do not exist on all architectures.

To test building for other architectures ($arch below):

	cd tools/objtool/arch
	ln -s missing $arch
	make O=build-$arch ARCH=$arch tools/objtool

This uses the weak, no-op definitions of the "check" and "orc"
commands for the newly-supported architecture. Presently these
exit with 127 to indicate that the subcommands are missing.
Subsequent patches can then be made to determine if the weak
definitions are used and explicitly report a missing command,
and even to list which subcommands are supported (perhaps if
no subcommand is specified it can list the supported subcommands).

objtool is not currently wired in to KConfig to be built for other
architectures because it's not needed for those architectures and
there are no commands it supports other than those for x86.

This commit allows us to demonstrate the pattern of adding
architecture support and isolates moving the various files from
adding support for more objtool subcommands.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/Build                     |  4 ---
 tools/objtool/arch/missing/Build        |  3 ++
 tools/objtool/arch/missing/check.c      | 14 +++++++++
 tools/objtool/arch/missing/orc_dump.c   | 11 +++++++
 tools/objtool/arch/missing/orc_gen.c    | 16 ++++++++++
 tools/objtool/arch/x86/Build            |  4 +++
 tools/objtool/{ => arch/x86}/arch.h     | 42 ++++++++++++++++++++++++-
 tools/objtool/{ => arch/x86}/cfi.h      |  0
 tools/objtool/{ => arch/x86}/check.c    | 11 ++++---
 tools/objtool/arch/x86/decode.c         |  2 +-
 tools/objtool/{ => arch/x86}/orc_dump.c |  5 +--
 tools/objtool/{ => arch/x86}/orc_gen.c  |  9 ++++--
 tools/objtool/{ => arch/x86}/special.c  |  4 +--
 tools/objtool/{ => arch/x86}/special.h  |  2 +-
 tools/objtool/builtin-orc.c             |  2 +-
 tools/objtool/check.h                   | 37 ----------------------
 tools/objtool/objtool.h                 |  2 +-
 tools/objtool/orc.h                     |  2 --
 18 files changed, 110 insertions(+), 60 deletions(-)
 create mode 100644 tools/objtool/arch/missing/Build
 create mode 100644 tools/objtool/arch/missing/check.c
 create mode 100644 tools/objtool/arch/missing/orc_dump.c
 create mode 100644 tools/objtool/arch/missing/orc_gen.c
 rename tools/objtool/{ => arch/x86}/arch.h (59%)
 rename tools/objtool/{ => arch/x86}/cfi.h (100%)
 rename tools/objtool/{ => arch/x86}/check.c (99%)
 rename tools/objtool/{ => arch/x86}/orc_dump.c (98%)
 rename tools/objtool/{ => arch/x86}/orc_gen.c (96%)
 rename tools/objtool/{ => arch/x86}/special.c (98%)
 rename tools/objtool/{ => arch/x86}/special.h (95%)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 66f44f5cd2a6..3178c00072f5 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -1,11 +1,7 @@
 objtool-y += arch/$(SRCARCH)/
 objtool-y += builtin-check.o
 objtool-y += builtin-orc.o
-objtool-y += check.o
-objtool-y += orc_gen.o
-objtool-y += orc_dump.o
 objtool-y += elf.o
-objtool-y += special.o
 objtool-y += objtool.o
 
 objtool-y += libstring.o
diff --git a/tools/objtool/arch/missing/Build b/tools/objtool/arch/missing/Build
new file mode 100644
index 000000000000..a2478db59484
--- /dev/null
+++ b/tools/objtool/arch/missing/Build
@@ -0,0 +1,3 @@
+objtool-y += check.o
+objtool-y += orc_gen.o
+objtool-y += orc_dump.o
diff --git a/tools/objtool/arch/missing/check.c b/tools/objtool/arch/missing/check.c
new file mode 100644
index 000000000000..5eac14c8c6a5
--- /dev/null
+++ b/tools/objtool/arch/missing/check.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Matt Helsley <mhelsley@vmware.com>
+ */
+
+#include <stdbool.h>
+#include "../../check.h"
+
+const char *objname;
+
+int __attribute__ ((weak)) check(const char *_objname, bool orc)
+{
+	return 127;
+}
diff --git a/tools/objtool/arch/missing/orc_dump.c b/tools/objtool/arch/missing/orc_dump.c
new file mode 100644
index 000000000000..f7ebb3a2ce9e
--- /dev/null
+++ b/tools/objtool/arch/missing/orc_dump.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#include "../../orc.h"
+
+int __attribute__ ((weak)) orc_dump(const char *_objname)
+{
+	return 127;
+}
diff --git a/tools/objtool/arch/missing/orc_gen.c b/tools/objtool/arch/missing/orc_gen.c
new file mode 100644
index 000000000000..4bf62ddf58a4
--- /dev/null
+++ b/tools/objtool/arch/missing/orc_gen.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#include "../../orc.h"
+
+int __attribute__ ((weak)) create_orc(struct objtool_file *file)
+{
+	return 127;
+}
+
+int __attribute__ ((weak)) create_orc_sections(struct objtool_file *file)
+{
+	return 127;
+}
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index 7c5004008e97..b5669c3f7a0e 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,4 +1,8 @@
 objtool-y += decode.o
+objtool-y += check.o
+objtool-y += orc_gen.o
+objtool-y += orc_dump.o
+objtool-y += special.o
 
 inat_tables_script = ../arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = ../arch/x86/lib/x86-opcode-map.txt
diff --git a/tools/objtool/arch.h b/tools/objtool/arch/x86/arch.h
similarity index 59%
rename from tools/objtool/arch.h
rename to tools/objtool/arch/x86/arch.h
index ced3765c4f44..81d07a5c3d29 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch/x86/arch.h
@@ -8,9 +8,12 @@
 
 #include <stdbool.h>
 #include <linux/list.h>
-#include "elf.h"
+#include "../../elf.h"
 #include "cfi.h"
 
+#include <asm/orc_types.h>
+#include "../../orc.h"
+
 enum insn_type {
 	INSN_JUMP_CONDITIONAL,
 	INSN_JUMP_UNCONDITIONAL,
@@ -66,6 +69,43 @@ struct stack_op {
 	struct op_src src;
 };
 
+struct insn_state {
+	struct cfi_reg cfa;
+	struct cfi_reg regs[CFI_NUM_REGS];
+	int stack_size;
+	unsigned char type;
+	bool bp_scratch;
+	bool drap, end, uaccess, df;
+	bool noinstr;
+	s8 instr;
+	unsigned int uaccess_stack;
+	int drap_reg, drap_offset;
+	struct cfi_reg vals[CFI_NUM_REGS];
+};
+
+struct instruction {
+	struct list_head list;
+	struct hlist_node hash;
+	struct section *sec;
+	unsigned long offset;
+	unsigned int len;
+	enum insn_type type;
+	unsigned long immediate;
+	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
+	bool retpoline_safe;
+	s8 instr;
+	u8 visited;
+	struct symbol *call_dest;
+	struct instruction *jump_dest;
+	struct instruction *first_jump_src;
+	struct rela *jump_table;
+	struct list_head alts;
+	struct symbol *func;
+	struct stack_op stack_op;
+	struct insn_state state;
+	struct orc_entry orc;
+};
+
 void arch_initial_func_cfi_state(struct cfi_state *state);
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
diff --git a/tools/objtool/cfi.h b/tools/objtool/arch/x86/cfi.h
similarity index 100%
rename from tools/objtool/cfi.h
rename to tools/objtool/arch/x86/cfi.h
diff --git a/tools/objtool/check.c b/tools/objtool/arch/x86/check.c
similarity index 99%
rename from tools/objtool/check.c
rename to tools/objtool/arch/x86/check.c
index 8dd01f986fbb..3663a6c47146 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/arch/x86/check.c
@@ -6,12 +6,13 @@
 #include <string.h>
 #include <stdlib.h>
 
-#include "builtin.h"
-#include "check.h"
-#include "elf.h"
-#include "special.h"
+#include "../../builtin.h"
+#include "cfi.h"
 #include "arch.h"
-#include "warn.h"
+#include "../../check.h"
+#include "../../elf.h"
+#include "special.h"
+#include "../../warn.h"
 
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index a62e032863a8..3052b11f5eeb 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -12,7 +12,7 @@
 #include "../../../arch/x86/lib/insn.c"
 
 #include "../../elf.h"
-#include "../../arch.h"
+#include "arch.h"
 #include "../../warn.h"
 
 static unsigned char op_to_cfi_reg[][2] = {
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/arch/x86/orc_dump.c
similarity index 98%
rename from tools/objtool/orc_dump.c
rename to tools/objtool/arch/x86/orc_dump.c
index 13ccf775a83a..6eb8e595463d 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/arch/x86/orc_dump.c
@@ -4,8 +4,9 @@
  */
 
 #include <unistd.h>
-#include "orc.h"
-#include "warn.h"
+#include <asm/orc_types.h>
+#include "../../orc.h"
+#include "../../warn.h"
 
 static const char *reg_name(unsigned int reg)
 {
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/arch/x86/orc_gen.c
similarity index 96%
rename from tools/objtool/orc_gen.c
rename to tools/objtool/arch/x86/orc_gen.c
index 41e4a2754da4..0c9d3a2b3094 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/arch/x86/orc_gen.c
@@ -5,10 +5,13 @@
 
 #include <stdlib.h>
 #include <string.h>
+#include <asm/orc_types.h>
 
-#include "orc.h"
-#include "check.h"
-#include "warn.h"
+#include "../../orc.h"
+#include "cfi.h"
+#include "arch.h"
+#include "../../check.h"
+#include "../../warn.h"
 
 int create_orc(struct objtool_file *file)
 {
diff --git a/tools/objtool/special.c b/tools/objtool/arch/x86/special.c
similarity index 98%
rename from tools/objtool/special.c
rename to tools/objtool/arch/x86/special.c
index e74e0189de22..677b6efe1446 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -11,9 +11,9 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "builtin.h"
+#include "../../builtin.h"
 #include "special.h"
-#include "warn.h"
+#include "../../warn.h"
 
 #define EX_ENTRY_SIZE		12
 #define EX_ORIG_OFFSET		0
diff --git a/tools/objtool/special.h b/tools/objtool/arch/x86/special.h
similarity index 95%
rename from tools/objtool/special.h
rename to tools/objtool/arch/x86/special.h
index 35061530e46e..beba41950725 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/arch/x86/special.h
@@ -7,7 +7,7 @@
 #define _SPECIAL_H
 
 #include <stdbool.h>
-#include "elf.h"
+#include "../../elf.h"
 
 struct special_alt {
 	struct list_head list;
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index 5f7cc6157edd..e6e54ae4ab75 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -15,7 +15,7 @@
 #include <string.h>
 #include "builtin.h"
 #include "check.h"
-
+#include "orc.h"
 
 static const char *orc_usage[] = {
 	"objtool orc generate [<options>] file.o",
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index ec6ff7f0970c..4d34bfc84dc7 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -8,43 +8,6 @@
 
 #include <stdbool.h>
 #include "objtool.h"
-#include "cfi.h"
-#include "arch.h"
-#include "orc.h"
-
-struct insn_state {
-	struct cfi_reg cfa;
-	struct cfi_reg regs[CFI_NUM_REGS];
-	int stack_size;
-	unsigned char type;
-	bool bp_scratch;
-	bool drap, end, uaccess, df;
-	unsigned int uaccess_stack;
-	int drap_reg, drap_offset;
-	struct cfi_reg vals[CFI_NUM_REGS];
-};
-
-struct instruction {
-	struct list_head list;
-	struct hlist_node hash;
-	struct section *sec;
-	unsigned long offset;
-	unsigned int len;
-	enum insn_type type;
-	unsigned long immediate;
-	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
-	bool retpoline_safe;
-	u8 visited;
-	struct symbol *call_dest;
-	struct instruction *jump_dest;
-	struct instruction *first_jump_src;
-	struct rela *jump_table;
-	struct list_head alts;
-	struct symbol *func;
-	struct stack_op stack_op;
-	struct insn_state state;
-	struct orc_entry orc;
-};
 
 int check(const char *objname, bool orc);
 
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index afa52fe6f644..5ff352083056 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -17,4 +17,4 @@ struct objtool_file {
 	DECLARE_HASHTABLE(insn_hash, 20);
 	bool ignore_unreachables, c_file, hints, rodata;
 };
-#endif
+#endif /* _OBJTOOL_H */
diff --git a/tools/objtool/orc.h b/tools/objtool/orc.h
index ee2832221e62..c67f451d7610 100644
--- a/tools/objtool/orc.h
+++ b/tools/objtool/orc.h
@@ -6,8 +6,6 @@
 #ifndef _ORC_H
 #define _ORC_H
 
-#include <asm/orc_types.h>
-
 struct objtool_file;
 
 int create_orc(struct objtool_file *file);
-- 
2.20.1

