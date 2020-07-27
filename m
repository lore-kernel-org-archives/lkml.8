Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F07CC433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62D420838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858872;
	bh=HE1tTQZPf/uXLBnCJG+o1pp+WMQMH2wEqncDBLCC6p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pa5+yo1b9ZuwUDgcS+XgrZpGyEzzQC2AB3JoR6kJRX3jv77mZiCwEkrMJIzQJdnO2
	 JB4Q/5fD3BcD0xzHr3URIX3bFc7FN/9besmq79K5VAgwqwtaBda2YFqocJmODjNKLl
	 nHAPq+B57ZGmbxv4hdmx4S1+Ht/0CT/ZKS+ISEyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgG0OHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729298AbgG0OHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:07:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83CDB2078E;
        Mon, 27 Jul 2020 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858865;
        bh=HE1tTQZPf/uXLBnCJG+o1pp+WMQMH2wEqncDBLCC6p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqiczZIQao+lCmAyFWvsIkDtSgcltn9HTTzj90D/qIfBqvY3qaPVdGX0Z9SgRjK6W
         fNv8IUqL28gfNBG5ZQPG7IJx1e5Qm6ekBaf0yI6fKUvakyHDzzligN256jzc/4Lydx
         gurxhhURDCRe+DKh7ddpQsAgavRYWQG8/GCP//KE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonid Ravich <Leonid.Ravich@emc.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 41/64] dmaengine: ioat setting ioat timeout as module parameter
Date:   Mon, 27 Jul 2020 16:04:20 +0200
Message-Id: <20200727134913.214594051@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
References: <20200727134911.020675249@linuxfoundation.org>
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
index e3899ae429e0f..4c2b41beaf638 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -38,6 +38,18 @@
 
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
index 56200eefcf5ee..01f9299572303 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -111,8 +111,6 @@ struct ioatdma_chan {
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



