Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59D4C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E6020775
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgCZVKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:10:40 -0400
Received: from sauhun.de ([88.99.104.3]:54558 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgCZVKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:10:15 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id C69492C1F96;
        Thu, 26 Mar 2020 22:10:13 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ALSA: ppc: keywest: convert to use i2c_new_client_device()
Date:   Thu, 26 Mar 2020 22:10:12 +0100
Message-Id: <20200326211013.13531-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326211013.13531-1-wsa+renesas@sang-engineering.com>
References: <20200326211013.13531-1-wsa+renesas@sang-engineering.com>
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
 sound/ppc/keywest.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index 093806d735c6..9554a0c506af 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -40,6 +40,7 @@ static int keywest_probe(struct i2c_client *client,
 static int keywest_attach_adapter(struct i2c_adapter *adapter)
 {
 	struct i2c_board_info info;
+	struct i2c_client *client;
 
 	if (! keywest_ctx)
 		return -EINVAL;
@@ -50,9 +51,11 @@ static int keywest_attach_adapter(struct i2c_adapter *adapter)
 	memset(&info, 0, sizeof(struct i2c_board_info));
 	strlcpy(info.type, "keywest", I2C_NAME_SIZE);
 	info.addr = keywest_ctx->addr;
-	keywest_ctx->client = i2c_new_device(adapter, &info);
-	if (!keywest_ctx->client)
-		return -ENODEV;
+	client = i2c_new_client_device(adapter, &info);
+	if (IS_ERR(client))
+		return PTR_ERR(client);
+	keywest_ctx->client = client;
+
 	/*
 	 * We know the driver is already loaded, so the device should be
 	 * already bound. If not it means binding failed, and then there
-- 
2.20.1

