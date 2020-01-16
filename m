Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ACFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF23F2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201285;
	bh=oZge8qcjmLHr1FyJzPzSH7Q+rLT/brvpKPHpjdJPLY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kNqDf526Smhdi9aw6kqi61TLBWP6m5lreUb065gBwL6c9kXR3lDyc/HsZYI/FPMgD
	 nA64xf4it3z6zMhq8VOBw+qCjHA22YOzkPb6hDBCKNPnmYLp58DQoBUQrb2xX1ogL8
	 r/+MhoVGFDcwzE04D4nUu1WWXH+XHPlFoaTsGIrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407258AbgAPTBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:01:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388807AbgAPRF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:05:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4980E2051A;
        Thu, 16 Jan 2020 17:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194355;
        bh=oZge8qcjmLHr1FyJzPzSH7Q+rLT/brvpKPHpjdJPLY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPAdUJPYlN7cIYjbqJpPmOLe9N4OWQNfJvaEasqE1h2aqMc+Aty6xg2fQeRrPZIS7
         g/aF+p2QM2Be8YTZX059cST7CFoegBpeOBv2gRAzCIJQv9iGfKTqsPRxl1Y858oHe4
         YjkHxLN/LT6hNwsIZMQqv57Yd5b5Rt2zsfsNAk9U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 294/671] hwmon: (w83627hf) Use request_muxed_region for Super-IO accesses
Date:   Thu, 16 Jan 2020 11:58:52 -0500
Message-Id: <20200116170509.12787-31-sashal@kernel.org>
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

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit e95fd518d05bfc087da6fcdea4900a57cfb083bd ]

Super-IO accesses may fail on a system with no or unmapped LPC bus.

Also, other drivers may attempt to access the LPC bus at the same time,
resulting in undefined behavior.

Use request_muxed_region() to ensure that IO access on the requested
address space is supported, and to ensure that access by multiple drivers
is synchronized.

Fixes: b72656dbc491 ("hwmon: (w83627hf) Stop using globals for I/O port numbers")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/w83627hf.c | 42 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 8ac89d0781cc..a575e1cdb81a 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -130,17 +130,23 @@ superio_select(struct w83627hf_sio_data *sio, int ld)
 	outb(ld,  sio->sioaddr + 1);
 }
 
-static inline void
+static inline int
 superio_enter(struct w83627hf_sio_data *sio)
 {
+	if (!request_muxed_region(sio->sioaddr, 2, DRVNAME))
+		return -EBUSY;
+
 	outb(0x87, sio->sioaddr);
 	outb(0x87, sio->sioaddr);
+
+	return 0;
 }
 
 static inline void
 superio_exit(struct w83627hf_sio_data *sio)
 {
 	outb(0xAA, sio->sioaddr);
+	release_region(sio->sioaddr, 2);
 }
 
 #define W627_DEVID 0x52
@@ -1278,7 +1284,7 @@ static DEVICE_ATTR_RO(name);
 static int __init w83627hf_find(int sioaddr, unsigned short *addr,
 				struct w83627hf_sio_data *sio_data)
 {
-	int err = -ENODEV;
+	int err;
 	u16 val;
 
 	static __initconst char *const names[] = {
@@ -1290,7 +1296,11 @@ static int __init w83627hf_find(int sioaddr, unsigned short *addr,
 	};
 
 	sio_data->sioaddr = sioaddr;
-	superio_enter(sio_data);
+	err = superio_enter(sio_data);
+	if (err)
+		return err;
+
+	err = -ENODEV;
 	val = force_id ? force_id : superio_inb(sio_data, DEVID);
 	switch (val) {
 	case W627_DEVID:
@@ -1644,9 +1654,21 @@ static int w83627thf_read_gpio5(struct platform_device *pdev)
 	struct w83627hf_sio_data *sio_data = dev_get_platdata(&pdev->dev);
 	int res = 0xff, sel;
 
-	superio_enter(sio_data);
+	if (superio_enter(sio_data)) {
+		/*
+		 * Some other driver reserved the address space for itself.
+		 * We don't want to fail driver instantiation because of that,
+		 * so display a warning and keep going.
+		 */
+		dev_warn(&pdev->dev,
+			 "Can not read VID data: Failed to enable SuperIO access\n");
+		return res;
+	}
+
 	superio_select(sio_data, W83627HF_LD_GPIO5);
 
+	res = 0xff;
+
 	/* Make sure these GPIO pins are enabled */
 	if (!(superio_inb(sio_data, W83627THF_GPIO5_EN) & (1<<3))) {
 		dev_dbg(&pdev->dev, "GPIO5 disabled, no VID function\n");
@@ -1677,7 +1699,17 @@ static int w83687thf_read_vid(struct platform_device *pdev)
 	struct w83627hf_sio_data *sio_data = dev_get_platdata(&pdev->dev);
 	int res = 0xff;
 
-	superio_enter(sio_data);
+	if (superio_enter(sio_data)) {
+		/*
+		 * Some other driver reserved the address space for itself.
+		 * We don't want to fail driver instantiation because of that,
+		 * so display a warning and keep going.
+		 */
+		dev_warn(&pdev->dev,
+			 "Can not read VID data: Failed to enable SuperIO access\n");
+		return res;
+	}
+
 	superio_select(sio_data, W83627HF_LD_HWM);
 
 	/* Make sure these GPIO pins are enabled */
-- 
2.20.1

