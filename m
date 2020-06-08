Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E603EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B1A2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661310;
	bh=p1wM2NM1idP8WzPTc5gRJuze3vYXKEUCpSW95/QBnjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UHaaBgAj0woBSf8uVJbEgK+Qqyr6+2q2/ulhWRGtg58ojiD719SQx4QbjWcD60rkP
	 ETdN22rNX31DEccbxd9Fcxrc/LN6X2qPH06qu/QobecAcVhfqLi+qdUjb1srX4KGxo
	 Qae0ttv6Cz88/esR79xhOThCmNmPduvG7OYuW+gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbgFIAI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbgFHXUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B1A520897;
        Mon,  8 Jun 2020 23:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658438;
        bh=p1wM2NM1idP8WzPTc5gRJuze3vYXKEUCpSW95/QBnjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6fMoUq+OD3yFJsQY59F5n+Bee2GXkrfq0d6m6MbNE5UnEjOqNG/BxnKEKTPv5PiA
         Hg4P/2VhniUvAtS1VXTGpCLoTTAJKSEgAj1rgHixkpvOJAU5XHsXs7ANhP39KU74cN
         IWBTxY6HsbhX1zK5FCOV7HN35qttujTelxV0X72U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 081/175] dpaa2-eth: fix return codes used in ndo_setup_tc
Date:   Mon,  8 Jun 2020 19:17:14 -0400
Message-Id: <20200608231848.3366970-81-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit b89c1e6bdc73f5775e118eb2ab778e75b262b30c ]

Drivers ndo_setup_tc call should return -EOPNOTSUPP, when it cannot
support the qdisc type. Other return values will result in failing the
qdisc setup.  This lead to qdisc noop getting assigned, which will
drop all TX packets on the interface.

Fixes: ab1e6de2bd49 ("dpaa2-eth: Add mqprio support")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index a935b20effa3..3177dd8ede8e 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1981,7 +1981,7 @@ static int dpaa2_eth_setup_tc(struct net_device *net_dev,
 	int i;
 
 	if (type != TC_SETUP_QDISC_MQPRIO)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	mqprio->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
 	num_queues = dpaa2_eth_queue_count(priv);
@@ -1993,7 +1993,7 @@ static int dpaa2_eth_setup_tc(struct net_device *net_dev,
 	if (num_tc  > dpaa2_eth_tc_count(priv)) {
 		netdev_err(net_dev, "Max %d traffic classes supported\n",
 			   dpaa2_eth_tc_count(priv));
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	if (!num_tc) {
-- 
2.25.1

