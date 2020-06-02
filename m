Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E272F205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFBMIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:08:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbgFBMIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:08:01 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 725333EECE82EA8BDB1B;
        Tue,  2 Jun 2020 20:07:59 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 20:07:52 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <fbarrat@linux.ibm.com>, <ajd@linux.ibm.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <mpe@ellerman.id.au>, <imunsie@au1.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <wanghai38@huawei.com>
Subject: [PATCH] cxl: Fix kobject memleak
Date:   Tue, 2 Jun 2020 20:07:33 +0800
Message-ID: <20200602120733.5943-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the error return path from kobject_init_and_add() is not
followed by a call to kobject_put() - which means we are leaking
the kobject.

Fix it by adding a call to kobject_put() in the error path of
kobject_init_and_add().

Fixes: b087e6190ddc ("cxl: Export optional AFU configuration record in sysfs")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/misc/cxl/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index f0263d1..d97a243 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -624,7 +624,7 @@ static struct afu_config_record *cxl_sysfs_afu_new_cr(struct cxl_afu *afu, int c
 	rc = kobject_init_and_add(&cr->kobj, &afu_config_record_type,
 				  &afu->dev.kobj, "cr%i", cr->cr);
 	if (rc)
-		goto err;
+		goto err1;
 
 	rc = sysfs_create_bin_file(&cr->kobj, &cr->config_attr);
 	if (rc)
-- 
1.8.3.1

