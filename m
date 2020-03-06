Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A682BC19437
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8980C2072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgCFHfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:35:03 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:33303 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgCFHfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:35:03 -0500
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4542820000C;
        Fri,  6 Mar 2020 07:35:01 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: ds1305: set range
Date:   Fri,  6 Mar 2020 08:34:58 +0100
Message-Id: <20200306073459.57197-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ds1305 is a BCD rtc valid from 2000 to 2099.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1305.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index 4420fbf2f8fe..ca55ebab24fb 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -694,6 +694,8 @@ static int ds1305_probe(struct spi_device *spi)
 		return PTR_ERR(ds1305->rtc);
 
 	ds1305->rtc->ops = &ds1305_ops;
+	ds1305->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	ds1305->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
 	ds1305_nvmem_cfg.priv = ds1305;
 	ds1305->rtc->nvram_old_abi = true;
-- 
2.24.1

