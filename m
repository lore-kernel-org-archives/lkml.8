Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F01C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665C220723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbgEVVbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:31:47 -0400
Received: from foss.arm.com ([217.140.110.172]:42348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbgEVVbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:31:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 524831063;
        Fri, 22 May 2020 14:31:13 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B3183F68F;
        Fri, 22 May 2020 14:31:13 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        madalin.bucur@oss.nxp.com, calvin.johnson@oss.nxp.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 07/11] net: phy: reset invalid phy reads of 0 back to 0xffffffff
Date:   Fri, 22 May 2020 16:30:55 -0500
Message-Id: <20200522213059.1535892-8-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200522213059.1535892-1-jeremy.linton@arm.com>
References: <20200522213059.1535892-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMD's in the device list sometimes return 0 for their id.
When that happens lets reset the id back to 0xfffffff so
that we don't get a stub device created for it.

This is a questionable commit, but i'm tossing it out
there along with the comment that reading the spec
seems to indicate that maybe there are further registers
that could be probed in an attempt to resolve some futher
"bad" phys. It sort of comes down to do we want unused phy
devices floating around (potentially unmatched in dt) or
do we want to cut them off early and let DT create them
directly.

For the ACPI case, we don't really have a good way to match
them, and since it hasn't been working I think its perfectly
reasonable at this point to expect phy's to implement enough
of the standard that we can detect them and attach a phy
specific driver.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/net/phy/phy_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b2cd22d6315c..acdada865864 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -780,6 +780,10 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr, u32 *phy_id,
 			return ret;
 		if (valid_phy_id(c45_ids->device_ids[i]))
 			valid_id = true;
+		else
+			c45_ids->device_ids[i] = 0xffffffff;
+
+		/* consider probing PKGID per 45.2.12.2.1? */
 	}
 
 	if (!valid_id && c22_present)
-- 
2.26.2

