Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3A5C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6170A20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759082;
	bh=IpskLDqHHZRm9edhwLu30IHxKAr24vBmtaA+c2F/oaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p9xR1WtBPoHeRBhEnYEtReYtcVae94iFgRt51SmkEFiDk3ROV/fKyhXPl8bl/0Wtv
	 ENA/V7tKNG3oT8wtBPmCrRumKIRq/s7ks1YkU/nzz5I2OiEgeLuU8tIScxn5o4d03I
	 DctOaTq9m/MlWHBqSJjybZji0sVsa2ysYrY7QJG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389045AbgDAQiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388751AbgDAQh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:37:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF34420BED;
        Wed,  1 Apr 2020 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759078;
        bh=IpskLDqHHZRm9edhwLu30IHxKAr24vBmtaA+c2F/oaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0z4GsTw82U6q81wsX1TY5tC7/mMIc60R3qAzjnXV/XOANuVgbBIsxXOtbMK3E2j3
         M0fvngYzt+1/Bc8NmDxJ8XwR7/FSWPpoU1ABo/o58YaARc5rwCyhKKNMvOIjSX4naX
         gskFD6FwDNRfem3Ws+DslzoEoAgUpcysa6Sllu80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 069/102] netfilter: nft_fwd_netdev: validate family and chain type
Date:   Wed,  1 Apr 2020 18:18:12 +0200
Message-Id: <20200401161544.267072629@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
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


