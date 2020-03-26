Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E30C2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5855D20774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265232;
	bh=1vNw19HI8j9c2EMi/E+spM3gRrZZKk18DlrDK2kPTUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FlXlcr8OCCmIrQ4wRSvwtMPUXYl67Gb2Fh26W/1+15CsGXstqlTBcTVzlTk4RPyOW
	 Zpncen8dknEdTcI/Gdj7moIVGK6f6FT65DrWKcNhVjXwOJeGLMyG3CmxL3uwmTgNuP
	 EUL+om0kWz4Sm+/0julTKrHGYVq58MGI8vEV0OJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgCZXZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbgCZXY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:24:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CEA620409;
        Thu, 26 Mar 2020 23:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265098;
        bh=1vNw19HI8j9c2EMi/E+spM3gRrZZKk18DlrDK2kPTUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sra4RmPvNwLaqYNpRfIWP6PNVBOBCfdhqO+5GguhcyisOF7E2uz8xj1O1SoOLfkOs
         av0ZcpqKKBGBd/2fsMeR0LKHcGb9JvjWAHohueTPDhR14qltcp0N3Y/RmVEG+BML5y
         pyjmbsI2gUL4PN3SkUxsfuYRyeEWptkFfwf4QUPE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Prabhath Sajeepa <psajeepa@purestorage.com>,
        Roland Dreier <roland@purestorage.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 02/15] nvme-rdma: Avoid double freeing of async event data
Date:   Thu, 26 Mar 2020 19:24:42 -0400
Message-Id: <20200326232455.8029-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232455.8029-1-sashal@kernel.org>
References: <20200326232455.8029-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prabhath Sajeepa <psajeepa@purestorage.com>

[ Upstream commit 9134ae2a2546cb96abddcd4469a79c77ee3a4480 ]

The timeout of identify cmd, which is invoked as part of admin queue
creation, can result in freeing of async event data both in
nvme_rdma_timeout handler and error handling path of
nvme_rdma_configure_admin queue thus causing NULL pointer reference.
Call Trace:
 ? nvme_rdma_setup_ctrl+0x223/0x800 [nvme_rdma]
 nvme_rdma_create_ctrl+0x2ba/0x3f7 [nvme_rdma]
 nvmf_dev_write+0xa54/0xcc6 [nvme_fabrics]
 __vfs_write+0x1b/0x40
 vfs_write+0xb2/0x1b0
 ksys_write+0x61/0xd0
 __x64_sys_write+0x1a/0x20
 do_syscall_64+0x60/0x1e0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reviewed-by: Roland Dreier <roland@purestorage.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e4f167e35353f..9711bfbdf4316 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -815,9 +815,11 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (new)
 		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
 out_free_async_qe:
-	nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-		sizeof(struct nvme_command), DMA_TO_DEVICE);
-	ctrl->async_event_sqe.data = NULL;
+	if (ctrl->async_event_sqe.data) {
+		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
+			sizeof(struct nvme_command), DMA_TO_DEVICE);
+		ctrl->async_event_sqe.data = NULL;
+	}
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
-- 
2.20.1

