Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160ACC11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E063220732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgBXRWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgBXRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 169F021D56;
        Mon, 24 Feb 2020 17:21:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPy-001Ahk-17; Mon, 24 Feb 2020 12:21:18 -0500
Message-Id: <20200224172117.900809318@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [for-linus][PATCH 13/15] bootconfig: Print array as multiple commands for legacy command line
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Print arraied values as multiple same options for legacy
kernel command line. With this rule, if the "kernel.*" and
"init.*" array entries in bootconfig are printed out as
multiple same options, e.g.

kernel {
 console = "ttyS0,115200"
 console += "tty0"
}

will be correctly converted to

console="ttyS0,115200" console="tty0"

in the kernel command line.

Link: http://lkml.kernel.org/r/158220118213.26565.8163300497009463916.stgit@devnote2

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2fe8dec93e68..c9b1ee6bbb8d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -268,7 +268,6 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 {
 	struct xbc_node *knode, *vnode;
 	char *end = buf + size;
-	char c = '\"';
 	const char *val;
 	int ret;
 
@@ -279,25 +278,20 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 			return ret;
 
 		vnode = xbc_node_get_child(knode);
-		ret = snprintf(buf, rest(buf, end), "%s%c", xbc_namebuf,
-				vnode ? '=' : ' ');
-		if (ret < 0)
-			return ret;
-		buf += ret;
-		if (!vnode)
+		if (!vnode) {
+			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
+			if (ret < 0)
+				return ret;
+			buf += ret;
 			continue;
-
-		c = '\"';
+		}
 		xbc_array_for_each_value(vnode, val) {
-			ret = snprintf(buf, rest(buf, end), "%c%s", c, val);
+			ret = snprintf(buf, rest(buf, end), "%s=\"%s\" ",
+				       xbc_namebuf, val);
 			if (ret < 0)
 				return ret;
 			buf += ret;
-			c = ',';
 		}
-		if (rest(buf, end) > 2)
-			strcpy(buf, "\" ");
-		buf += 2;
 	}
 
 	return buf - (end - size);
-- 
2.25.0


