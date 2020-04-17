Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA3C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4084B221E9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgDQIzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:55:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729784AbgDQIzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:55:14 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E2194417BC2613B5E240;
        Fri, 17 Apr 2020 16:55:09 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 16:54:59 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <linus.walleij@linaro.org>, <andriy.shevchenko@linux.intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] pinctrl: mcp23s08: add module license
Date:   Fri, 17 Apr 2020 17:21:25 +0800
Message-ID: <20200417092125.12513-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build warning:

WARNING: modpost: missing MODULE_LICENSE() in
drivers/pinctrl/pinctrl-mcp23s08.o
see include/linux/module.h for more information

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index cb545557dcd4..151931b593f6 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -658,3 +658,4 @@ int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mcp23s08_probe_one);
+MODULE_LICENSE("GPL");
-- 
2.21.1

