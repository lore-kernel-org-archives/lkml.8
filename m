Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE81AC2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E2620692
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607486;
	bh=ac9LB+mggSg1L55NuykFTX4QFSdgB8uLvduZC4UzgWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AX87ucz1qn4wMB6eNexbx4bugS74wJr9NBo0HNaNa5XGmV/KWMqoFmaaB4226OrBb
	 wCsONKulpnQX7VqnJiWRXB7b0NdzrmMR20cXo5U8hLNt6l3roS1KFfXPJCx+QehW2m
	 YrFf8Z6wrleUpl43IyuT4oJojJPL+PPPSnnHUDfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgDKMSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbgDKMR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:17:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E73020692;
        Sat, 11 Apr 2020 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607479;
        bh=ac9LB+mggSg1L55NuykFTX4QFSdgB8uLvduZC4UzgWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swZ9QyPQYqMqLj5huZaE1vO8ItJz+Dkuv6blh7qjOPfCy5TwFOmFPplwPefhrh9uO
         UEfMSKng59N6CMzzWs0n5AfROgVUGf+ZFBdMhqsCzhf4+U1/tariHxn1uG3AhbVPcx
         VlpA283SeHHH5IuTdJ3wwoF6/RdVz0JJsAX9MH5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 07/41] net: phy: micrel: kszphy_resume(): add delay after genphy_resume() before accessing PHY registers
Date:   Sat, 11 Apr 2020 14:09:16 +0200
Message-Id: <20200411115504.613332853@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115504.124035693@linuxfoundation.org>
References: <20200411115504.124035693@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 6110dff776f7fa65c35850ef65b41d3b39e2fac2 ]

After the power-down bit is cleared, the chip internally triggers a
global reset. According to the KSZ9031 documentation, we have to wait at
least 1ms for the reset to finish.

If the chip is accessed during reset, read will return 0xffff, while
write will be ignored. Depending on the system performance and MDIO bus
speed, we may or may not run in to this issue.

This bug was discovered on an iMX6QP system with KSZ9031 PHY and
attached PHY interrupt line. If IRQ was used, the link status update was
lost. In polling mode, the link status update was always correct.

The investigation showed, that during a read-modify-write access, the
read returned 0xffff (while the chip was still in reset) and
corresponding write hit the chip _after_ reset and triggered (due to the
0xffff) another reset in an undocumented bit (register 0x1f, bit 1),
resulting in the next write being lost due to the new reset cycle.

This patch fixes the issue by adding a 1...2 ms sleep after the
genphy_resume().

Fixes: 836384d2501d ("net: phy: micrel: Add specific suspend")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/micrel.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -25,6 +25,7 @@
 #include <linux/micrel_phy.h>
 #include <linux/of.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 
 /* Operation Mode Strap Override */
 #define MII_KSZPHY_OMSO				0x16
@@ -902,6 +903,12 @@ static int kszphy_resume(struct phy_devi
 
 	genphy_resume(phydev);
 
+	/* After switching from power-down to normal mode, an internal global
+	 * reset is automatically generated. Wait a minimum of 1 ms before
+	 * read/write access to the PHY registers.
+	 */
+	usleep_range(1000, 2000);
+
 	ret = kszphy_config_reset(phydev);
 	if (ret)
 		return ret;


