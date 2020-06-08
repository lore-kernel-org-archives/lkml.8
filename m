Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55247C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E400204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XldP9FL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgFHHMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:12:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58196 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728032AbgFHHMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591600332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVvEBKYL9SiRyrwTcQNMfs37AyJatE6ZkmtZGf9Ce7M=;
        b=XldP9FL3/47szo5EqD1NgmrzoHhAHk5+9Nk20fV6sdnZaSje3RxuPxILl73gc+VjtPvyYu
        VgUCftltXcc0SAtGK6qRrGDVVxe7CcUNhmhCyYaMiTzET4Y1lS/oOEmDL9lV6nvfy+faNH
        x1C9JlLCZB5wA/V+CF2qYloTU0HhiQA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-2R26CqzfMUmHwakKsE3EnA-1; Mon, 08 Jun 2020 03:12:11 -0400
X-MC-Unique: 2R26CqzfMUmHwakKsE3EnA-1
Received: by mail-wr1-f72.google.com with SMTP id w4so6788965wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 00:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVvEBKYL9SiRyrwTcQNMfs37AyJatE6ZkmtZGf9Ce7M=;
        b=ib2+s9A8oUyIBeu1sQvzWbFin3Ru+QEaqmV1WPXakWwp/bIxOH3uno/RIeztEiertY
         iXsM5+FaLW3Pe/fGoTDAoyV3yLhe/XnDCeD6qk4VFH9mXFTAOo9AKn+n2NBail/dKfWR
         SNbL1sKG5c6ShMKZqT46Fg+JOoVf1I9CljoceOyr+E7lqfg8xEyMvWMWQBGrnLk1wEf1
         gv+Xua7IArrI+AY1h6Bu4DMEg+v6pBkmjXntnE9NKXxM8vXR/joU4pfCgb6agNu+/ETP
         lkPlpl9omiyy5TeI7Qwmtm4ukGm5JxzI6TEjIT9eI1MHdaRq1i9Ozptpem5GGIjWfWK/
         kZkQ==
X-Gm-Message-State: AOAM533Vr1QTGwT8bLOxQllVqykaqIYKuggZ1RsxrNQ9wF31+JkKcrdU
        XKmWv+cogbvykxC8ALNlFDCKcE2iwnNf1sfdd4wYhmmThPZsqUkUZLo16ia4rC/ilUWgvLCKWUJ
        K9vMsZrFHS69w8hnKHHC7Y8HO
X-Received: by 2002:adf:a350:: with SMTP id d16mr22760849wrb.237.1591600329869;
        Mon, 08 Jun 2020 00:12:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxqKtX4+zQ03zqzNhtzkZ1UzmhpRWAIZkOfLu5LmMEO16Gb3XNoyJP2OHUIbXUMX1eCHgwqQ==
X-Received: by 2002:adf:a350:: with SMTP id d16mr22760830wrb.237.1591600329685;
        Mon, 08 Jun 2020 00:12:09 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id w17sm22908254wra.71.2020.06.08.00.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 00:12:08 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        mbenes@suse.cz, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 2/4] objtool: Move orc outside of check
Date:   Mon,  8 Jun 2020 08:12:01 +0100
Message-Id: <20200608071203.4055-3-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608071203.4055-1-jthierry@redhat.com>
References: <20200608071203.4055-1-jthierry@redhat.com>
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

