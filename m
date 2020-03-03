Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FB2C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A862A21741
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgCCIWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:22:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:55336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbgCCIWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:22:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6472FBA48;
        Tue,  3 Mar 2020 08:22:53 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 81F7FE1F46; Tue,  3 Mar 2020 09:22:52 +0100 (CET)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net] tun: fix ethtool_ops get_msglvl and set_msglvl handlers
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Message-Id: <20200303082252.81F7FE1F46@unicorn.suse.cz>
Date:   Tue,  3 Mar 2020 09:22:52 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_msglvl and setmsglvl handlers only work as expected if TUN_DEBUG
is defined (which required editing the source). Otherwise tun_get_msglvl()
returns -EOPNOTSUPP but as this handler is not supposed to return error
code, it is not recognized as one and passed to userspace as is, resulting
in bogus output of ethtool command. The set_msglvl handler ignores its
argument and does nothing if TUN_DEBUG is left undefined.

The way to return EOPNOTSUPP to userspace for both requests is not to
provide these ethtool_ops callbacks at all if TUN_DEBUG is left undefined.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 drivers/net/tun.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 650c937ed56b..0aae2d208398 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3557,23 +3557,21 @@ static void tun_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info
 	}
 }
 
+#ifdef TUN_DEBUG
 static u32 tun_get_msglevel(struct net_device *dev)
 {
-#ifdef TUN_DEBUG
 	struct tun_struct *tun = netdev_priv(dev);
+
 	return tun->debug;
-#else
-	return -EOPNOTSUPP;
-#endif
 }
 
 static void tun_set_msglevel(struct net_device *dev, u32 value)
 {
-#ifdef TUN_DEBUG
 	struct tun_struct *tun = netdev_priv(dev);
+
 	tun->debug = value;
-#endif
 }
+#endif /* TUN_DEBUG */
 
 static int tun_get_coalesce(struct net_device *dev,
 			    struct ethtool_coalesce *ec)
@@ -3600,8 +3598,10 @@ static int tun_set_coalesce(struct net_device *dev,
 
 static const struct ethtool_ops tun_ethtool_ops = {
 	.get_drvinfo	= tun_get_drvinfo,
+#ifdef TUN_DEBUG
 	.get_msglevel	= tun_get_msglevel,
 	.set_msglevel	= tun_set_msglevel,
+#endif
 	.get_link	= ethtool_op_get_link,
 	.get_ts_info	= ethtool_op_get_ts_info,
 	.get_coalesce   = tun_get_coalesce,
-- 
2.25.1

