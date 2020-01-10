Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6125C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FF7206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578693989;
	bh=k7jLbKDGZ4iRjIZ4qzQ6bAEV+npIVuYrJOHBHWLt2XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zStU3yZeV06QRu0Uqf+Elcu/9MJ1eqATl2mx5TZMNRKOXQJ648/nlMzb5Gj6nYWzA
	 SgRgfduKQZ/2xaYmIonemHudZhiVpGrReIEZdm0ct7mqKUz8o81iv10K0y5/sHOzU/
	 RMOqnqbbXWSxPmjJ+xleSj4q/FsA32CB4Ug/SMdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgAJWG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgAJWG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:06:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD9A2082E;
        Fri, 10 Jan 2020 22:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578693985;
        bh=k7jLbKDGZ4iRjIZ4qzQ6bAEV+npIVuYrJOHBHWLt2XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDxvqv82HGG0VULv4csV8SjFaO4yEe9M7CWSxEcss9TYmKszO5VrMk0NHOVgzVf4b
         9i/iR9IOjo2JeDLEBaxOX/aIYuZBNieruab9k47Ne8Jj8sG4X4LLKSGF8Hfm97DyB4
         u7lkI5ONIN1MW0rDLFHtZn0wuH83yFndMEilFbXM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/8] dmaengine: k3dma: Avoid null pointer traversal
Date:   Fri, 10 Jan 2020 17:06:16 -0500
Message-Id: <20200110220621.28651-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110220621.28651-1-sashal@kernel.org>
References: <20200110220621.28651-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <john.stultz@linaro.org>

[ Upstream commit 2f42e05b942fe2fbfb9bbc6e34e1dd8c3ce4f3a4 ]

In some cases we seem to submit two transactions in a row, which
causes us to lose track of the first. If we then cancel the
request, we may still get an interrupt, which traverses a null
ds_run value.

So try to avoid starting a new transaction if the ds_run value
is set.

While this patch avoids the null pointer crash, I've had some
reports of the k3dma driver still getting confused, which
suggests the ds_run/ds_done value handling still isn't quite
right. However, I've not run into an issue recently with it
so I think this patch is worth pushing upstream to avoid the
crash.

Signed-off-by: John Stultz <john.stultz@linaro.org>
[add ss tag]
Link: https://lore.kernel.org/r/20191218190906.6641-1-john.stultz@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/k3dma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 219ae3b545db..803045c92f3b 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -222,9 +222,11 @@ static irqreturn_t k3_dma_int_handler(int irq, void *dev_id)
 			c = p->vchan;
 			if (c && (tc1 & BIT(i))) {
 				spin_lock_irqsave(&c->vc.lock, flags);
-				vchan_cookie_complete(&p->ds_run->vd);
-				p->ds_done = p->ds_run;
-				p->ds_run = NULL;
+				if (p->ds_run != NULL) {
+					vchan_cookie_complete(&p->ds_run->vd);
+					p->ds_done = p->ds_run;
+					p->ds_run = NULL;
+				}
 				spin_unlock_irqrestore(&c->vc.lock, flags);
 			}
 			if (c && (tc2 & BIT(i))) {
@@ -264,6 +266,10 @@ static int k3_dma_start_txd(struct k3_dma_chan *c)
 	if (BIT(c->phy->idx) & k3_dma_get_chan_stat(d))
 		return -EAGAIN;
 
+	/* Avoid losing track of  ds_run if a transaction is in flight */
+	if (c->phy->ds_run)
+		return -EAGAIN;
+
 	if (vd) {
 		struct k3_dma_desc_sw *ds =
 			container_of(vd, struct k3_dma_desc_sw, vd);
-- 
2.20.1

