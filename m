Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17FFC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD7520663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584444124;
	bh=Xm8Z014pk2x8VwaGlzsmRLXltETeKcYWHoTM1dlIbYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NsCBOlzzhGnCjhAP/wqyH2wU5TDhvyk8lf90rnodXpEp8N7P17nL2hsz/G9V0vsBu
	 UXwqSYoh8JeBBMh6rY2Ak436Wdo2HoPRVeMnz9E7ldau8ZhPgq4udrwXhhz6f0gZ3c
	 ZjVKIAdneqA/zHG4Ub127YPO0aYABUIM8MNedsXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgCQK5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgCQK52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:57:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7A582076E;
        Tue, 17 Mar 2020 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442648;
        bh=Xm8Z014pk2x8VwaGlzsmRLXltETeKcYWHoTM1dlIbYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xr4ltx8jzj0L45Phr5DOiv++uY/GwYwezFlNV12Vw87lF96TAZzgjbqyZurJAnk03
         2tykZtAtvO2Su3ReaHWbCsvI/hsBTMoV56K0b9ocdLyoOJlmB/9NQ8uE0OD5HNcnMt
         PqGXDLmbIc6kBatPx88zKD+TvuSIWTzBXjY0DcZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 09/89] ipvlan: do not use cond_resched_rcu() in ipvlan_process_multicast()
Date:   Tue, 17 Mar 2020 11:54:18 +0100
Message-Id: <20200317103300.940961121@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
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
@@ -282,7 +282,6 @@ void ipvlan_process_multicast(struct wor
 			}
 			ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, true);
 			local_bh_enable();
-			cond_resched_rcu();
 		}
 		rcu_read_unlock();
 
@@ -299,6 +298,7 @@ void ipvlan_process_multicast(struct wor
 		}
 		if (dev)
 			dev_put(dev);
+		cond_resched();
 	}
 }
 


