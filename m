Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC6FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC97A2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592924;
	bh=LNfpDdOcd2Tj+mjwph6GeGR2gp+07qJzQK877hYzwGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WZK2cZLJLnLLtixFBU9rWIiPIXROmEy9iO2OucXmQ2QuMw53dFV07YhScWofcrgTl
	 zUmZ9Bg/6iGrg10HNg3zHPf7SPS3YgHGTKQ0hZs4t2y0K6q4olnS9lygePat8Z/gB/
	 wSLpRylRtfT06rWnhRwcR7CJcMjNTbVnwD3vcepY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbgIHTWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731103AbgIHQBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:01:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 376E424170;
        Tue,  8 Sep 2020 15:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579524;
        bh=LNfpDdOcd2Tj+mjwph6GeGR2gp+07qJzQK877hYzwGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhj0k4MLhVkri4x6sWn13tdvF5EuMFTgT3OR+25MIezs19CYZeI2gsd3RLcyJbkgx
         d0Qd1El3gyeytF7UyHj+FpC/iCkeYZr2yfpYckxzwoAck15kSgCrJtWQv/1cnfYK5Z
         bkFoy0HwBtxYmdPTjT4ujqEyeHoh4YCDMEyvnMj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 084/186] nvme: fix controller instance leak
Date:   Tue,  8 Sep 2020 17:23:46 +0200
Message-Id: <20200908152245.714419643@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 192f6c29bb28bfd0a17e6ad331d09f1ec84143d0 ]

If the driver has to unbind from the controller for an early failure
before the subsystem has been set up, there won't be a subsystem holding
the controller's instance, so the controller needs to free its own
instance in this case.

Fixes: 733e4b69d508d ("nvme: Assign subsys instance from first ctrl")
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f38548e6d55ec..fa0039dcacc66 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4148,7 +4148,7 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
-	if (subsys && ctrl->instance != subsys->instance)
+	if (!subsys || ctrl->instance != subsys->instance)
 		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 
 	kfree(ctrl->effects);
-- 
2.25.1



