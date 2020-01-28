Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BDDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530A6207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222612;
	bh=E2V+C8zIRFAMXdmYAylFrU6KBTlqSKmy3/QxbVXgaME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HMUrIUFSZ4zdrkMKDBmF8t6QY/lAHNMN1XfLjgWZLrEMn5tKiAVNNK4cCs0ekHgIT
	 DKzn6BuM0/mwWy1XQ6PVDJJoZoDUB9CRZ25/giC0cVDVMMcivEuK42zZKAqGkmMbge
	 uZb38S9LTL6FES/A4lVv2LbApAFgvvYM8ovx40MY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgA1OLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbgA1OL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:11:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C55520678;
        Tue, 28 Jan 2020 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220687;
        bh=E2V+C8zIRFAMXdmYAylFrU6KBTlqSKmy3/QxbVXgaME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWs1RDXZ01mPm4HAX14KPuQ0dM7974LkPRcw1w1dfZ192xZdw7m9meHlBWbsFRaED
         pJHGlkTOYo5li8eSBRJVmxIX9q6hktpfNOQz6RhHh0xBeTfkNNGjh4huvvyr9gZ9ci
         iz1KGKGWcsqiuwvFTjf9aJ8sY4zSuKTNIfviHMtk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 105/183] rtc: pcf8563: Clear event flags and disable interrupts before requesting irq
Date:   Tue, 28 Jan 2020 15:05:24 +0100
Message-Id: <20200128135840.459076942@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 3572e8aea3bf925dac1dbf86127657c39fe5c254 ]

Besides the alarm, the PCF8563 also has a timer triggered interrupt.
In cases where the previous system left the timer and interrupts on,
or somehow the bits got enabled, the interrupt would keep triggering
as the kernel doesn't know about it.

Clear both the alarm and timer event flags, and disable the interrupts,
before requesting the interrupt line.

Fixes: ede3e9d47cca ("drivers/rtc/rtc-pcf8563.c: add alarm support")
Fixes: a45d528aab8b ("rtc: pcf8563: clear expired alarm at boot time")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-pcf8563.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 45b5a3d47ccf0..1982eec0a3eac 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -568,7 +568,6 @@ static int pcf8563_probe(struct i2c_client *client,
 	struct pcf8563 *pcf8563;
 	int err;
 	unsigned char buf;
-	unsigned char alm_pending;
 
 	dev_dbg(&client->dev, "%s\n", __func__);
 
@@ -594,13 +593,13 @@ static int pcf8563_probe(struct i2c_client *client,
 		return err;
 	}
 
-	err = pcf8563_get_alarm_mode(client, NULL, &alm_pending);
-	if (err) {
-		dev_err(&client->dev, "%s: read error\n", __func__);
+	/* Clear flags and disable interrupts */
+	buf = 0;
+	err = pcf8563_write_block_data(client, PCF8563_REG_ST2, 1, &buf);
+	if (err < 0) {
+		dev_err(&client->dev, "%s: write error\n", __func__);
 		return err;
 	}
-	if (alm_pending)
-		pcf8563_set_alarm_mode(client, 0);
 
 	pcf8563->rtc = devm_rtc_device_register(&client->dev,
 				pcf8563_driver.driver.name,
-- 
2.20.1



