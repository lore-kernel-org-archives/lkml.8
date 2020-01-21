Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A761DC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852C422314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAUFyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:54:32 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:41248 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728748AbgAUFyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:54:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ToH1aMT_1579586069;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToH1aMT_1579586069)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 13:54:29 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: remove NR_TO_INIT macro
Date:   Tue, 21 Jan 2020 13:54:23 +0800
Message-Id: <1579586063-44984-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro isn't used from commit cb7be3b2fc2c ("ftrace: remove
daemon"). So no needs to keep it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/trace/ftrace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 68c4f20c564e..07a115481a52 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1101,9 +1101,6 @@ struct ftrace_page {
 #define ENTRY_SIZE sizeof(struct dyn_ftrace)
 #define ENTRIES_PER_PAGE (PAGE_SIZE / ENTRY_SIZE)
 
-/* estimate from running different kernels */
-#define NR_TO_INIT		10000
-
 static struct ftrace_page	*ftrace_pages_start;
 static struct ftrace_page	*ftrace_pages;
 
-- 
1.8.3.1

