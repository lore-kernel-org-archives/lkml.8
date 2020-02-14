Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43084C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDF52086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704580;
	bh=r7FkUelilDY8E2lxOEaBeUfq44C8QuYUFKAVBdViqps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S4Xmus5/b+lBS5AOdPT4dzpMo5JdMW7t5nxrveM+tM2HfNTBRJGt9gYm7r/tPWWxt
	 6kXR8eGjCDTuG/2Xw62OLoY9EGhTvoF+Xotn6B1m+aAi/tIBYq8OZi7RoejuLwkn2H
	 Gjt6gpQsNLBj7sQCSOg87xgBUV5HIYn7NnrhlFrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404854AbgBNSW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbgBNPt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:49:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 910542467D;
        Fri, 14 Feb 2020 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695367;
        bh=r7FkUelilDY8E2lxOEaBeUfq44C8QuYUFKAVBdViqps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRJ5UO7nzNkI3B2FsvFqQf+sN5/rxQj4qoCBwv8nm6VIGmX8opWj79+aC+PGoIKKK
         YL54AliVyABbmqSNbIgfQqD3QV6KFmlXqqk68MUYe92vzuTBO0KRetoqIACJleIbkV
         lViqfoV7UwCAxrGBu6i76I9ihPi5DXlhw2dTwcoQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 025/542] dmaengine: ti: edma: Fix error return code in edma_probe()
Date:   Fri, 14 Feb 2020 10:40:17 -0500
Message-Id: <20200214154854.6746-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit d1fd03a35efc6285e43f4ef35ef04dbf2c9389c6 ]

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 2a03c1314506 ("dmaengine: ti: edma: add missed operations")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191212114622.127322-1-weiyongjun1@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ti/edma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 0628ee4bf1b41..03a7f647f7b2c 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2342,8 +2342,10 @@ static int edma_probe(struct platform_device *pdev)
 	ecc->channels_mask = devm_kcalloc(dev,
 					   BITS_TO_LONGS(ecc->num_channels),
 					   sizeof(unsigned long), GFP_KERNEL);
-	if (!ecc->slave_chans || !ecc->slot_inuse || !ecc->channels_mask)
+	if (!ecc->slave_chans || !ecc->slot_inuse || !ecc->channels_mask) {
+		ret = -ENOMEM;
 		goto err_disable_pm;
+	}
 
 	/* Mark all channels available initially */
 	bitmap_fill(ecc->channels_mask, ecc->num_channels);
-- 
2.20.1

