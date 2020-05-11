Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2293EC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE25206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbgEKRfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:35:39 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:26400 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731027AbgEKRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:35:36 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 11 May 2020 10:35:35 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 96B59401AA;
        Mon, 11 May 2020 10:35:35 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 2/5] objtool: Move struct objtool_file into arch-independent header
Date:   Mon, 11 May 2020 10:35:10 -0700
Message-ID: <dfa8c8aaf75493d739ef4f8feabf99bbb3f5d195.1588888003.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1588888003.git.mhelsley@vmware.com>
References: <cover.1588888003.git.mhelsley@vmware.com>
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
not architecture dependent -- it's not x86 only -- and it will be useful
for any future commands that might not be part of the check / orc
tooling. So we move it from the check.h header  into the objtool.h header.

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

