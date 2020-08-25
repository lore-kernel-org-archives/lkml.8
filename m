Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DD4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FFC2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrmZ/pgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgHYMrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbgHYMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598359629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjZLo6mDyWyvCnED8Jf/q99jB/pytg41/FYF51HEwZQ=;
        b=KrmZ/pgda152v32uY8Yj2RZ/RSASwEVQZouVNfQiW+Xy1Mgb0o4Y0/dilszHEpi3U5QYFJ
        VvxI490rl+znVkxOY6W28UNytS5J6ND5K4EZDv/ri8TwNKEmH31IFZGv+Xh6ZBhlLuTnIa
        lh/elYKogiJTGeGKAmEZGNexdGG4J0g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-ShjwVvp2M4K87dTfhuKm7w-1; Tue, 25 Aug 2020 08:47:07 -0400
X-MC-Unique: ShjwVvp2M4K87dTfhuKm7w-1
Received: by mail-wm1-f70.google.com with SMTP id f125so897433wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjZLo6mDyWyvCnED8Jf/q99jB/pytg41/FYF51HEwZQ=;
        b=UESy27d4j5Ag17j38kM/KuYIfZlUqlr8YAQ5TiDI67YjzFOQWNBG8P83J0jbr6/7Lp
         2LADZFjf1p8u/xCmBxOyoOq2Q/JQxtVDAWKXHagyot8k6dexMLlyebtvCbX4NXK5Qzf4
         tCgtdp7EP5PmN23NO7XeTw/xlfbtlIL+c+G3N2B5dAqTgFi2AbrprxlUIBJQFwHj8iWx
         ZDQko/VBmUOlqoQv3OkQpuMBzwzM+GGOIpwm0PhX2F1FnNSUOxkupR4Ki4Ua0cw1m7pK
         hTiTsVMTp2k4r1Wkn90Q5FxkOy0JQXq2JKjjMM2bFPs58mclzZc4qJ3eZY7J/ovDeLVG
         WNYg==
X-Gm-Message-State: AOAM530ubUhPRh0YrkKXCNRPVhzHtHJawEwomDZ+O7c0xCQe22jEy75v
        oH4V5h3M7u23AaOxHB3Dk9e+XgRNEBUHJxEDSdojsAwxZBuezFRjS5+ASUn+RqcLnYAjknfynLu
        Tcy7dJy0EfVWFuMIjL1R6W0pH
X-Received: by 2002:adf:ba83:: with SMTP id p3mr10893272wrg.246.1598359626072;
        Tue, 25 Aug 2020 05:47:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzknUoE4jdxCHSgVWstg6FzejGYP1wBLljLSmKIqGnusifXFIgJi1B7vjg8GX+QovXvK378Q==
X-Received: by 2002:adf:ba83:: with SMTP id p3mr10893254wrg.246.1598359625883;
        Tue, 25 Aug 2020 05:47:05 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id m125sm6179521wme.35.2020.08.25.05.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:47:05 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        benh@kernel.crashing.org, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v4 2/4] objtool: Move orc outside of check
Date:   Tue, 25 Aug 2020 13:46:58 +0100
Message-Id: <20200825124700.29616-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200825124700.29616-1-jthierry@redhat.com>
References: <20200825124700.29616-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the objtool_file can be obtained outside of the check function,
orc generation builtin no longer requires check to explicitly call its
orc related functions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/builtin-check.c | 10 +++++++++-
 tools/objtool/builtin-orc.c   | 21 ++++++++++++++++++++-
 tools/objtool/check.c         | 18 +-----------------
 tools/objtool/objtool.h       |  2 +-
 tools/objtool/weak.c          |  2 +-
 5 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 0126ec3bb6c9..c6d199bfd0ae 100644
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
index 3979f275a775..53e316585a3c 100644
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
+		if (ret < 0)
+			return ret;
+
+		ret = create_orc_sections(file);
+		if (ret < 0)
+			return ret;
+
+		if (file->elf->changed)
+			return elf_write(file->elf);
+
+		return 0;
 	}
 
 	if (!strcmp(argv[0], "dump")) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ef8e9300e1a3..6156bd9a687c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2776,7 +2776,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return 0;
 }
 
-int check(struct objtool_file *file, bool orc)
+int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
 
@@ -2823,22 +2823,6 @@ int check(struct objtool_file *file, bool orc)
 		warnings += ret;
 	}
 
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
index 42b27c4ed683..46240098f08d 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -21,7 +21,7 @@ struct objtool_file {
 
 struct objtool_file *objtool_open_read(const char *_objname);
 
-int check(struct objtool_file *file, bool orc);
+int check(struct objtool_file *file);
 int orc_dump(const char *objname);
 int create_orc(struct objtool_file *file);
 int create_orc_sections(struct objtool_file *file);
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index 82698319f008..29180d599b08 100644
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
-- 
2.21.3

