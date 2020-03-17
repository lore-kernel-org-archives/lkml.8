Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F535C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390FC205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443869;
	bh=Fsxsh6GAc/7ZsxzmgKx/2MhbtT42qSKJ3sGzD4I6uAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fxl/WPfiR6eZpkirdh0aSXkKmE2xLhmlTb0+Swt25HT6rx3aL8E6kIU4Xea83EybA
	 OgYnv7k8yuy1h4M08yN0ZAdaI8ucwkjLEu+zunaosMskINFIYQ3DUBPw6k369Ox2mL
	 v37i20qi7hPQcjEO+Ptp++uT5nDn0WX1WTzU+HwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgCQLRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbgCQLGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:06:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19780206EC;
        Tue, 17 Mar 2020 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443215;
        bh=Fsxsh6GAc/7ZsxzmgKx/2MhbtT42qSKJ3sGzD4I6uAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0pysjaIeh2JxPeO+oh3bupW5F6VMUXoUexl/JX5nZmIR57a64zaNzPjXucIrEcN4
         af5/shCW303Rxz1YKYjKTXe0Q35xqATt+baYWEmmlmCI818l933pyixXYivOA+HlD5
         1dKtDnPK8nN6dAMStm+uYOcVWPLcppjbo1C5jtB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 012/151] ipvlan: do not use cond_resched_rcu() in ipvlan_process_multicast()
Date:   Tue, 17 Mar 2020 11:53:42 +0100
Message-Id: <20200317103327.320832388@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
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
@@ -277,7 +277,6 @@ void ipvlan_process_multicast(struct wor
 			}
 			ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, true);
 			local_bh_enable();
-			cond_resched_rcu();
 		}
 		rcu_read_unlock();
 
@@ -294,6 +293,7 @@ void ipvlan_process_multicast(struct wor
 		}
 		if (dev)
 			dev_put(dev);
+		cond_resched();
 	}
 }
 


