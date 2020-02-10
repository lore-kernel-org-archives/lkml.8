Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5DFC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383C920873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgBJOpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbgBJOpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A7BE2173E;
        Mon, 10 Feb 2020 14:45:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j1AJb-001Vxg-9I; Mon, 10 Feb 2020 09:45:35 -0500
Message-Id: <20200210144535.166654787@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 10 Feb 2020 09:44:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 1/4] tools/bootconfig: Fix wrong __VA_ARGS__ usage
References: <20200210144455.531096382@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since printk() wrapper macro uses __VA_ARGS__ without "##" prefix, it causes
a build error if there is no variable arguments (e.g. only fmt is
specified.) To fix this error, use ##__VA_ARGS__ instead of __VAR_ARGS__.

Link: http://lkml.kernel.org/r/158108370130.2758.10893830923800978011.stgit@devnote2

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/include/linux/printk.h | 2 +-
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
-- 
2.24.1


