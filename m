Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990A2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCA8207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860147;
	bh=RBYFblPQop8OJr48l7BkzZOT8znndds4pQrFRWY0Whw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dxNADr0bFC2xDkArsbxB8O6ims1692HQeL5MXzsfi/irVJ6AcIiJ4LGj6Nhp00EZQ
	 Truoxf9ySwshDfH35l29UrIMx/ieXxkNmj3E2+0rZXSgtbtU6bt8pBdQG6Znj38FA7
	 kckqg8w0TxuvY0sBBG/S4Tl7xgCWiYrbKESxWKE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbgG0O3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732148AbgG0OXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:23:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 298392083E;
        Mon, 27 Jul 2020 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859834;
        bh=RBYFblPQop8OJr48l7BkzZOT8znndds4pQrFRWY0Whw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRYKv5HsB+earQUKGgQN9R9IHsR9TqpdC1Yck1xqr9al0zJq45I+fe4NXL/yQiSGl
         dUGhq8zWx6xCS2KQE8vG94X0UoBxcC8uwBgE0ldQ2rM2kIPuvl7ys4BdFZdIa5lMIR
         ReXYmn/0GanCglR1/cLvW7ajCSYaW86WumQkyPjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonid Ravich <Leonid.Ravich@emc.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 116/179] dmaengine: ioat setting ioat timeout as module parameter
Date:   Mon, 27 Jul 2020 16:04:51 +0200
Message-Id: <20200727134938.305043891@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



