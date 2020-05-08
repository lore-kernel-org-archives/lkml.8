Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD9DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72248206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943961;
	bh=umPbEYMIhzfcDyFvmPVUvgjO5yt1/0HqmvIq/Nw+3fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G+vJsQWYJByr2lH4pT70sP5DVbfo+D4G5oQWKNNmcUUSfs7bcjrsLKpEcTc1C+too
	 VTB1ZKoHxhXP911+GEJQhy9DRS3HcRQXdAC++U7GcR5MN8YHb/HDOKSM61Zxg6M8Tm
	 i/iYtJ61dB2qjsiqLQ+37i4ZrQDekArXhJHtGpyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgEHNTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbgEHMmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:42:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F7A24971;
        Fri,  8 May 2020 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941741;
        bh=umPbEYMIhzfcDyFvmPVUvgjO5yt1/0HqmvIq/Nw+3fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FvW04gvVip5nKO6jXMFWBNeVwtuM8f55iWEqDwsyJlLtr2zqknw4qAlrN7l9otdc0
         qdOZqwqNZ8f6ef1HryOk9Z9va6H6hIWpwyhscYapg2bob4K9ZPYVwbc32zJGKVIy9f
         gJSRdfQcF3kLoKT0hnZd4svwU97uOnfO2LRSNoKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 154/312] net: phy: bcm7xxx: Fix shadow mode 2 disabling
Date:   Fri,  8 May 2020 14:32:25 +0200
Message-Id: <20200508123135.292978579@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit 50d899808d33a5b0aa82be23e824119944042689 upstream.

The clear and set masks in the call to phy_set_clr_bits() called from
bcm7xxx_config_init() are inverted. We need to fix this by swapping the two
arguments, that is, set 0 bits, but clear the shade mode 2 enable bit.

Fixes: b560a58c45c66 ("net: phy: add Broadcom BCM7xxx internal PHY driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/phy/bcm7xxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -270,7 +270,7 @@ static int bcm7xxx_config_init(struct ph
 	phy_write(phydev, MII_BCM7XXX_100TX_FALSE_CAR, 0x7555);
 
 	/* reset shadow mode 2 */
-	ret = phy_set_clr_bits(phydev, MII_BCM7XXX_TEST, MII_BCM7XXX_SHD_MODE_2, 0);
+	ret = phy_set_clr_bits(phydev, MII_BCM7XXX_TEST, 0, MII_BCM7XXX_SHD_MODE_2);
 	if (ret < 0)
 		return ret;
 


