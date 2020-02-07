Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C45FC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93F921741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581083706;
	bh=/DJDioa5aewgXfPA9osE7mqZMcad0mT1AbwY/XarPgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eQhCL5RRzNx0Mqngvz36jUKT0a2hMNCqO3KtGkYeR9u/pDHSkrJMrAT+8PUsz0pSz
	 aEmwmZo5pYHOBDZb7IJApzlCj3CFf8dWd/0R5qcKzRJJY/5bNsk3sWuzxnHk+aGvWU
	 9fl7K5ja3/ir8uS268xb9OorQQVwNHfqsLA96f9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgBGNzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgBGNzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:55:05 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE50C20720;
        Fri,  7 Feb 2020 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581083705;
        bh=/DJDioa5aewgXfPA9osE7mqZMcad0mT1AbwY/XarPgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2gFMslvSyBiAaLDzxpsxU78KqVgOxbNA7N5n2gnm735yJ91jwwjJ1fhETkC5lkNS6
         Y6SCIUM5nUmfSGBVo8OXZw+1zNSdmASX+PJnao+jwgRgy6DpZT3Uqb0Y1urR6PuFKZ
         2Dn7UXKlVY5pTwfXse7SH7DtkbKVg0fHNDnQBs6Y=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] tools/bootconfig: Fix wrong __VA_ARGS__ usage
Date:   Fri,  7 Feb 2020 22:55:01 +0900
Message-Id: <158108370130.2758.10893830923800978011.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87o8ua1rg3.fsf@mpe.ellerman.id.au>
References: <87o8ua1rg3.fsf@mpe.ellerman.id.au>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since printk() wrapper macro uses __VA_ARGS__ without
"##" prefix, it causes a build error if there is no
variable arguments (e.g. only fmt is specified.)
To fix this error, use ##__VA_ARGS__ instead of
__VAR_ARGS__.

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/include/linux/printk.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/include/linux/printk.h b/tools/bootconfig/include/linux/printk.h
index 017bcd6912a5..e978a63d3222 100644
--- a/tools/bootconfig/include/linux/printk.h
+++ b/tools/bootconfig/include/linux/printk.h
@@ -7,7 +7,7 @@
 /* controllable printf */
 extern int pr_output;
 #define printk(fmt, ...)	\
-	(pr_output ? printf(fmt, __VA_ARGS__) : 0)
+	(pr_output ? printf(fmt, ##__VA_ARGS__) : 0)
 
 #define pr_err printk
 #define pr_warn	printk

