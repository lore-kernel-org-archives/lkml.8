Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66000C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3674220885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445987;
	bh=B3HdxUBiJCU32sbuk444sodIJkPGhv+mpEKr9pRgcY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R16MLIOMPLVwRpich0UHCQpoBUAGytuETHrpv9yCZbr4nT2cmj0QE1/Pxe34Yednw
	 cHqLNuVOpQeB/su/wqd22zQvNkLuhDfY0MKfP77Slf7A8TRpcUfU0P9vUhgp6v4t7Q
	 67F9eIpYRZH6rMroi4b1EQatszAc3fHrMhIQMMXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgFRCGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbgFRBWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:22:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA7320663;
        Thu, 18 Jun 2020 01:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443353;
        bh=B3HdxUBiJCU32sbuk444sodIJkPGhv+mpEKr9pRgcY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ndn8eVjJ8XEacRN2xWTQLlc4DWG/NWJDk13VJpng/qg+dVipzXeQTaKLF5pICUwiN
         tlCO0O+KuoYUIZJa4d/0wykn4R/Kg0RdM6EZEhNte26o6DV8M9+Fe4bnX/2cC200WA
         mDPhHH4IZH5c+mnLq9ILG1X4Z31BE3WS5/Y2/K+I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 011/172] ASoC: davinci-mcasp: Fix dma_chan refcnt leak when getting dma type
Date:   Wed, 17 Jun 2020 21:19:37 -0400
Message-Id: <20200618012218.607130-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit a697ae6ea56e23397341b027098c1b11d9ab13da ]

davinci_mcasp_get_dma_type() invokes dma_request_chan(), which returns a
reference of the specified dma_chan object to "chan" with increased
refcnt.

When davinci_mcasp_get_dma_type() returns, local variable "chan" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one exception handling path of
davinci_mcasp_get_dma_type(). When chan device is NULL, the function
forgets to decrease the refcnt increased by dma_request_chan(), causing
a refcnt leak.

Fix this issue by calling dma_release_channel() when chan device is
NULL.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/1587818916-38730-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 14ab16e1369f..1203de8aab99 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1758,8 +1758,10 @@ static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
 				PTR_ERR(chan));
 		return PTR_ERR(chan);
 	}
-	if (WARN_ON(!chan->device || !chan->device->dev))
+	if (WARN_ON(!chan->device || !chan->device->dev)) {
+		dma_release_channel(chan);
 		return -EINVAL;
+	}
 
 	if (chan->device->dev->of_node)
 		ret = of_property_read_string(chan->device->dev->of_node,
-- 
2.25.1

