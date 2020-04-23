Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFE0C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 04:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922C92073A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 04:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgDWECa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 00:02:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2836 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbgDWECa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 00:02:30 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 90F35CEB21F28EFDEF7D;
        Thu, 23 Apr 2020 12:02:27 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 12:02:19 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] tracing: Make tracing_snapshot_instance_cond() static
Date:   Thu, 23 Apr 2020 12:08:25 +0800
Message-ID: <1587614905-48692-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

kernel/trace/trace.c:950:6: warning: symbol 'tracing_snapshot_instance_cond'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 kernel/trace/trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8d2b988..1424a89 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -947,7 +947,8 @@ int __trace_bputs(unsigned long ip, const char *str)
 EXPORT_SYMBOL_GPL(__trace_bputs);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-void tracing_snapshot_instance_cond(struct trace_array *tr, void *cond_data)
+static void tracing_snapshot_instance_cond(struct trace_array *tr,
+					   void *cond_data)
 {
 	struct tracer *tracer = tr->current_trace;
 	unsigned long flags;
-- 
2.6.2

