Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB727C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF6C20684
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgGUIl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:41:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725984AbgGUIl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:41:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 639707B8D216B423070D;
        Tue, 21 Jul 2020 16:41:54 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 16:41:45 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH] drivers: modules: remove set but not used variable 'no_warn'
Date:   Tue, 21 Jul 2020 16:41:44 +0800
Message-ID: <20200721084144.13545-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/base/module.c: In function 'module_add_driver':
drivers/base/module.c:33: warning:
variable 'no_warn' set but not used [-Wunused-but-set-variable]

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/base/module.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/module.c b/drivers/base/module.c
index 46ad4d636731..d1060c504c1b 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -33,7 +33,6 @@ static void module_create_drivers_dir(struct module_kobject *mk)
 void module_add_driver(struct module *mod, struct device_driver *drv)
 {
 	char *driver_name;
-	int no_warn;
 	struct module_kobject *mk = NULL;
 
 	if (!drv)
@@ -59,11 +58,11 @@ void module_add_driver(struct module *mod, struct device_driver *drv)
 		return;
 
 	/* Don't check return codes; these calls are idempotent */
-	no_warn = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
+	sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
 	driver_name = make_driver_name(drv);
 	if (driver_name) {
 		module_create_drivers_dir(mk);
-		no_warn = sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
+		sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
 					    driver_name);
 		kfree(driver_name);
 	}
-- 
2.17.1

