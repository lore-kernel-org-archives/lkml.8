Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74E3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB1920714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759542;
	bh=IpskLDqHHZRm9edhwLu30IHxKAr24vBmtaA+c2F/oaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KcQNSTNp9yU6NMZF2LyDjluBw8ioGoLoAi+Ek1TkRk/LyCOMQ9w05Ah3syBsGoQiq
	 wy+z4oCK3hnUuOQAgjIfJ/kPDW9duqE3zm3I+qU7DthXgaTbWb8rJzzjbdsWh4h3ww
	 bqpR3Xkx6RW9Miar7i2SgfyzOhvs89mCfUCDE5t8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389866AbgDAQpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389853AbgDAQpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:45:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F5C720719;
        Wed,  1 Apr 2020 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759535;
        bh=IpskLDqHHZRm9edhwLu30IHxKAr24vBmtaA+c2F/oaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5GEzTVlcRPUCaG7dcH4QeS0vjTsEIXR27Er+tg7L9+DlcZUb1q2XOiUsJR062rq3
         b0a9ex/hMgE1R1XlCXL7FJPSYIhUXq7kVJX4Aljk9UtKCkf7Zza+rMAds4u1ip1LQo
         8Mlp6Im8MQj6RsUYJgNH+3wF2gheba1z4PCWutHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 109/148] netfilter: nft_fwd_netdev: validate family and chain type
Date:   Wed,  1 Apr 2020 18:18:21 +0200
Message-Id: <20200401161603.061574431@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
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
 net/netfilter/nft_fwd_netdev.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -62,6 +62,13 @@ nla_put_failure:
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
 static const struct nft_expr_ops nft_fwd_netdev_ops = {
 	.type		= &nft_fwd_netdev_type,
@@ -69,6 +76,7 @@ static const struct nft_expr_ops nft_fwd
 	.eval		= nft_fwd_netdev_eval,
 	.init		= nft_fwd_netdev_init,
 	.dump		= nft_fwd_netdev_dump,
+	.validate	= nft_fwd_validate,
 };
 
 static struct nft_expr_type nft_fwd_netdev_type __read_mostly = {


