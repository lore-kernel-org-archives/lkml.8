Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282D8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F368320826
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335072;
	bh=PUzTYBSHOirlV2aVKGWK2BT7iZVCemjI+oH1SEDkz3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qWxAdOqbA3myupszRVQxTjh81QjGWDRwsu1F9vkoGcz+Rpeif111zEqGtvrvoAjGY
	 OAWsIBTycqzrzFAqjLpjmYQ01UyauSRJANkuEJW+iWETb7j+bD9HHTk7S+UklQ9NfX
	 cD/w9PrppkBCVOiMe3YdKWZs1487dq9r+2IawHi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbgEXPob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:44:31 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19696 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgEXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcUn017561;
        Mon, 25 May 2020 00:42:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcUn017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334961;
        bh=C9SkWcDjS1G0ZjL6SShMHVdZAUZnR9C+tPjC6mkPDew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mf3NMY/E4hxeYWeX8iB+Xm00FQgpzedInc2N5sR6m1M91I+o5lqQnahgthhq6wuUO
         eraED5Y7IxQk//X4VPzKO7s5gxz2Cx/4EjboYrPwM07PszztSCIzRRnkJePUwbTZLw
         uuTwnvgSO2GEED6d2S2UVwndGxTWZEhNMKqYXln9W+74qhvxaNDsHC4YgD8gm0rwi0
         LQ/4RsoLXgX+KsGPYCe5wEG5zLHZDiQSXXaRprv0TSUPsLW/hILURSTnKzv5dmpH5L
         kLqMLdjEozu3CQi0Sm9mdvNheTi4iJW30vcaJLxmI8ffGED8e7jIU+vHMvGsOYIJuL
         /lgn7t7mBoGMQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/29] modpost: fix potential mmap'ed file overrun in get_src_version()
Date:   Mon, 25 May 2020 00:42:10 +0900
Message-Id: <20200524154235.380482-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not know how reliably this function works, but it seems dangerous
to me, at least.

The function call

    strchr(sources, '\n');

... continues searching until it finds '\n' or it reaches the '\0'
terminator. In other words, 'sources' should be a null-terminated
string.

However, grab_file() just mmaps a file, so 'sources' is not terminated
with null byte. If the file does not contain '\n' at all, strchr() will
go beyond the mmap'ed memory.

Instead, use read_text_file(), which loads the file content into a
malloc'ed buffer, appending null-byte.

Here we are interested only in the first line of *.mod files. Use
get_line() helper to get the first line.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/mod/sumversion.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index f27f22420cbc..f9aa532d93cf 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -392,40 +392,37 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
 /* Calc and record src checksum. */
 void get_src_version(const char *modname, char sum[], unsigned sumlen)
 {
-	void *file;
-	unsigned long len;
+	char *buf, *pos, *firstline;
 	struct md4_ctx md;
-	char *sources, *end, *fname;
+	char *fname;
 	char filelist[PATH_MAX + 1];
 
 	/* objects for a module are listed in the first line of *.mod file. */
 	snprintf(filelist, sizeof(filelist), "%.*smod",
 		 (int)strlen(modname) - 1, modname);
 
-	file = grab_file(filelist, &len);
-	if (!file)
+	buf = read_text_file(filelist);
+	if (!buf)
 		/* not a module or .mod file missing - ignore */
 		return;
 
-	sources = file;
-
-	end = strchr(sources, '\n');
-	if (!end) {
+	pos = buf;
+	firstline = get_line(&pos);
+	if (!firstline) {
 		warn("bad ending versions file for %s\n", modname);
-		goto release;
+		goto free;
 	}
-	*end = '\0';
 
 	md4_init(&md);
-	while ((fname = strsep(&sources, " ")) != NULL) {
+	while ((fname = strsep(&firstline, " "))) {
 		if (!*fname)
 			continue;
 		if (!(is_static_library(fname)) &&
 				!parse_source_files(fname, &md))
-			goto release;
+			goto free;
 	}
 
 	md4_final_ascii(&md, sum, sumlen);
-release:
-	release_file(file, len);
+free:
+	free(buf);
 }
-- 
2.25.1

