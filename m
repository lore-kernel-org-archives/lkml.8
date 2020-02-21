Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344A7C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07A5222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271068;
	bh=r7FkUelilDY8E2lxOEaBeUfq44C8QuYUFKAVBdViqps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JH98kbwsz+y2Wy14mAYy7Y89d7BnC+ZkFiST+hac5ymP706KEXEroRT+nRioOBEjR
	 +fqkxsfgOOG4XjqwLndFqRGrsgYyya2MNmxJJD5udUd8nIlsserLahQ2A06z5xJMmB
	 yYndyj8ue5BnqVhTUtaxO7qB3w4BRk1lG126tEyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBUHo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:44:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbgBUHoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:44:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C13942465D;
        Fri, 21 Feb 2020 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271063;
        bh=r7FkUelilDY8E2lxOEaBeUfq44C8QuYUFKAVBdViqps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjDg9EZ0PBSOrzdyArpSHP+hp/ZT9NxxGrrbQFpSU0WFXjjgpn7CawqFl0Ey7C4hU
         XJFq69n13vdoYPQpgPG7jvU/YkqkxnNoUj0loyJN9YLzvxFCsteFVbJj7pXVZZZX3Q
         G6cK4XNLqtU8i7R1KwSLzVhAWWU+QpNBP6YUIS4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 025/399] dmaengine: ti: edma: Fix error return code in edma_probe()
Date:   Fri, 21 Feb 2020 08:35:50 +0100
Message-Id: <20200221072404.804529594@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



