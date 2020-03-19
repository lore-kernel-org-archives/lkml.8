Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED2C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816D720772
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623184;
	bh=tg4KSLlT4UUukes8K54LjRAKN0KEiCQaGJAx5zXBXQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u6oQLsiLJ1Lf4zOfBCM5pimHDtVfS62gEDfEnJd1l8VvRq6BlygrQ18BT0AgjfSsx
	 nuZmABmB/hqPZKNa0JY1+U8aFNYPGnLwXwW4syZMLAnsB775ayM8lVkSyrsd41mPZB
	 S5MiYtwpT3Yni4QT0ngl4hF7zVKpR3v8UCNgFfjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgCSNGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCSNGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:06:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E5A2076E;
        Thu, 19 Mar 2020 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623177;
        bh=tg4KSLlT4UUukes8K54LjRAKN0KEiCQaGJAx5zXBXQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3eJonBCU2R/UVjQxd305g7Jr/5ZVQxHFg3w/gKWU9eSdCKOz82G++b1PYvj2lvsK
         TY2oXf1Ys+FbbRMg4rh8K/nJ5Z9mbVHrGk4pM4S6tPJlaBOEpmXShNdq8HL+nwtjN7
         8/5lwnj7eyZTfcUf3euuif/AMQIRHyD4mG2leJqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 17/93] macvlan: add cond_resched() during multicast processing
Date:   Thu, 19 Mar 2020 13:59:21 +0100
Message-Id: <20200319123930.524401248@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit ce9a4186f9ac475c415ffd20348176a4ea366670 ]

The Rx bound multicast packets are deferred to a workqueue and
macvlan can also suffer from the same attack that was discovered
by Syzbot for IPvlan. This solution is not as effective as in
IPvlan. IPvlan defers all (Tx and Rx) multicast packet processing
to a workqueue while macvlan does this way only for the Rx. This
fix should address the Rx codition to certain extent.

Tx is still suseptible. Tx multicast processing happens when
.ndo_start_xmit is called, hence we cannot add cond_resched().
However, it's not that severe since the user which is generating
 / flooding will be affected the most.

Fixes: 412ca1550cbe ("macvlan: Move broadcasts into a work queue")
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macvlan.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -306,6 +306,8 @@ static void macvlan_process_broadcast(st
 		rcu_read_unlock();
 
 		kfree_skb(skb);
+
+		cond_resched();
 	}
 }
 


