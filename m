Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63694C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6122073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgCZVJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:09:57 -0400
Received: from sauhun.de ([88.99.104.3]:54332 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgCZVJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:09:53 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id 234122C1F8B;
        Thu, 26 Mar 2020 22:09:51 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] media: usb: hdpvr: convert to use i2c_new_client_device()
Date:   Thu, 26 Mar 2020 22:09:45 +0100
Message-Id: <20200326210947.12747-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
References: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/usb/hdpvr/hdpvr-core.c | 4 ++--
 drivers/media/usb/hdpvr/hdpvr-i2c.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-core.c b/drivers/media/usb/hdpvr/hdpvr-core.c
index b75c18a012a7..52e05a69c46e 100644
--- a/drivers/media/usb/hdpvr/hdpvr-core.c
+++ b/drivers/media/usb/hdpvr/hdpvr-core.c
@@ -363,9 +363,9 @@ static int hdpvr_probe(struct usb_interface *interface,
 	}
 
 	client = hdpvr_register_ir_i2c(dev);
-	if (!client) {
+	if (IS_ERR(client)) {
 		v4l2_err(&dev->v4l2_dev, "i2c IR device register failed\n");
-		retval = -ENODEV;
+		retval = PTR_ERR(client);
 		goto reg_fail;
 	}
 #endif
diff --git a/drivers/media/usb/hdpvr/hdpvr-i2c.c b/drivers/media/usb/hdpvr/hdpvr-i2c.c
index 785c8508a46e..070559b01b01 100644
--- a/drivers/media/usb/hdpvr/hdpvr-i2c.c
+++ b/drivers/media/usb/hdpvr/hdpvr-i2c.c
@@ -44,7 +44,7 @@ struct i2c_client *hdpvr_register_ir_i2c(struct hdpvr_device *dev)
 	init_data->polling_interval = 405; /* ms, duplicated from Windows */
 	info.platform_data = init_data;
 
-	return i2c_new_device(&dev->i2c_adapter, &info);
+	return i2c_new_client_device(&dev->i2c_adapter, &info);
 }
 
 static int hdpvr_i2c_read(struct hdpvr_device *dev, int bus,
-- 
2.20.1

