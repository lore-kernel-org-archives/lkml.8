Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B871FC35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856272086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748213;
	bh=juo3GS7boxFKexj+JW88vhjeX/iXSAXwaH0be0zL5jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kDJW2uLpc+DLueYRkZe1+Cc1GFW6E2r+oQUKwBmoalg4562Shto+wN/C5+OWdsOHq
	 fUEm7M1frk4qjDW8lVT3xLBFpBMlxpYXAL0kGWtSwFXkVHPZ/ezZxCbjXfWSp9is5p
	 dDhx7DUkcXtlaRK0jdK4WqvaRiLtKp9/wa4/ZUNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgBCQcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730000AbgBCQct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:32:49 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B842051A;
        Mon,  3 Feb 2020 16:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747568;
        bh=juo3GS7boxFKexj+JW88vhjeX/iXSAXwaH0be0zL5jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMj54UC/i//QYoMYrWc0esgmBvqwE2O0QpUGFB7EIhPTNi71YUX80bQnezohCrI3i
         q8+/flvyv2a2MOH9gCznUeCEPwdlYn017w4+IQrjVtVKa/X2YFfZFvb/Qc1YvhfH13
         SSXQKvWR8Z/0DtMTJEiqxhe0atqD99JyO1xEy2gw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 46/70] netfilter: nft_tunnel: ERSPAN_VERSION must not be null
Date:   Mon,  3 Feb 2020 16:19:58 +0000
Message-Id: <20200203161918.995823026@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 9ec22d7c6c69146180577f3ad5fdf504beeaee62 ]

Fixes: af308b94a2a4a5 ("netfilter: nf_tables: add tunnel support")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 09441bbb0166f..e5444f3ff43fc 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -235,6 +235,9 @@ static int nft_tunnel_obj_erspan_init(const struct nlattr *attr,
 	if (err < 0)
 		return err;
 
+	if (!tb[NFTA_TUNNEL_KEY_ERSPAN_VERSION])
+		 return -EINVAL;
+
 	version = ntohl(nla_get_be32(tb[NFTA_TUNNEL_KEY_ERSPAN_VERSION]));
 	switch (version) {
 	case ERSPAN_VERSION:
-- 
2.20.1



