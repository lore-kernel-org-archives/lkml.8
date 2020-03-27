Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5714C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DF220717
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgC0XBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 19:01:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:44502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbgC0XBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:01:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BFE7CAC69;
        Fri, 27 Mar 2020 23:01:03 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 6825AE0FC6; Sat, 28 Mar 2020 00:01:03 +0100 (CET)
Message-Id: <1ae600976e0b11c556d35224da395b68700d91e6.1585349448.git.mkubecek@suse.cz>
In-Reply-To: <cover.1585349448.git.mkubecek@suse.cz>
References: <cover.1585349448.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v3 01/12] ethtool: fix reference leak in
 ethnl_set_privflags()
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 28 Mar 2020 00:01:03 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew noticed that some handlers for *_SET commands leak a netdev
reference if required ethtool_ops callbacks do not exist. One of them is
ethnl_set_privflags(), a simple reproducer would be e.g.

  ip link add veth1 type veth peer name veth2
  ethtool --set-priv-flags veth1 foo on
  ip link del veth1

Make sure dev_put() is called when ethtool_ops check fails.

Fixes: f265d799596a ("ethtool: set device private flags with PRIVFLAGS_SET request")
Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/ethtool/privflags.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/privflags.c b/net/ethtool/privflags.c
index e8f03b33db9b..77447dceb109 100644
--- a/net/ethtool/privflags.c
+++ b/net/ethtool/privflags.c
@@ -175,9 +175,10 @@ int ethnl_set_privflags(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 	dev = req_info.dev;
 	ops = dev->ethtool_ops;
+	ret = -EOPNOTSUPP;
 	if (!ops->get_priv_flags || !ops->set_priv_flags ||
 	    !ops->get_sset_count || !ops->get_strings)
-		return -EOPNOTSUPP;
+		goto out_dev;
 
 	rtnl_lock();
 	ret = ethnl_ops_begin(dev);
@@ -204,6 +205,7 @@ int ethnl_set_privflags(struct sk_buff *skb, struct genl_info *info)
 	ethnl_ops_complete(dev);
 out_rtnl:
 	rtnl_unlock();
+out_dev:
 	dev_put(dev);
 	return ret;
 }
-- 
2.25.1

