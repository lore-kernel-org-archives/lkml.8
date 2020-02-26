Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0703C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10EA2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBZJHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:07:13 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:59135 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgBZJHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:07:13 -0500
Received: from localhost.localdomain ([77.204.247.159])
        by mwinf5d57 with ME
        id 7M782200F3T54jx03M783H; Wed, 26 Feb 2020 10:07:10 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 Feb 2020 10:07:10 +0100
X-ME-IP: 77.204.247.159
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dan.j.williams@intel.com, vkoul@kernel.org, dave.jiang@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: Simplify error handling path in '__dma_async_device_channel_register()'
Date:   Wed, 26 Feb 2020 10:07:07 +0100
Message-Id: <20200226090707.12285-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'chan->dev = kzalloc()' fails, there is no need to explicitly call
'free_percpu()'. It is already called in the error handling path.
So it can be removed.

While at it, add a 'chan->local = NULL;' in the error handling path after
the 'free_percpu()' call. It is maybe useless, but can not hurt.

Fixes: d2fb0a043838 ("dmaengine: break out channel registration")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure a Fixes tag is required for just a clean-up. I added it if the
move of the 'chan->local = NULL;' makes a real sense.
---
 drivers/dma/dmaengine.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c3b1283b6d31..6bb6e88c6019 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -978,11 +978,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	if (!chan->local)
 		goto err_out;
 	chan->dev = kzalloc(sizeof(*chan->dev), GFP_KERNEL);
-	if (!chan->dev) {
-		free_percpu(chan->local);
-		chan->local = NULL;
+	if (!chan->dev)
 		goto err_out;
-	}
 
 	/*
 	 * When the chan_id is a negative value, we are dynamically adding
@@ -1008,6 +1005,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 
  err_out:
 	free_percpu(chan->local);
+	chan->local = NULL;
 	kfree(chan->dev);
 	if (atomic_dec_return(idr_ref) == 0)
 		kfree(idr_ref);
-- 
2.20.1

