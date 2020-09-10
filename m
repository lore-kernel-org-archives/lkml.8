Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D850C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A9920731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="orOlJXPx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="av4Bj7z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgIJTAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgIJSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:55:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753ABC06179B;
        Thu, 10 Sep 2020 11:54:42 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cmBUa79ZL4WJl5jNgzdooZslXx0/ZBdAe4JG9csV4A0=;
        b=orOlJXPx1s0qMhZgTjmKJnJxparJuQEZwkBqQnR9Y8nU9NHe51+ChrBZfozAgbwS0Wef83
        adK+chGnMbkAyyg3YTBf/ilQMuj/NnUVSSmOHkvxgbQqlCNEsL+Qw4gdvdVyyWy4KPhd++
        2eduue939fT2kMcyRX5DjO0GYUD/NInSHDnleovjCfGB5+pO3ZdOHvDqG+t5MuLzSctX3t
        zZnrYNRCH339DKyj0f455mddI5crPDPI/zCgQHFQMuuFfgG2c/C2VA3W+5/iEUWsczMIWQ
        3ZKxsRXyzekr5fjugnskFwdJtiCXjadOHievhO9VkYmk/CMZPO1EW+OU1qvzJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cmBUa79ZL4WJl5jNgzdooZslXx0/ZBdAe4JG9csV4A0=;
        b=av4Bj7z1B69ennepX60dMJLnUBg6hjbqGsCzR74NShQ74j4w2ncSarj4/3yLZCK3pJOlsu
        Ufnw9My32VDlu/Cg==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Move ORC logic out of check()
Cc:     Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976408016.20229.4845386271122861472.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d44becb9decf4438d1e555b1428634964d2e5764
Gitweb:        https://git.kernel.org/tip/d44becb9decf4438d1e555b1428634964d2e5764
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Tue, 25 Aug 2020 13:47:40 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 01 Sep 2020 17:19:11 -05:00

objtool: Move ORC logic out of check()

Now that the objtool_file can be obtained outside of the check function,
orc generation builtin no longer requires check to explicitly call its
orc related functions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/builtin-check.c | 10 +++++++++-
 tools/objtool/builtin-orc.c   | 21 ++++++++++++++++++++-
 tools/objtool/check.c         | 18 +-----------------
 tools/objtool/objtool.h       |  2 +-
 tools/objtool/weak.c          |  2 +-
 5 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 0126ec3..c6d199b 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -42,6 +42,7 @@ int cmd_check(int argc, const char **argv)
 {
 	const char *objname, *s;
 	struct objtool_file *file;
+	int ret;
 
 	argc = parse_options(argc, argv, check_options, check_usage, 0);
 
@@ -58,5 +59,12 @@ int cmd_check(int argc, const char **argv)
 	if (!file)
 		return 1;
 
-	return check(file, false);
+	ret = check(file);
+	if (ret)
+		return ret;
+
+	if (file->elf->changed)
+		return elf_write(file->elf);
+
+	return 0;
 }
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index 3979f27..7b31121 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -32,6 +32,7 @@ int cmd_orc(int argc, const char **argv)
 
 	if (!strncmp(argv[0], "gen", 3)) {
 		struct objtool_file *file;
+		int ret;
 
 		argc = parse_options(argc, argv, check_options, orc_usage, 0);
 		if (argc != 1)
@@ -43,7 +44,25 @@ int cmd_orc(int argc, const char **argv)
 		if (!file)
 			return 1;
 
-		return check(file, true);
+		ret = check(file);
+		if (ret)
+			return ret;
+
+		if (list_empty(&file->insn_list))
+			return 0;
+
+		ret = create_orc(file);
+		if (ret)
+			return ret;
+
+		ret = create_orc_sections(file);
+		if (ret)
+			return ret;
+
+		if (!file->elf->changed)
+			return 0;
+
+		return elf_write(file->elf);
 	}
 
 	if (!strcmp(argv[0], "dump")) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9d4efa3..4afc2d5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2908,7 +2908,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return 0;
 }
 
-int check(struct objtool_file *file, bool orc)
+int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
 
@@ -2960,22 +2960,6 @@ int check(struct objtool_file *file, bool orc)
 		goto out;
 	warnings += ret;
 
-	if (orc) {
-		ret = create_orc(file);
-		if (ret < 0)
-			goto out;
-
-		ret = create_orc_sections(file);
-		if (ret < 0)
-			goto out;
-	}
-
-	if (file->elf->changed) {
-		ret = elf_write(file->elf);
-		if (ret < 0)
-			goto out;
-	}
-
 out:
 	if (ret < 0) {
 		/*
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index 7efc43f..a635f68 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -22,7 +22,7 @@ struct objtool_file {
 
 struct objtool_file *objtool_open_read(const char *_objname);
 
-int check(struct objtool_file *file, bool orc);
+int check(struct objtool_file *file);
 int orc_dump(const char *objname);
 int create_orc(struct objtool_file *file);
 int create_orc_sections(struct objtool_file *file);
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index 8269831..29180d5 100644
--- a/tools/objtool/weak.c
+++ b/tools/objtool/weak.c
@@ -17,7 +17,7 @@
 	return ENOSYS;							\
 })
 
-int __weak check(struct objtool_file *file, bool orc)
+int __weak check(struct objtool_file *file)
 {
 	UNSUPPORTED("check subcommand");
 }
