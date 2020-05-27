Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1654EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE00B20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbgE0PEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389378AbgE0PEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:04:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE31C03E96E;
        Wed, 27 May 2020 08:04:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdxbW-0006L4-8G; Wed, 27 May 2020 17:04:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CB0751C03A9;
        Wed, 27 May 2020 17:04:25 +0200 (CEST)
Date:   Wed, 27 May 2020 15:04:25 -0000
From:   "tip-bot2 for Matt Helsley" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Move struct objtool_file into
 arch-independent header
Cc:     Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159059186570.17951.4503828165472799510.tip-bot2@tip-bot2>
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

Commit-ID:     d37c90d47fc4657423d2ff1c3ed3fd70612a9b43
Gitweb:        https://git.kernel.org/tip/d37c90d47fc4657423d2ff1c3ed3fd70612a9b43
Author:        Matt Helsley <mhelsley@vmware.com>
AuthorDate:    Tue, 19 May 2020 13:55:32 -07:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 20 May 2020 08:35:20 -05:00

objtool: Move struct objtool_file into arch-independent header

The objtool_file structure describes the files objtool works on,
is used by the check subcommand, and the check.h header is included
by the orc subcommands so it's presently used by all subcommands.

Since the structure will be useful in all subcommands besides check,
and some subcommands may not want to include check.h to get the
definition, split the structure out into a new header meant for use
by all objtool subcommands.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
Reviewed-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.h   | 10 +---------
 tools/objtool/objtool.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 9 deletions(-)
 create mode 100644 tools/objtool/objtool.h

diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 2428022..3b59a1c 100644
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
index 0000000..d89616b
--- /dev/null
+++ b/tools/objtool/objtool.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Matt Helsley <mhelsley@vmware.com>
+ */
+
+#ifndef _OBJTOOL_H
+#define _OBJTOOL_H
+
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
+
+#endif /* _OBJTOOL_H */
