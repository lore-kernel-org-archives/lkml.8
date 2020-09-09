Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C85DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3ED207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgIIQWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:22:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730870AbgIIQTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:19:02 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1B63DC3F8083677D7ACB;
        Wed,  9 Sep 2020 22:23:51 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 22:23:43 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Lee Jones <lee.jones@linaro.org>,
        "Lubomir Rintel" <lkundrak@v3.sk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mfd: ene-kb3930: Make symbol 'kb3930_power_off' static
Date:   Wed, 9 Sep 2020 22:32:53 +0800
Message-ID: <20200909143253.66168-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/mfd/ene-kb3930.c:36:15: warning:
 symbol 'kb3930_power_off' was not declared. Should it be static?

This variable is not used outside of ene-kb3930.c, this commit
marks it static.

Fixes: 753bd752e181 ("mfd: ene-kb3930: Add driver for ENE KB3930 Embedded Controller")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mfd/ene-kb3930.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
index 1c32ff586816..eb7312bd6361 100644
--- a/drivers/mfd/ene-kb3930.c
+++ b/drivers/mfd/ene-kb3930.c
@@ -33,7 +33,7 @@ struct kb3930 {
 	struct gpio_descs *off_gpios;
 };
 
-struct kb3930 *kb3930_power_off;
+static struct kb3930 *kb3930_power_off;
 
 #define EC_GPIO_WAVE		0
 #define EC_GPIO_OFF_MODE	1

