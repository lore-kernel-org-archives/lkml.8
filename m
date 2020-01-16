Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CC9C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F22824690
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194880;
	bh=d1ot/YYV0RfF+eScit7Pv9Z4aszxjt9nvHftGYJUmFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xM65cuQbABYX10XI4R/7ur3kOS47IzJqG1RCdNDLIgL2nEOj3RH7EgLmwvpHR+Y14
	 gzU9eXVNq4XC6TQx9zIKigZariaqRNWnMkm3kBJJ9rspu313Abs64TZZy+OfLVL52b
	 Bj8h7+1/c7fBdjToIdA8q2SJARlfSk9r/t+0MJ9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391056AbgAPROj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389707AbgAPROX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:14:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37664246B9;
        Thu, 16 Jan 2020 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194862;
        bh=d1ot/YYV0RfF+eScit7Pv9Z4aszxjt9nvHftGYJUmFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phnGnqLm/yrmcRDxhNGtiHRWfM2EzsCfXdI53r3O1LiXV59GfGCPKU0zx6btz5Pdp
         cydw9xcdJGL3taiqY7UpDiDiSXLZbduFWv8IgZj+Mb+P3502sFkhxJ/qtbRwgOM180
         CinaOgHVWotDJu9fcVnwmhHfi/2tzGmUq4L6UJc8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 657/671] dmaengine: ti: edma: fix missed failure handling
Date:   Thu, 16 Jan 2020 12:04:55 -0500
Message-Id: <20200116170509.12787-394-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
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
 drivers/dma/ti/edma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 982631d4e1f8..44158fa85973 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2345,8 +2345,10 @@ static int edma_probe(struct platform_device *pdev)
 
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

