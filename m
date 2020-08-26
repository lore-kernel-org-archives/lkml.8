Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76391C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483212087C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598443607;
	bh=O8ZwRVfglmC1HCV5rl0wMfnoGxS661gLxObTPdOyfoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l4cjnaJHGDGk/Q4IpvWttJHz3NPK9GjQ0iwyFeqOUk7p+34WwOB6BPT6VA1xMiza5
	 mbDX0F4a3q98Uph8AeJyTWCu4GQL6zDTAoAMcVcDwfTfS7ugOliWjw4s5IKj4D+ChP
	 39Nw4Fn3fZtZWeK0rODmFsgqq7fI+GOwYGGGzHaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgHZMGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729526AbgHZMD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:03:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D12208A9;
        Wed, 26 Aug 2020 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443408;
        bh=O8ZwRVfglmC1HCV5rl0wMfnoGxS661gLxObTPdOyfoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqRxhpi7bploDaVXtx1h/mslopTS/QLDu8swSr5aYZgPhMKlFaJLBRDA/GE+uccEy
         PXCZ5QsdkmL/EYFOy/etybHV1lPUNkPEPPqp1ECSBXf8EqvNm68I7794ehEiCZQROB
         8/UWLexQjLwc8OlVjpZkamRK6HZCFx7PE3WPXXYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxim Mikityanskiy <maximmi@mellanox.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.8 13/16] ethtool: Dont omit the netlink reply if no features were changed
Date:   Wed, 26 Aug 2020 14:02:50 +0200
Message-Id: <20200826114911.869913007@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826114911.216745274@linuxfoundation.org>
References: <20200826114911.216745274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Mikityanskiy <maximmi@mellanox.com>

[ Upstream commit f01204ec8be7ea5e8f0230a7d4200e338d563bde ]

The legacy ethtool userspace tool shows an error when no features could
be changed. It's useful to have a netlink reply to be able to show this
error when __netdev_update_features wasn't called, for example:

1. ethtool -k eth0
   large-receive-offload: off
2. ethtool -K eth0 rx-fcs on
3. ethtool -K eth0 lro on
   Could not change any device features
   rx-lro: off [requested on]
4. ethtool -K eth0 lro on
   # The output should be the same, but without this patch the kernel
   # doesn't send the reply, and ethtool is unable to detect the error.

This commit makes ethtool-netlink always return a reply when requested,
and it still avoids unnecessary calls to __netdev_update_features if the
wanted features haven't changed.

Fixes: 0980bfcd6954 ("ethtool: set netdev features with FEATURES_SET request")
Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ethtool/features.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/net/ethtool/features.c
+++ b/net/ethtool/features.c
@@ -268,14 +268,11 @@ int ethnl_set_features(struct sk_buff *s
 	bitmap_and(req_wanted, req_wanted, req_mask, NETDEV_FEATURE_COUNT);
 	bitmap_andnot(new_wanted, old_wanted, req_mask, NETDEV_FEATURE_COUNT);
 	bitmap_or(req_wanted, new_wanted, req_wanted, NETDEV_FEATURE_COUNT);
-	if (bitmap_equal(req_wanted, old_wanted, NETDEV_FEATURE_COUNT)) {
-		ret = 0;
-		goto out_rtnl;
+	if (!bitmap_equal(req_wanted, old_wanted, NETDEV_FEATURE_COUNT)) {
+		dev->wanted_features &= ~dev->hw_features;
+		dev->wanted_features |= ethnl_bitmap_to_features(req_wanted) & dev->hw_features;
+		__netdev_update_features(dev);
 	}
-
-	dev->wanted_features &= ~dev->hw_features;
-	dev->wanted_features |= ethnl_bitmap_to_features(req_wanted) & dev->hw_features;
-	__netdev_update_features(dev);
 	ethnl_features_to_bitmap(new_active, dev->features);
 	mod = !bitmap_equal(old_active, new_active, NETDEV_FEATURE_COUNT);
 


