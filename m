Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B286CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB3520838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073479;
	bh=AGdYApRkl/MI0MZX28LEMG91c/WjS4eEBNI1jcaazac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sEVdnnb/UfB/E0F9lCysWZ7KjtocYdXTy+1bBQhDUgAs+NboLz9bQsRL4jy1P973p
	 6dx9gFl6cUQGnBKA0ReEcMBh/g1L5l+amsO0Gpy1UKZanfiyde5ZtGk9PT4QtcPNcZ
	 jnwQ+KEyJ5rYG/zs1B9A/WSsz7fnkJllHpsFlg40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgHJPbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729179AbgHJPbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:31:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 057042080C;
        Mon, 10 Aug 2020 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073471;
        bh=AGdYApRkl/MI0MZX28LEMG91c/WjS4eEBNI1jcaazac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0wAyRxjwotSK+3FfgcMq3EUr5LcL/nVgTAegCeTmKHIhCIpzIPNJytX8I8BIjmWVo
         aA449lNyARGhydhOmtSv9UQLI6b/dcrrPAP+EKuwY7bWIfBLE5lK4u82wnYGifWF3y
         iokRwIz5JcPKOUt36caf0f2xTP5UXyah9zaphM1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Squires <julian@cipht.net>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 26/48] cfg80211: check vendor command doit pointer before use
Date:   Mon, 10 Aug 2020 17:21:48 +0200
Message-Id: <20200810151805.502158557@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
References: <20200810151804.199494191@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Squires <julian@cipht.net>

[ Upstream commit 4052d3d2e8f47a15053320bbcbe365d15610437d ]

In the case where a vendor command does not implement doit, and has no
flags set, doit would not be validated and a NULL pointer dereference
would occur, for example when invoking the vendor command via iw.

I encountered this while developing new vendor commands.  Perhaps in
practice it is advisable to always implement doit along with dumpit,
but it seems reasonable to me to always check doit anyway, not just
when NEED_WDEV.

Signed-off-by: Julian Squires <julian@cipht.net>
Link: https://lore.kernel.org/r/20200706211353.2366470-1-julian@cipht.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0221849b72180..996b68b48a878 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12392,13 +12392,13 @@ static int nl80211_vendor_cmd(struct sk_buff *skb, struct genl_info *info)
 				if (!wdev_running(wdev))
 					return -ENETDOWN;
 			}
-
-			if (!vcmd->doit)
-				return -EOPNOTSUPP;
 		} else {
 			wdev = NULL;
 		}
 
+		if (!vcmd->doit)
+			return -EOPNOTSUPP;
+
 		if (info->attrs[NL80211_ATTR_VENDOR_DATA]) {
 			data = nla_data(info->attrs[NL80211_ATTR_VENDOR_DATA]);
 			len = nla_len(info->attrs[NL80211_ATTR_VENDOR_DATA]);
-- 
2.25.1



