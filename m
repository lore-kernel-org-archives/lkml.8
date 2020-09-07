Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4FCC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4A9208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497324;
	bh=OYWucVYP7dD+UA/1BSwGw/P5H+lgPztv1OB0A580bek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N2OB77M38J8vpMMCfQ1bwftCgwmBfSVfOyeZ5XMKa6/9bML28wLMP5zEvX1E8Sb6b
	 cUXRanPwFU/iU06u5DjX6ayYCmlhRafQThMe0BOPXTkR7/h/nzaCvQidZUmryrEiLa
	 jfCoHxPo7yR1YC7NPtuzSWTmjWW/8TAGZDkonfpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgIGQsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730818AbgIGQfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:35:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9918021D82;
        Mon,  7 Sep 2020 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496510;
        bh=OYWucVYP7dD+UA/1BSwGw/P5H+lgPztv1OB0A580bek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZmy+VmjNbAK4KMz1R8KI5QwrOSSrBAkx5nTthTzbPJlnAheb7dS2bgqbENx080bV
         h11aB5baxkLYvsnCbEqUfe5EfCMtI+NuH5qSAp/79M8Wrbx1o4SIojQr58T8XzHYoG
         Bk2a2KpQHxmWAsGCJ3qK1HPJdHkWM4/GgFITqAkA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xie He <xie.he.0141@gmail.com>, Martin Schiller <ms@dev.tdt.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/17] drivers/net/wan/lapbether: Set network_header before transmitting
Date:   Mon,  7 Sep 2020 12:34:50 -0400
Message-Id: <20200907163500.1281543-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163500.1281543-1-sashal@kernel.org>
References: <20200907163500.1281543-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie He <xie.he.0141@gmail.com>

[ Upstream commit 91244d108441013b7367b3b4dcc6869998676473 ]

Set the skb's network_header before it is passed to the underlying
Ethernet device for transmission.

This patch fixes the following issue:

When we use this driver with AF_PACKET sockets, there would be error
messages of:
   protocol 0805 is buggy, dev (Ethernet interface name)
printed in the system "dmesg" log.

This is because skbs passed down to the Ethernet device for transmission
don't have their network_header properly set, and the dev_queue_xmit_nit
function in net/core/dev.c complains about this.

Reason of setting the network_header to this place (at the end of the
Ethernet header, and at the beginning of the Ethernet payload):

Because when this driver receives an skb from the Ethernet device, the
network_header is also set at this place.

Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/lapbether.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 6b2553e893aca..15177a54b17d7 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -213,6 +213,8 @@ static void lapbeth_data_transmit(struct net_device *ndev, struct sk_buff *skb)
 
 	skb->dev = dev = lapbeth->ethdev;
 
+	skb_reset_network_header(skb);
+
 	dev_hard_header(skb, dev, ETH_P_DEC, bcast_addr, NULL, 0);
 
 	dev_queue_xmit(skb);
-- 
2.25.1

