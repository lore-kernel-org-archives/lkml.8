Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74D5C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB8D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443668;
	bh=ng0rIq4lb1Gt+CABGzF4M9dNcAFtcYGFMu3c96wZV0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fbu3bs20TaW+1yIAmJr8+Tljm69k7k1QBe855d3FCR1f/RstJQw0NsmO2rjZcbLtz
	 65VVAWfsO2cFpAQV+r4V/xOXiPPYYMaReTlq+0Qd3XAp/RwM/VXILovzTqKHJOfKPV
	 MiowDGx+gLqDYcbxbT/NOMylPHUhm9TmX1zlmesk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgCQLO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729613AbgCQLOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:14:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BB19205ED;
        Tue, 17 Mar 2020 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443663;
        bh=ng0rIq4lb1Gt+CABGzF4M9dNcAFtcYGFMu3c96wZV0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvlVagmbYAHwX6q3S2U4Gve3p8k2603MA5ZC8i0fqqtzCs6xsV0+CuszCamYx7VKb
         qORwdr8cnARYLNsvniFYeUkw4+HjFkNEg3n2eP+3BwCoR+eNTzRl6H0CE9vS+KA3x7
         W3/KDJEcq8q0/RiD7UARnNrZISiAlnf3KDrWCr1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.5 142/151] netfilter: nft_payload: add missing attribute validation for payload csum flags
Date:   Tue, 17 Mar 2020 11:55:52 +0100
Message-Id: <20200317103336.747899413@linuxfoundation.org>
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

commit 9d6effb2f1523eb84516e44213c00f2fd9e6afff upstream.

Add missing attribute validation for NFTA_PAYLOAD_CSUM_FLAGS
to the netlink policy.

Fixes: 1814096980bb ("netfilter: nft_payload: layer 4 checksum adjustment for pseudoheader fields")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_payload.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -129,6 +129,7 @@ static const struct nla_policy nft_paylo
 	[NFTA_PAYLOAD_LEN]		= { .type = NLA_U32 },
 	[NFTA_PAYLOAD_CSUM_TYPE]	= { .type = NLA_U32 },
 	[NFTA_PAYLOAD_CSUM_OFFSET]	= { .type = NLA_U32 },
+	[NFTA_PAYLOAD_CSUM_FLAGS]	= { .type = NLA_U32 },
 };
 
 static int nft_payload_init(const struct nft_ctx *ctx,


