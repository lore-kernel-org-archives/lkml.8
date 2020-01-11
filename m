Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF73C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3376920848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737680;
	bh=RtFS6Ig+xSxNO0ISJNYHYxVZI60x+9oEXxbVu9DCVwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EW7RlNZEsDi3cViVPrnmyDP91YgzAElcKGSmaFmEQM/42aDhFen7GsqygJnH9EvFQ
	 JDI16jpKzeEocSUzANipv8udDtsmJkUZMTOYuXzOqcgWEqDyItX6nWo6HMmgjvQQYI
	 X+3zMT769tJArgNspYbHQ7ZFie7XHBAF68rG87+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgAKKOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:14:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730160AbgAKKOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:14:36 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8367320673;
        Sat, 11 Jan 2020 10:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737675;
        bh=RtFS6Ig+xSxNO0ISJNYHYxVZI60x+9oEXxbVu9DCVwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=np1pOfCi+PX/fFkQW0oT4AjqfhdKXTvT5sXLOn9YGVwcJrEQjg+Y5QjGqhWRl/Bo9
         Rjw5bbs8sBM9jzlILsgeISFp6qOlzRD+EMQhprqn1A5qq6VzSSknW35V8tqWIYGHmO
         IACKRdst/4H2hfNSBxnYUi8rUAHwk+pqIyr/f5YE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/84] netfilter: nf_tables: validate NFT_DATA_VALUE after nft_data_init()
Date:   Sat, 11 Jan 2020 10:49:57 +0100
Message-Id: <20200111094853.004631684@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 0d2c96af797ba149e559c5875c0151384ab6dd14 ]

Userspace might bogusly sent NFT_DATA_VERDICT in several netlink
attributes that assume NFT_DATA_VALUE. Moreover, make sure that error
path invokes nft_data_release() to decrement the reference count on the
chain object.

Fixes: 96518518cc41 ("netfilter: add nftables")
Fixes: 0f3cd9b36977 ("netfilter: nf_tables: add range expression")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c |  4 +++-
 net/netfilter/nft_bitwise.c   |  4 ++--
 net/netfilter/nft_cmp.c       |  6 ++++++
 net/netfilter/nft_range.c     | 10 ++++++++++
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 42f79f9532c6..4711a8b56f32 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4117,8 +4117,10 @@ static int nft_get_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		return err;
 
 	err = -EINVAL;
-	if (desc.type != NFT_DATA_VALUE || desc.len != set->klen)
+	if (desc.type != NFT_DATA_VALUE || desc.len != set->klen) {
+		nft_data_release(&elem.key.val, desc.type);
 		return err;
+	}
 
 	priv = set->ops->get(ctx->net, set, &elem, flags);
 	if (IS_ERR(priv))
diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index fff8073e2a56..058ee84ea531 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -83,7 +83,7 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 			    tb[NFTA_BITWISE_MASK]);
 	if (err < 0)
 		return err;
-	if (d1.len != priv->len) {
+	if (d1.type != NFT_DATA_VALUE || d1.len != priv->len) {
 		err = -EINVAL;
 		goto err1;
 	}
@@ -92,7 +92,7 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 			    tb[NFTA_BITWISE_XOR]);
 	if (err < 0)
 		goto err1;
-	if (d2.len != priv->len) {
+	if (d2.type != NFT_DATA_VALUE || d2.len != priv->len) {
 		err = -EINVAL;
 		goto err2;
 	}
diff --git a/net/netfilter/nft_cmp.c b/net/netfilter/nft_cmp.c
index 79d48c1d06f4..7007045c0849 100644
--- a/net/netfilter/nft_cmp.c
+++ b/net/netfilter/nft_cmp.c
@@ -82,6 +82,12 @@ static int nft_cmp_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	if (err < 0)
 		return err;
 
+	if (desc.type != NFT_DATA_VALUE) {
+		err = -EINVAL;
+		nft_data_release(&priv->data, desc.type);
+		return err;
+	}
+
 	priv->sreg = nft_parse_register(tb[NFTA_CMP_SREG]);
 	err = nft_validate_register_load(priv->sreg, desc.len);
 	if (err < 0)
diff --git a/net/netfilter/nft_range.c b/net/netfilter/nft_range.c
index cedb96c3619f..2e1d2ec2f52a 100644
--- a/net/netfilter/nft_range.c
+++ b/net/netfilter/nft_range.c
@@ -70,11 +70,21 @@ static int nft_range_init(const struct nft_ctx *ctx, const struct nft_expr *expr
 	if (err < 0)
 		return err;
 
+	if (desc_from.type != NFT_DATA_VALUE) {
+		err = -EINVAL;
+		goto err1;
+	}
+
 	err = nft_data_init(NULL, &priv->data_to, sizeof(priv->data_to),
 			    &desc_to, tb[NFTA_RANGE_TO_DATA]);
 	if (err < 0)
 		goto err1;
 
+	if (desc_to.type != NFT_DATA_VALUE) {
+		err = -EINVAL;
+		goto err2;
+	}
+
 	if (desc_from.len != desc_to.len) {
 		err = -EINVAL;
 		goto err2;
-- 
2.20.1



