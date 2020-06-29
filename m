Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE44C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6272220672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593459459;
	bh=9rqKrbzo3JjtzWA6Mdtnh6euWpF7uMzaUCbtORndMw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WGRmZuY0MOkDxH6qBLIyJunuCSB8Z0YMT8RVpKM9Pvllv9uUONqfZB7mNLYKQIY62
	 jD2RwZPyxp7NoPRy64NRn4/IVWiEA8zcZ2Fs6lF7efqSCUdr9dMtOyqAl8r6K5/AGR
	 XS1fGNGK20+1A2RiiIquo3OKVtNcYEt/xAb3u9kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbgF2Thi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733018AbgF2Tae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA0722520A;
        Mon, 29 Jun 2020 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444928;
        bh=9rqKrbzo3JjtzWA6Mdtnh6euWpF7uMzaUCbtORndMw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q0Z9FLMMhG0EmaNNGDT9fDSE/kMaW2e+eXWt5V1ZfQBqzAWIkV/MhM+N9go7YhHab
         guoceUEwKPYht+e86HfHREEcC4dlumtn481YHMSDu7f1R8uNouMcAfdXwc3Xm6alnG
         f0xmPvI4MQ1O/bjjgF1igZRNH/bPfF1sbXIM99Rw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 025/131] rocker: fix incorrect error handling in dma_rings_init
Date:   Mon, 29 Jun 2020 11:33:16 -0400
Message-Id: <20200629153502.2494656-26-sashal@kernel.org>
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

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 58d0c864e1a759a15c9df78f50ea5a5c32b3989e ]

In rocker_dma_rings_init, the goto blocks in case of errors
caused by the functions rocker_dma_cmd_ring_waits_alloc() and
rocker_dma_ring_create() are incorrect. The patch fixes the
order consistent with cleanup in rocker_dma_rings_fini().

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/rocker/rocker_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index aeafdb9ac015f..b13ab4eee4c73 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -651,10 +651,10 @@ static int rocker_dma_rings_init(struct rocker *rocker)
 err_dma_event_ring_bufs_alloc:
 	rocker_dma_ring_destroy(rocker, &rocker->event_ring);
 err_dma_event_ring_create:
+	rocker_dma_cmd_ring_waits_free(rocker);
+err_dma_cmd_ring_waits_alloc:
 	rocker_dma_ring_bufs_free(rocker, &rocker->cmd_ring,
 				  PCI_DMA_BIDIRECTIONAL);
-err_dma_cmd_ring_waits_alloc:
-	rocker_dma_cmd_ring_waits_free(rocker);
 err_dma_cmd_ring_bufs_alloc:
 	rocker_dma_ring_destroy(rocker, &rocker->cmd_ring);
 	return err;
-- 
2.25.1

