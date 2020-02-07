Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65399C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439CE20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGH4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:56:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgBGH4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:56:43 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DB1AA3694BE73AD34D31;
        Fri,  7 Feb 2020 15:56:38 +0800 (CST)
Received: from HGHY2S004841851.china.huawei.com (10.184.217.114) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 7 Feb 2020 15:56:32 +0800
From:   Shen Kai <shenkai8@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <linfeilong@huawei.com>
Subject: [PATCH] add lock proctect to __handle_sysrq in write_sysrq_trigger
Date:   Fri, 7 Feb 2020 07:56:06 +0000
Message-ID: <1581062166-27284-1-git-send-email-shenkai8@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.217.114]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feilong Lin <linfeilong@huawei.com>

Add lock protect to __handle_sysrq to avoid race condition.
__handle_sysrq will change console_loglevel without lock protect
which can lead to console_loglevel to be set as an unexpected value.

Problem may occur when "echo t > /proc/sysrq-trigger" is called on 
multiple cpus concurrently.

In this case in __handle_sysrq, console_loglevel is set to 7 to print
some head info to the console then restore it. But without lock protect
in parallel execution situation, restoring may go wrong. The new 
loglevel may be taken as the previous loglevel incorrectly.
Console_loglevel can be 7 at last, which causes the terminal to output
info in most log levels.

This bug was found on linux 4.19

Signed-off-by: Feilong Lin <linfeilong@huawei.com>
Reported-by: Kai Shen <shenkai8@huawei.com>
---
 drivers/tty/sysrq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f724962..cbb48a9 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -1087,6 +1087,8 @@ EXPORT_SYMBOL(unregister_sysrq_key);
 /*
  * writing 'C' to /proc/sysrq-trigger is like sysrq-C
  */
+static DEFINE_MUTEX(sysrq_mutex);
+
 static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
 				   size_t count, loff_t *ppos)
 {
@@ -1095,7 +1097,9 @@ static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
 
 		if (get_user(c, buf))
 			return -EFAULT;
+		mutex_lock(&sysrq_mutex);
 		__handle_sysrq(c, false);
+		mutex_unlock(&sysrq_mutex);
 	}
 
 	return count;
-- 
2.6.4.windows.1


