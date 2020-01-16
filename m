Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A3EC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9879206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201958;
	bh=ySCCAT5S4SA6jQ16+NN9WalXDEvCTtgMSFPJgzlj4y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GbByeb6iRru5MfPAOZkXxBWYhMolx6rUDlINI4g18/bpcKeh6F9B+2SdiApvS5okZ
	 CyazoqWj6vNMKv1xvsVDOIeZBgegOX/sCyjjNX/YuYWqGZm3FXLMMClxtZCqlr/cJm
	 qGmFFAEAg8ThFgnNTAJEUVyCG6y5j/7tYHbpi1+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437393AbgAPTMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387625AbgAPQ74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:59:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7782922525;
        Thu, 16 Jan 2020 16:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193996;
        bh=ySCCAT5S4SA6jQ16+NN9WalXDEvCTtgMSFPJgzlj4y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjxpWM5ne1Y+04YvAGE/NAsT0KZvqG0YU6jFGKfzmprDbohuY9BfJnW2lociT08x5
         5rd9XostZgr8Txvs9CEDo79+pykpOCPKdvUnvVbgiN74t+LEkAYB8sWpwNGcuECppQ
         haEkqtOAkwnEFMojc544ncZ/maE2ZlfNcL2xT7lA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 125/671] media: tw9910: Unregister subdevice with v4l2-async
Date:   Thu, 16 Jan 2020 11:50:34 -0500
Message-Id: <20200116165940.10720-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

[ Upstream commit 341fe1d301f587c930509f6b9153436b957f649c ]

As the tw9910 subdevice is registered through the v4l2-async framework,
use the v4l2-async provided function to register it.

Fixes: 7b20f325a566 ("media: i2c: tw9910: Remove soc_camera dependencies")

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/tw9910.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/tw9910.c b/drivers/media/i2c/tw9910.c
index a54548cc4285..c7321a70e3ed 100644
--- a/drivers/media/i2c/tw9910.c
+++ b/drivers/media/i2c/tw9910.c
@@ -1000,7 +1000,7 @@ static int tw9910_remove(struct i2c_client *client)
 	if (priv->pdn_gpio)
 		gpiod_put(priv->pdn_gpio);
 	clk_put(priv->clk);
-	v4l2_device_unregister_subdev(&priv->subdev);
+	v4l2_async_unregister_subdev(&priv->subdev);
 
 	return 0;
 }
-- 
2.20.1

