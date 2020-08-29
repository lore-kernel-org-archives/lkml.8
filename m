Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD68C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A721207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgH2L7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 07:59:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52586 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgH2L7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:59:00 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0A44C8AF50A8EC321EA2;
        Sat, 29 Aug 2020 19:58:59 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 29 Aug 2020
 19:58:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <qiang.zhao@nxp.com>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net/wan/fsl_ucc_hdlc: Add MODULE_DESCRIPTION
Date:   Sat, 29 Aug 2020 19:58:23 +0800
Message-ID: <20200829115823.10140-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing MODULE_DESCRIPTION.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 9edd94679283..dca97cd7c4e7 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1295,3 +1295,4 @@ static struct platform_driver ucc_hdlc_driver = {
 
 module_platform_driver(ucc_hdlc_driver);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION(DRV_DESC);
-- 
2.17.1


