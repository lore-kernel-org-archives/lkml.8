Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E546DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15B12075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAahJE5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgG3Jl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:41:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37962 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726273AbgG3Jly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/Qkj45vHnzJAuOijRPklw8QDXm5O1pBJpEaGZuHLeg=;
        b=HAahJE5dguhXVuq0OFYYJo1wEfz6NP+cTlyuLqgguxwv4Oa3hxE1uLdNXYsYpR0L3lroVk
        U9wN1MlX0+h2x2/GrKQSldaFmVG4QlF5z84LwH881AwqPuna43B1U74WRGhnXBwxHzk5x4
        fYsF8BZwBeO5IdzKr+sp7rtj7u470jE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-TcSvPM9wPs6OuAe85RtS5g-1; Thu, 30 Jul 2020 05:41:50 -0400
X-MC-Unique: TcSvPM9wPs6OuAe85RtS5g-1
Received: by mail-wr1-f69.google.com with SMTP id w1so5713241wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/Qkj45vHnzJAuOijRPklw8QDXm5O1pBJpEaGZuHLeg=;
        b=C4RXTb7qxPQeoaxAfu/KTj/YP5Yk+VnqISdtjqSlmTEsznKRsghF7K2JDdsnUrPdwG
         umCeQf3WK6cmpcxnt2E/KfAbOV2cjJvvpcrvsMtlfMbcvv5G5fzrpo37i1GqVL6VuprT
         0tp7WWcUKGt9pbqAk7OKea+VJkLbzNZRGlutFXHeFenbwbTp15JlZMM/zDhSBsxmW1EX
         zJ/eFt1Lm90lYDKzNNnc5wOyiLiW3KNiMfhlP5z9PNyx7mIvxx1CJqUREElIYHcxXMhr
         iwaHmqbtihfHFhoSAMfsa1hVxGBNollu1ZvwjoxJu5ZVXXJ1SClJVQYukLqOhH8UV9xQ
         w7Mw==
X-Gm-Message-State: AOAM531fDFPtAcvgFC3WjBLKa37DMsjseo7xhYvZdyf7/INrKZzIOAeT
        tXCmpCrhWnkx7h0zVMoTML9jknU5Cr6wyub930cxMa3LF0dXmQ3k6jR3M4K2uj4c+xhdjRViLhm
        Yy2tosUSDOZoBjEwcyYbCRnGD
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr12886944wmb.150.1596102108362;
        Thu, 30 Jul 2020 02:41:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGOUMBd/VUyCL66wjmpM0vmR2EwtVRhWoyOdToSTGkKPSs5zkLYBWmZ8itbKKW2pjozeX2zw==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr12886924wmb.150.1596102108132;
        Thu, 30 Jul 2020 02:41:48 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id w2sm10984807wre.5.2020.07.30.02.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:41:47 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        mbenes@suse.cz, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 1/4] objtool: Move object file loading out of check
Date:   Thu, 30 Jul 2020 10:41:40 +0100
Message-Id: <20200730094143.27494-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094143.27494-1-jthierry@redhat.com>
References: <20200730094143.27494-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Structure objtool_file can be used by different subcommands. In fact
it already is, by check and orc.

Provide a function that allows to initialize objtool_file, that builtin
can call, without relying on check to do the correct setup for them and
explicitly hand the objtool_file to them.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/builtin-check.c |  7 ++++++-
 tools/objtool/builtin-orc.c   |  8 ++++++-
 tools/objtool/check.c         | 39 +++++++++++------------------------
 tools/objtool/objtool.c       | 29 ++++++++++++++++++++++++++
 tools/objtool/objtool.h       |  4 +++-
 tools/objtool/weak.c          |  4 +---
 6 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7a44174967b5..698df1fa57f4 100644
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
+	file = objtool_setup_file(objname);
+	if (!file)
+		return 1;
+
+	return check(file, false);
 }
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index b1dfe2007962..5641d759f7a3 100644
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
+		file = objtool_setup_file(objname);
+		if (!file)
+			return 1;
+
+		return check(file, true);
 	}
 
 	if (!strcmp(argv[0], "dump")) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a2313ecce6d1..051f2ee6b4bc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -27,7 +27,6 @@ struct alternative {
 	bool skip_orig;
 };
 
-const char *objname;
 struct cfi_init_state initial_func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
@@ -2751,36 +2750,22 @@ static int validate_reachable_instructions(struct objtool_file *file)
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
-	file.c_file = find_section_by_name(file.elf, ".comment");
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
 
@@ -2789,41 +2774,41 @@ int check(const char *_objname, bool orc)
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
index 58fdda510653..d935522c7359 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -22,6 +22,8 @@
 #include <linux/kernel.h>
 
 #include "builtin.h"
+#include "objtool.h"
+#include "warn.h"
 
 struct cmd_struct {
 	const char *name;
@@ -39,6 +41,33 @@ static struct cmd_struct objtool_cmds[] = {
 
 bool help;
 
+const char *objname;
+static struct objtool_file file;
+
+struct objtool_file *objtool_setup_file(const char *_objname)
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
+	file.c_file = find_section_by_name(file.elf, ".comment");
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
index 528028a66816..62f0ab49dc0c 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -19,7 +19,9 @@ struct objtool_file {
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
-int check(const char *objname, bool orc);
+struct objtool_file *objtool_setup_file(const char *_objname);
+
+int check(struct objtool_file *file, bool orc);
 int orc_dump(const char *objname);
 int create_orc(struct objtool_file *file);
 int create_orc_sections(struct objtool_file *file);
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index 942ea5e8ac36..82698319f008 100644
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
-- 
2.21.3

