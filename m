Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B943AC11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9265A24673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582183670;
	bh=ZfvP0/waC5M8XVQY066oJvqxQW8C54uBoxnMBMRCNaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O0wOO33w9qvuWJyQ2vHMn0ts0K4/gxrcY56MONlnC6xFzElkikF1f1ZTQbxv+z9Kp
	 scx4VMdu3gs9oJvhQ6ZMe+jWSDC+9NltTE5zMmQ7V/XDpz+zbJ9pPmmigQNNH+Ftsz
	 rxkWYDNpOAoO5fORS50cxQe8RmMsyTWf5ODewdP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgBTH1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:27:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgBTH1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:27:49 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 687072467A;
        Thu, 20 Feb 2020 07:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582183668;
        bh=ZfvP0/waC5M8XVQY066oJvqxQW8C54uBoxnMBMRCNaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BmCQZr7Y1WjnkuKc/1+l8sB+OLT1kh2Fq0UNpAG/xP6DQ2tSIWz4aPzVC60m2eqtH
         IGQ/1qCY7vqf0ILtpRpT1FyHEONFNAvQjiXgsubBnvj6KWZQtqb8xjFrpOOUrF/9mi
         /To9cDp7jKb4+pRrLWrcAidteZ55+O0KyguoX5yc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 8/8] bootconfig: Print array as multiple commands for legacy command line
Date:   Thu, 20 Feb 2020 16:27:44 +0900
Message-Id: <158218366394.6940.17725577299878032543.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158218358363.6940.18380270211351882136.stgit@devnote2>
References: <158218358363.6940.18380270211351882136.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/init/main.c b/init/main.c
index 7c4ca805562a..606c702f5fc8 100644
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

