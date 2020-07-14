Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF71C433F8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B286822B4E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753495;
	bh=lFGMtysz5U3UgWxk8qAbvF8pcn57l+N6BjIQ7eXaho0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RGzhvefl+j3jKgkn8NGnbA2vU7DgAbRt7G2MC0nTjD0xHggiWKhtTr/IUTpPLkCr6
	 4jGjBAabac667aFlOMkGK8+BdodeXudmcpVkF/OD7tlyO7uKshJhsQiMN9FcZIURCr
	 hDNbcg/Bx9SItajwIom2/lniOU2NqdR5WAlVWFj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgGNSzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730879AbgGNSzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:55:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D936222507;
        Tue, 14 Jul 2020 18:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752932;
        bh=lFGMtysz5U3UgWxk8qAbvF8pcn57l+N6BjIQ7eXaho0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEB1saT5dS+iRiifJs96KCeI4aCXl3K2tN+oKS+UNZvPeQCgtvaxTRwpJt5IrsXIb
         z3M0LnwSsF6hQ2jKrcCZ5O5FDIkw93SAhx1PyTSgp6zZPm3Fzqwgt7AuSQKFARvzRb
         0qIKjEOkHQij6CABuWt+u9zoWwhVvR4p8Uo7zHtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 054/166] mac80211: Fix dropping broadcast packets in 802.11 encap
Date:   Tue, 14 Jul 2020 20:43:39 +0200
Message-Id: <20200714184118.463503899@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

[ Upstream commit 78fb5b541b7ae57ac39187ccb3097e606004cf9b ]

Broadcast pkts like arp are getting dropped in 'ieee80211_8023_xmit'.
Fix this by replacing is_valid_ether_addr api with is_zero_ether_addr.

Fixes: 50ff477a8639 ("mac80211: add 802.11 encapsulation offloading support")
Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Link: https://lore.kernel.org/r/1591697754-4975-1-git-send-email-seevalam@codeaurora.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 82846aca86d96..6ab33d9904eec 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4192,7 +4192,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	    (!sta || !test_sta_flag(sta, WLAN_STA_TDLS_PEER)))
 		ra = sdata->u.mgd.bssid;
 
-	if (!is_valid_ether_addr(ra))
+	if (is_zero_ether_addr(ra))
 		goto out_free;
 
 	multicast = is_multicast_ether_addr(ra);
-- 
2.25.1



