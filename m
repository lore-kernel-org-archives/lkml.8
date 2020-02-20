Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFA9C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF8824676
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582201188;
	bh=T6827mSnyvKgT9BHC3wiK1eVbFXxKEp7/bfCsigzPZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GYQBXue6DCpmccn/dcWgdUZ4Kni4pMM7UJVw3XerzIR9Ai2tgYhjLb0zxwVJ/OeNd
	 sPI50gUzljCyd2v1n2xbWV9TnJGUv2yWlgdmCZ9KJqhEyXFASL8HNjwLPx07iJ3P6S
	 /MhyJpyOTRAJL8oLX2oIN1A/s1uDyfrSXxh0hjBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBTMTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:19:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgBTMTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:19:46 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE6A24673;
        Thu, 20 Feb 2020 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582201186;
        bh=T6827mSnyvKgT9BHC3wiK1eVbFXxKEp7/bfCsigzPZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJbOnNma1ZE5C61k2a440CqZHNfIZxi6rNO2s3xSpiWOvNuo6xyO15l+z61gWMMjE
         RMy2wzNPSBDvA9F+aR/zeVzGZzySVg9VHdsIgzKNC9HbDZYWCUbESdoygHrYgpZjQf
         z0aFhXqiWY03ahY+qg3egxuZmDT1ltiki254Jf1U=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 8/8] bootconfig: Print array as multiple commands for legacy command line
Date:   Thu, 20 Feb 2020 21:19:42 +0900
Message-Id: <158220118213.26565.8163300497009463916.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158220110257.26565.4812934676257459744.stgit@devnote2>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
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
index 821c582af49b..19a5577e0bb0 100644
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

