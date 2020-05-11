Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F69C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C4020708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgEKIt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 04:49:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728562AbgEKIt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:49:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BB63AB93F3FEEFD6C057;
        Mon, 11 May 2020 16:49:53 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 16:49:45 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <ezequiel@vanguardiasur.com.ar>, <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] [media] tw686x: add a missing newline when printing parameter 'dma_mode'
Date:   Mon, 11 May 2020 16:43:46 +0800
Message-ID: <1589186626-17243-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I cat module parameter 'dma_mode' by sysfs, it displays as follows.
It is better to add a newline for easy reading.

[root@hulk-202 ~]# cat /sys/module/tw686x/parameters/dma_mode
memcpy[root@hulk-202 ~]#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/media/pci/tw686x/tw686x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/tw686x/tw686x-core.c b/drivers/media/pci/tw686x/tw686x-core.c
index 74ae4f0..bfc61da 100644
--- a/drivers/media/pci/tw686x/tw686x-core.c
+++ b/drivers/media/pci/tw686x/tw686x-core.c
@@ -71,7 +71,7 @@ static const char *dma_mode_name(unsigned int mode)
 
 static int tw686x_dma_mode_get(char *buffer, const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%s", dma_mode_name(dma_mode));
+	return sprintf(buffer, "%s\n", dma_mode_name(dma_mode));
 }
 
 static int tw686x_dma_mode_set(const char *val, const struct kernel_param *kp)
-- 
1.7.12.4

