Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D927DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8291C20731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="icSIOhZr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EMtXWh0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgIJTAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:00:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41908 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgIJSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:55:06 -0400
Date:   Thu, 10 Sep 2020 18:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AD3QDzszcDz/BrtlXxGdM6Rtg+hx9N9dG2jNiT9uvbQ=;
        b=icSIOhZrddRsRdEw4xFTlIvkzsKS+d4MeOZE/NVR6eYHzRCt2PFPjmUwYejH53h1k7uiZE
        W01LID/1pc5yzoLfxickYT7xVwddKEVcq0vMONAhmcLgF0YvrgOs22DiKZc/HWWRVdeTk1
        7oYd/BXtqgJn+2znXil/y5MGct6VldrrcxVYfaiM6lZx052KPrUXMp5TrQFCJCSmN0ui0/
        HupJE00p/sCKJz+ScgjHs2Roiua+KXHYyyXKY21ZFKOFxMXlJO0Y+rfs6u+Tr2Bj7KBIRU
        t7AuWSBx+C2ObJCe+A8NbLDmAdiqq6RjiSt9eLm/2smQKFAvDEzHdJTnIS+S1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AD3QDzszcDz/BrtlXxGdM6Rtg+hx9N9dG2jNiT9uvbQ=;
        b=EMtXWh0OxmFUhHG7wtW+SIyluql/atOnAl/TAMwUqpTaf9+dJfB/3iiblOx1AjkTS4gELJ
        Wi4UtXFKDFIZLHBA==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Move object file loading out of check()
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976408065.20229.17940088831403600351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     6545eb030e6f14cef8793a86312483c788eaee46
Gitweb:        https://git.kernel.org/tip/6545eb030e6f14cef8793a86312483c788eaee46
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Tue, 25 Aug 2020 13:47:39 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 01 Sep 2020 17:19:07 -05:00

objtool: Move object file loading out of check()

Structure objtool_file can be used by different subcommands. In fact
it already is, by check and orc.

Provide a function that allows to initialize objtool_file, that builtin
can call, without relying on check to do the correct setup for them and
explicitly hand the objtool_file to them.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/builtin-check.c |  7 +++++-
 tools/objtool/builtin-orc.c   |  8 +++++-
 tools/objtool/check.c         | 42 ++++++++++------------------------
 tools/objtool/objtool.c       | 30 ++++++++++++++++++++++++-
 tools/objtool/objtool.h       |  4 ++-
 tools/objtool/weak.c          |  4 +---
 6 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7a44174..0126ec3 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -41,6 +41,7 @@ const struct option check_options[] = {
 int cmd_check(int argc, const char **argv)
 {
 	const char *objname, *s;
+	struct objtool_file *file;
 
 	argc = parse_options(argc, argv, check_options, check_usage, 0);
 
@@ -53,5 +54,9 @@ int cmd_check(int argc, const char **argv)
 	if (s && !s[9])
 		vmlinux = true;
 
-	return check(objname, false);
+	file = objtool_open_read(objname);
+	if (!file)
+		return 1;
+
+	return check(file, false);
 }
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index b1dfe20..3979f27 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -31,13 +31,19 @@ int cmd_orc(int argc, const char **argv)
 		usage_with_options(orc_usage, check_options);
 
 	if (!strncmp(argv[0], "gen", 3)) {
+		struct objtool_file *file;
+
 		argc = parse_options(argc, argv, check_options, orc_usage, 0);
 		if (argc != 1)
 			usage_with_options(orc_usage, check_options);
 
 		objname = argv[0];
 
-		return check(objname, true);
+		file = objtool_open_read(objname);
+		if (!file)
+			return 1;
+
+		return check(file, true);
 	}
 
 	if (!strcmp(argv[0], "dump")) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 75d0cd2..9d4efa3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -28,7 +28,6 @@ struct alternative {
 	bool skip_orig;
 };
 
-const char *objname;
 struct cfi_init_state initial_func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
@@ -2909,37 +2908,22 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return 0;
 }
 
