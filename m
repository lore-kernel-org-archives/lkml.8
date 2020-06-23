Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7C0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C4D20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbgFWIwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:52:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731840AbgFWIwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:52:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DB9081C1A8914FFD59C3;
        Tue, 23 Jun 2020 16:52:33 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Tue, 23 Jun 2020
 16:52:27 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <cj.chengjian@huawei.com>,
        <xiexiuqi@huawei.com>, <bobo.shaobowang@huawei.com>
Subject: [PATCH] tracing: Fix tracing buffer length in tracing_mark_write
Date:   Tue, 23 Jun 2020 16:52:18 +0800
Message-ID: <20200623085218.26426-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__copy_from_user_inatomic() return the byte length that copied failed,
tracing buffer should left this bytes.

Fixes: 656c7f0d2d2b ("tracing: Replace kmap with copy_from_user() in trace_marker writing")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 29615f15a820..ed5fe0f165e0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6628,7 +6628,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 		written = -EFAULT;
 	} else
 		written = cnt;
-	len = cnt;
+	cnt -= len;
 
 	if (tr->trace_marker_file && !list_empty(&tr->trace_marker_file->triggers)) {
 		/* do not add \n before testing triggers, but add \0 */
-- 
2.17.1

