Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E4FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFBD2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864687;
	bh=3NiqEoj2Y5pVgGxdEdDMggCoFAh4dCge3GczTBOPzQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xzMELLw+dyI2kP+MNriwLAuGm+Zk/x7yKIyxYzzvcTw/sv5d+6pOLk7dqftPLGDG4
	 YHDbuwsnYT3PRKbEl4PKAP2MC0kyXHF22pQvEa5PA6JMo7/wrHv1JwtOSK88OM2qTq
	 Rfb/0ZmUvXITosA6MTiq8vGBDRHGd93o5m6pTHUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbgAXLSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:18:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390583AbgAXLSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:18:00 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A14720708;
        Fri, 24 Jan 2020 11:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864679;
        bh=3NiqEoj2Y5pVgGxdEdDMggCoFAh4dCge3GczTBOPzQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0V1hV73wvLAQr8qwyi8Tf3swvK2icfBbAwLf9LcP/3qD8kw/8W4+ka/Su22iCa/YE
         SrQ6lpA7P5sP0/FmM3ETxiVe3gpJfVh6ycb9J5K+gO9lofJ6SyVsy9f6RHjFuBVOHK
         lGSbZtkAcL0MUCIvNpn+HHJ5RLCL1g/wriwpe2xw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 335/639] netfilter: nft_flow_offload: add entry to flowtable after confirmation
Date:   Fri, 24 Jan 2020 10:28:25 +0100
Message-Id: <20200124093129.078918958@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 270a8a297f42ecff82060aaa53118361f09c1f7d ]

This is fixing flow offload for UDP traffic where packets only follow
one single direction.

The flow_offload_fixup_tcp() mechanism works fine in case that the
offloaded entry remains in SYN_RECV state, given sequence tracking is
reset and that conntrack handles syn+ack packets as a retransmission, ie.

	sES + synack => sIG

for reply traffic.

Fixes: a3c90f7a2323 ("netfilter: nf_tables: flow offload expression")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_flow_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 1ef8cb789c41a..166edea0e4527 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -103,8 +103,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	    ct->status & IPS_SEQ_ADJUST)
 		goto out;
 
-	if (ctinfo == IP_CT_NEW ||
-	    ctinfo == IP_CT_RELATED)
+	if (!nf_ct_is_confirmed(ct))
 		goto out;
 
 	if (test_and_set_bit(IPS_OFFLOAD_BIT, &ct->status))
-- 
2.20.1



