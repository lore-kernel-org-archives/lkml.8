Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C177BC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924AE217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgBEWVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:21:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbgBEWVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:21:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 690BD222D9;
        Wed,  5 Feb 2020 22:21:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1izT3H-001P1a-B5; Wed, 05 Feb 2020 17:21:43 -0500
Message-Id: <20200205222143.227990456@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Feb 2020 17:21:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 4/5] tools/bootconfig: Show the number of bootconfig nodes
References: <20200205222110.912457436@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Show the number of bootconfig nodes when applying new bootconfig to
initrd.

Since there are limitations of bootconfig not only in its filesize,
but also the number of nodes, the number should be shown when applying
so that user can get the feeling of scale of current bootconfig.

Link: http://lkml.kernel.org/r/158091061337.27924.10886706631693823982.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/bootconfig.c        | 5 ++++-
 tools/bootconfig/main.c | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a98ae136529c..afb2e767e6fe 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -728,7 +728,8 @@ void __init xbc_destroy_all(void)
  *
  * This parses the boot config text in @buf. @buf must be a
  * null terminated string and smaller than XBC_DATA_MAX.
- * Return 0 if succeeded, or -errno if there is any error.
+ * Return the number of stored nodes (>0) if succeeded, or -errno
+ * if there is any error.
  */
 int __init xbc_init(char *buf)
 {
@@ -788,6 +789,8 @@ int __init xbc_init(char *buf)
 
 	if (ret < 0)
 		xbc_destroy_all();
+	else
+		ret = xbc_node_num;
 
 	return ret;
 }
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 91c9a5c0c499..47f488458328 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -268,6 +268,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 		return ret;
 	}
 	printf("Apply %s to %s\n", xbc_path, path);
+	printf("\tNumber of nodes: %d\n", ret);
 	printf("\tSize: %u bytes\n", (unsigned int)size);
 	printf("\tChecksum: %d\n", (unsigned int)csum);
 
-- 
2.24.1


