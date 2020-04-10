Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A419C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCC420769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgDJTgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:36:22 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25452 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgDJTgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:36:22 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:36:17 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 417F7B2C6E;
        Fri, 10 Apr 2020 15:36:21 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 02/36] objtool: Move struct objtool_file into arch-independent header
Date:   Fri, 10 Apr 2020 12:35:25 -0700
Message-ID: <e05a8c8c717895fafb443bb6bc5d7d5f3c2de38e.1586468801.git.mhelsley@vmware.com>
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

The objtool_file structure describing the files objtool works on is
not architecture dependent -- it's not x86 only. So we can split it
out from the check.h header that will move into arch/x86 and reuse
it for future objtool subcommands.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/check.h   | 10 +---------
 tools/objtool/objtool.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 9 deletions(-)
 create mode 100644 tools/objtool/objtool.h

diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index f0ce8ffe7135..ec6ff7f0970c 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -7,11 +7,10 @@
 #define _CHECK_H
 
 #include <stdbool.h>
-#include "elf.h"
+#include "objtool.h"
 #include "cfi.h"
 #include "arch.h"
 #include "orc.h"
-#include <linux/hashtable.h>
 
 struct insn_state {
 	struct cfi_reg cfa;
@@ -47,13 +46,6 @@ struct instruction {
 	struct orc_entry orc;
 };
 
-struct objtool_file {
-	struct elf *elf;
-	struct list_head insn_list;
-	DECLARE_HASHTABLE(insn_hash, 20);
-	bool ignore_unreachables, c_file, hints, rodata;
-};
-
 int check(const char *objname, bool orc);
 
 struct instruction *find_insn(struct objtool_file *file,
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
new file mode 100644
index 000000000000..afa52fe6f644
--- /dev/null
+++ b/tools/objtool/objtool.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Matt Helsley <mhelsley@vmware.com>
+ */
+
+#ifndef _OBJTOOL_H
+#define _OBJTOOL_H
+#include <stdbool.h>
+#include <linux/list.h>
+#include <linux/hashtable.h>
+
+#include "elf.h"
+
+struct objtool_file {
+	struct elf *elf;
+	struct list_head insn_list;
+	DECLARE_HASHTABLE(insn_hash, 20);
+	bool ignore_unreachables, c_file, hints, rodata;
+};
+#endif
-- 
2.20.1

