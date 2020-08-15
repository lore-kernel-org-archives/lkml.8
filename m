Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5173CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C99A2063A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529490;
	bh=nVJ1YOeSYsEtBFDu1yB6K6Mup+VVhxZPIANp/vQT/Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LW1INDcyZ/OyY9IpyYn6loGTqwRdsAXgO/ZuFdcNVYIxNuIBUn+bNF00qD1sAJ3Ci
	 tH9LsZJ2idYvYU9HRMYZariZ/T51xgfNbWAIYFs0ePgvc+OiTEdS0416deEM0fgqpM
	 Krrrb6Jntny6ToMTpTaZQatqTL7Nti1qBcWv8+tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgHOWLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbgHOWKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:30 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2E923123;
        Sat, 15 Aug 2020 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597500073;
        bh=nVJ1YOeSYsEtBFDu1yB6K6Mup+VVhxZPIANp/vQT/Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JL9PdoUeuGcAkmF1/Z0Yvc7rApXXtrPGxa5pJlWGJSD3VPHSCfF3xS+OKfcYM1nVL
         UKCvMiJoOmyM3PTSSt7NNpR4x7Ll9GWqkuzoqjLmRCvefCnD31Gcuj+2ifa6aqeYnY
         6ACM9CanYdyYn1Hv8fmlUZU3bC16tieKKVVg3ank=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 1/6] tools/bootconfig: Show bootconfig compact tree from bootconfig file
Date:   Sat, 15 Aug 2020 23:01:10 +0900
Message-Id: <159750006983.202708.3005608326834658992.stgit@devnote2>
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

Show the bootconfig compact tree from the bootconfig file
instead of an initrd if the given file has no magic number
and is smaller than 32KB.

User can use this for checking the syntax error or output
checking before applying the bootconfig to initrd.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |   81 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index e0878f5f74b1..d165e63b5d5a 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -195,10 +195,55 @@ int load_xbc_from_initrd(int fd, char **buf)
 	return size;
 }
 
+static void show_xbc_error(const char *data, const char *msg, int pos)
+{
+	int lin = 1, col, i;
+
+	if (pos < 0) {
+		pr_err("Error: %s.\n", msg);
+		return;
+	}
+
+	/* Note that pos starts from 0 but lin and col should start from 1. */
+	col = pos + 1;
+	for (i = 0; i < pos; i++) {
+		if (data[i] == '\n') {
+			lin++;
+			col = pos - i;
+		}
+	}
+	pr_err("Parse Error: %s at %d:%d\n", msg, lin, col);
+
+}
+
+static int init_xbc_with_error(char *buf, int len)
+{
+	char *copy = strdup(buf);
+	const char *msg;
+	int ret, pos;
+
+	if (!copy)
+		return -ENOMEM;
+
+	ret = xbc_init(buf, &msg, &pos);
+	if (ret < 0)
+		show_xbc_error(copy, msg, pos);
+	free(copy);
+
+	return ret;
+}
+
 int show_xbc(const char *path)
 {
 	int ret, fd;
 	char *buf = NULL;
+	struct stat st;
+
+	ret = stat(path, &st);
+	if (ret < 0) {
+		pr_err("Failed to stat %s: %d\n", path, -errno);
+		return -errno;
+	}
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
@@ -207,14 +252,24 @@ int show_xbc(const char *path)
 	}
 
 	ret = load_xbc_from_initrd(fd, &buf);
+	close(fd);
 	if (ret < 0) {
 		pr_err("Failed to load a boot config from initrd: %d\n", ret);
 		goto out;
 	}
+	/* Assume a bootconfig file if it is enough small */
+	if (ret == 0 && st.st_size <= XBC_DATA_MAX) {
+		ret = load_xbc_file(path, &buf);
+		if (ret < 0) {
+			pr_err("Failed to load a boot config: %d\n", ret);
+			goto out;
+		}
+		if (init_xbc_with_error(buf, ret) < 0)
+			goto out;
+	}
 	xbc_show_compact_tree();
 	ret = 0;
 out:
-	close(fd);
 	free(buf);
 
 	return ret;
@@ -251,27 +306,6 @@ int delete_xbc(const char *path)
 	return ret;
 }
 
-static void show_xbc_error(const char *data, const char *msg, int pos)
-{
-	int lin = 1, col, i;
-
-	if (pos < 0) {
-		pr_err("Error: %s.\n", msg);
-		return;
-	}
-
-	/* Note that pos starts from 0 but lin and col should start from 1. */
-	col = pos + 1;
-	for (i = 0; i < pos; i++) {
-		if (data[i] == '\n') {
-			lin++;
-			col = pos - i;
-		}
-	}
-	pr_err("Parse Error: %s at %d:%d\n", msg, lin, col);
-
-}
-
 int apply_xbc(const char *path, const char *xbc_path)
 {
 	u32 size, csum;
@@ -352,11 +386,12 @@ int apply_xbc(const char *path, const char *xbc_path)
 int usage(void)
 {
 	printf("Usage: bootconfig [OPTIONS] <INITRD>\n"
+		"Or     bootconfig <CONFIG>\n"
 		" Apply, delete or show boot config to initrd.\n"
 		" Options:\n"
 		"		-a <config>: Apply boot config to initrd\n"
 		"		-d : Delete boot config file from initrd\n\n"
-		" If no option is given, show current applied boot config.\n");
+		" If no option is given, show the bootconfig in the given file.\n");
 	return -1;
 }
 

