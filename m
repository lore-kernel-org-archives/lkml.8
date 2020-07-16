Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7972CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6070F2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgGPIoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:44:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51484 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbgGPIoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:44:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 069ED22CDA09305709ED;
        Thu, 16 Jul 2020 16:44:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:44:07 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] debugobjects: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 16:47:47 +0800
Message-ID: <20200716084747.8034-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 lib/debugobjects.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 5d2bbfc55..916a5c492 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1023,17 +1023,7 @@ static int debug_stats_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int debug_stats_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, debug_stats_show, NULL);
-}
-
-static const struct file_operations debug_stats_fops = {
-	.open		= debug_stats_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debug_stats);
 
 static int __init debug_objects_init_debugfs(void)
 {
-- 
2.17.1

