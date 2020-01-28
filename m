Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C469DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8B524681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220433;
	bh=4ur1Ix63mEhL4kZuXF7GWGOWcQMmuI6lxxCh9xmTNZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XKgVuFT3ARhCktRnVPShp2DyGJxZtkZN8S9Ei/d9ZBfLHbp2xnV+8jCQoLwBwSBSb
	 2ejUqRo/GpBrmAibEt69FUr0Xi4kcUMOvvZj4i/v7zRyllvNDK7lbwAk0OSFPVps+g
	 nuNvJx4/6/O6E5AznZv0yVXbG0oR0l+P4yb7shaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgA1OHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:07:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgA1OD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:03:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94891205F4;
        Tue, 28 Jan 2020 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220237;
        bh=4ur1Ix63mEhL4kZuXF7GWGOWcQMmuI6lxxCh9xmTNZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrLCmcr+CZpjnmTMssESJkMe68TYSVDmc+typSR5Acntt0oBaqB1eDqjGbC7vaUO1
         02mtlvrW2uqtg7116YmLoJ0GZm8VUiufz8o8AJfHWRdWECHGThhq+vcjRizYZVw6fi
         67n/FdFdzlAYwLlX/oKKaaiwYwAKGyu1YSHTyS8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+cf23983d697c26c34f60@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 070/104] netfilter: nft_osf: add missing check for DREG attribute
Date:   Tue, 28 Jan 2020 15:00:31 +0100
Message-Id: <20200128135827.019998828@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 7eaecf7963c1c8f62d62c6a8e7c439b0e7f2d365 upstream.

syzbot reports just another NULL deref crash because of missing test
for presence of the attribute.

Reported-by: syzbot+cf23983d697c26c34f60@syzkaller.appspotmail.com
Fixes:  b96af92d6eaf9fadd ("netfilter: nf_tables: implement Passive OS fingerprint module in nft_osf")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_osf.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -61,6 +61,9 @@ static int nft_osf_init(const struct nft
 	int err;
 	u8 ttl;
 
+	if (!tb[NFTA_OSF_DREG])
+		return -EINVAL;
+
 	if (tb[NFTA_OSF_TTL]) {
 		ttl = nla_get_u8(tb[NFTA_OSF_TTL]);
 		if (ttl > 2)


