Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AA2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07362080D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135540;
	bh=Oi7wYcE/YFfHSzj7dau8rDS3JbKaxqE5Oyv2XFaEYvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q5aOq/asBiBy5FXdUqpNT4KgpYMcWD6CMt/tcVX/7kDrMVUo9wubWO0Agd6bIvfc7
	 g4zh+KpuAziE78HQRuFJg8c79fyzBeOYq1Vc06vL34XBaTaOe3u0qcFqgaf3YqLwxq
	 bDmNcIaOzrR6hJUyziSW8PHSUxy2piTrOesaVg/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgGGPZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730222AbgGGPZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:25:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1444520663;
        Tue,  7 Jul 2020 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135532;
        bh=Oi7wYcE/YFfHSzj7dau8rDS3JbKaxqE5Oyv2XFaEYvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSd5ViqUi9wLkmNvDSeykY1fUfL8ApwK+nrbdtKmM+1EZ+bMuLlO5DxJ4aLmnGmUx
         Hkc8fL92ncQB7Hfi/M7S4RyofvD2Wg26lkhMNfAPLWpAmBHER6ULSdiLNj+6X53bDv
         /a9ZOjMrtgIPj3KFIknKzvysLgJRQ1YOcrncR144=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avinash M N <Avinash.M.N@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 078/112] nvme: fix a crash in nvme_mpath_add_disk
Date:   Tue,  7 Jul 2020 17:17:23 +0200
Message-Id: <20200707145804.703589351@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 72d447113bb751ded97b2e2c38f886e4a4139082 ]

For private namespaces ns->head_disk is NULL, so add a NULL check
before updating the BDI capabilities.

Fixes: b2ce4d90690b ("nvme-multipath: set bdi capabilities once")
Reported-by: Avinash M N <Avinash.M.N@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 03bc3aba09871..36db7d2e6a896 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -673,10 +673,11 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 	}
 
 	if (bdi_cap_stable_pages_required(ns->queue->backing_dev_info)) {
-		struct backing_dev_info *info =
-					ns->head->disk->queue->backing_dev_info;
+		struct gendisk *disk = ns->head->disk;
 
-		info->capabilities |= BDI_CAP_STABLE_WRITES;
+		if (disk)
+			disk->queue->backing_dev_info->capabilities |=
+					BDI_CAP_STABLE_WRITES;
 	}
 }
 
-- 
2.25.1



