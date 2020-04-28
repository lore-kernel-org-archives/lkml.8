Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749ABC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BF3206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099889;
	bh=uIn2G7kOEb2huzpJZoDazjAU0elALl1jCoxLFvDPrx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EvXvRx9/rDWNB+bB+b+k89SWnB7pFA+Pqe/7Rienfm3U4J8rlYcv1LsCPUAgEu+bu
	 N85n7jjjL1p3zMgU1vmy0M1JbeC82ahMI85nS9EcOJMO2cdL22RqQRmuEixxkA+StV
	 7b5VhB2mgH5mKUEr0LX0nU90HglCYr+BkxqbfdZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgD1ShV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730456AbgD1ShO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:37:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0046720730;
        Tue, 28 Apr 2020 18:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099033;
        bh=uIn2G7kOEb2huzpJZoDazjAU0elALl1jCoxLFvDPrx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwn4q29Sg58kfTyVJ5LBaOsG7UzNoM8fifn4iXWsC/31ogfFeJeZ8GowYD9TxuSvc
         gcr9VO3nQn1GvPb7bOO4E65/WWJJYh4SNOSzBB3sC/trkDXmOtSDposZNvgcrwYB1O
         jV4k7JF3mr+7lR2lktb5vOKy9Aq/4e8KCSGDxB84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 048/168] ASoC: SOF: trace: fix unconditional free in trace release
Date:   Tue, 28 Apr 2020 20:23:42 +0200
Message-Id: <20200428182237.956072572@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit e6110114d18d330c05fd6de9f31283fd086a5a3a ]

Check if DMA pages were successfully allocated in initialization
before calling free. For many types of memory (like sgbufs)
the extra free is harmless, but not all backends track allocation
state, so add an explicit check.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200124213625.30186-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/trace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/trace.c b/sound/soc/sof/trace.c
index 4c3cff031fd66..fd6f5913782bf 100644
--- a/sound/soc/sof/trace.c
+++ b/sound/soc/sof/trace.c
@@ -328,7 +328,10 @@ void snd_sof_free_trace(struct snd_sof_dev *sdev)
 {
 	snd_sof_release_trace(sdev);
 
-	snd_dma_free_pages(&sdev->dmatb);
-	snd_dma_free_pages(&sdev->dmatp);
+	if (sdev->dma_trace_pages) {
+		snd_dma_free_pages(&sdev->dmatb);
+		snd_dma_free_pages(&sdev->dmatp);
+		sdev->dma_trace_pages = 0;
+	}
 }
 EXPORT_SYMBOL(snd_sof_free_trace);
-- 
2.20.1



ansport.c:937

This bug occurs when cancellation of the S-G transfer races with
transfer completion.  When that happens, usb_sg_cancel() may continue
to access the transfer's URBs after usb_sg_wait() has freed them.

The bug is caused by the fact that usb_sg_cancel() does not take any
sort of reference to the transfer, and so there is nothing to prevent
the URBs from being deallocated while the routine is trying to use
them.  The fix is to take such a reference by incrementing the
transfer's io->count field while the cancellation is in progres and
decrementing it afterward.  The transfer's URBs are not deallocated
until io->complete is triggered, which happens when io->count reaches
zero.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Kyungtae Kim <kt0755@gmail.com>
CC: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/Pine.LNX.4.44L0.2003281615140.14837-100000@netrider.rowland.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/message.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -588,12 +588,13 @@ void usb_sg_cancel(struct usb_sg_request
 	int i, retval;
 
 	spin_lock_irqsave(&io->lock, flags);
-	if (io->status) {
+	if (io->status || io->count == 0) {
 		spin_unlock_irqrestore(&io->lock, flags);
 		return;
 	}
 	/* shut everything down */
 	io->status = -ECONNRESET;
+	io->count++;		/* Keep the request alive until we're done */
 	spin_unlock_irqrestore(&io->lock, flags);
 
 	for (i = io->entries - 1; i >= 0; --i) {
@@ -607,6 +608,12 @@ void usb_sg_cancel(struct usb_sg_request
 			dev_warn(&io->dev->dev, "%s, unlink --> %d\n",
 				 __func__, retval);
 	}
+
+	spin_lock_irqsave(&io->lock, flags);
+	io->count--;
+	if (!io->count)
+		complete(&io->complete);
+	spin_unlock_irqrestore(&io->lock, flags);
 }
 EXPORT_SYMBOL_GPL(usb_sg_cancel);
 


