Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25127C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027E72074D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCZDY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727560AbgCZDY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B3CDE53E932DA8590320;
        Thu, 26 Mar 2020 11:24:03 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Mar 2020
 11:23:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jcliburn@gmail.com>, <chris.snook@gmail.com>,
        <davem@davemloft.net>, <yuehaibing@huawei.com>,
        <hkallweit1@gmail.com>, <mhabets@solarflare.com>,
        <huangfq.daxian@gmail.com>, <leon@kernel.org>,
        <colin.king@canonical.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] atl2: remove unused variable 'atl2_driver_string'
Date:   Thu, 26 Mar 2020 11:21:50 +0800
Message-ID: <20200326032150.15568-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/ethernet/atheros/atlx/atl2.c:40:19: warning: ‘atl2_driver_string’ defined but not used [-Wunused-const-variable=]
 static const char atl2_driver_string[] = "Atheros(R) L2 Ethernet Driver";
                   ^~~~~~~~~~~~~~~~~~

commit ea973742140b ("net/atheros: Clean atheros code from driver version")
left behind this, remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/atheros/atlx/atl2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index 7c52b92b599d..c915852b8892 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -37,7 +37,6 @@
 #include "atl2.h"
 
 static const char atl2_driver_name[] = "atl2";
-static const char atl2_driver_string[] = "Atheros(R) L2 Ethernet Driver";
 static const struct ethtool_ops atl2_ethtool_ops;
 
 MODULE_AUTHOR("Atheros Corporation <xiong.huang@atheros.com>, Chris Snook <csnook@redhat.com>");
-- 
2.17.1


