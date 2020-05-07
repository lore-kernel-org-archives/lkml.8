Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE574C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955A5208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgEGMVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:21:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3892 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbgEGMVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:21:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7BAAD1B3ABE06615F60E;
        Thu,  7 May 2020 20:21:07 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 20:20:57 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>, <dm-devel@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] dm mpath: Remove unused variable ret
Date:   Thu, 7 May 2020 20:26:52 +0800
Message-ID: <1588854412-19301-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below warning reported by coccicheck:

drivers/md/dm-historical-service-time.c:240:14-16: Unneeded variable: "sz". Return "0" on line 261

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/md/dm-historical-service-time.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-historical-service-time.c b/drivers/md/dm-historical-service-time.c
index 186f91e..3c8acb9 100644
--- a/drivers/md/dm-historical-service-time.c
+++ b/drivers/md/dm-historical-service-time.c
@@ -237,7 +237,6 @@ static void hst_destroy(struct path_selector *ps)
 static int hst_status(struct path_selector *ps, struct dm_path *path,
 		     status_type_t type, char *result, unsigned int maxlen)
 {
-	unsigned int sz = 0;
 	struct path_info *pi;
 
 	if (!path) {
@@ -258,7 +257,7 @@ static int hst_status(struct path_selector *ps, struct dm_path *path,
 		}
 	}
 
-	return sz;
+	return 0;
 }
 
 static int hst_add_path(struct path_selector *ps, struct dm_path *path,
-- 
2.6.2

