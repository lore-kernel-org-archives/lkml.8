Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FCFC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E42D2468D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686215;
	bh=Dp6VtfTwcqViQmhEqLkrbqaVJBMMsF+zh6srQidMBpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y3Jq5z0PqNnan3fJw6QoCfZwesT35JBwIJXhG54eoU9pKo786Mj/41HvePX4ficra
	 fdLwaxQfvfWYvsL+7BpyxW/uL8ou09nVZ+XWkHssXyMzdVhZPSt6i0jWg9xhL6RfJL
	 BlAbi8+tzZ0lrfkfN74jqdEwEYyYUF+ikLpHQBW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbgAVJne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387883AbgAVJn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:43:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D222424680;
        Wed, 22 Jan 2020 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686209;
        bh=Dp6VtfTwcqViQmhEqLkrbqaVJBMMsF+zh6srQidMBpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNoMlp7+dserQTbGs1DJHAcIKn9+9AQGCwgLltGVDUjlFsVzcgoRrD5aBJDuh6sZc
         qrWDtxpaa9cljieT6y06ThQTythKzEmoVkRKNH3fO56DNlmZtrfz2UP0KUVYceEF4H
         dl0pDZWNfJmF3pMb5nwC4VP1sS9g0MRWaAULepkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+76d0b80493ac881ff77b@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 061/103] netfilter: nft_tunnel: fix null-attribute check
Date:   Wed, 22 Jan 2020 10:29:17 +0100
Message-Id: <20200122092813.029931693@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 1c702bf902bd37349f6d91cd7f4b372b1e46d0ed upstream.

else we get null deref when one of the attributes is missing, both
must be non-null.

Reported-by: syzbot+76d0b80493ac881ff77b@syzkaller.appspotmail.com
Fixes: aaecfdb5c5dd8ba ("netfilter: nf_tables: match on tunnel metadata")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_tunnel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -56,7 +56,7 @@ static int nft_tunnel_get_init(const str
 	struct nft_tunnel *priv = nft_expr_priv(expr);
 	u32 len;
 
-	if (!tb[NFTA_TUNNEL_KEY] &&
+	if (!tb[NFTA_TUNNEL_KEY] ||
 	    !tb[NFTA_TUNNEL_DREG])
 		return -EINVAL;
 


