Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48025C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132592080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498666;
	bh=DwG1sBgFRudgjt/efP3AlPsg1CgNduDPpdP1AxBu/t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r0mV6zejgbz7VbTKwcsCyCTqpa1GaL09RN511N+eFnpQnjjHZ4UAehHzpwQhFbBZK
	 p/JIEibICqd4JGCMb1T1st8GDZ2BP+gusLg/cLt8RCZiLJep317kALuN0HvfgjPokL
	 8w9/JwBqjbo5eYDXmJBSwkfCDLgV7S1u4cy2qnog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbgIGRLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730651AbgIGQcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:32:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D6FC21775;
        Mon,  7 Sep 2020 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496363;
        bh=DwG1sBgFRudgjt/efP3AlPsg1CgNduDPpdP1AxBu/t0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+oSb1FMUspk4XShV/zVB4+McsZuKkMvtpU8kzUU5tl4SCRepFNjYWxmEvoPZDQxZ
         ODblMfbn5GvmTTYLbbdP8UHHcxV0rqhF0Fyp4SsldMgsdwdU0LGjNPZRA4dR33eF1A
         I3mHsSOsPfBFpoQsH+7e3HYxyi0cY39W99TnaBgE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xie He <xie.he.0141@gmail.com>, Martin Schiller <ms@dev.tdt.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 17/53] drivers/net/wan/lapbether: Set network_header before transmitting
Date:   Mon,  7 Sep 2020 12:31:43 -0400
Message-Id: <20200907163220.1280412-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
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
index cc297ea9c6ece..e61616b0b91c7 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -210,6 +210,8 @@ static void lapbeth_data_transmit(struct net_device *ndev, struct sk_buff *skb)
 
 	skb->dev = dev = lapbeth->ethdev;
 
+	skb_reset_network_header(skb);
+
 	dev_hard_header(skb, dev, ETH_P_DEC, bcast_addr, NULL, 0);
 
 	dev_queue_xmit(skb);
-- 
2.25.1

