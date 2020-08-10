Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63915C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDE420716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597048498;
	bh=Ysl/FfEA15nZohgMrKMoXiAFQWj3fx2wTXztEgbYH9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zEOsmdHDWixfluWAOxciya5cBnCLzCzfvEL5qGnB5Oj5z1QUy0kKTzmVewRJ/FjTF
	 jFwCY0GFscw1qFGA1YA7tx6b/+XLoH1pGL2FLwxMrq7s6XLIoxh27js+rgJBDrdRUs
	 SNm3jDHhNoPGkJZ6J/B/Fdy0A+JBViiA64LYI2VE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgHJIe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgHJIe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:34:56 -0400
Received: from localhost.localdomain (unknown [180.22.250.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2782070B;
        Mon, 10 Aug 2020 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597048496;
        bh=Ysl/FfEA15nZohgMrKMoXiAFQWj3fx2wTXztEgbYH9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zloAdwOeWiRQIn0t6LNsK2z8x2iDK4TRJ+U4QeWeDxDLZblLe8laCN3Z09Zm6UHcJ
         4Kf+P0/pOI1LDZDeiRNKi2qH2e4SEGK895ptsW1ib6EfwXEd1U5O6xS52h8bBtARFh
         SqdVWNLEv8PyX2hCEbH5RmC3+0LlTFsQMDJVgdvg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/6] tools/bootconfig: Add list option
Date:   Mon, 10 Aug 2020 17:34:51 +0900
Message-Id: <159704849087.175360.8761890802048625207.stgit@devnote2>
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

