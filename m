Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2723AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9F524692
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699364;
	bh=G5oThlaiHggG4BtupsoslD6PHZ8zb7l3LumKJofs4bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uDhk33SzguvBCAgDhXspUa5c8JHyfbgOooRVYUctJ6sgKNwHC+/aI0i2iuxHOhAP4
	 gbSTlTNoM6gF+QKuycO2fxAjocVivagVD282tuiPpCCF17kdkvyI3tcFJRYsYcsEVA
	 Rg8GIbBLEvNdU5YXFUNI7MmCTBRjz83NY+U8YL6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgAVNWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:22:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbgAVNWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:22:41 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D49B2468C;
        Wed, 22 Jan 2020 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699361;
        bh=G5oThlaiHggG4BtupsoslD6PHZ8zb7l3LumKJofs4bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMMI4rMmH2whEprWlpMW8Bjl8daeuIsK1XeFUcrhK9tTa7damSrHTjl0GThrn/r+e
         qkbq3cXgatMnPkg51e6AnjAYx091xRmwrb3FUZO/KdKmQxCi2Bgo/VO1nF6cqWQ9rz
         cVtLF/j/TlTJqEEBGi4aNZ//cJFRT4QKoEjmV/X4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.4 121/222] cfg80211: fix page refcount issue in A-MSDU decap
Date:   Wed, 22 Jan 2020 10:28:27 +0100
Message-Id: <20200122092842.401964700@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

commit 81c044fc3bdc5b7be967cd3682528ea94b58c06a upstream.

The fragments attached to a skb can be part of a compound page. In that case,
page_ref_inc will increment the refcount for the wrong page. Fix this by
using get_page instead, which calls page_ref_inc on the compound head and
also checks for overflow.

Fixes: 2b67f944f88c ("cfg80211: reuse existing page fragments in A-MSDU rx")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://lore.kernel.org/r/20200113182107.20461-1-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/util.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -564,7 +564,7 @@ __frame_add_frag(struct sk_buff *skb, st
 	struct skb_shared_info *sh = skb_shinfo(skb);
 	int page_offset;
 
-	page_ref_inc(page);
+	get_page(page);
 	page_offset = ptr - page_address(page);
 	skb_add_rx_frag(skb, sh->nr_frags, page, page_offset, len, size);
 }


