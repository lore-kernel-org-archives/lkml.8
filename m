Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D590C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C6522202
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgDSQtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:49:32 -0400
Received: from v6.sk ([167.172.42.174]:43706 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgDSQta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:49:30 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id ECA4C610AC;
        Sun, 19 Apr 2020 16:49:28 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 5/7] dmaengine: mmp_tdma: Log an error if channel is in wrong state
Date:   Sun, 19 Apr 2020 18:49:10 +0200
Message-Id: <20200419164912.670973-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419164912.670973-1-lkundrak@v3.sk>
References: <20200419164912.670973-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's log an error if the channel can't be prepared because it is in an
unexpected state.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/dma/mmp_tdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 0b1aa6eab1801..191640f26246d 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -436,8 +436,10 @@ static struct dma_async_tx_descriptor *mmp_tdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int i = 0, buf = 0;
 
-	if (tdmac->status != DMA_COMPLETE)
+	if (tdmac->status != DMA_COMPLETE) {
+		dev_err(tdmac->dev, "controller busy");
 		return NULL;
+	}
 
 	if (period_len > TDMA_MAX_XFER_BYTES) {
 		dev_err(tdmac->dev,
-- 
2.26.0

