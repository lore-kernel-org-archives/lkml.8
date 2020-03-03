Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD506C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881252086A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583234697;
	bh=2Ae0w3bWvQECQaRXNvjEHT5PtqeznR2GTdvqPgQX+fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u2bqMNAsaHvAEj0L+iCx9pffr2aYNzC8ikRtYb+GKJmFVbnBt+ljDYUh8NiCjnFwf
	 PUFgkkgkUNkOUVPFGH83Yp5iD3WhWX4YoYNA11+GIWvJHzA8btrfnFZw1Jr8Ojamnn
	 4TQBmN/Qgr9klRt9IAccq4+LkuE70CHPzm0BEM1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgCCLY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbgCCLY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:24:56 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA1720857;
        Tue,  3 Mar 2020 11:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583234694;
        bh=2Ae0w3bWvQECQaRXNvjEHT5PtqeznR2GTdvqPgQX+fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvWcxnRA6+fxYobIc7JAl/xld4/3YI7g5g02vskdHndAhl3WZ5OU4scMhP+v6dnNn
         1nwqzbQT5Qr3YXUf9AC9uc1LOTN3g/6nChcAlYTyoReFoZ1c5WJ1B+L2QwPRbmg2aa
         4P64QyrYbRMzXa7X/GOSm8kgrgBt8u3ODInZ5Ys0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] tools/bootconfig: Show line and column in parse error
Date:   Tue,  3 Mar 2020 20:24:50 +0900
Message-Id: <158323469002.10560.4023923847704522760.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158323467008.10560.4307464503748340855.stgit@devnote2>
References: <158323467008.10560.4307464503748340855.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show line and column when we got a parse error in bootconfig tool.
Current lib/bootconfig shows the parse error with byte offset, but
that is not human readable.
This makes xbc_init() not showing error message itself but able to
pass the error message and position to caller, so that the caller
can decode it and show the error message with line number and columns.

With this patch, bootconfig tool shows an error with line:column as
below.

  $ cat samples/bad-dotword.bconf
  # do not start keyword with .
  key {
    .word = 1
  }
  $ ./bootconfig -a samples/bad-dotword.bconf initrd
  Parse Error: Invalid keyword at 3:3

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/bootconfig.h |    3 ++-
 init/main.c                |   14 ++++++++++----
 lib/bootconfig.c           |   35 ++++++++++++++++++++++++++---------
 tools/bootconfig/main.c    |   35 +++++++++++++++++++++++++++++++----
 4 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index d11e183fcb54..9903088891fa 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -216,7 +216,8 @@ static inline int __init xbc_node_compose_key(struct xbc_node *node,
 }
 
 /* XBC node initializer */
-int __init xbc_init(char *buf);
+int __init xbc_init(char *buf, const char **emsg, int *epos);
+
 
 /* XBC cleanup data structures */
 void __init xbc_destroy_all(void);
