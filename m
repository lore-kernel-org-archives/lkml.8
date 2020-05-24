Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02267C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD634207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgEXPeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:34:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60768 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgEXPeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:34:05 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04OFX9K7020749;
        Mon, 25 May 2020 00:33:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Mon, 25 May 2020 00:33:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04OFX2m8020738
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 May 2020 00:33:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] printk: Remove pr_cont_once()
Date:   Mon, 25 May 2020 00:32:43 +0900
Message-Id: <20200524153243.11690-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_cont_once() does not make sense; at least emitting module name using
pr_fmt() into middle of a line (after e.g. pr_info_once()) does not make
sense. Let's remove unused pr_cont_once().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Joe Perches <joe@perches.com>
---
 include/linux/printk.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 2562ffb438ed..4c565871f659 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -476,8 +476,7 @@ extern int kptr_restrict;
 	printk_once(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_info_once(fmt, ...)					\
 	printk_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_cont_once(fmt, ...)					\
-	printk_once(KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
+/* no pr_cont_once, don't do that... */
 
 #if defined(DEBUG) || defined(CONFIG_TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK)
 #define pr_devel_once(fmt, ...)					\
-- 
2.18.2

