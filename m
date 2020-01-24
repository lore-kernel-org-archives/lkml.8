Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69904C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406B9206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860131;
	bh=0oAE/C2OKKjtN5eLRKcmqSsDdWrBYGIFDPrROVGLNzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Arh+YuOlSguUBjgEi+vyALIkmdZnA8glmGC6QmDCjFtxB2V778RoRIDYBkbB2dQ2
	 yqQwCMDt9BCVSalHqTFklN7uhC9QHnaDU2nKtbXhl96wIARdM+pmiNcBPl0sg9ENBR
	 SkfopvAl506wRmFYKGJz/K0vCu2uJ4OXqtzFWq7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbgAXKCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:02:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731227AbgAXKCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:02:07 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F69120709;
        Fri, 24 Jan 2020 10:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860127;
        bh=0oAE/C2OKKjtN5eLRKcmqSsDdWrBYGIFDPrROVGLNzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkN+Gz0JF2EvzPBBYES+iQn3OULwjb+dWjYl0w+QZV02PCZQDJtL0OY05sUt5FI1r
         XkjB5h63AxwSC4ZcW19fPZ3ERPLTelsvaz4A37YmqIwTLt6+ScjYPnTZAL9PTSif3/
         IdIA6hkNL4D9ik4BRu3ysu23npz4tiXSo0W/xBhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 240/343] rtc: pcf8563: Fix interrupt trigger method
Date:   Fri, 24 Jan 2020 10:30:58 +0100
Message-Id: <20200124092951.700944883@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 65f662cbf829834fa4d94190eb7691e5a9cb92d8 ]

The PCF8563 datasheet says the interrupt line is active low and stays
active until the events are cleared, i.e. a level trigger interrupt.

Fix the flags used to request the interrupt.

Fixes: ede3e9d47cca ("drivers/rtc/rtc-pcf8563.c: add alarm support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-pcf8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 8c836c51a508f..ef04472dde1d2 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -605,7 +605,7 @@ static int pcf8563_probe(struct i2c_client *client,
 	if (client->irq > 0) {
 		err = devm_request_threaded_irq(&client->dev, client->irq,
 				NULL, pcf8563_irq,
-				IRQF_SHARED|IRQF_ONESHOT|IRQF_TRIGGER_FALLING,
+				IRQF_SHARED | IRQF_ONESHOT | IRQF_TRIGGER_LOW,
 				pcf8563_driver.driver.name, client);
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ %d\n",
-- 
2.20.1



