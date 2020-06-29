Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7A9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4EF9206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467925;
	bh=PPoFicczah2+Cv9aeNEK0ooYF25MkmA+rcIgIUfURK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AUvoSkN1QhgxZo1XsvK0gorSPXbcCGQmw/lBxAP2ugdhGy3+kxfdDDCQk9QtfWB86
	 JfKZOKtWycwHL78QYwhyf7eDXwMOjM+cJq1GlnM3FV/6Tm+ZlKzhWhNMnF6O90aDVb
	 3WKh12OxGwdQXsSWWuJqZxhL76oOpTLXU58OpbgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404651AbgF2V6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgF2Sf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79DBB246E7;
        Mon, 29 Jun 2020 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444031;
        bh=PPoFicczah2+Cv9aeNEK0ooYF25MkmA+rcIgIUfURK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iIVxnAOj69spV+TCQt7YpGQcqn9cMhl3ExzFN1f3Z9ehTViP0zKn9Fy9XWyA06JUG
         ayd/KZHoHC+DrRwF7BMix0IPJF5swy30mfSw3UtXRnpEJbpUwj9IWFvOD6T6y29iDO
         5uzhK8TC+eDsD3QnP8+hW4t/QtCL8CRppPWnfREc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fan Guo <guofan5@huawei.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 138/265] RDMA/mad: Fix possible memory leak in ib_mad_post_receive_mads()
Date:   Mon, 29 Jun 2020 11:16:11 -0400
Message-Id: <20200629151818.2493727-139-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fan Guo <guofan5@huawei.com>

[ Upstream commit a17f4bed811c60712d8131883cdba11a105d0161 ]

If ib_dma_mapping_error() returns non-zero value,
ib_mad_post_receive_mads() will jump out of loops and return -ENOMEM
without freeing mad_priv. Fix this memory-leak problem by freeing mad_priv
in this case.

Fixes: 2c34e68f4261 ("IB/mad: Check and handle potential DMA mapping errors")
Link: https://lore.kernel.org/r/20200612063824.180611-1-guofan5@huawei.com
Signed-off-by: Fan Guo <guofan5@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/mad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index f7626ebcf31cf..049c9cdc10dec 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2941,6 +2941,7 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 						 DMA_FROM_DEVICE);
 		if (unlikely(ib_dma_mapping_error(qp_info->port_priv->device,
 						  sg_list.addr))) {
+			kfree(mad_priv);
 			ret = -ENOMEM;
 			break;
 		}
-- 
2.25.1

