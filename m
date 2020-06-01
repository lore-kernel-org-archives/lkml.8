Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F68EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D75206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037436;
	bh=yfUCa8pG+oMetMxHeFh42pzFCHPZVmGxtgRQxs1EHs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ELjlUs6G4QfaRCZRKtYEShqf3iktDtYVEfqIHvg39EFweHRYLxdL4psLjzFYbcwX
	 tZteQ+O9sfFeOBvwU3W8OWcTDY8jQApbxsSqEUkKDN5NY34m9UzFoYF7bjjLDBAfXc
	 gJUgeihPmYvRyHXdt/nQEELe+FLlJG+Ej46wdQWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgFASFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgFASFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:05:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93F042068D;
        Mon,  1 Jun 2020 18:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034732;
        bh=yfUCa8pG+oMetMxHeFh42pzFCHPZVmGxtgRQxs1EHs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4Wi1ZiobJA2w5l1Xmo3LM+fB/YZzGCc9TA4SWFTWUQJBgCwcwx6LXgHXSoNe7Z6L
         ln06yjL4uyLg7hffR5adZ8C1H0yGMNjNFn32FN+Xo+ITmAY30sz6J6ETCRRzhrjsBn
         2ZleE86V4X7FE8b3poglo3iXKH7dCdmlNbdAXecg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 85/95] netfilter: nfnetlink_cthelper: unbreak userspace helper support
Date:   Mon,  1 Jun 2020 19:54:25 +0200
Message-Id: <20200601174033.436137301@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 703acd70f2496537457186211c2f03e792409e68 upstream.

Restore helper data size initialization and fix memcopy of the helper
data size.

Fixes: 157ffffeb5dc ("netfilter: nfnetlink_cthelper: reject too large userspace allocation requests")
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nfnetlink_cthelper.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -106,7 +106,7 @@ nfnl_cthelper_from_nlattr(struct nlattr
 	if (help->helper->data_len == 0)
 		return -EINVAL;
 
-	nla_memcpy(help->data, nla_data(attr), sizeof(help->data));
+	nla_memcpy(help->data, attr, sizeof(help->data));
 	return 0;
 }
 
@@ -242,6 +242,7 @@ nfnl_cthelper_create(const struct nlattr
 		ret = -ENOMEM;
 		goto err2;
 	}
+	helper->data_len = size;
 
 	helper->flags |= NF_CT_HELPER_F_USERSPACE;
 	memcpy(&helper->tuple, tuple, sizeof(struct nf_conntrack_tuple));


