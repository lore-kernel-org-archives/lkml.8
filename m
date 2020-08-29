Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C1C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D329207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgH2L7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 07:59:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgH2L7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:59:41 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 605F3638B88DA67393BC;
        Sat, 29 Aug 2020 19:59:37 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 29 Aug 2020
 19:59:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kvalo@codeaurora.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <yuehaibing@huawei.com>
CC:     <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] libertas_tf: Remove unused macro QOS_CONTROL_LEN
Date:   Sat, 29 Aug 2020 19:59:24 +0800
Message-ID: <20200829115924.7572-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no caller in tree.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/marvell/libertas_tf/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 02bd7c99b358..cb494b59de93 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -15,7 +15,6 @@
 /* thinfirm version: 5.132.X.pX */
 #define LBTF_FW_VER_MIN		0x05840300
 #define LBTF_FW_VER_MAX		0x0584ffff
-#define QOS_CONTROL_LEN		2
 
 /* Module parameters */
 unsigned int lbtf_debug;
-- 
2.17.1


