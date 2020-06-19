Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504BEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC1E217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578170;
	bh=rCItgz97uH/w6p0rQznSJvlK8/pyJWrkWMPE1BU7KS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pEjU5kZmk6iqUib/KLUAd60AHBQXfiQkEIjw+3aU0ahAj9z74L/S2ZShRXHwyC4zQ
	 oooV6YzpxoZLeGtw9tTP048CYXMievQkA2EXaFj064apzZt4n/cOzalddUBxpe8O+o
	 hKOjj7CEl52M7d+LCWJM6cTfOrX0qCEuwJOxxvZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbgFSOt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389192AbgFSOtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:49:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66306217BA;
        Fri, 19 Jun 2020 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578157;
        bh=rCItgz97uH/w6p0rQznSJvlK8/pyJWrkWMPE1BU7KS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0+3YUvACA4H+9+DKZDjvGAIE9WNjoT0nkUnyW7b1K+3VnIV7gkt3aXJkme/Kb571
         Uv86AL5WbAEoxIXgcwgB71byrAnoza0HBEVCI+Hxesr9lskmp/P6QumOXN29hRqUUi
         NOdGiizz//SWU+099YzDrKPhrmnecixooBm354ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 105/190] netfilter: nft_nat: return EOPNOTSUPP if type or flags are not supported
Date:   Fri, 19 Jun 2020 16:32:30 +0200
Message-Id: <20200619141638.835664557@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 0d7c83463fdf7841350f37960a7abadd3e650b41 ]

Instead of EINVAL which should be used for malformed netlink messages.

Fixes: eb31628e37a0 ("netfilter: nf_tables: Add support for IPv6 NAT")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_nat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index ed548d06b6dd..a18cceecef88 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -135,7 +135,7 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		priv->type = NF_NAT_MANIP_DST;
 		break;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	if (tb[NFTA_NAT_FAMILY] == NULL)
@@ -202,7 +202,7 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	if (tb[NFTA_NAT_FLAGS]) {
 		priv->flags = ntohl(nla_get_be32(tb[NFTA_NAT_FLAGS]));
 		if (priv->flags & ~NF_NAT_RANGE_MASK)
-			return -EINVAL;
+			return -EOPNOTSUPP;
 	}
 
 	return nf_ct_netns_get(ctx->net, family);
-- 
2.25.1



