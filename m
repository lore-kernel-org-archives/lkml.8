Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7132C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96279207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943642;
	bh=Yk050y+biJEAGvsKaTUJVbcaGV4a4C3rY2vTssrcBwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1niJMBSkQGJZhVfffAp1qTJPRf3kRe9BWFyXBhGzfTxRQN9hInCdYTY130OkzJO0i
	 jEqDeuu91tueGY7uP3Is2BPIlU6/108Nf5yj9nKgxB21CI8dF/QLu/xjrWvwJOCmjL
	 mdBoCOZG7LCu/H6dzokMzIZ5cRQMbeBzUi2w65WU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389958AbgFWUUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389868AbgFWUUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:20:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19872070E;
        Tue, 23 Jun 2020 20:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943631;
        bh=Yk050y+biJEAGvsKaTUJVbcaGV4a4C3rY2vTssrcBwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBK6Umu/gyF88A8NXr88xr7bmzzEhmzbVslADGX5UaCnrrvjKx/MwGYKOGWEcSF+n
         o5TYCv72CcIt7ujqya8IGdxJ+cWOeixY9kxku/j4IQEeImTfZcoMClz7daqjfPFZ5g
         9ejL7BLCW2paOPC1l5TiJVfdAJJJuVzMqnAqNX/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.7 466/477] tools/bootconfig: Fix to return 0 if succeeded to show the bootconfig
Date:   Tue, 23 Jun 2020 21:57:43 +0200
Message-Id: <20200623195429.575649147@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

commit f91cb5b7476a603068eae31e5b2cc170dd2b9b1b upstream.

Fix bootconfig to return 0 if succeeded to show the bootconfig
in initrd. Without this fix, "bootconfig INITRD" command
returns !0 even if the command succeeded to show the bootconfig.

Link: http://lkml.kernel.org/r/159230246566.65555.11891772258543514487.stgit@devnote2

Cc: stable@vger.kernel.org
Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/bootconfig/main.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

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
 


