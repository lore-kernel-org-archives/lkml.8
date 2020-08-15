Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2FBC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F6320657
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529520;
	bh=8gHR5RT2Xpn8p+n0BStBpJuhKNrrbJqjqtYClxXmE1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lvt1NcbFNK45tNRlbiVUHqOeWxWjqDUwDx8N+TO4fE8f7ufnk7d7VzhAjNQq8q3nQ
	 kk3At0m3xvOaK0dJ7eJtv9Z6Hs7nzfVNOpjdXQAt8Gh649YPJfPSQfd1OV/84yYWqf
	 bn84zSNKRXwemHqsj4Q50PuV47s54pv3nUuKtDCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgHOWL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbgHOWK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:29 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39C52312B;
        Sat, 15 Aug 2020 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597500091;
        bh=8gHR5RT2Xpn8p+n0BStBpJuhKNrrbJqjqtYClxXmE1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgA9H808NYJnX09ERUqQD/oEiLoukcB+kYqGf8P4qQZTzCoLCTVqMKplqvWdRS1xY
         pn121oKbXotlhVTL/4q62v/bKHpr1NN21CHScAB9Wo3CBjK9E0bROBdZ6Tp1qjvXdb
         Tgd/58KvVzkn2XkB1XS0ZnPrJGxP5jdQ+Icx1B34=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 3/6] tools/bootconfig: Make all functions static
Date:   Sat, 15 Aug 2020 23:01:28 +0900
Message-Id: <159750008786.202708.353781509113517420.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159750006069.202708.12439674123720173666.stgit@devnote2>
References: <159750006069.202708.12439674123720173666.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make all functions static except for main(). This is just a cleanup.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 78025267df20..eb92027817a7 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -99,7 +99,7 @@ static void xbc_show_list(void)
 }
 
 /* Simple real checksum */
-int checksum(unsigned char *buf, int len)
+static int checksum(unsigned char *buf, int len)
 {
 	int i, sum = 0;
 
@@ -111,7 +111,7 @@ int checksum(unsigned char *buf, int len)
 
 #define PAGE_SIZE	4096
 
-int load_xbc_fd(int fd, char **buf, int size)
+static int load_xbc_fd(int fd, char **buf, int size)
 {
 	int ret;
 
@@ -128,7 +128,7 @@ int load_xbc_fd(int fd, char **buf, int size)
 }
 
 /* Return the read size or -errno */
-int load_xbc_file(const char *path, char **buf)
+static int load_xbc_file(const char *path, char **buf)
 {
 	struct stat stat;
 	int fd, ret;
@@ -147,7 +147,7 @@ int load_xbc_file(const char *path, char **buf)
 	return ret;
 }
 
-int load_xbc_from_initrd(int fd, char **buf)
+static int load_xbc_from_initrd(int fd, char **buf)
 {
 	struct stat stat;
 	int ret;
@@ -254,7 +254,7 @@ static int init_xbc_with_error(char *buf, int len)
 	return ret;
 }
 
-int show_xbc(const char *path, bool list)
+static int show_xbc(const char *path, bool list)
 {
 	int ret, fd;
 	char *buf = NULL;
@@ -299,7 +299,7 @@ int show_xbc(const char *path, bool list)
 	return ret;
 }
 
-int delete_xbc(const char *path)
+static int delete_xbc(const char *path)
 {
 	struct stat stat;
 	int ret = 0, fd, size;
@@ -330,7 +330,7 @@ int delete_xbc(const char *path)
 	return ret;
 }
 
-int apply_xbc(const char *path, const char *xbc_path)
+static int apply_xbc(const char *path, const char *xbc_path)
 {
 	u32 size, csum;
 	char *buf, *data;
@@ -407,7 +407,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 	return ret;
 }
 
-int usage(void)
+static int usage(void)
 {
 	printf("Usage: bootconfig [OPTIONS] <INITRD>\n"
 		"Or     bootconfig <CONFIG>\n"

