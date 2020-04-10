Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F852C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787A02063A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgDJGhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 02:37:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbgDJGhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:37:55 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4B03FD5C246B5C79CE4B;
        Fri, 10 Apr 2020 14:37:54 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 14:37:45 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <cpw@sgi.com>, <robinmholt@gmail.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 1/2] sgi-xp: make some symbols static in xpnet.c
Date:   Fri, 10 Apr 2020 14:36:17 +0800
Message-ID: <20200410063618.27143-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/misc/sgi-xp/xpnet.c:99:19: warning: symbol 'xpnet_device' was
not declared. Should it be static?
drivers/misc/sgi-xp/xpnet.c:134:22: warning: symbol 'xpnet_dbg_name' was
not declared. Should it be static?
drivers/misc/sgi-xp/xpnet.c:138:15: warning: symbol 'xpnet_dbg_subname'
was not declared. Should it be static?
drivers/misc/sgi-xp/xpnet.c:143:15: warning: symbol 'xpnet' was not
declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/misc/sgi-xp/xpnet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
index ada94e6a3c91..837d6c3fe69c 100644
--- a/drivers/misc/sgi-xp/xpnet.c
+++ b/drivers/misc/sgi-xp/xpnet.c
@@ -96,7 +96,7 @@ struct xpnet_pending_msg {
 	atomic_t use_count;
 };
 
-struct net_device *xpnet_device;
+static struct net_device *xpnet_device;
 
 /*
  * When we are notified of other partitions activating, we add them to
@@ -131,16 +131,16 @@ static DEFINE_SPINLOCK(xpnet_broadcast_lock);
 
 /* Define the XPNET debug device structures to be used with dev_dbg() et al */
 
-struct device_driver xpnet_dbg_name = {
+static struct device_driver xpnet_dbg_name = {
 	.name = "xpnet"
 };
 
-struct device xpnet_dbg_subname = {
+static struct device xpnet_dbg_subname = {
 	.init_name = "",	/* set to "" */
 	.driver = &xpnet_dbg_name
 };
 
-struct device *xpnet = &xpnet_dbg_subname;
+static struct device *xpnet = &xpnet_dbg_subname;
 
 /*
  * Packet was recevied by XPC and forwarded to us.
-- 
2.17.2

