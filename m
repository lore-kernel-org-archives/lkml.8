Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D70C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B1820714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443192;
	bh=hOU8ZuvyR2Io/lI9o8Aqs0ag8ypx4zG/pxoZrYHsiks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AYa2fSnPdxpIoxLcqGdK27abXYeALs0ZvE6aNeTydI36/46vesaHZnaPNyoKQ5s3G
	 llT8GEHXOjULu3qKjgyTsntoJ+c62h48ON7MVfNgogh+i9rZI915x2F32JLiCLV0jJ
	 xAZz8kRzYC10PauSqAb1qi4NoqUFuZFui5L2NqwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgCQLGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCQLG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:06:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B49E820658;
        Tue, 17 Mar 2020 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443186;
        bh=hOU8ZuvyR2Io/lI9o8Aqs0ag8ypx4zG/pxoZrYHsiks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T49Y/m2vSJON3wm9QUVTvzmT5tNwYQqUPRrY5fuS+WyRdCA2ZuvHSCOEuM5MLTdeZ
         xHo35pxq2+TppBhCTdCgwmfuJHnfPHwgdjPj3HmELdiWmh5X14nxuvmWRLXexYNeR6
         NMcnRUPciDqtv9SU0PDdc9MgxbbXem/6mnbxwemw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 115/123] netfilter: nf_tables: dump NFTA_CHAIN_FLAGS attribute
Date:   Tue, 17 Mar 2020 11:55:42 +0100
Message-Id: <20200317103319.139981553@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit d78008de6103c708171baff9650a7862645d23b0 upstream.

Missing NFTA_CHAIN_FLAGS netlink attribute when dumping basechain
definitions.

Fixes: c9626a2cbdb2 ("netfilter: nf_tables: add hardware offload support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_tables_api.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1309,6 +1309,11 @@ static int nf_tables_fill_chain_info(str
 					      lockdep_commit_lock_is_held(net));
 		if (nft_dump_stats(skb, stats))
 			goto nla_put_failure;
+
+		if ((chain->flags & NFT_CHAIN_HW_OFFLOAD) &&
+		    nla_put_be32(skb, NFTA_CHAIN_FLAGS,
+				 htonl(NFT_CHAIN_HW_OFFLOAD)))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_be32(skb, NFTA_CHAIN_USE, htonl(chain->use)))


