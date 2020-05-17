Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71307C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD7F2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589708980;
	bh=KUnQZR/HufKJMKrCYtNxVFFl1qNR7/CGNsbZFTX4n4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZcPAAX5FfJQQP5SqISFdwLAmSSUwv5IizFgUXBrraEXXHzRo/PSgHYe9Ron1IizaA
	 PzrTvCtmPDNATb1eFeP+T4KDYrUMD89uIDO00Jtw701cnKCExXWNxA6MOprOOEpzMu
	 2LBvE0Hc0yGRWg4zv7N9ZRgi/cjhbK5WwAXsTnKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgEQJtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:49:39 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:38337 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgEQJth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:49:37 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 04H9n4L5018560;
        Sun, 17 May 2020 18:49:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 04H9n4L5018560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589708950;
        bh=xYq0Wz8Mg+n/AM+6QwGzaReGlpbaasY+wlFVALGCRTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWFcJwnVWGewoSOghCFrDvofTGnWtEszCyhVIzceJ2vfkvqhZI2DBkrIDebS+0PaU
         l1pV8lMQ4eouj8A2rj6u1XDez30h6bpuCckvXyHXaTmJb7OwICwwp3jHN1ipCEbJ5d
         P+TdBanBYNTK93lrAJkzwl6kBignlpIjVkugY9BtVAXYRT1+x0w601TTk2QVOere3h
         L44pcehfoQjP+zXMFTFBhgoiO0egEydBsJkeJI+0ZP5TiKZoPh8Z5+R/+EtAndolL9
         a2PpVeprNjmKPoH+bRL+t/gZSRotlW8GL7hry8juJcIL6qxEpFM5hw0gvl3+sSqWjQ
         0BHj3ldOqsMNw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/29] modpost: remove get_next_text() and make {grab,release_}file static
Date:   Sun, 17 May 2020 18:48:38 +0900
Message-Id: <20200517094859.2376211-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517094859.2376211-1-masahiroy@kernel.org>
References: <20200517094859.2376211-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_next_line() is no longer used. Remove.

grab_file() and release_file() are only used in modpost.c. Make them
static.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 38 ++------------------------------------
 scripts/mod/modpost.h |  3 ---
 2 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 8021f7e93448..cd3cb781a2e7 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -452,7 +452,7 @@ static void sym_set_crc(const char *name, unsigned int crc)
 	s->crc_valid = 1;
 }
 
-void *grab_file(const char *filename, unsigned long *size)
+static void *grab_file(const char *filename, unsigned long *size)
 {
 	struct stat st;
 	void *map = MAP_FAILED;
@@ -474,41 +474,7 @@ void *grab_file(const char *filename, unsigned long *size)
 	return map;
 }
 
-/**
-  * Return a copy of the next line in a mmap'ed file.
-  * spaces in the beginning of the line is trimmed away.
-  * Return a pointer to a static buffer.
-  **/
-char *get_next_line(unsigned long *pos, void *file, unsigned long size)
-{
-	static char line[4096];
-	int skip = 1;
-	size_t len = 0;
-	signed char *p = (signed char *)file + *pos;
-	char *s = line;
-
-	for (; *pos < size ; (*pos)++) {
-		if (skip && isspace(*p)) {
-			p++;
-			continue;
-		}
-		skip = 0;
-		if (*p != '\n' && (*pos < size)) {
-			len++;
-			*s++ = *p++;
-			if (len > 4095)
-				break; /* Too long, stop */
-		} else {
-			/* End of string */
-			*s = '\0';
-			return line;
-		}
-	}
-	/* End of buffer */
-	return NULL;
-}
-
-void release_file(void *file, unsigned long size)
+static void release_file(void *file, unsigned long size)
 {
 	munmap(file, size);
 }
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index dfadaa0c01ec..232a0e11fcaa 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -192,9 +192,6 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen);
 /* from modpost.c */
 char *read_text_file(const char *filename);
 char *get_line(char **stringp);
-void *grab_file(const char *filename, unsigned long *size);
-char* get_next_line(unsigned long *pos, void *file, unsigned long size);
-void release_file(void *file, unsigned long size);
 
 enum loglevel {
 	LOG_WARN,
-- 
2.25.1

