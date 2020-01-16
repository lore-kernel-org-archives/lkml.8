Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCB6C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBA12051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198849;
	bh=ymg0NxErnGtKE2uVNTzOP1nUg39rleRL/N+JyWd4kGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mA2f+dLifoJpicW9k+yjnaQHcpfhAIpsb5Td2XAl4gaR5xJNl3KDTe0jcb7VQf7le
	 e6cLJ7kqMn+5f8jZlkSKx7kxIRYvIWhf6vxBdBnDrxNBcEEBvYdWzxlvTbsf0qwniX
	 wKwnim/EHiSAp6mDUA0letWkJkeWaozH4HGT1/jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436578AbgAPSUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:20:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:38514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392535AbgAPR17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:27:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82554246E6;
        Thu, 16 Jan 2020 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195679;
        bh=ymg0NxErnGtKE2uVNTzOP1nUg39rleRL/N+JyWd4kGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qedmnn0UfE0EppD54rCdV1khCAq9Gdt2APSNAWceEUcq2mcGURI5OAFhwxBKRanwZ
         ShZH9iZs/uoMs/6ZrW+052aBS0SrKqbQn1G4ONUhsV7H6np6cc0BAb0xXqgz08Afbc
         /bUQq+uJ3uX+ojHUjTv5L7zbaxXHer3QlfsU673g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 234/371] rtc: pcf8563: Fix interrupt trigger method
Date:   Thu, 16 Jan 2020 12:21:46 -0500
Message-Id: <20200116172403.18149-177-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 8c836c51a508..ef04472dde1d 100644
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

