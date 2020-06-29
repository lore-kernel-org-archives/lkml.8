Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62AAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17282067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459066;
	bh=sao9ckKzaUK23sbUv/2l4EGHfrcnXMsFqHg7IfOOGOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+CbB8sqSIibsmO9s15PbsgVZje15k7Mc8yJpPR9+wEdP+a40tyTd5wJmVDllLYx3
	 vqxukOJmuiql6xHVmkKGBnrPeVLBJp6160H/qxlFmsa070qV6pXL6/g4/c8KW+nhtp
	 Z1JDqv2HX4NaE6cl55OxchEW6iMbpsDgIB1c1H8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbgF2TbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732987AbgF2Tab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8790425310;
        Mon, 29 Jun 2020 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445140;
        bh=sao9ckKzaUK23sbUv/2l4EGHfrcnXMsFqHg7IfOOGOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RUwMS93IoFbcqD/nhRShiV3b9liL/e/an9uGv1iejzgk1vFZ8MveplYnAvrfvSg7X
         HUI7GN35NfdVwcbruZLWdp9RQmW4TaFyc+lXUQhqNYFU7sZGgwEdf9DiHDR5XSByH2
         4sAyQWdCvMpAaf+FA/3tGa4+tYVeY0bzljbgHi9Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fan Guo <guofan5@huawei.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 45/78] RDMA/mad: Fix possible memory leak in ib_mad_post_receive_mads()
Date:   Mon, 29 Jun 2020 11:37:33 -0400
Message-Id: <20200629153806.2494953-46-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153806.2494953-1-sashal@kernel.org>
References: <20200629153806.2494953-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.186-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.186-rc1
X-KernelTest-Deadline: 2020-07-01T15:38+00:00
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
index 6072ac7023cb7..08d2e9cc28eb4 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2907,6 +2907,7 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 						 DMA_FROM_DEVICE);
 		if (unlikely(ib_dma_mapping_error(qp_info->port_priv->device,
 						  sg_list.addr))) {
+			kfree(mad_priv);
 			ret = -ENOMEM;
 			break;
 		}
-- 
2.25.1

