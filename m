Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52CDC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD8C206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgA3OtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:49:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgA3OsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2604B24686;
        Thu, 30 Jan 2020 14:48:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB75-001CM8-34; Thu, 30 Jan 2020 09:48:11 -0500
Message-Id: <20200130144810.971745670@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:47:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [for-next][PATCH 05/21] tracing: eval_map_next() should always increase position index
References: <20200130144743.527378179@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

Link: http://lkml.kernel.org/r/7ad85b22-1866-977c-db17-88ac438bc764@virtuozzo.com

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
[ This is not a bug fix, it just makes it "technically correct"
  which is why I applied it. NULL is only returned on an anomaly
  which triggers a WARN_ON ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a28b1b9bf42..8d144fd94aa8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5399,14 +5399,12 @@ static void *eval_map_next(struct seq_file *m, void *v, loff_t *pos)
 	 * Paranoid! If ptr points to end, we don't want to increment past it.
 	 * This really should never happen.
 	 */
+	(*pos)++;
 	ptr = update_eval_map(ptr);
 	if (WARN_ON_ONCE(!ptr))
 		return NULL;
 
 	ptr++;
-
-	(*pos)++;
-
 	ptr = update_eval_map(ptr);
 
 	return ptr;
-- 
2.24.1


