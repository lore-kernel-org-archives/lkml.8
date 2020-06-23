Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD96C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7D320702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945570;
	bh=KXNT2BGgxLyfWbI/dMW1t1lIfe+k9Gw1cvEYm9KvZbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eHZUpRdV1MOI24FGNyPcwkNxkWZR0Y1/aRz2mCB2rti3fIV8q2bE/JYPO6mjlA4TG
	 oBUWEZrVBzCKE5EdabPJSnhhmalwRb9C5fHJX4eBKad5b9HM/sdweQYwRJHil/YohI
	 jy42rqMDkQ6I7kykmaCZLvo8lWbnGjRtbOvxw3JA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391813AbgFWUws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392359AbgFWUrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:47:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB03321548;
        Tue, 23 Jun 2020 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945237;
        bh=KXNT2BGgxLyfWbI/dMW1t1lIfe+k9Gw1cvEYm9KvZbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aehq64tziRogofQ9ydJc7h7eva8uU+zec/v57Ziz9NmdJKY2oSk6IoOA+YhW1IwaH
         KeBQuTMMaKvn5UPyvZQFHFNGiuxNcxluukvRvMsFs0Kov2oGAZ8Er+VQEbsf+veOhk
         lH0ntjXwT4xg22chRyosms7q/h7/2BOuCv58U3wA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 092/136] geneve: change from tx_error to tx_dropped on missing metadata
Date:   Tue, 23 Jun 2020 21:59:08 +0200
Message-Id: <20200623195308.293838166@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Benc <jbenc@redhat.com>

[ Upstream commit 9d149045b3c0e44c049cdbce8a64e19415290017 ]

If the geneve interface is in collect_md (external) mode, it can't send any
packets submitted directly to its net interface, as such packets won't have
metadata attached. This is expected.

However, the kernel itself sends some packets to the interface, most
notably, IPv6 DAD, IPv6 multicast listener reports, etc. This is not wrong,
as tunnel metadata can be specified in routing table (although technically,
that has never worked for IPv6, but hopefully will be fixed eventually) and
then the interface must correctly participate in IPv6 housekeeping.

The problem is that any such attempt increases the tx_error counter. Just
bringing up a geneve interface with IPv6 enabled is enough to see a number
of tx_errors. That causes confusion among users, prompting them to find
a network error where there is none.

Change the counter used to tx_dropped. That better conveys the meaning
(there's nothing wrong going on, just some packets are getting dropped) and
hopefully will make admins panic less.

Signed-off-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/geneve.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 6d3fa36b16160..3c9f8770f7e78 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -915,9 +915,10 @@ static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (geneve->collect_md) {
 		info = skb_tunnel_info(skb);
 		if (unlikely(!info || !(info->mode & IP_TUNNEL_INFO_TX))) {
-			err = -EINVAL;
 			netdev_dbg(dev, "no tunnel metadata\n");
-			goto tx_error;
+			dev_kfree_skb(skb);
+			dev->stats.tx_dropped++;
+			return NETDEV_TX_OK;
 		}
 	} else {
 		info = &geneve->info;
@@ -934,7 +935,7 @@ static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (likely(!err))
 		return NETDEV_TX_OK;
-tx_error:
+
 	dev_kfree_skb(skb);
 
 	if (err == -ELOOP)
-- 
2.25.1



