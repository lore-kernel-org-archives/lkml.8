Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171B9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27512467F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699594;
	bh=3TSY0k3j/NS0qp81sKVoj9zgSdog5u4XrMOmTpcP3dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T3YAynI18UAx/meadnQEZKRDhTptlOkeMB9ybHtM+ZXegc0gswz++jHR0BMFrpJsZ
	 Yr3wjc9YrYHWNupTbYNtR+sm24DkjyqmwNtzV7p/j3Vv3UmcDicycGspuwvgoXFpK/
	 5vyAY9B68bm8VQBI/3AUttWcS0lO4As8OdASBz4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgAVN0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbgAVN0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:26:31 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D787B2467B;
        Wed, 22 Jan 2020 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699590;
        bh=3TSY0k3j/NS0qp81sKVoj9zgSdog5u4XrMOmTpcP3dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAT8WlkKRiG/QTBSDZWy93uTXfPFwTUaKPzmfoSU+RZCkMllW3DrUOSx4FvhsC9N0
         SyxkQliiMOB+WOlCjplREYIYOo1Su+DJdSWuZ50nWHG3eHuDY+6D837PW54QBjSS9I
         yb+2v6o6T8hBzXh/0Z4CvF1ftbmMEvPIhxhuVCeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 152/222] net: ethernet: ave: Avoid lockdep warning
Date:   Wed, 22 Jan 2020 10:28:58 +0100
Message-Id: <20200122092844.606889750@linuxfoundation.org>
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

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

[ Upstream commit 82d5d6a638cbd12b7dfe8acafd9efd87a656cc06 ]

When building with PROVE_LOCKING=y, lockdep shows the following
dump message.

    INFO: trying to register non-static key.
    the code is fine but needs lockdep annotation.
    turning off the locking correctness validator.
     ...

Calling device_set_wakeup_enable() directly occurs this issue,
and it isn't necessary for initialization, so this patch creates
internal function __ave_ethtool_set_wol() and replaces with this
in ave_init() and ave_resume().

Fixes: 7200f2e3c9e2 ("net: ethernet: ave: Set initial wol state to disabled")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/socionext/sni_ave.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -424,16 +424,22 @@ static void ave_ethtool_get_wol(struct n
 		phy_ethtool_get_wol(ndev->phydev, wol);
 }
 
-static int ave_ethtool_set_wol(struct net_device *ndev,
-			       struct ethtool_wolinfo *wol)
+static int __ave_ethtool_set_wol(struct net_device *ndev,
+				 struct ethtool_wolinfo *wol)
 {
-	int ret;
-
 	if (!ndev->phydev ||
 	    (wol->wolopts & (WAKE_ARP | WAKE_MAGICSECURE)))
 		return -EOPNOTSUPP;
 
-	ret = phy_ethtool_set_wol(ndev->phydev, wol);
+	return phy_ethtool_set_wol(ndev->phydev, wol);
+}
+
+static int ave_ethtool_set_wol(struct net_device *ndev,
+			       struct ethtool_wolinfo *wol)
+{
+	int ret;
+
+	ret = __ave_ethtool_set_wol(ndev, wol);
 	if (!ret)
 		device_set_wakeup_enable(&ndev->dev, !!wol->wolopts);
 
@@ -1216,7 +1222,7 @@ static int ave_init(struct net_device *n
 
 	/* set wol initial state disabled */
 	wol.wolopts = 0;
-	ave_ethtool_set_wol(ndev, &wol);
+	__ave_ethtool_set_wol(ndev, &wol);
 
 	if (!phy_interface_is_rgmii(phydev))
 		phy_set_max_speed(phydev, SPEED_100);
@@ -1768,7 +1774,7 @@ static int ave_resume(struct device *dev
 
 	ave_ethtool_get_wol(ndev, &wol);
 	wol.wolopts = priv->wolopts;
-	ave_ethtool_set_wol(ndev, &wol);
+	__ave_ethtool_set_wol(ndev, &wol);
 
 	if (ndev->phydev) {
 		ret = phy_resume(ndev->phydev);


