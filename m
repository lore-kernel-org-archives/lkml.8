Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BE0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C29246B5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196563;
	bh=Gz3DyGPdoK3HaUxL8jcQcFzoATbXBNNfW6xPJ5GWL7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EZXH8B3MxsNr/p3q6ZZNz2KIO0ZiGkR+eJY7cx8ApC1ZUipqDyZio9jU3trToZS5b
	 7EQ62vS3NJnn59iECyx4rfSef14P3TjG0Th28Q2NVXkUY9/UYkzPA1PqAwBMVOT7rm
	 GIgspS/cOv8XXke2Qw7IeQkIfKKOhOL6Cn+dF8n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405829AbgAPRmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405784AbgAPRlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:41:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B88124731;
        Thu, 16 Jan 2020 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196507;
        bh=Gz3DyGPdoK3HaUxL8jcQcFzoATbXBNNfW6xPJ5GWL7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVoTnASGp9KZ+4h9S/CNCVP6Glr6XM8r2+dYLixLD1klfK0Pt54t/NVa/k6tqx8hd
         bjPOmTodDGV7zMLe31/+Ory395LypBdxqKeknnzYyuHOS4LlflinWzuYlMDm9SWdZp
         tYcE+83UtrSQq7aHEG7NKm7tyfB6xdFX/+Xk2oNE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 247/251] dmaengine: ti: edma: fix missed failure handling
Date:   Thu, 16 Jan 2020 12:36:36 -0500
Message-Id: <20200116173641.22137-207-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 340049d453682a9fe8d91fe794dd091730f4bb25 ]

When devm_kcalloc fails, it forgets to call edma_free_slot.
Replace direct return with failure handler to fix it.

Fixes: 1be5336bc7ba ("dmaengine: edma: New device tree binding")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191118073802.28424-1-hslester96@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/edma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 72f31e837b1d..56ec72468745 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2340,8 +2340,10 @@ static int edma_probe(struct platform_device *pdev)
 
 		ecc->tc_list = devm_kcalloc(dev, ecc->num_tc,
 					    sizeof(*ecc->tc_list), GFP_KERNEL);
-		if (!ecc->tc_list)
-			return -ENOMEM;
+		if (!ecc->tc_list) {
+			ret = -ENOMEM;
+			goto err_reg1;
+		}
 
 		for (i = 0;; i++) {
 			ret = of_parse_phandle_with_fixed_args(node, "ti,tptcs",
-- 
2.20.1

