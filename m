Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C907C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C3F20731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgD3Uav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:30:51 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:53491
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgD3Uau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:30:50 -0400
X-IronPort-AV: E=Sophos;i="5.73,337,1583190000"; 
   d="scan'208";a="347432591"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 30 Apr 2020 22:30:48 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nic Volanschi <eugene.volanschi@inria.fr>
Subject: [PATCH] dp83640: reverse arguments to list_add_tail
Date:   Thu, 30 Apr 2020 21:51:32 +0200
Message-Id: <1588276292-19166-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this code, it appears that phyter_clocks is a list head, based on
the previous list_for_each, and that clock->list is intended to be a
list element, given that it has just been initialized in
dp83640_clock_init.  Accordingly, switch the arguments to
list_add_tail, which takes the list head as the second argument.

Fixes: cb646e2b02b27 ("ptp: Added a clock driver for the National Semiconductor PHYTER.")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
Not tested.

 drivers/net/phy/dp83640.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 415c27310982..ecbd5e0d685c 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1120,7 +1120,7 @@ static struct dp83640_clock *dp83640_clock_get_bus(struct mii_bus *bus)
 		goto out;
 	}
 	dp83640_clock_init(clock, bus);
-	list_add_tail(&phyter_clocks, &clock->list);
+	list_add_tail(&clock->list, &phyter_clocks);
 out:
 	mutex_unlock(&phyter_clocks_lock);
 

