Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23DFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990F2206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200283;
	bh=UJXpdwgUgEDaEfqLqTmPWk2BbGW7Ngv25la4YVI2Fi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W01R0mkQYFUCw1q4WbKayrCSmZuXS6AY47Iwhb0vrh2hxwrofFMtnagWiPe+V3m31
	 ieDi6d/HNyGxKk6IQmD6nfZ4rVmWHLkxNIHirytgGRX0jSw1XJJNUa0CQluOJq4C8D
	 EvlM8IGXnmnxu3PFg7uz4Uvgy+otgp0GYudl9jOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390070AbgAPSom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390072AbgAPRKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:10:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806FF24687;
        Thu, 16 Jan 2020 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194650;
        bh=UJXpdwgUgEDaEfqLqTmPWk2BbGW7Ngv25la4YVI2Fi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zza311atfthgODC/+icLnTE+MSmojkF3VE++0u8P+JRnzs7yi8e/p67rnFBZN97vD
         cD4tpB8ViUjN/XIz5+bEwih/jzMjU5B1zt/lWcM33PlxSuY8dYv469oLGsE2AXsOkv
         bZCy0wUKh0N6ISg+RbavqsClTGN78HCM+/tySYhU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Kroupski <alexandre.kroupski@ingenico.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 505/671] media: atmel: atmel-isi: fix timeout value for stop streaming
Date:   Thu, 16 Jan 2020 12:02:23 -0500
Message-Id: <20200116170509.12787-242-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Kroupski <alexandre.kroupski@ingenico.com>

[ Upstream commit 623fd246bb40234fe68dd4e7c1f1f081f9c45a3d ]

In case of sensor malfunction, stop streaming timeout takes much longer
than expected. This is due to conversion of time to jiffies: milliseconds
multiplied with HZ (ticks/second) gives out a value of jiffies with 10^3
greater. We need to also divide by 10^3 to obtain the right jiffies value.
In other words FRAME_INTERVAL_MILLI_SEC must be in seconds in order to
multiply by HZ and get the right jiffies value to add to the current
jiffies for the timeout expire time.

Fixes: 195ebc43bf76 ("[media] V4L: at91: add Atmel Image Sensor Interface (ISI) support")
Signed-off-by: Alexandre Kroupski <alexandre.kroupski@ingenico.com>
Reviewed-by: Eugen Hristev <eugen.hristev@microchip.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index e8db4df1e7c4..1a0e5233ae28 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -496,7 +496,7 @@ static void stop_streaming(struct vb2_queue *vq)
 	spin_unlock_irq(&isi->irqlock);
 
 	if (!isi->enable_preview_path) {
-		timeout = jiffies + FRAME_INTERVAL_MILLI_SEC * HZ;
+		timeout = jiffies + (FRAME_INTERVAL_MILLI_SEC * HZ) / 1000;
 		/* Wait until the end of the current frame. */
 		while ((isi_readl(isi, ISI_STATUS) & ISI_CTRL_CDC) &&
 				time_before(jiffies, timeout))
-- 
2.20.1

