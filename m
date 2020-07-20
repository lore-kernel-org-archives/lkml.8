Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE8EC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E20E22CBB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGTIGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:06:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgGTIGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:06:18 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B8920FD77153135EF878;
        Mon, 20 Jul 2020 16:06:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 20 Jul 2020 16:06:07 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <minyard@acm.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <cminyard@mvista.com>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] ipmi: remve duplicate code in __ipmi_bmc_register()
Date:   Mon, 20 Jul 2020 16:08:38 +0800
Message-ID: <20200720080838.148737-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ipmi_bmc_register() jumps to the label 'out_free_my_dev_name' in an
error path. So we can remove duplicate code in the if (rv).

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e1b22fe0916c..737c0b6b24ea 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3080,8 +3080,6 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 	rv = sysfs_create_link(&bmc->pdev.dev.kobj, &intf->si_dev->kobj,
 			       intf->my_dev_name);
 	if (rv) {
-		kfree(intf->my_dev_name);
-		intf->my_dev_name = NULL;
 		dev_err(intf->si_dev, "Unable to create symlink to bmc: %d\n",
 			rv);
 		goto out_free_my_dev_name;
-- 
2.17.1

