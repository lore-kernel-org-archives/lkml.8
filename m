Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442AAC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3B42072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDTMID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:08:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2413 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbgDTMIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:08:02 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BEAFDC9AE20436C7EF10;
        Mon, 20 Apr 2020 20:07:59 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 20:07:49 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ptp: Remove unneeded conversion to bool
Date:   Mon, 20 Apr 2020 20:34:31 +0800
Message-ID: <20200420123431.7040-1-yanaijie@huawei.com>
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

The '==' expression itself is bool, no need to convert it to bool again.
This fixes the following coccicheck warning:

drivers/ptp/ptp_ines.c:403:55-60: WARNING: conversion to bool not
needed here
drivers/ptp/ptp_ines.c:404:55-60: WARNING: conversion to bool not
needed here

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/ptp/ptp_ines.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
index dfda54cbd866..52d77db39829 100644
--- a/drivers/ptp/ptp_ines.c
+++ b/drivers/ptp/ptp_ines.c
@@ -400,8 +400,8 @@ static int ines_hwtstamp(struct mii_timestamper *mii_ts, struct ifreq *ifr)
 	ines_write32(port, ts_stat_rx, ts_stat_rx);
 	ines_write32(port, ts_stat_tx, ts_stat_tx);
 
-	port->rxts_enabled = ts_stat_rx == TS_ENABLE ? true : false;
-	port->txts_enabled = ts_stat_tx == TS_ENABLE ? true : false;
+	port->rxts_enabled = ts_stat_rx == TS_ENABLE;
+	port->txts_enabled = ts_stat_tx == TS_ENABLE;
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-- 
2.21.1

