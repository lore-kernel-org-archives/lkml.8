Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A69BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B8121556
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607578;
	bh=ac9LB+mggSg1L55NuykFTX4QFSdgB8uLvduZC4UzgWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n1c100Si58tHhoN34wNhB+471bmYtJLO60DtHc8DwENEopxECSfJ0HRjX51i/cNQk
	 IcCn276N+BLHHT1PBt+QlcmAkMnrLPwF58ZP9SJClclKGwY1od925NcCRPpRodfOke
	 ixOGj6gIW5pTih04aBH4p8dPMWTPtjDxEQrZAq8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgDKMTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgDKMTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:19:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DE2F2084D;
        Sat, 11 Apr 2020 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607573;
        bh=ac9LB+mggSg1L55NuykFTX4QFSdgB8uLvduZC4UzgWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vxROhwuCWALl10m6xCyJ8cuTvdbN41vcSRceo2XD+3K6EoTN/NJUuMmMFk1X0gjFX
         5Xi7rOYIr1KFqr/Uym7l80eklQlk3P/tOmc3mRS0tPMa/idS5EifjBWFMP5wCAssRG
         UhKkcGsHzUuOETTQ/t6tbCUcOaX7tHNQNJnAzTCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 06/44] net: phy: micrel: kszphy_resume(): add delay after genphy_resume() before accessing PHY registers
Date:   Sat, 11 Apr 2020 14:09:26 +0200
Message-Id: <20200411115457.413602141@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115456.934174282@linuxfoundation.org>
References: <20200411115456.934174282@linuxfoundation.org>
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


