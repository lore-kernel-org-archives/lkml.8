Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8EAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A2B205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699830;
	bh=VMpHdUqH22/DvoyrLKi+8RnqH5XZgUWcbk35nYMzkqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YRLxeFJ+mbLQaAXjP4+eoxPTZ6ZDxOwwaDOfQLHFu96y/WVrlFXhnEvkVZbDlD1WD
	 gXHRMxERqmcNgN0HapNE0eYw9nPI21yoWKJNCdzqFYbpJG4VejRatrFubBap+sy53F
	 dSUH8dm/2LrQbRS6vILFxLmAlQQL8aT+UTSj9g9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgAVNXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbgAVNXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:23:00 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADC72468C;
        Wed, 22 Jan 2020 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699380;
        bh=VMpHdUqH22/DvoyrLKi+8RnqH5XZgUWcbk35nYMzkqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9XP3D8DzlTmrnpGhM1w22S9KMt53EHX1q/BdEZ0sCiaYCOS6XXWhsOziKqyGI7YA
         SmDMBOptPZwRX+Kw0NlVvLx2m6xgCor6LeW26IYODtmqyOzOPbOPwu2tFfc4tTNlDc
         M+wTj+8H6JQ+jDHNWSMyoj8Nzgbo5RF5MyiNNxTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+76d0b80493ac881ff77b@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 127/222] netfilter: nft_tunnel: fix null-attribute check
Date:   Wed, 22 Jan 2020 10:28:33 +0100
Message-Id: <20200122092842.844012730@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
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
@@ -76,7 +76,7 @@ static int nft_tunnel_get_init(const str
 	struct nft_tunnel *priv = nft_expr_priv(expr);
 	u32 len;
 
-	if (!tb[NFTA_TUNNEL_KEY] &&
+	if (!tb[NFTA_TUNNEL_KEY] ||
 	    !tb[NFTA_TUNNEL_DREG])
 		return -EINVAL;
 


