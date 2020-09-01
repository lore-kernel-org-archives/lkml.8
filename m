Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16592C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7F52078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgIAPCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgIAPCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:02:43 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EF7C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:02:42 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id Nf2g230054C55Sk01f2g9P; Tue, 01 Sep 2020 17:02:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kD7o0-000651-3o; Tue, 01 Sep 2020 17:02:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kD7o0-0003zf-1W; Tue, 01 Sep 2020 17:02:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Gaku Inami <gaku.inami.xh@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] Revert "net: linkwatch: add check for netdevice being present to linkwatch_do_dev"
Date:   Tue,  1 Sep 2020 17:02:37 +0200
Message-Id: <20200901150237.15302-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 124eee3f6955f7aa19b9e6ff5c9b6d37cb3d1e2c.

Inami-san reported that this commit breaks bridge support in a Xen
environment, and that reverting it fixes this.

During system resume, bridge ports are no longer enabled, as that relies
on the receipt of the NETDEV_CHANGE notification.  This notification is
not sent, as netdev_state_change() is no longer called.

Note that the condition this commit intended to fix never existed
upstream, as the patch triggering it and referenced in the commit was
never applied upstream.  Hence I can confirm s2ram on r8a73a4/ape6evm
and sh73a0/kzm9g works fine before/after this revert.

Reported-by Gaku Inami <gaku.inami.xh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 net/core/link_watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 75431ca9300fb9c4..c24574493ecf95e6 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -158,7 +158,7 @@ static void linkwatch_do_dev(struct net_device *dev)
 	clear_bit(__LINK_STATE_LINKWATCH_PENDING, &dev->state);
 
 	rfc2863_policy(dev);
-	if (dev->flags & IFF_UP && netif_device_present(dev)) {
+	if (dev->flags & IFF_UP) {
 		if (netif_carrier_ok(dev))
 			dev_activate(dev);
 		else
-- 
2.17.1

