Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B8C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A3F20722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623437;
	bh=wU4NwJ9NUvMKV0MNxtBjjwGZ2yBWqq14jFkBzOlrpuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nGIqrVXiEunwLfhr200MEHR3hD19J4KFbp+E7oyb0smw85xuUd09olKvZoAEiL5JV
	 UI05buVzp3S4YUVVbLhetmC6ElztqLzWg/nSiQ8RI/qiKO+LX/dcKfsWM6qmfitS3L
	 wNWRO9JidGLZSUoJN4+yDPqH1fSMdZfcEDke7//0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCSNKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbgCSNKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:10:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DCF0215A4;
        Thu, 19 Mar 2020 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623432;
        bh=wU4NwJ9NUvMKV0MNxtBjjwGZ2yBWqq14jFkBzOlrpuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ga9ctHBG18IsBVEz+YYeeeiopkDPjufLz5Wea8HBDh/YKGsj5yOD2xk1VBKC1ZMJ0
         mFlB/lEk19rF95hZi4JGWtkDqqgmsB4o29NlTassdFfCM12CfuiJMFGon/bIcS75Hl
         FcQGyAvF3xN8wJnwuhTQBiLhskB7vSIeEONLtUM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 25/90] macvlan: add cond_resched() during multicast processing
Date:   Thu, 19 Mar 2020 13:59:47 +0100
Message-Id: <20200319123936.326467399@linuxfoundation.org>
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
@@ -309,6 +309,8 @@ static void macvlan_process_broadcast(st
 		if (src)
 			dev_put(src->dev);
 		kfree_skb(skb);
+
+		cond_resched();
 	}
 }
 


