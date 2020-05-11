Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2B9C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F09420735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgEKI3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 04:29:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4327 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728341AbgEKI3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:29:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6C974235951EAA2CC910;
        Mon, 11 May 2020 16:29:32 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 16:29:25 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <song@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] md: add a newline when printing parameter 'start_ro' by sysfs
Date:   Mon, 11 May 2020 16:23:25 +0800
Message-ID: <1589185405-39519-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing newline when printing module parameter 'start_ro' by
sysfs.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 271e8a5..acffcc0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9785,7 +9785,7 @@ static __exit void md_exit(void)
 
 static int get_ro(char *buffer, const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%d", start_readonly);
+	return sprintf(buffer, "%d\n", start_readonly);
 }
 static int set_ro(const char *val, const struct kernel_param *kp)
 {
-- 
1.7.12.4

