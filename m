Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC38FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC0720771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgGUPH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:07:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52624 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729612AbgGUPH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:07:29 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 327F0BB75E78DFD01A54;
        Tue, 21 Jul 2020 23:07:27 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 23:07:18 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] soc: TI knav_qmss: make symbol 'knav_acc_range_ops' static
Date:   Tue, 21 Jul 2020 23:17:15 +0800
Message-ID: <20200721151715.41095-1-weiyongjun1@huawei.com>
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

drivers/soc/ti/knav_qmss_acc.c:453:23: warning:
 symbol 'knav_acc_range_ops' was not declared. Should it be static?

'knav_acc_range_ops' is not used outside of knav_qmss_acc.c,
so marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/soc/ti/knav_qmss_acc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
index 1762d89fc05d..fde66e28e046 100644
--- a/drivers/soc/ti/knav_qmss_acc.c
+++ b/drivers/soc/ti/knav_qmss_acc.c
@@ -450,7 +450,7 @@ static int knav_acc_free_range(struct knav_range_info *range)
 	return 0;
 }
 
-struct knav_range_ops knav_acc_range_ops = {
+static struct knav_range_ops knav_acc_range_ops = {
 	.set_notify	= knav_acc_set_notify,
 	.init_queue	= knav_acc_init_queue,
 	.open_queue	= knav_acc_open_queue,

