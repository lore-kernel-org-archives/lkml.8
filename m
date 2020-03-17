Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD69FC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86664206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443622;
	bh=BzV1Hk4+TCda+cm8PDvDZzplYkCHdjRvG+dQ6nC0zuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DUBLYiOCZ6byxYY25U9girYFY5rBdu+qTV+EdkmANOIr+7q++VxV2RPkYCw18hLc6
	 Df3LxNqjqGki3X4TbAkf6d6mqYrIK0TotRQYHfXUcN7Luytvt2rRPyci1+lQq8grkr
	 1eHL6FyEcQSk/RcsQxrVmMz6yuEMh5CPXQ8MMRCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgCQLNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgCQLNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:13:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146A9205ED;
        Tue, 17 Mar 2020 11:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443615;
        bh=BzV1Hk4+TCda+cm8PDvDZzplYkCHdjRvG+dQ6nC0zuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsxJi0OBsGJ3H25CZ+DLl2NWX+O8+9jO4nDSTo/UBuiPYbYfOCcfaW2gejVvjmSDK
         7rcTIXF6oZ93KrUAZxtKfoGSMa4RReCsF11r2nFB8bfSpeyDo154cJsV6h7q4vbq8D
         XNZU44uNZ6X213izaFr3rGDF9SUKPf6AjdkGDdXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.5 143/151] netfilter: nft_tunnel: add missing attribute validation for tunnels
Date:   Tue, 17 Mar 2020 11:55:53 +0100
Message-Id: <20200317103336.834147337@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

commit 88a637719a1570705c02cacb3297af164b1714e7 upstream.

Add missing attribute validation for tunnel source and
destination ports to the netlink policy.

Fixes: af308b94a2a4 ("netfilter: nf_tables: add tunnel support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_tunnel.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -339,6 +339,8 @@ static const struct nla_policy nft_tunne
 	[NFTA_TUNNEL_KEY_FLAGS]	= { .type = NLA_U32, },
 	[NFTA_TUNNEL_KEY_TOS]	= { .type = NLA_U8, },
 	[NFTA_TUNNEL_KEY_TTL]	= { .type = NLA_U8, },
+	[NFTA_TUNNEL_KEY_SPORT]	= { .type = NLA_U16, },
+	[NFTA_TUNNEL_KEY_DPORT]	= { .type = NLA_U16, },
 	[NFTA_TUNNEL_KEY_OPTS]	= { .type = NLA_NESTED, },
 };
 


