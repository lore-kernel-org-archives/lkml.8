Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AAAC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC8A20658
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529434;
	bh=Ysl/FfEA15nZohgMrKMoXiAFQWj3fx2wTXztEgbYH9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=amRqFpmCJebe2eLgrsomtLkfG5blu5F3Wn0kFrvtPHFEq7t2gbj2FtvFxYybC2nzC
	 Z7KPRvHuvgvEUMIrndsFxAZQxlQ4JqXT9MrqrDr+kmQv1/TAzo4TQmTzgjzVaUFv5X
	 QpJX7pjJH8pGa26UeXMuLx0Ya3GyTYOASTkqFegY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgHOWKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729448AbgHOWKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:30 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B84923125;
        Sat, 15 Aug 2020 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597500082;
        bh=Ysl/FfEA15nZohgMrKMoXiAFQWj3fx2wTXztEgbYH9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBgrOjXbrs9Ik1Lpgft8PLxllsDsh2kDSCwbcDnYEuWaklAWhHh7tyUH+XYj+M/AC
         KQ/ukQ9fBEF763WpagL+vsoG5r4f/PC/4UpFMzeereXDOHgPLGuJf8DdAtXZrqP5vG
         hf/7z16eG9mIIlWnpayMlETP3rGkzXhKETXl/P1o=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 2/6] tools/bootconfig: Add list option
Date:   Sat, 15 Aug 2020 23:01:19 +0900
Message-Id: <159750007885.202708.17797040591267238939.stgit@devnote2>
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

Add list option (-l) to show the bootconfig in the list style.
This is same output of /proc/bootconfig. So users can check
how their bootconfig will be shown in procfs. This will help
them to write a user-space script to parse the /proc/bootconfig.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |   52 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index d165e63b5d5a..78025267df20 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -14,18 +14,19 @@
 #include <linux/kernel.h>
 #include <linux/bootconfig.h>
 
-static int xbc_show_value(struct xbc_node *node)
+static int xbc_show_value(struct xbc_node *node, bool semicolon)
 {
-	const char *val;
+	const char *val, *eol;
 	char q;
 	int i = 0;
 
+	eol = semicolon ? ";\n" : "\n";
 	xbc_array_for_each_value(node, val) {
 		if (strchr(val, '"'))
 			q = '\'';
 		else
 			q = '"';
-		printf("%c%s%c%s", q, val, q, node->next ? ", " : ";\n");
+		printf("%c%s%c%s", q, val, q, node->next ? ", " : eol);
 		i++;
 	}
 	return i;
@@ -53,7 +54,7 @@ static void xbc_show_compact_tree(void)
 			continue;
 		} else if (cnode && xbc_node_is_value(cnode)) {
 			printf("%s = ", xbc_node_get_data(node));
-			xbc_show_value(cnode);
+			xbc_show_value(cnode, true);
 		} else {
 			printf("%s;\n", xbc_node_get_data(node));
 		}
@@ -77,6 +78,26 @@ static void xbc_show_compact_tree(void)
 	}
 }
 
+static void xbc_show_list(void)
+{
+	char key[XBC_KEYLEN_MAX];
+	struct xbc_node *leaf;
+	const char *val;
+	int ret = 0;
+
+	xbc_for_each_key_value(leaf, val) {
+		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
+		if (ret < 0)
+			break;
+		printf("%s = ", key);
+		if (!val || val[0] == '\0') {
+			printf("\"\"\n");
+			continue;
+		}
+		xbc_show_value(xbc_node_get_child(leaf), false);
+	}
+}
+
 /* Simple real checksum */
 int checksum(unsigned char *buf, int len)
 {
@@ -233,7 +254,7 @@ static int init_xbc_with_error(char *buf, int len)
 	return ret;
 }
 
-int show_xbc(const char *path)
+int show_xbc(const char *path, bool list)
 {
 	int ret, fd;
 	char *buf = NULL;
@@ -267,7 +288,10 @@ int show_xbc(const char *path)
 		if (init_xbc_with_error(buf, ret) < 0)
 			goto out;
 	}
-	xbc_show_compact_tree();
+	if (list)
+		xbc_show_list();
+	else
+		xbc_show_compact_tree();
 	ret = 0;
 out:
 	free(buf);
@@ -390,7 +414,8 @@ int usage(void)
 		" Apply, delete or show boot config to initrd.\n"
 		" Options:\n"
 		"		-a <config>: Apply boot config to initrd\n"
-		"		-d : Delete boot config file from initrd\n\n"
+		"		-d : Delete boot config file from initrd\n"
+		"		-l : list boot config in initrd or file\n\n"
 		" If no option is given, show the bootconfig in the given file.\n");
 	return -1;
 }
@@ -399,10 +424,10 @@ int main(int argc, char **argv)
 {
 	char *path = NULL;
 	char *apply = NULL;
-	bool delete = false;
+	bool delete = false, list = false;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "hda:")) != -1) {
+	while ((opt = getopt(argc, argv, "hda:l")) != -1) {
 		switch (opt) {
 		case 'd':
 			delete = true;
@@ -410,14 +435,17 @@ int main(int argc, char **argv)
 		case 'a':
 			apply = optarg;
 			break;
+		case 'l':
+			list = true;
+			break;
 		case 'h':
 		default:
 			return usage();
 		}
 	}
 
-	if (apply && delete) {
-		pr_err("Error: You can not specify both -a and -d at once.\n");
+	if ((apply && delete) || (delete && list) || (apply && list)) {
+		pr_err("Error: You can give one of -a, -d or -l at once.\n");
 		return usage();
 	}
 
@@ -433,5 +461,5 @@ int main(int argc, char **argv)
 	else if (delete)
 		return delete_xbc(path);
 
-	return show_xbc(path);
+	return show_xbc(path, list);
 }

