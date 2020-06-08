Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC5AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F59720775
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659289;
	bh=YMVGyMftjFCL29CHvdRJ5Ees7rM6CcvpjSQgTN+22Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hqt2Q8YvCJtP8HbhTADbhBFIdD6zBPAd5xEUzSndEup9uJQPs3DkBwM72KNqM/iO+
	 SanpRBgMeIR/0k3MzKxCMYOXw3IC/3zZNxnuRkpyD36rUgLrYBETxe8/UPp1W2jBXB
	 p1ccKxKG/mtP5ckhxP0Xa1CqN3P3jYMUfdCavGsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbgFHXes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387723AbgFHX2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:28:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20F4F2074B;
        Mon,  8 Jun 2020 23:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658894;
        bh=YMVGyMftjFCL29CHvdRJ5Ees7rM6CcvpjSQgTN+22Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bK1+8qOA21lKmeu/boj1JX5w3p3F86jY1zSbdqxpF0P3KeLV2dxL3M7UYFiTJur7M
         P8xOYcJPY1531E/nzP6jg1CvR7qDJR+NHVRQjJqVA5eAb8Q0vVAhVKITwZczH1raZs
         vqZggvHm3tYoo2pynWTKm6MIK5nXBFbmat9w6pmc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 17/37] netfilter: nft_nat: return EOPNOTSUPP if type or flags are not supported
Date:   Mon,  8 Jun 2020 19:27:29 -0400
Message-Id: <20200608232750.3370747-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232750.3370747-1-sashal@kernel.org>
References: <20200608232750.3370747-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index ee2d71753746..868480b83649 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -135,7 +135,7 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		priv->type = NF_NAT_MANIP_DST;
 		break;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	err = nft_nat_validate(ctx, expr, NULL);
@@ -206,7 +206,7 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	if (tb[NFTA_NAT_FLAGS]) {
 		priv->flags = ntohl(nla_get_be32(tb[NFTA_NAT_FLAGS]));
 		if (priv->flags & ~NF_NAT_RANGE_MASK)
-			return -EINVAL;
+			return -EOPNOTSUPP;
 	}
 
 	return 0;
-- 
2.25.1

