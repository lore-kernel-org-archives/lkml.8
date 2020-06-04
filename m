Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75024C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B92E20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxzeBlAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgFDQjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:39:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33549 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729115AbgFDQjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591288787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGXzotyGQ0uS8DSLgpA4BDR+heUxDbWEeeYOwit4OjY=;
        b=OxzeBlAn+oHPVpE24eo4dERsld7f94gcoX1E3GanIuEvTOSCsvYv4BWcq9Ahw5ea3ZZ168
        3v7eOj0TRDhA1LD/nrR/FGWSjtktIy86aiDWqpt70C3M9u5LTFjmDFqkzk1r7Io/QGpFg6
        81zX227M3RiCoP/OX7RcIzbH5iZ4Cho=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-YF_G7h7gNTqEY-fGEPHRTQ-1; Thu, 04 Jun 2020 12:39:45 -0400
X-MC-Unique: YF_G7h7gNTqEY-fGEPHRTQ-1
Received: by mail-wr1-f70.google.com with SMTP id o1so2624665wrm.17
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGXzotyGQ0uS8DSLgpA4BDR+heUxDbWEeeYOwit4OjY=;
        b=b5aQ+RNz2qeIfKhLebIn/ZXRy7JVf1IRMaPAwhdZrj7OWGmWOo9TGtPKckOA23RO5J
         nvGYZndww+XkJbrpnjLcjwLgV6nqgZwVxvXlJYgk80pjhg9e9EvcL0qyQQPaoHCNcsjm
         Fc5yzMi5+BVkKDn+GD5Yr/cB4hkqsuBIEXfUaev9oZd6bZDk5SH/BsbVWkWR+sfrTKy2
         Rv9fPDYRI283tS1uTLAyhzUCGWGdhwmxCqJ6Bwbc8rj0/3MxfU99iCguZl19OJn3KK8u
         oXR8sZYICJVEcTP4YHNgf+zQA0lPC+Rp0RkWXDTDt2PCtbG7xu/kNxxqBb2q/a40HvXc
         Ci6w==
X-Gm-Message-State: AOAM5329/rP71A76iVY9PdL3pDE23gbs8E/hX0/VebXpFsFsKDLwc/19
        Ot+3X4ttt11NaZut1E0J7I8+nytfc1Jsr60BZfDSwLnSE51gZ+o11A0gwoCTe5ad6lWSNMdwXgy
        6uuLW/+DXBlQeQli9ECoJa6hr
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr5144951wrx.167.1591288783739;
        Thu, 04 Jun 2020 09:39:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtyJ0tmjf8fdtQZFqLVCHFz6liK1ysUwYwSwcn7gEXkglGEsEbZwSoKH8WW7JgiEMONG75kQ==
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr5144940wrx.167.1591288783500;
        Thu, 04 Jun 2020 09:39:43 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id p9sm7881636wma.48.2020.06.04.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 09:39:42 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 1/4] objtool: Move object file loading out of check
Date:   Thu,  4 Jun 2020 17:39:35 +0100
Message-Id: <20200604163938.21660-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200604163938.21660-1-jthierry@redhat.com>
References: <20200604163938.21660-1-jthierry@redhat.com>
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

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/builtin-check.c |  7 ++++++-
 tools/objtool/builtin-orc.c   |  8 +++++++-
 tools/objtool/check.c         | 37 +++++++++++------------------------
 tools/objtool/objtool.c       | 29 +++++++++++++++++++++++++++
 tools/objtool/objtool.h       |  4 +++-
 tools/objtool/weak.c          |  4 +---
 6 files changed, 57 insertions(+), 32 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7a44174967b5..9f525d497308 100644
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
+	file = objtool_setup_file(objname, false);
+	if (!file)
+		return 1;
+
+	return check(file, false);
 }
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index b1dfe2007962..3b700f477a11 100644
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
+		file = objtool_setup_file(objname, true);
+		if (!file)
+			return 1;
+
+		return check(file, true);
 	}
 
 	if (!strcmp(argv[0], "dump")) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 63d65a702900..1638428df454 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -26,7 +26,6 @@ struct alternative {
 	bool skip_orig;
 };
 
-const char *objname;
 struct cfi_init_state initial_func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
@@ -2710,36 +2709,22 @@ static int validate_reachable_instructions(struct objtool_file *file)
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
-	file.elf = elf_open_read(objname, orc ? O_RDWR : O_RDONLY);
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
 
@@ -2748,39 +2733,39 @@ int check(const char *_objname, bool orc)
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
 
-		ret = elf_write(file.elf);
+		ret = elf_write(file->elf);
 		if (ret < 0)
 			goto out;
 	}
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 58fdda510653..71c4122cf491 100644
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
+struct objtool_file *objtool_setup_file(const char *_objname, bool writable)
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
+	file.elf = elf_open_read(objname, writable ? O_RDWR : O_RDONLY);
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
index 528028a66816..e4f0ab5a4094 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -19,7 +19,9 @@ struct objtool_file {
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
-int check(const char *objname, bool orc);
+struct objtool_file *objtool_setup_file(const char *_objname, bool writable);
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
2.21.1

