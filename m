Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2183C433FB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9D02070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EYQ2L2LW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGXVnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:43:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37108 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgGXVn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:43:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06OLgpkG088853;
        Fri, 24 Jul 2020 16:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595626971;
        bh=EENDgKjYGdyjuwWFWxbHFsIqJ467mMOcoygJG/xnCoI=;
        h=From:To:CC:Subject:Date;
        b=EYQ2L2LWfZP6dD8JOenRLBNQPDb/OQs5WlBya1sjvMntH3dHBipDrHlcKPanQfDa+
         FWNeBqUZJ7YL9xl7KcY5jepHyEYPcfQV64NMFRIkL5xHX9lfTM1jHgpcNwzr81B61O
         OTniMLY8o22xvmkug62G2MTu+j/p30mCV4kUDxOU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06OLgpNn103365
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 16:42:51 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Jul 2020 16:42:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Jul 2020 16:42:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06OLgodS037326;
        Fri, 24 Jul 2020 16:42:51 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [RESEND PATCH] ARM: dts: keystone-k2g-evm: fix rgmii phy-mode for ksz9031 phy
Date:   Sat, 25 Jul 2020 00:42:21 +0300
Message-ID: <20200724214221.28125-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the
KSZ9031 PHY") the networking is broken on keystone-k2g-evm board.

The above board have phy-mode = "rgmii-id" and it is worked before because
KSZ9031 PHY started with default RGMII internal delays configuration (TX
off, RX on 1.2 ns) and MAC provided TX delay by default.
After above commit, the KSZ9031 PHY starts handling phy mode properly and
enables both RX and TX delays, as result networking is become broken.

Fix it by switching to phy-mode = "rgmii-rxid" to reflect previous
behavior.

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Philippe Schenker <philippe.schenker@toradex.com>
Fixes: bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the KSZ9031 PHY")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Fix for one more broken TI board with KSZ9031 PHY.

 arch/arm/boot/dts/keystone-k2g-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index db640bab8c1d..8b3d64c913d8 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -402,7 +402,7 @@
 
 &gbe0 {
 	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii-rxid";
 	status = "okay";
 };
 
-- 
2.17.1

