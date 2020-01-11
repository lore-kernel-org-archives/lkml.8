Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD873C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989402084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738204;
	bh=b0j4uUP36eM65YwUbTde7dNnwD7Sf+hUVDxtcT2ZUDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z2vUYD16q59PET9flLJT4b1AQy3CFHCuBs7kQE9pnRtP3TvXxoAGuXfkoLKVCydzq
	 Ps45tTzv0hqOAoacS2fAuj6KcFXHM1YrCQw3d86wCvvObqiyhYAQtAQZMF7Y9KkaPq
	 Ucdplu58IDRe+LAHl9YbvbMabDM18Da1j4lvR7bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgAKKXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730160AbgAKKXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:23:20 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AEDE2084D;
        Sat, 11 Jan 2020 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738200;
        bh=b0j4uUP36eM65YwUbTde7dNnwD7Sf+hUVDxtcT2ZUDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0AAW4rTgGOY33vtaDdqpFiKvYNKBp16bFdqq+L78k2Rk7jazRLrQpCRXhITf8K/PZ
         rupyGuRye1ukPLBWlVN8ziqEOqQvK01nf9BDCrMeVaf4Qdqrb2VKAM3tnVXt0+ASU3
         D/Vcj4u1YK7uyOc9b/AsbGLlp4I19dgIknSDhh8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 031/165] netfilter: nf_tables: skip module reference count bump on object updates
Date:   Sat, 11 Jan 2020 10:49:10 +0100
Message-Id: <20200111094923.288123504@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit fd57d0cbe187e93f63777d36e9f49293311d417f ]

Use __nft_obj_type_get() instead, otherwise there is a module reference
counter leak.

Fixes: d62d0ba97b58 ("netfilter: nf_tables: Introduce stateful object update operation")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 4c03c14e46bc..67ca47c7ce54 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5217,7 +5217,7 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 		if (nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
-		type = nft_obj_type_get(net, objtype);
+		type = __nft_obj_type_get(objtype);
 		nft_ctx_init(&ctx, net, skb, nlh, family, table, NULL, nla);
 
 		return nf_tables_updobj(&ctx, type, nla[NFTA_OBJ_DATA], obj);
-- 
2.20.1



