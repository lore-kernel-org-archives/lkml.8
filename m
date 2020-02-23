Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C308C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138392067D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425086;
	bh=d3tCGsaHvyFa1WvXXX3zicSLN3cuLKdXuBZl6y3jaP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0wAb4Y+SsEZK+4/2hUPgOfLMjR2UurXa3cc+/Nsh/6/QfsZk30HIIGQGjD0sNsnJZ
	 22hF9uhKrv0any9QIKXYvXvq5ix04/9EcmQ2qQsoPk4vN3af9amQGOBA4Dxmqj1sKx
	 BNcMutEkWPduS6hmgle0cpi7iq6gLRKHHhPnfb40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgBWCbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:31:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbgBWCXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:23:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83A0420702;
        Sun, 23 Feb 2020 02:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424604;
        bh=d3tCGsaHvyFa1WvXXX3zicSLN3cuLKdXuBZl6y3jaP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+MQntf7+ywdkliffpA0ftSOuwQvzUuspg8T09gWL8OttdRUvL6jazClqV8jVpvVg
         6nHlpBU3yA2N+lZP/tfWbB+KuZNJ2axh65PzXjZbr9OQlWPuyDSCeae0soebv4BRLt
         CpfaLVMswNOa+FzKhAYR5Gfy7CG3PkQU1ewzNPXU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Firo Yang <firo.yang@suse.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 40/50] enic: prevent waking up stopped tx queues over watchdog reset
Date:   Sat, 22 Feb 2020 21:22:25 -0500
Message-Id: <20200223022235.1404-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022235.1404-1-sashal@kernel.org>
References: <20200223022235.1404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Firo Yang <firo.yang@suse.com>

[ Upstream commit 0f90522591fd09dd201065c53ebefdfe3c6b55cb ]

Recent months, our customer reported several kernel crashes all
preceding with following message:
NETDEV WATCHDOG: eth2 (enic): transmit queue 0 timed out
Error message of one of those crashes:
BUG: unable to handle kernel paging request at ffffffffa007e090

After analyzing severl vmcores, I found that most of crashes are
caused by memory corruption. And all the corrupted memory areas
are overwritten by data of network packets. Moreover, I also found
that the tx queues were enabled over watchdog reset.

After going through the source code, I found that in enic_stop(),
the tx queues stopped by netif_tx_disable() could be woken up over
a small time window between netif_tx_disable() and the
napi_disable() by the following code path:
napi_poll->
  enic_poll_msix_wq->
     vnic_cq_service->
        enic_wq_service->
           netif_wake_subqueue(enic->netdev, q_number)->
              test_and_clear_bit(__QUEUE_STATE_DRV_XOFF, &txq->state)
In turn, upper netowrk stack could queue skb to ENIC NIC though
enic_hard_start_xmit(). And this might introduce some race condition.

Our customer comfirmed that this kind of kernel crash doesn't occur over
90 days since they applied this patch.

Signed-off-by: Firo Yang <firo.yang@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index acb2856936d20..6e2ab10ad2e6f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2013,10 +2013,10 @@ static int enic_stop(struct net_device *netdev)
 		napi_disable(&enic->napi[i]);
 
 	netif_carrier_off(netdev);
-	netif_tx_disable(netdev);
 	if (vnic_dev_get_intr_mode(enic->vdev) == VNIC_DEV_INTR_MODE_MSIX)
 		for (i = 0; i < enic->wq_count; i++)
 			napi_disable(&enic->napi[enic_cq_wq(enic, i)]);
+	netif_tx_disable(netdev);
 
 	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
 		enic_dev_del_station_addr(enic);
-- 
2.20.1

