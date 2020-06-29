Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39A3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31B22065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461752;
	bh=e2QNlmsuQpPKWy51VFelmbUXLW8vI9Bet605hJcGwOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYmP+tdIZzCPiCj/XfxaTO/3SsOVjEox/Y36WrDN8x3ZzSTbeIH+Pg8YlW+1SqCcr
	 BIR2x3RTTv/fQhi6Id3KHhukaPTaFEIz4a/d3aVhkuN2PwGs0k9nc202Xwg3Rn2U2F
	 MUCYvlSY4OJ+Hjek25eilLYKCI753iCtbvd9xXG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbgF2UPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732821AbgF2TaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1956425243;
        Mon, 29 Jun 2020 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444960;
        bh=e2QNlmsuQpPKWy51VFelmbUXLW8vI9Bet605hJcGwOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lX3h5/+AgpPMo2oorRuCzuAPUG5Xi3yZgFW26yxyu2LC61YVkqMRRvWMiemVuyrFK
         EuD5lk/CTrToJJdbzUHrySq+S1ha3e0WgoldsbnJTEstDdMZiZxzML3AKGGm6af7VF
         wec0xhofIlFddwV0mM/M2zDL1NShCtPo+SdEHYuM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shay Drory <shayd@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 058/131] IB/mad: Fix use after free when destroying MAD agent
Date:   Mon, 29 Jun 2020 11:33:49 -0400
Message-Id: <20200629153502.2494656-59-sashal@kernel.org>
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

From: Shay Drory <shayd@mellanox.com>

commit 116a1b9f1cb769b83e5adff323f977a62b1dcb2e upstream.

Currently, when RMPP MADs are processed while the MAD agent is destroyed,
it could result in use after free of rmpp_recv, as decribed below:

	cpu-0						cpu-1
	-----						-----
ib_mad_recv_done()
 ib_mad_complete_recv()
  ib_process_rmpp_recv_wc()
						unregister_mad_agent()
						 ib_cancel_rmpp_recvs()
						  cancel_delayed_work()
   process_rmpp_data()
    start_rmpp()
     queue_delayed_work(rmpp_recv->cleanup_work)
						  destroy_rmpp_recv()
						   free_rmpp_recv()
     cleanup_work()[1]
      spin_lock_irqsave(&rmpp_recv->agent->lock) <-- use after free

[1] cleanup_work() == recv_cleanup_handler

Fix it by waiting for the MAD agent reference count becoming zero before
calling to ib_cancel_rmpp_recvs().

Fixes: 9a41e38a467c ("IB/mad: Use IDR for agent IDs")
Link: https://lore.kernel.org/r/20200621104738.54850-2-leon@kernel.org
Signed-off-by: Shay Drory <shayd@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/mad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 218411282069b..cd82134d517be 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -615,10 +615,10 @@ static void unregister_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
 	idr_unlock(&ib_mad_clients);
 
 	flush_workqueue(port_priv->wq);
-	ib_cancel_rmpp_recvs(mad_agent_priv);
 
 	deref_mad_agent(mad_agent_priv);
 	wait_for_completion(&mad_agent_priv->comp);
+	ib_cancel_rmpp_recvs(mad_agent_priv);
 
 	ib_mad_agent_security_cleanup(&mad_agent_priv->agent);
 
-- 
2.25.1

