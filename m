Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66127C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4259920787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335016;
	bh=ZNUaJ8VAiVvctC+In4ZbiPMKP3Hcjr1cEfGtl8qjBmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jjYXGnxAC9x924Dd68BQmTRYDj+1KUE5hnlVMr/NZSw4XfyTwwp1rC09jhCNUTUVp
	 NMunsAqN5DH/pw6p757lYq0MvpiuN+YkLc/ZXCa/V3qQxTGZ0VRT05AdXxalfcCYyr
	 7TkJhEjVRgkG0Wi2veQHEjZ8Nu7SR/IklPZRiv7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgEXPnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:43:35 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19693 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgEXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcUq017561;
        Mon, 25 May 2020 00:42:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcUq017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334962;
        bh=jdqXlLmHJ+7BFFpf+rEv+Akjfx/OVUuy7vbajuczGpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXhPHdg8KfF9Mwf1eZ5UrqB8lg4UH0PpfmveAmGiDgq4qpHHnTbVUnoC2ylBhwRY0
         KMUeI0dFKVsJ8PoinDVWiDaolbUX6sU+oGWuvrdTeOneIyCdO5rf+OR2RJriIUqdU2
         DygyeIyE2anYCtuApeFHrH/nEZkoLoybVhQzmDZ5izkXG0Ub6OTFYMfs2D1g4lD7hc
         XILGM2esC6dIazqTWaUlCbLyCrA0SUHlkQ+99w0VNgkXO+teCegqU3u8gcLmvkIOzY
         qB5sHzgXhgqj1yyWbR7zTWqFAXkPIqs5MaeFQgYYZ1jdfJkmEHL/lQBBzoO/jHgwPT
         eGaTFQDUruYXA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/29] modpost: use read_text_file() and get_line() for reading text files
Date:   Mon, 25 May 2020 00:42:13 +0900
Message-Id: <20200524154235.380482-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

grab_file() mmaps a file, but it is not so efficient here because
get_next_line() copies every line to the temporary buffer anyway.

read_text_file() and get_line() are simpler. get_line() exploits the
library function strchr().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/mod/modpost.c    | 15 ++++++++-------
 scripts/mod/sumversion.c | 11 ++++++-----
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 139b811dc183..40c6414aaeec 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2476,15 +2476,16 @@ static void write_if_changed(struct buffer *b, const char *fname)
  **/
 static void read_dump(const char *fname, unsigned int kernel)
 {
-	unsigned long size, pos = 0;
-	void *file = grab_file(fname, &size);
-	char *line;
+	char *buf, *pos, *line;
 
-	if (!file)
+	buf = read_text_file(fname);
+	if (!buf)
 		/* No symbol versions, silently ignore */
 		return;
 
-	while ((line = get_next_line(&pos, file, size))) {
+	pos = buf;
+
+	while ((line = get_line(&pos))) {
 		char *symname, *namespace, *modname, *d, *export;
 		unsigned int crc;
 		struct module *mod;
@@ -2519,10 +2520,10 @@ static void read_dump(const char *fname, unsigned int kernel)
 		sym_set_crc(symname, crc);
 		sym_update_namespace(symname, namespace);
 	}
-	release_file(file, size);
+	free(buf);
 	return;
 fail:
-	release_file(file, size);
+	free(buf);
 	fatal("parse error in symbol dump file\n");
 }
 
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index a1c7b0f4cd5a..89c8baefde9d 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -306,9 +306,8 @@ static int is_static_library(const char *objfile)
  * to figure out source files. */
 static int parse_source_files(const char *objfile, struct md4_ctx *md)
 {
-	char *cmd, *file, *line, *dir;
+	char *cmd, *file, *line, *dir, *pos;
 	const char *base;
-	unsigned long flen, pos = 0;
 	int dirlen, ret = 0, check_files = 0;
 
 	cmd = NOFAIL(malloc(strlen(objfile) + sizeof("..cmd")));
@@ -326,14 +325,16 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
 	strncpy(dir, objfile, dirlen);
 	dir[dirlen] = '\0';
 
-	file = grab_file(cmd, &flen);
+	file = read_text_file(cmd);
 	if (!file) {
 		warn("could not find %s for %s\n", cmd, objfile);
 		goto out;
 	}
 
+	pos = file;
+
 	/* Sum all files in the same dir or subdirs. */
-	while ((line = get_next_line(&pos, file, flen)) != NULL) {
+	while ((line = get_line(&pos))) {
 		char* p = line;
 
 		if (strncmp(line, "source_", sizeof("source_")-1) == 0) {
@@ -384,7 +385,7 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
 	/* Everyone parsed OK */
 	ret = 1;
 out_file:
-	release_file(file, flen);
+	free(file);
 out:
 	free(dir);
 	free(cmd);
-- 
2.25.1

