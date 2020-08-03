Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2E2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2769206F6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgHCDeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 23:34:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbgHCDeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 23:34:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 89C87851660E51267347;
        Mon,  3 Aug 2020 11:33:59 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 3 Aug 2020 11:33:48 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] driver core: Use the ktime_us_delta() helper
Date:   Mon, 3 Aug 2020 11:33:43 +0800
Message-ID: <20200803033343.1178-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ktime_us_delta() helper to measure the driver probe time. Given the
helpers already returns an s64 value, let's drop the unnecessary casting to
s64 as well. There is no functional change.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/base/dd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 3cefe89e94ca..0ef5b2f32932 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -618,15 +618,14 @@ static int really_probe(struct device *dev, struct device_driver *drv)
  */
 static int really_probe_debug(struct device *dev, struct device_driver *drv)
 {
-	ktime_t calltime, delta, rettime;
+	ktime_t calltime, rettime;
 	int ret;
 
 	calltime = ktime_get();
 	ret = really_probe(dev, drv);
 	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
 	pr_debug("probe of %s returned %d after %lld usecs\n",
-		 dev_name(dev), ret, (s64) ktime_to_us(delta));
+		 dev_name(dev), ret, ktime_us_delta(rettime, calltime));
 	return ret;
 }
 
-- 
2.19.1