-static struct objtool_file file;
-
-int check(const char *_objname, bool orc)
+int check(struct objtool_file *file, bool orc)
 {
 	int ret, warnings = 0;
 
-	objname = _objname;
-
-	file.elf = elf_open_read(objname, O_RDWR);
-	if (!file.elf)
-		return 1;
-
-	INIT_LIST_HEAD(&file.insn_list);
-	hash_init(file.insn_hash);
-	INIT_LIST_HEAD(&file.static_call_list);
-	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
-	file.ignore_unreachables = no_unreachable;
-	file.hints = false;
-
 	arch_initial_func_cfi_state(&initial_func_cfi);
 
-	ret = decode_sections(&file);
+	ret = decode_sections(file);
 	if (ret < 0)
 		goto out;
 	warnings += ret;
 
-	if (list_empty(&file.insn_list))
+	if (list_empty(&file->insn_list))
 		goto out;
 
 	if (vmlinux && !validate_dup) {
-		ret = validate_vmlinux_functions(&file);
+		ret = validate_vmlinux_functions(file);
 		if (ret < 0)
 			goto out;
 
@@ -2948,46 +2932,46 @@ int check(const char *_objname, bool orc)
 	}
 
 	if (retpoline) {
-		ret = validate_retpoline(&file);
+		ret = validate_retpoline(file);
 		if (ret < 0)
 			return ret;
 		warnings += ret;
 	}
 
-	ret = validate_functions(&file);
+	ret = validate_functions(file);
 	if (ret < 0)
 		goto out;
 	warnings += ret;
 
-	ret = validate_unwind_hints(&file, NULL);
+	ret = validate_unwind_hints(file, NULL);
 	if (ret < 0)
 		goto out;
 	warnings += ret;
 
 	if (!warnings) {
-		ret = validate_reachable_instructions(&file);
+		ret = validate_reachable_instructions(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
-	ret = create_static_call_sections(&file);
+	ret = create_static_call_sections(file);
 	if (ret < 0)
 		goto out;
 	warnings += ret;
 
 	if (orc) {
-		ret = create_orc(&file);
+		ret = create_orc(file);
 		if (ret < 0)
 			goto out;
 
-		ret = create_orc_sections(&file);
+		ret = create_orc_sections(file);
 		if (ret < 0)
 			goto out;
 	}
 
-	if (file.elf->changed) {
-		ret = elf_write(file.elf);
+	if (file->elf->changed) {
+		ret = elf_write(file->elf);
 		if (ret < 0)
 			goto out;
 	}
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 58fdda5..9df0cd8 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -22,6 +22,8 @@
 #include <linux/kernel.h>
 
 #include "builtin.h"
+#include "objtool.h"
+#include "warn.h"
 
 struct cmd_struct {
 	const char *name;
@@ -39,6 +41,34 @@ static struct cmd_struct objtool_cmds[] = {
 
 bool help;
 
+const char *objname;
+static struct objtool_file file;
+
+struct objtool_file *objtool_open_read(const char *_objname)
+{
+	if (objname) {
+		if (strcmp(objname, _objname)) {
+			WARN("won't handle more than one file at a time");
+			return NULL;
+		}
+		return &file;
+	}
+	objname = _objname;
+
+	file.elf = elf_open_read(objname, O_RDWR);
+	if (!file.elf)
+		return NULL;
+
+	INIT_LIST_HEAD(&file.insn_list);
+	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.static_call_list);
+	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
+	file.ignore_unreachables = no_unreachable;
+	file.hints = false;
+
+	return &file;
+}
+
 static void cmd_usage(void)
 {
 	unsigned int i, longest = 0;
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index 9a7cd0b..7efc43f 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -20,7 +20,9 @@ struct objtool_file {
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
-int check(const char *objname, bool orc);
+struct objtool_file *objtool_open_read(const char *_objname);
+
+int check(struct objtool_file *file, bool orc);
 int orc_dump(const char *objname);
 int create_orc(struct objtool_file *file);
 int create_orc_sections(struct objtool_file *file);
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index 942ea5e..8269831 100644
--- a/tools/objtool/weak.c
+++ b/tools/objtool/weak.c
@@ -17,9 +17,7 @@
 	return ENOSYS;							\
 })
 
-const char __weak *objname;
-
-int __weak check(const char *_objname, bool orc)
+int __weak check(struct objtool_file *file, bool orc)
 {
 	UNSUPPORTED("check subcommand");
 }
