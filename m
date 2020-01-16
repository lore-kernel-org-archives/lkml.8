Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B75C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6F32468D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197074;
	bh=k6NqwYjkAzGyZhuFx7sYDANLh/1m695dI/1xf+8H3Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DgIRwpiDEolkkg9k3mBcowvI3ZDPEywCnMdoa8EOSvHsvFzt5DiZho9+zoCYPC7Jg
	 qEY2dJoJlgavn5guX5uDfmDVtzQO9N0QoAyjcvzOkpSToYTrabADpy5+kOJD7YN21+
	 i9id2DO/EoyrTiIebCNCPUNqbJvxBtGO8smPFOd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406427AbgAPRpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:45:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406150AbgAPRpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:45:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C40924782;
        Thu, 16 Jan 2020 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196716;
        bh=k6NqwYjkAzGyZhuFx7sYDANLh/1m695dI/1xf+8H3Ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJdxnSDQQFAthtjHm7QdkdWpQkuN4PRfqBu7x2PP/GNIjoSmtDhXnjv+SKvBKC1Y0
         1cOMrh5Y/bWZ9R2woDx2V9dfdK76oAp7rbPt5dWawsjIRrkEMZfyD459f91POx4kXE
         vPmGIzaRDPYa2sShoV4aLxti8PuOqARwAuAb02eU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 104/174] rtc: pcf8563: Clear event flags and disable interrupts before requesting irq
Date:   Thu, 16 Jan 2020 12:41:41 -0500
Message-Id: <20200116174251.24326-104-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 45b5a3d47ccf..1982eec0a3ea 100644
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

