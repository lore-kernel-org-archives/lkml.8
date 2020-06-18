Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B830C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5569220771
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgFRX5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbgFRX4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:56:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AABA208D5;
        Thu, 18 Jun 2020 23:56:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jm4Of-003lTN-EI; Thu, 18 Jun 2020 19:56:41 -0400
Message-ID: <20200618235641.330959344@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 19:56:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 15/17] tools/bootconfig: Fix to return 0 if succeeded to show the bootconfig
References: <20200618235556.451120786@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix bootconfig to return 0 if succeeded to show the bootconfig
in initrd. Without this fix, "bootconfig INITRD" command
returns !0 even if the command succeeded to show the bootconfig.

Link: http://lkml.kernel.org/r/159230246566.65555.11891772258543514487.stgit@devnote2

Cc: stable@vger.kernel.org
Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 21896a6675fd..e0878f5f74b1 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -207,11 +207,13 @@ int show_xbc(const char *path)
 	}
 
 	ret = load_xbc_from_initrd(fd, &buf);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_err("Failed to load a boot config from initrd: %d\n", ret);
-	else
-		xbc_show_compact_tree();
-
+		goto out;
+	}
+	xbc_show_compact_tree();
+	ret = 0;
+out:
 	close(fd);
 	free(buf);
 
-- 
2.26.2


