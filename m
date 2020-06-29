Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D80C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D17B20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461087;
	bh=1ZDQjQTTwcBQldNxnDO1vv80rmNxahdb4GVupela0pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dRN7Z7+Xi3skj+5JvExcwpsiz1zCD0OoWzWTH5iRf9Y+QLSvt6cY6YYGafv5A1n0I
	 HMYMVk1juECxk9jQaFaK/JWbm7qXsfMobi59zVwCiT2z+Ju0L23oiJKt8ssvdUwO2x
	 vQebl+WPoUKNzOrbRtPcsMylXimJ/MK/HX56z/sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbgF2UEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732989AbgF2Tab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8625E25264;
        Mon, 29 Jun 2020 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444975;
        bh=1ZDQjQTTwcBQldNxnDO1vv80rmNxahdb4GVupela0pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjKLJ7VjU4U3ERNkzKxKTCJIRU6J89lVBF7R7ndaH1UCw+JIDe0xo6pG9bcXaROem
         OZpNn8jN956IPhTYwFE6ZmAg8B5FVcpPpVZeSKTw2RXfnC6LWA7fp+XpJMmAL8zr3F
         oyCv0yExYzAsuutyFrzZIawv7eIBtHMAv7wBj8Gc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fan Guo <guofan5@huawei.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/131] RDMA/mad: Fix possible memory leak in ib_mad_post_receive_mads()
Date:   Mon, 29 Jun 2020 11:34:05 -0400
Message-Id: <20200629153502.2494656-75-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
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
index cd82134d517be..a36b3b4f5c0a2 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2920,6 +2920,7 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 						 DMA_FROM_DEVICE);
 		if (unlikely(ib_dma_mapping_error(qp_info->port_priv->device,
 						  sg_list.addr))) {
+			kfree(mad_priv);
 			ret = -ENOMEM;
 			break;
 		}
-- 
2.25.1

