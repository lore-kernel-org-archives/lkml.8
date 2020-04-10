Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37695C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EAD2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDJGh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 02:37:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12635 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbgDJGh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:37:56 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 461E89EE022D5BD0CDE2;
        Fri, 10 Apr 2020 14:37:54 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 14:37:46 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <cpw@sgi.com>, <robinmholt@gmail.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 2/2] sgi-xp: make some symbols static in xpc_main.c
Date:   Fri, 10 Apr 2020 14:36:18 +0800
Message-ID: <20200410063618.27143-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200410063618.27143-1-yanaijie@huawei.com>
References: <20200410063618.27143-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/misc/sgi-xp/xpc_main.c:62:22: warning: symbol 'xpc_dbg_name' was
not declared. Should it be static?
drivers/misc/sgi-xp/xpc_main.c:66:15: warning: symbol
'xpc_part_dbg_subname' was not declared. Should it be static?
drivers/misc/sgi-xp/xpc_main.c:71:15: warning: symbol
'xpc_chan_dbg_subname' was not declared. Should it be static?
drivers/misc/sgi-xp/xpc_main.c:1221:1: warning: symbol 'xpc_init' was
not declared. Should it be static?
drivers/misc/sgi-xp/xpc_main.c:1323:1: warning: symbol 'xpc_exit' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/misc/sgi-xp/xpc_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index 79a963105983..d5e097cd556d 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -59,16 +59,16 @@
 
 /* define two XPC debug device structures to be used with dev_dbg() et al */
 
-struct device_driver xpc_dbg_name = {
+static struct device_driver xpc_dbg_name = {
 	.name = "xpc"
 };
 
-struct device xpc_part_dbg_subname = {
+static struct device xpc_part_dbg_subname = {
 	.init_name = "",	/* set to "part" at xpc_init() time */
 	.driver = &xpc_dbg_name
 };
 
-struct device xpc_chan_dbg_subname = {
+static struct device xpc_chan_dbg_subname = {
 	.init_name = "",	/* set to "chan" at xpc_init() time */
 	.driver = &xpc_dbg_name
 };
@@ -1217,7 +1217,7 @@ xpc_system_die(struct notifier_block *nb, unsigned long event, void *_die_args)
 	return NOTIFY_DONE;
 }
 
-int __init
+static int __init
 xpc_init(void)
 {
 	int ret;
@@ -1319,7 +1319,7 @@ xpc_init(void)
 
 module_init(xpc_init);
 
-void __exit
+static void __exit
 xpc_exit(void)
 {
 	xpc_do_exit(xpUnloading);
-- 
2.17.2

