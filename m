Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0FDC2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1462F206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439424AbgDNLi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:38:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2319 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439405AbgDNLiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:38:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 72E5C9490E1CDCE6EB0C;
        Tue, 14 Apr 2020 19:36:21 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Apr 2020
 19:36:11 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] clocksource: atmel-st: remove useless 'status'
Date:   Tue, 14 Apr 2020 20:02:38 +0800
Message-ID: <20200414120238.35704-1-yanaijie@huawei.com>
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

Fix the following coccicheck warning:

drivers/clocksource/timer-atmel-st.c:142:6-12: Unneeded variable:
"status". Return "0" on line 166

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/clocksource/timer-atmel-st.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index ab0aabfae5f0..73e8aee445da 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -139,7 +139,6 @@ static int
 clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
 {
 	u32		alm;
-	int		status = 0;
 	unsigned int	val;
 
 	BUG_ON(delta < 2);
@@ -163,7 +162,7 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
 	alm += delta;
 	regmap_write(regmap_st, AT91_ST_RTAR, alm);
 
-	return status;
+	return 0;
 }
 
 static struct clock_event_device clkevt = {
-- 
2.21.1

