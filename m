Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D181C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C591F20716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597048507;
	bh=8gHR5RT2Xpn8p+n0BStBpJuhKNrrbJqjqtYClxXmE1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B3yj9nVn+v4W7W4MZUNSaxxYBTpDdFJhx/FByHo5IBYDRQfSBU6Zg4aLoSUMo7cX/
	 C8PpBhgpFzHZWJTqEF7egB8ObVQvZ6wO4fu/pp9QsAISlswdi43wZvw3mPRe+POkKs
	 xTALHFI+OTD6OTqIBTd7jhWTUbGUlfrQ2sUjchiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHJIfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgHJIfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:35:06 -0400
Received: from localhost.localdomain (unknown [180.22.250.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B78A2065C;
        Mon, 10 Aug 2020 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597048505;
        bh=8gHR5RT2Xpn8p+n0BStBpJuhKNrrbJqjqtYClxXmE1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0We9vcwpVjC95LNYbEZbME8ZE7W4I/f3384LAhqQSQJZgcnYm962Mbxh3Tv/FCHSi
         5ZOzdPeuwsjW1kUE1eiZsWqXPJ3F94p5xH4T+jG/LGKxDKWs7u+e0qgOvzyybDQfUf
         f7KmF4w1bFDhWq9+o15h54Iyw24fuUvH6614y8d8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/6] tools/bootconfig: Make all functions static
Date:   Mon, 10 Aug 2020 17:35:01 +0900
Message-Id: <159704850135.175360.12465608936326167517.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159704847064.175360.3292152056631660862.stgit@devnote2>
References: <159704847064.175360.3292152056631660862.stgit@devnote2>
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

