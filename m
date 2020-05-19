Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2ACC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C900204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgESU4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:56:00 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:4154 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgESUz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:55:56 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 19 May 2020 13:55:54 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id EF279404B7;
        Tue, 19 May 2020 13:55:55 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH 2/3] objtool: Move struct objtool_file into arch-independent header
Date:   Tue, 19 May 2020 13:55:32 -0700
Message-ID: <8a877bc283cbad704c7472ac3ef534d49629dd05.1589913349.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1589913349.git.mhelsley@vmware.com>
References: <cover.1589913349.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The objtool_file structure describes the files objtool works on,
is used by the check subcommand, and the check.h header is included
by the orc subcommands so it's presently used by all subcommands.

Since the structure will be useful in all subcommands besides check,
and some subcommands may not want to include check.h to get the
definition, split the structure out into a new header meant for use
by all objtool subcommands.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/check.h   | 10 +---------
 tools/objtool/objtool.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 9 deletions(-)
 create mode 100644 tools/objtool/objtool.h

diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 24280227ef21..3b59a1cbcff5 100644
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
 	struct cfi_state cfi;
@@ -48,13 +47,6 @@ struct instruction {
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

