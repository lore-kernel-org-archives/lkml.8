Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BD9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B122F20738
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599581343;
	bh=cZTh0F4UwMPZNeIZOrF3D9te8pCo9YKGjBWc/4qcV5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WKA+i3QEbqwXGhh/ZAzibnnmkDBslzMJkDxnlqvd6kbtmSx5atH0qx28rNJTu82xn
	 KsudW9bsRBiH7r+MCZPs6xzDsYCSc5ptsO1TF+0rrDyylIAe2wwgxJUqLsKAw8E+Ed
	 dqzpfwsGmXcBS+ogRH4kTAFg//xcVQm8H/xKprBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgIHQI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731069AbgIHQAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05F3D23C44;
        Tue,  8 Sep 2020 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579379;
        bh=cZTh0F4UwMPZNeIZOrF3D9te8pCo9YKGjBWc/4qcV5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tL24LDkBP+86ogxXCNqzBniQdqCtXTnJkQAjp9Uds+Inlzv/6r00PlawTrAMA7XIr
         PR00PP+qYkHdORIYMvVCon3Mm386yBK+i8HQcWTbpUZUTnDZeEaGzWsO1brMmh5oxK
         k9V+6MRdPjLjwNqpk/nVDi+XnmZcBJAKtogZTVp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 054/186] netfilter: nf_tables: add NFTA_SET_USERDATA if not null
Date:   Tue,  8 Sep 2020 17:23:16 +0200
Message-Id: <20200908152244.291680213@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 6f03bf43ee05b31d3822def2a80f11b3591c55b3 ]

Kernel sends an empty NFTA_SET_USERDATA attribute with no value if
userspace adds a set with no NFTA_SET_USERDATA attribute.

Fixes: e6d8ecac9e68 ("netfilter: nf_tables: Add new attributes into nft_set to store user data.")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d31832d32e028..39be0a3015c63 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3643,7 +3643,8 @@ static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 			goto nla_put_failure;
 	}
 
-	if (nla_put(skb, NFTA_SET_USERDATA, set->udlen, set->udata))
+	if (set->udata &&
+	    nla_put(skb, NFTA_SET_USERDATA, set->udlen, set->udata))
 		goto nla_put_failure;
 
 	nest = nla_nest_start_noflag(skb, NFTA_SET_DESC);
-- 
2.25.1



