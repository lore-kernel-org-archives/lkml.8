Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C10C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22823206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262853;
	bh=mI8PfatD0ZZBAb5FsZokIJrZwsYttyYOdG8c0l1e0wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sbZXgY9CQ/GquDM3G0ORHCWP5tE50vmZzDg6HwsEekldGV5OY1Ejik6mJvUPNlszE
	 991SOA8bnawaF77oy0VciokwefFFy35BgJViY6bFQF+GLVH3xpSLJabrtBBnD7NC3c
	 pYBB/pSFNbP+m71QR5P2Nf1p90CUeYt8TEqR877E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgHXJyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgHXIhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:37:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF4012177B;
        Mon, 24 Aug 2020 08:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258271;
        bh=mI8PfatD0ZZBAb5FsZokIJrZwsYttyYOdG8c0l1e0wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iaAO/Fy5p0H/6/wjAeUdphMYf40ktmUR367VBb8F32yQV6pVcLEEMiUlp9qxt62JN
         jLnlCnlRqXBbxbUTOebX+1TJzqt6eHja5RBfFcAGuICCnY8qRQ8+YqmiX2ejWsSYpW
         eiRs1HDdVsE811lcivOzvtsEXhtOJW13YTBogGZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 137/148] hv_netvsc: Fix the queue_mapping in netvsc_vf_xmit()
Date:   Mon, 24 Aug 2020 10:30:35 +0200
Message-Id: <20200824082420.580231930@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit c3d897e01aef8ddc43149e4d661b86f823e3aae7 ]

netvsc_vf_xmit() / dev_queue_xmit() will call VF NIC’s ndo_select_queue
or netdev_pick_tx() again. They will use skb_get_rx_queue() to get the
queue number, so the “skb->queue_mapping - 1” will be used. This may
cause the last queue of VF not been used.

Use skb_record_rx_queue() here, so that the skb_get_rx_queue() called
later will get the correct queue number, and VF will be able to use
all queues.

Fixes: b3bf5666a510 ("hv_netvsc: defer queue selection to VF")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 0d779bba1b019..6b81c04ab5e29 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -502,7 +502,7 @@ static int netvsc_vf_xmit(struct net_device *net, struct net_device *vf_netdev,
 	int rc;
 
 	skb->dev = vf_netdev;
-	skb->queue_mapping = qdisc_skb_cb(skb)->slave_dev_queue_mapping;
+	skb_record_rx_queue(skb, qdisc_skb_cb(skb)->slave_dev_queue_mapping);
 
 	rc = dev_queue_xmit(skb);
 	if (likely(rc == NET_XMIT_SUCCESS || rc == NET_XMIT_CN)) {
-- 
2.25.1



