Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E69C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CDD2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJSd+ZW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgFDQjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:39:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42050 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729582AbgFDQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591288787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVvEBKYL9SiRyrwTcQNMfs37AyJatE6ZkmtZGf9Ce7M=;
        b=QJSd+ZW6vhQbUjRgpcYf32QxVrRYQDZRY8CLDNqLegKyxY18f0uwi6OL2yqTspqIJn6IUf
        G17r0MjDW1/h39gD2M/FbKsvsaJHxGVQiJCgWTqlh7rKaHQQzJ2oCcN65iik69hqTQ9Y2Z
        Gduna1y+uNJ27jZau+K01PvfyYm3PNI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-_gCegx7jPyiR4pUofirpiw-1; Thu, 04 Jun 2020 12:39:45 -0400
X-MC-Unique: _gCegx7jPyiR4pUofirpiw-1
Received: by mail-wr1-f72.google.com with SMTP id n6so2651361wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVvEBKYL9SiRyrwTcQNMfs37AyJatE6ZkmtZGf9Ce7M=;
        b=E8ABZQ85JSu7eiy4SJw1LqXYL80b6KxT1qJVpaNpYVWsiNMy/IJsu6emrF5AJuTcxa
         RS/m6k9SLWJdGtKL0/v66Ikx0oaK0YKKt69UzEfywL7iI4m+K/gg+55YATP5vkfrinSU
         uyQ/27/eewpfsoqd2DhvfeT7eFjEtJGLnGMiigIFlSoWv7rEY1w3kDdJFv+F/Ff53GCW
         AgdbtLAsZbJHNQHHtDPIbho38h0SY4f0CyWAkHoHEPIX7UQIwsmppEt6sLAWsXZWUYoy
         RfplbqoT0bsuh7qHRlwAJtGCqb++6aXOyAdQ7kNk7TKxH/PMjnUPExQTGVjZLMtHCwOf
         BzJQ==
X-Gm-Message-State: AOAM531JGq8129wJAYanlBusr43KVf3oB5NPW3Rh0QtRnkrQgyxoAHy4
        shVvCftCSrpsToH+YWeb1NXcdVwEhrgczol2kSjSTnkl0kXQV7XP6nUu0nfER67QuCOExHhrWRZ
        A9WzFixL2MJS8pAcnehudO89A
X-Received: by 2002:a5d:4404:: with SMTP id z4mr5404018wrq.189.1591288784459;
        Thu, 04 Jun 2020 09:39:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA42SCXjHMtpFFKMGN0tQbnQVH4JgF3B76YKdjIkcIdWpMU7lnZZ2rujAEA2vN9B1wfxNLOg==
X-Received: by 2002:a5d:4404:: with SMTP id z4mr5404009wrq.189.1591288784282;
        Thu, 04 Jun 2020 09:39:44 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id p9sm7881636wma.48.2020.06.04.09.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 09:39:43 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 2/4] objtool: Move orc outside of check
Date:   Thu,  4 Jun 2020 17:39:36 +0100
Message-Id: <20200604163938.21660-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200604163938.21660-1-jthierry@redhat.com>
References: <20200604163938.21660-1-jthierry@redhat.com>
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
 tools/objtool/builtin-orc.c   | 18 +++++++++++++++++-
 tools/objtool/check.c         | 16 +---------------
 tools/objtool/objtool.h       |  2 +-
 tools/objtool/weak.c          |  2 +-
 5 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 9f525d497308..2bd520446ef8 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -58,5 +58,5 @@ int cmd_check(int argc, const char **argv)
 	if (!file)
 		return 1;
 
-	return check(file, false);
+	return check(file);
 }
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index 3b700f477a11..833ce587c3d4 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -32,6 +32,7 @@ int cmd_orc(int argc, const char **argv)
 
 	if (!strncmp(argv[0], "gen", 3)) {
 		struct objtool_file *file;
+		int ret;
 
 		argc = parse_options(argc, argv, check_options, orc_usage, 0);
 		if (argc != 1)
@@ -43,7 +44,22 @@ int cmd_orc(int argc, const char **argv)
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
+		return elf_write(file->elf);
 	}
 
 	if (!strcmp(argv[0], "dump")) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1638428df454..3fbb60fe94df 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2709,7 +2709,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 	return 0;
 }
 
-int check(struct objtool_file *file, bool orc)
+int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
 
@@ -2756,20 +2756,6 @@ int check(struct objtool_file *file, bool orc)
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
-
-		ret = elf_write(file->elf);
-		if (ret < 0)
-			goto out;
-	}
-
 out:
 	if (ret < 0) {
 		/*
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index e4f0ab5a4094..be526f3d294d 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -21,7 +21,7 @@ struct objtool_file {
 
 struct objtool_file *objtool_setup_file(const char *_objname, bool writable);
 
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
2.21.1

