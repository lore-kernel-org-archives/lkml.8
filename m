Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB931C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748D32065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978112;
	bh=+twnufWi3x03h1AwFfniqv5oWUZjz95y+3fwKNyHuQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vPiAyZdyLPsYuDZPry1b8TRCANTxq0M5bL3LVcxx+ui430QdqodhZ1sMPF9ssSnmC
	 /cnBVtSl84brelAYhV1qDO4Ek58b5FLpHF0Mrxcm2uwBVCcm1HEfciWc/aq9hNeDDD
	 qvudDBp3NRS2qIfRbCHP2xNf/joce/2+rZly80LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgIAQfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbgIAPa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:30:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4C1207D3;
        Tue,  1 Sep 2020 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974257;
        bh=+twnufWi3x03h1AwFfniqv5oWUZjz95y+3fwKNyHuQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvSh2j3VXXRIcI3IGPOERQ1AX6Ad/ypcxtsT+EKOWgh9fvMFtJqI9w4eob/FoT8sS
         J/xHzr3ZqykS49UBI0VLiHorNINgqnMuSAhsXv3UsqBcqmYdk8GV4+OVupW5xBt2iu
         PwGYFCw7UcxNMiGaY6qDltQzQuWTFN0uKZF3rzck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 107/214] nvme-fc: Fix wrong return value in __nvme_fc_init_request()
Date:   Tue,  1 Sep 2020 17:09:47 +0200
Message-Id: <20200901150958.117349119@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

[ Upstream commit f34448cd0dc697723fb5f4118f8431d9233b370d ]

On an error exit path, a negative error code should be returned
instead of a positive return value.

Fixes: e399441de9115 ("nvme-fabrics: Add host support for FC transport")
Cc: James Smart <jsmart2021@gmail.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 83ac88924f253..dce4d6782ceb1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1740,7 +1740,7 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 	if (fc_dma_mapping_error(ctrl->lport->dev, op->fcp_req.cmddma)) {
 		dev_err(ctrl->dev,
 			"FCP Op failed - cmdiu dma mapping failed.\n");
-		ret = EFAULT;
+		ret = -EFAULT;
 		goto out_on_error;
 	}
 
@@ -1750,7 +1750,7 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 	if (fc_dma_mapping_error(ctrl->lport->dev, op->fcp_req.rspdma)) {
 		dev_err(ctrl->dev,
 			"FCP Op failed - rspiu dma mapping failed.\n");
-		ret = EFAULT;
+		ret = -EFAULT;
 	}
 
 	atomic_set(&op->state, FCPOP_STATE_IDLE);
-- 
2.25.1