diff --git a/init/main.c b/init/main.c
index c9b1ee6bbb8d..c749da3ce070 100644
--- a/init/main.c
+++ b/init/main.c
@@ -353,6 +353,8 @@ static int __init bootconfig_params(char *param, char *val,
 static void __init setup_boot_config(const char *cmdline)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
+	const char *msg;
+	int pos;
 	u32 size, csum;
 	char *data, *copy;
 	u32 *hdr;
@@ -400,10 +402,14 @@ static void __init setup_boot_config(const char *cmdline)
 	memcpy(copy, data, size);
 	copy[size] = '\0';
 
-	ret = xbc_init(copy);
-	if (ret < 0)
-		pr_err("Failed to parse bootconfig\n");
-	else {
+	ret = xbc_init(copy, &msg, &pos);
+	if (ret < 0) {
+		if (pos < 0)
+			pr_err("Failed to init bootconfig: %s.\n", msg);
+		else
+			pr_err("Failed to parse bootconfig: %s at %d.\n",
+				msg, pos);
+	} else {
 		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index ec3ce7fd299f..912ef4921398 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -29,12 +29,14 @@ static int xbc_node_num __initdata;
 static char *xbc_data __initdata;
 static size_t xbc_data_size __initdata;
 static struct xbc_node *last_parent __initdata;
+static const char *xbc_err_msg __initdata;
+static int xbc_err_pos __initdata;
 
 static int __init xbc_parse_error(const char *msg, const char *p)
 {
-	int pos = p - xbc_data;
+	xbc_err_msg = msg;
+	xbc_err_pos = (int)(p - xbc_data);
 
-	pr_err("Parse error at pos %d: %s\n", pos, msg);
 	return -EINVAL;
 }
 
@@ -738,33 +740,44 @@ void __init xbc_destroy_all(void)
 /**
  * xbc_init() - Parse given XBC file and build XBC internal tree
  * @buf: boot config text
+ * @emsg: A pointer of const char * to store the error message
+ * @epos: A pointer of int to store the error position
  *
  * This parses the boot config text in @buf. @buf must be a
  * null terminated string and smaller than XBC_DATA_MAX.
  * Return the number of stored nodes (>0) if succeeded, or -errno
  * if there is any error.
+ * In error cases, @emsg will be updated with an error message and
+ * @epos will be updated with the error position which is the byte offset
+ * of @buf. If the error is not a parser error, @epos will be -1.
  */
-int __init xbc_init(char *buf)
+int __init xbc_init(char *buf, const char **emsg, int *epos)
 {
 	char *p, *q;
 	int ret, c;
 
+	if (epos)
+		*epos = -1;
+
 	if (xbc_data) {
-		pr_err("Error: bootconfig is already initialized.\n");
+		if (emsg)
+			*emsg = "Bootconfig is already initialized";
 		return -EBUSY;
 	}
 
 	ret = strlen(buf);
 	if (ret > XBC_DATA_MAX - 1 || ret == 0) {
-		pr_err("Error: Config data is %s.\n",
-			ret ? "too big" : "empty");
+		if (emsg)
+			*emsg = ret ? "Config data is too big" :
+				"Config data is empty";
 		return -ERANGE;
 	}
 
 	xbc_nodes = memblock_alloc(sizeof(struct xbc_node) * XBC_NODE_MAX,
 				   SMP_CACHE_BYTES);
 	if (!xbc_nodes) {
-		pr_err("Failed to allocate memory for bootconfig nodes.\n");
+		if (emsg)
+			*emsg = "Failed to allocate bootconfig nodes";
 		return -ENOMEM;
 	}
 	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
@@ -814,9 +827,13 @@ int __init xbc_init(char *buf)
 	if (!ret)
 		ret = xbc_verify_tree();
 
-	if (ret < 0)
+	if (ret < 0) {
+		if (epos)
+			*epos = xbc_err_pos;
+		if (emsg)
+			*emsg = xbc_err_msg;
 		xbc_destroy_all();
-	else
+	} else
 		ret = xbc_node_num;
 
 	return ret;
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index a9b97814d1a9..16b9a420e6fd 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -130,6 +130,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 	int ret;
 	u32 size = 0, csum = 0, rcsum;
 	char magic[BOOTCONFIG_MAGIC_LEN];
+	const char *msg;
 
 	ret = fstat(fd, &stat);
 	if (ret < 0)
@@ -182,10 +183,12 @@ int load_xbc_from_initrd(int fd, char **buf)
 		return -EINVAL;
 	}
 
-	ret = xbc_init(*buf);
+	ret = xbc_init(*buf, &msg, NULL);
 	/* Wrong data */
-	if (ret < 0)
+	if (ret < 0) {
+		pr_err("parse error: %s.\n", msg);
 		return ret;
+	}
 
 	return size;
 }
@@ -244,11 +247,34 @@ int delete_xbc(const char *path)
 	return ret;
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
 int apply_xbc(const char *path, const char *xbc_path)
 {
 	u32 size, csum;
 	char *buf, *data;
 	int ret, fd;
+	const char *msg;
+	int pos;
 
 	ret = load_xbc_file(xbc_path, &buf);
 	if (ret < 0) {
@@ -267,11 +293,12 @@ int apply_xbc(const char *path, const char *xbc_path)
 	*(u32 *)(data + size + 4) = csum;
 
 	/* Check the data format */
-	ret = xbc_init(buf);
+	ret = xbc_init(buf, &msg, &pos);
 	if (ret < 0) {
-		pr_err("Failed to parse %s: %d\n", xbc_path, ret);
+		show_xbc_error(data, msg, pos);
 		free(data);
 		free(buf);
+
 		return ret;
 	}
 	printf("Apply %s to %s\n", xbc_path, path);

