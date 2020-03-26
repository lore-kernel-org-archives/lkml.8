Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9840BC2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C822078C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgCZVJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:09:55 -0400
Received: from sauhun.de ([88.99.104.3]:54328 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbgCZVJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:09:52 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id 87EE82C1F8A;
        Thu, 26 Mar 2020 22:09:50 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] media: usb: cx231xx: convert to use i2c_new_client_device()
Date:   Thu, 26 Mar 2020 22:09:44 +0100
Message-Id: <20200326210947.12747-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
References: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the deprecated API and make use of the fact that
unregistering devices is NULL- and ERR_PTR-safe.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/usb/cx231xx/cx231xx-input.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-input.c b/drivers/media/usb/cx231xx/cx231xx-input.c
index 9f88c640ec2b..8149702bcf89 100644
--- a/drivers/media/usb/cx231xx/cx231xx-input.c
+++ b/drivers/media/usb/cx231xx/cx231xx-input.c
@@ -88,7 +88,7 @@ int cx231xx_ir_init(struct cx231xx *dev)
 	ir_i2c_bus = cx231xx_boards[dev->model].ir_i2c_master;
 	dev_dbg(dev->dev, "Trying to bind ir at bus %d, addr 0x%02x\n",
 		ir_i2c_bus, info.addr);
-	dev->ir_i2c_client = i2c_new_device(
+	dev->ir_i2c_client = i2c_new_client_device(
 		cx231xx_get_i2c_adap(dev, ir_i2c_bus), &info);
 
 	return 0;
@@ -96,7 +96,6 @@ int cx231xx_ir_init(struct cx231xx *dev)
 
 void cx231xx_ir_exit(struct cx231xx *dev)
 {
-	if (dev->ir_i2c_client)
-		i2c_unregister_device(dev->ir_i2c_client);
+	i2c_unregister_device(dev->ir_i2c_client);
 	dev->ir_i2c_client = NULL;
 }
-- 
2.20.1

