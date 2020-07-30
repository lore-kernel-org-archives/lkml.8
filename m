Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C41C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B132075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt/+hem+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgG3Jl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:41:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58282 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726707AbgG3Jly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pFXcym4u0UGeAd2DMevvmjIUW3Bhq8ynYynpndN3OLY=;
        b=Xt/+hem+WTzjc8kc9TccGofKJtZb4U8ItivHHdT1FQLhHyMnDhQnogVK2idNnMkOzGmD8b
        4H5aCGqmO8YWNDDYpoTsEZ06N15f+0DlRQ9+YBGdHi7yNP3eEJ7Kpi86QeGILynxgoatMm
        KqwW7TCPwSJYsKl46I83Rf9IjE7a08A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-xwT2RF4lOwKy9nidvHJrmw-1; Thu, 30 Jul 2020 05:41:51 -0400
X-MC-Unique: xwT2RF4lOwKy9nidvHJrmw-1
Received: by mail-wr1-f69.google.com with SMTP id w7so7738827wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFXcym4u0UGeAd2DMevvmjIUW3Bhq8ynYynpndN3OLY=;
        b=rA9GnKqDnp+Mi5QplPnLYnwbLIY7NATpttNlTm8jaIK0Cbgm4JsShBez7AU5kD7FBm
         oWSIb8t+EbaiFFc3ou0vxYUn4qSFC1r5wWStD5e3ii935a+WSUrQrWmWqMuZY0wsNwER
         1EyP98hHLkF4Cs9TezpcHufCx1aT5zaqUCa/5pV+MW1CbBUWQExTnd1FsYEZNjYs2Njr
         gfgWZuzPBkWoxP8hKm/3QInRQiOs+EAhJLdt8R2M2biebqBmjaz7abyR+Wtvkshme9+o
         y5IVvsYC+8naGKX0/vJ0jBboYkgnpI0UQmJ3WyYHLUXAF1gZalUcAU9WE+/nmo/9Z/KV
         bt4A==
X-Gm-Message-State: AOAM532EdSRGhkqXWXJpWqLFm8xE8gSt/mrhnDHuGscMzPFDcZM4SMJu
        rwfikgs7u7ZKFpfJSinp9gaEdi3kS/jzbpGceUvpTgG76yqmsHOvNv8Z30XgpnBEsjdI1z/wm4R
        jaka3zNUDPq+stSThB3mI60v+
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr4579159wmt.94.1596102109945;
        Thu, 30 Jul 2020 02:41:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzguVZ/Ug8/NaRFRrQjqQKK31A3DBRUaepDREcXK0yUEuxB9EWVEfNTjrLiRabQlKTaErMig==
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr4579145wmt.94.1596102109774;
        Thu, 30 Jul 2020 02:41:49 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id w2sm10984807wre.5.2020.07.30.02.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:41:49 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        mbenes@suse.cz, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 2/4] objtool: Move orc outside of check
Date:   Thu, 30 Jul 2020 10:41:41 +0100
Message-Id: <20200730094143.27494-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094143.27494-1-jthierry@redhat.com>
References: <20200730094143.27494-1-jthierry@redhat.com>
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
 tools/objtool/builtin-check.c |  2 +-
 tools/objtool/builtin-orc.c   | 21 ++++++++++++++++++++-
 tools/objtool/check.c         | 18 +-----------------
 tools/objtool/objtool.h       |  2 +-
 tools/objtool/weak.c          |  2 +-
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 698df1fa57f4..525dbcdf8394 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -58,5 +58,5 @@ int cmd_check(int argc, const char **argv)
 	if (!file)
 		return 1;
 
-	return check(file, false);
+	return check(file);
 }
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index 5641d759f7a3..2ba2d49bf63c 100644
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
+		else
+			return 0;
 	}
 
 	if (!strcmp(argv[0], "dump")) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 051f2ee6b4bc..bb19e4c79e46 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2750,7 +2750,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return 0;
 }
 
-int check(struct objtool_file *file, bool orc)
+int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
 
@@ -2797,22 +2797,6 @@ int check(struct objtool_file *file, bool orc)
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
index 62f0ab49dc0c..44415ed8c7be 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -21,7 +21,7 @@ struct objtool_file {
 
 struct objtool_file *objtool_setup_file(const char *_objname);
 
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

