Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79DAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941C3214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgDRCYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 22:24:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2354 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbgDRCYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 22:24:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 70F2F5FF84E0A60E4E66;
        Sat, 18 Apr 2020 10:24:06 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Apr 2020
 10:23:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <richardcochran@gmail.com>, <min.li.xe@renesas.com>,
        <yuehaibing@huawei.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] ptp: idt82p33: Make two variables static
Date:   Sat, 18 Apr 2020 10:01:49 +0800
Message-ID: <20200418020149.29796-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/ptp/ptp_idt82p33.c:26:5: warning: symbol 'sync_tod_timeout' was not declared. Should it be static?
drivers/ptp/ptp_idt82p33.c:31:5: warning: symbol 'phase_snap_threshold' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/ptp/ptp_idt82p33.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_idt82p33.c b/drivers/ptp/ptp_idt82p33.c
index b63ac240308b..31ea811b6d5f 100644
--- a/drivers/ptp/ptp_idt82p33.c
+++ b/drivers/ptp/ptp_idt82p33.c
@@ -23,12 +23,12 @@ MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL");
 
 /* Module Parameters */
-u32 sync_tod_timeout = SYNC_TOD_TIMEOUT_SEC;
+static u32 sync_tod_timeout = SYNC_TOD_TIMEOUT_SEC;
 module_param(sync_tod_timeout, uint, 0);
 MODULE_PARM_DESC(sync_tod_timeout,
 "duration in second to keep SYNC_TOD on (set to 0 to keep it always on)");
 
-u32 phase_snap_threshold = SNAP_THRESHOLD_NS;
+static u32 phase_snap_threshold = SNAP_THRESHOLD_NS;
 module_param(phase_snap_threshold, uint, 0);
 MODULE_PARM_DESC(phase_snap_threshold,
 "threshold (150000ns by default) below which adjtime would ignore");
-- 
2.17.1


