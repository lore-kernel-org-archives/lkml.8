Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02795C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A5F2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgDQHOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:14:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51094 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbgDQHOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:14:15 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1293738B17AEE043B47E;
        Fri, 17 Apr 2020 15:14:10 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 15:14:00 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <akpm@linux-foundation.org>, <khlebnikov@yandex-team.ru>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] lib/test_lockup.c: make test_inode static
Date:   Fri, 17 Apr 2020 15:40:21 +0800
Message-ID: <20200417074021.46411-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

lib/test_lockup.c:145:14: warning: symbol 'test_inode' was not declared.
Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 lib/test_lockup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index ea09ca335b21..419fbaceba73 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -142,7 +142,7 @@ module_param(reallocate_pages, bool, 0400);
 MODULE_PARM_DESC(reallocate_pages, "free and allocate pages between iterations");
 
 struct file *test_file;
-struct inode *test_inode;
+static struct inode *test_inode;
 static char test_file_path[256];
 module_param_string(file_path, test_file_path, sizeof(test_file_path), 0400);
 MODULE_PARM_DESC(file_path, "file path to test");
-- 
2.21.1

