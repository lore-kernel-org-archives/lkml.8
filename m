Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F934C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B2722CBB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281063;
	bh=RBYFblPQop8OJr48l7BkzZOT8znndds4pQrFRWY0Whw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FFu1aPE95WMpthroZetO13Jns9brt2Wx3HP0brr9nqdhRb4gdthG1eQLBNtWPErMX
	 zsBlXUZivxhHK3Cj+WO7H+lP+PM3IW50utD+8qXY5r+XGpvYlV5nkG4AQkoPRKt9X0
	 d/nzdQlVv5C14j1GR49cLasbQGwNUuawmLa80yGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgGTVhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgGTVhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:37:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4C622BF5;
        Mon, 20 Jul 2020 21:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281057;
        bh=RBYFblPQop8OJr48l7BkzZOT8znndds4pQrFRWY0Whw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAdwjpuC2uiH+HXObCnb6ncVYY+i/mfPIWJrh+oRaGaWgpslJu94yGzWtD2cQBEYZ
         HUxdtNOb+ljKMxt9HMZTte9w6C6e/syjxrdG4K+2lDSZRSsfgF7bfB/6SmDY/cunWI
         sYcvNN21zcETgakFBmvmpKOU6AXkNQOu/cN9OiIc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leonid Ravich <Leonid.Ravich@emc.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 17/40] dmaengine: ioat setting ioat timeout as module parameter
Date:   Mon, 20 Jul 2020 17:36:52 -0400
Message-Id: <20200720213715.406997-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213715.406997-1-sashal@kernel.org>
References: <20200720213715.406997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

[ Upstream commit 87730ccbddcb48478b1b88e88b14e73424130764 ]

DMA transaction time to completion is a function of PCI bandwidth,
transaction size and a queue depth.  So hard coded value for timeouts
might be wrong for some scenarios.

Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20200701184816.29138-1-leonid.ravich@dell.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ioat/dma.c | 12 ++++++++++++
 drivers/dma/ioat/dma.h |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 18c011e57592e..8e2a4d1f0be53 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -26,6 +26,18 @@
 
 #include "../dmaengine.h"
 
+int completion_timeout = 200;
+module_param(completion_timeout, int, 0644);
+MODULE_PARM_DESC(completion_timeout,
+		"set ioat completion timeout [msec] (default 200 [msec])");
+int idle_timeout = 2000;
+module_param(idle_timeout, int, 0644);
+MODULE_PARM_DESC(idle_timeout,
+		"set ioat idel timeout [msec] (default 2000 [msec])");
+
+#define IDLE_TIMEOUT msecs_to_jiffies(idle_timeout)
+#define COMPLETION_TIMEOUT msecs_to_jiffies(completion_timeout)
+
 static char *chanerr_str[] = {
 	"DMA Transfer Source Address Error",
 	"DMA Transfer Destination Address Error",
diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index b8e8e0b9693c7..4ac9134962f3b 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -99,8 +99,6 @@ struct ioatdma_chan {
 	#define IOAT_RUN 5
 	#define IOAT_CHAN_ACTIVE 6
 	struct timer_list timer;
-	#define COMPLETION_TIMEOUT msecs_to_jiffies(100)
-	#define IDLE_TIMEOUT msecs_to_jiffies(2000)
 	#define RESET_DELAY msecs_to_jiffies(100)
 	struct ioatdma_device *ioat_dma;
 	dma_addr_t completion_dma;
-- 
2.25.1

