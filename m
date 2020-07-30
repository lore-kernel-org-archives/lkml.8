Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC22DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8D722B48
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgG3C2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 22:28:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48468 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbgG3C2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 22:28:32 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8269D776C5C57E678038;
        Thu, 30 Jul 2020 10:28:27 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 10:28:23 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <jdike@addtoit.com>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] um: Remove redundant NULL check
Date:   Thu, 30 Jul 2020 10:29:45 +0800
Message-ID: <1596076185-39276-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warnings reported by coccicheck:
./arch/um/drivers/vector_user.c:403:2-7: WARNING: NULL check before some freeing functions is not needed.

Signed-off-by: Li Heng <liheng40@huawei.com>
---
 arch/um/drivers/vector_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index c4a0f26..e836d49 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -399,8 +399,7 @@ static struct vector_fds *user_init_fd_fds(struct arglist *ifspec)
 fd_cleanup:
 	if (fd >= 0)
 		os_close_file(fd);
-	if (result != NULL)
-		kfree(result);
+	kfree(result);
 	return NULL;
 }
 
-- 
2.7.4

