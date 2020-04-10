Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354FDC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130D621974
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgDJL4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:56:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46008 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbgDJL4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:56:35 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 036C678809575001BBEA;
        Fri, 10 Apr 2020 19:56:34 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 19:56:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] xen/pvcalls: Make pvcalls_back_global static
Date:   Fri, 10 Apr 2020 19:56:20 +0800
Message-ID: <20200410115620.33024-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/xen/pvcalls-back.c:30:3: warning:
 symbol 'pvcalls_back_global' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/xen/pvcalls-back.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index cf4ce3e9358d..4807704f8d69 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -24,7 +24,7 @@
 #define PVCALLS_VERSIONS "1"
 #define MAX_RING_ORDER XENBUS_MAX_RING_GRANT_ORDER
 
-struct pvcalls_back_global {
+static struct pvcalls_back_global {
 	struct list_head frontends;
 	struct semaphore frontends_lock;
 } pvcalls_back_global;
-- 
2.17.1


