Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A33C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE96120738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262233;
	bh=c9AkEOt9bcvgiy0QtcxTOZ0AT/fea3hLXHb8UK7DReg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M9JqZabFkMTrXECHKdiq8w0RDFvtKuRW7nc/Bd46iKW6snQQUed+jIUGsTwKMQRyy
	 +1WQwfahFQ62rQpm4I8NpXcmg+LCjgD1Mz6RjHMaCYGxCngyLvzTYk3+AXZ5ideH97
	 XrDHhvtI1rucwGaroi1c7Hw7wHT7g6INYYS/3ZJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgHXJnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgHXInu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:43:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C0121741;
        Mon, 24 Aug 2020 08:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258628;
        bh=c9AkEOt9bcvgiy0QtcxTOZ0AT/fea3hLXHb8UK7DReg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECiv4OQDot7V6A5SAVWIY9YK2eLPElhuny3vpqp2FNge5LSFqLm1rw3+SSn6MEqBX
         yNpjYBBTp1YzXLU0J4Ye0kqZT0Ywbz4GaiNPaPfV7X4g4XzO6Cx35zFWNIkTdCipiO
         YkDSOl1TTuSwThB/fPkjaShVIbjTHtQNry+92HNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 114/124] hv_netvsc: Fix the queue_mapping in netvsc_vf_xmit()
Date:   Mon, 24 Aug 2020 10:30:48 +0200
Message-Id: <20200824082415.012823015@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
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
index b8b7fc13b3dc4..016fec19063a5 100644
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



