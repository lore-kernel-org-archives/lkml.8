Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FE2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6246F21927
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945005;
	bh=0ncV6HTRfo/3u06mJYnRbHPw2o4yr/9wsxgVNim2oHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dnlS8rfF5g5e/GfQyjS/XsUrwxkAXF3XLGlBmIZz7LzAGtMG1Joqn7qDRuUQpEGka
	 5SlG5qW+RAcnVCGiPzx9NZBsi8fOwHi1J8AVXNwMVlkHNNGnW27AG3q3OHFUj735Tf
	 sY0F7uoSkqGNa+CBxlKA3iHwdXJSSY+gTM72C+f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392514AbgFWUnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392478AbgFWUnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:43:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4317C21941;
        Tue, 23 Jun 2020 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944995;
        bh=0ncV6HTRfo/3u06mJYnRbHPw2o4yr/9wsxgVNim2oHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTyP/SGyyh8k5H+cjG1HOEbY4EKiuWw+ynGuHFAf8AmRu8/sz4zD4/kb6kuXoEc8R
         xyyNdswpyxvNe45ItZIJrQQRTjcUpA0XXYLDtWNjkeg98+bBcMjYf8CGshs/IeQAUV
         lJHnGngF2METcfifwL2W4pTP4xo0KFiWnnHxH/UY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH 4.19 206/206] Revert "dpaa_eth: fix usage as DSA master, try 3"
Date:   Tue, 23 Jun 2020 21:58:54 +0200
Message-Id: <20200623195327.188985616@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Vladimir Oltean <vladimir.oltean@nxp.com>

This reverts commit b145710b69388aa4034d32b4a937f18f66b5538e which is
commit 5d14c304bfc14b4fd052dc83d5224376b48f52f0 upstream.

The patch is not wrong, but the Fixes: tag is. It should have been:

	Fixes: 060ad66f9795 ("dpaa_eth: change DMA device")

which means that it's fixing a commit which was introduced in:

git describe --tags 060ad66f97954
v5.4-rc3-783-g060ad66f9795

which then means it should have not been backported to linux-4.19.y,
where things _were_ working and now they're not.

Reported-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2796,7 +2796,7 @@ static int dpaa_eth_probe(struct platfor
 	}
 
 	/* Do this here, so we can be verbose early */
-	SET_NETDEV_DEV(net_dev, dev->parent);
+	SET_NETDEV_DEV(net_dev, dev);
 	dev_set_drvdata(dev, net_dev);
 
 	priv = netdev_priv(net_dev);


