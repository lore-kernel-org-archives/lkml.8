Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4492C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16DE22314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAUFyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:54:40 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:52347 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbgAUFyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:54:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ToH3SVv_1579586077;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToH3SVv_1579586077)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 13:54:37 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] trace/kprobe: remove MAX_KPROBE_CMDLINE_SIZE
Date:   Tue, 21 Jan 2020 13:54:35 +0800
Message-Id: <1579586075-45132-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This limitation are never lunched from introduce commit 970988e19eb0
("tracing/kprobe: Add kprobe_event= boot parameter")

Could we remove it if no intention to implement it?

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/trace/trace_kprobe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7f890262c8a3..eafa90d0f760 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -22,7 +22,6 @@
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
 #define KRETPROBE_MAXACTIVE_MAX 4096
-#define MAX_KPROBE_CMDLINE_SIZE 1024
 
 /* Kprobe early definition from command line */
 static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
-- 
1.8.3.1

