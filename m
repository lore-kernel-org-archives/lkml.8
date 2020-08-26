Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C32BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C7920838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598443468;
	bh=rG3PYJLfKC9NUtVeihfVocRKM2NrWLJZSdMjvohnzyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HKc7owRRcjSmcodZ56VZhBwb/sYTifoE82SBEGWjLIbFB0pBbdHAQYcAaq7rdoxEC
	 IKZENdogdei/MqwISGTF9Oup/9FpYhF98RngXZwBaZ79Gpl7jNNr/9fRGuDidYT6a9
	 mNpvIYi5PQiO/DXArm+Wdi91qsFLjwKyAopGhIwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgHZMEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729507AbgHZMDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:03:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDCE92087C;
        Wed, 26 Aug 2020 12:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443390;
        bh=rG3PYJLfKC9NUtVeihfVocRKM2NrWLJZSdMjvohnzyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iXzCq+e4od6XWrscLO58TNpK2rYUxlkL1pSGuFzmel8gNtzcVXYmrbRxrohLB/uIF
         TPZhT14Q37XKlAblaqbQRfYpobaR7iU5/q9g7y/sw2ShNNiWQWVdHD3KBOiGBw8wK/
         hRKtjMODrRzq88KmAJjFd9B76hIw2voxCUPJfMGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxim Mikityanskiy <maximmi@mellanox.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 11/15] ethtool: Fix preserving of wanted feature bits in netlink interface
Date:   Wed, 26 Aug 2020 14:02:39 +0200
Message-Id: <20200826114849.847729571@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826114849.295321031@linuxfoundation.org>
References: <20200826114849.295321031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Mikityanskiy <maximmi@mellanox.com>

[ Upstream commit 840110a4eae190dcbb9907d68216d5d1d9f25839 ]

Currently, ethtool-netlink calculates new wanted bits as:
(req_wanted & req_mask) | (old_active & ~req_mask)

It completely discards the old wanted bits, so they are forgotten with
the next ethtool command. Sample steps to reproduce:

1. ethtool -k eth0
   tx-tcp-segmentation: on # TSO is on from the beginning
2. ethtool -K eth0 tx off
   tx-tcp-segmentation: off [not requested]
3. ethtool -k eth0
   tx-tcp-segmentation: off [requested on]
4. ethtool -K eth0 rx off # Some change unrelated to TSO
5. ethtool -k eth0
   tx-tcp-segmentation: off # "Wanted on" is forgotten

This commit fixes it by changing the formula to:
(req_wanted & req_mask) | (old_wanted & ~req_mask),
where old_active was replaced by old_wanted to account for the wanted
bits.

The shortcut condition for the case where nothing was changed now
compares wanted bitmasks, instead of wanted to active.

Fixes: 0980bfcd6954 ("ethtool: set netdev features with FEATURES_SET request")
Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ethtool/features.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/ethtool/features.c
+++ b/net/ethtool/features.c
@@ -224,7 +224,9 @@ int ethnl_set_features(struct sk_buff *s
 	DECLARE_BITMAP(wanted_diff_mask, NETDEV_FEATURE_COUNT);
 	DECLARE_BITMAP(active_diff_mask, NETDEV_FEATURE_COUNT);
 	DECLARE_BITMAP(old_active, NETDEV_FEATURE_COUNT);
+	DECLARE_BITMAP(old_wanted, NETDEV_FEATURE_COUNT);
 	DECLARE_BITMAP(new_active, NETDEV_FEATURE_COUNT);
+	DECLARE_BITMAP(new_wanted, NETDEV_FEATURE_COUNT);
 	DECLARE_BITMAP(req_wanted, NETDEV_FEATURE_COUNT);
 	DECLARE_BITMAP(req_mask, NETDEV_FEATURE_COUNT);
 	struct nlattr *tb[ETHTOOL_A_FEATURES_MAX + 1];
@@ -250,6 +252,7 @@ int ethnl_set_features(struct sk_buff *s
 
 	rtnl_lock();
 	ethnl_features_to_bitmap(old_active, dev->features);
+	ethnl_features_to_bitmap(old_wanted, dev->wanted_features);
 	ret = ethnl_parse_bitset(req_wanted, req_mask, NETDEV_FEATURE_COUNT,
 				 tb[ETHTOOL_A_FEATURES_WANTED],
 				 netdev_features_strings, info->extack);
@@ -261,11 +264,11 @@ int ethnl_set_features(struct sk_buff *s
 		goto out_rtnl;
 	}
 
-	/* set req_wanted bits not in req_mask from old_active */
+	/* set req_wanted bits not in req_mask from old_wanted */
 	bitmap_and(req_wanted, req_wanted, req_mask, NETDEV_FEATURE_COUNT);
-	bitmap_andnot(new_active, old_active, req_mask, NETDEV_FEATURE_COUNT);
-	bitmap_or(req_wanted, new_active, req_wanted, NETDEV_FEATURE_COUNT);
-	if (bitmap_equal(req_wanted, old_active, NETDEV_FEATURE_COUNT)) {
+	bitmap_andnot(new_wanted, old_wanted, req_mask, NETDEV_FEATURE_COUNT);
+	bitmap_or(req_wanted, new_wanted, req_wanted, NETDEV_FEATURE_COUNT);
+	if (bitmap_equal(req_wanted, old_wanted, NETDEV_FEATURE_COUNT)) {
 		ret = 0;
 		goto out_rtnl;
 	}


