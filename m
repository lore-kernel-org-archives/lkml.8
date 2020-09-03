Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9D3C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBBE20786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgICPVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:21:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10759 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728547AbgICLZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:25:11 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 41D9C69B637213C69AA1;
        Thu,  3 Sep 2020 19:08:41 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 19:08:32 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <minyard@acm.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] ipmi: add a newline when printing parameter 'panic_op' by sysfs
Date:   Thu, 3 Sep 2020 19:01:13 +0800
Message-ID: <1599130873-2402-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I cat ipmi_msghandler parameter 'panic_op' by sysfs, it displays as
follows. It's better to add a newline for easy reading.

root@(none):/# cat /sys/module/ipmi_msghandler/parameters/panic_op
noneroot@(none):/#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 737c0b6..6ebb549 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -89,19 +89,19 @@ static int panic_op_read_handler(char *buffer, const struct kernel_param *kp)
 {
 	switch (ipmi_send_panic_event) {
 	case IPMI_SEND_PANIC_EVENT_NONE:
-		strcpy(buffer, "none");
+		strcpy(buffer, "none\n");
 		break;
 
 	case IPMI_SEND_PANIC_EVENT:
-		strcpy(buffer, "event");
+		strcpy(buffer, "event\n");
 		break;
 
 	case IPMI_SEND_PANIC_EVENT_STRING:
-		strcpy(buffer, "string");
+		strcpy(buffer, "string\n");
 		break;
 
 	default:
-		strcpy(buffer, "???");
+		strcpy(buffer, "???\n");
 		break;
 	}
 
-- 
1.7.12.4

