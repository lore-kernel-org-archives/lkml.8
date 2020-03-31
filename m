Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20217208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646239;
	bh=mga9ZlB7EBqybPtMS1PRXb7f40tCX4Df5PKMdx1hR/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m+XRVjYJU3y9OAGJ2Iky2YWwBJPbXUTxDb39bwNXrb6PtsDOwLtB89RynPl6fRvWg
	 X2jjT0RIQsQnGOlwvz6yQWdi1Uiz6M+SSDT5KXj+6PS0KR/fiBav9lbZG+EJ+/nKEn
	 tGp3QwSAF4d7/lUK7Quk4AVs+KezdHSmyzE65F0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbgCaJRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731537AbgCaJRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:17:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 717D4208E0;
        Tue, 31 Mar 2020 09:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646235;
        bh=mga9ZlB7EBqybPtMS1PRXb7f40tCX4Df5PKMdx1hR/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnxzxCBp64hyXARPcgEq+2Pky0OxsgncMO3UPJ1oRO+t0Hna+LBmSPuikPNWxhcZN
         8z7eiegExZAB3QhWFK5Q6nwy2dU/aWugv60KXUcp2MCbpptZ1yMaL2oeBF+vKyi282
         k4EkjsRFGYk8jEEuQkxTVi8umRls4cchHhXG4ZkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 125/155] netfilter: nft_fwd_netdev: validate family and chain type
Date:   Tue, 31 Mar 2020 10:59:25 +0200
Message-Id: <20200331085432.363210376@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 76a109fac206e158eb3c967af98c178cff738e6a upstream.

Make sure the forward action is only used from ingress.

Fixes: 39e6dea28adc ("netfilter: nf_tables: add forward expression to the netdev family")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_fwd_netdev.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -190,6 +190,13 @@ nla_put_failure:
 	return -1;
 }
 
+static int nft_fwd_validate(const struct nft_ctx *ctx,
+			    const struct nft_expr *expr,
+			    const struct nft_data **data)
+{
+	return nft_chain_validate_hooks(ctx->chain, (1 << NF_NETDEV_INGRESS));
+}
+
 static struct nft_expr_type nft_fwd_netdev_type;
 static const struct nft_expr_ops nft_fwd_neigh_netdev_ops = {
 	.type		= &nft_fwd_netdev_type,
@@ -197,6 +204,7 @@ static const struct nft_expr_ops nft_fwd
 	.eval		= nft_fwd_neigh_eval,
 	.init		= nft_fwd_neigh_init,
 	.dump		= nft_fwd_neigh_dump,
+	.validate	= nft_fwd_validate,
 };
 
 static const struct nft_expr_ops nft_fwd_netdev_ops = {
@@ -205,6 +213,7 @@ static const struct nft_expr_ops nft_fwd
 	.eval		= nft_fwd_netdev_eval,
 	.init		= nft_fwd_netdev_init,
 	.dump		= nft_fwd_netdev_dump,
+	.validate	= nft_fwd_validate,
 	.offload	= nft_fwd_netdev_offload,
 };
 


