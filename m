Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A896BC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AD4208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623486;
	bh=cllkRC3cSCiVLdhUYjcuFQo53vQ1VHyJF83NY7CGG7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SHx2OHm/tX7+N0DGc19azvvniMEpW1029+K+6CdDiS0S8DfsOUlSM7j8smtmJamV9
	 oGJBeTD6w9/V4Qmu4Ro7iwUrykWyOyu7s62KruyHpWf6lnre9QjUQa7WJc2h72JwNi
	 EE7jfQmisp5wGpndC2l6udkPZSqlYHWdObcJbTHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgCSNLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbgCSNLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:11:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03FD2208D6;
        Thu, 19 Mar 2020 13:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623482;
        bh=cllkRC3cSCiVLdhUYjcuFQo53vQ1VHyJF83NY7CGG7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVdaNUcPcxoI4iv7zOOZZKdfXbJ3+lfjMW+FOdRKnpoVlf/XlMUZxFGOTdxDe6Bi9
         5VHb7e8TS5HwlJp31xrBiKFAuK1lTEUKbFBjjBXNM1mKuMti8vOdTV67PeIOU7COfp
         zJBX/0z4oQyOHKE6AcMlo11x+fx1YfZe7RlFwgWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 23/90] ipvlan: do not use cond_resched_rcu() in ipvlan_process_multicast()
Date:   Thu, 19 Mar 2020 13:59:45 +0100
Message-Id: <20200319123935.781583849@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123928.635114118@linuxfoundation.org>
References: <20200319123928.635114118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit afe207d80a61e4d6e7cfa0611a4af46d0ba95628 ]

Commit e18b353f102e ("ipvlan: add cond_resched_rcu() while
processing muticast backlog") added a cond_resched_rcu() in a loop
using rcu protection to iterate over slaves.

This is breaking rcu rules, so lets instead use cond_resched()
at a point we can reschedule

Fixes: e18b353f102e ("ipvlan: add cond_resched_rcu() while processing muticast backlog")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ipvlan/ipvlan_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -240,7 +240,6 @@ void ipvlan_process_multicast(struct wor
 				ret = netif_rx(nskb);
 acct:
 			ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, true);
-			cond_resched_rcu();
 		}
 		rcu_read_unlock();
 
@@ -252,6 +251,7 @@ acct:
 		} else {
 			kfree_skb(skb);
 		}
+		cond_resched();
 	}
 }
 


