Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFBBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09402070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EFifNyF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgETMSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:18:48 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59118 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETMSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:18:47 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04KCIfBW111632;
        Wed, 20 May 2020 07:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589977121;
        bh=lveTRFgFsCYfbjIVbrg/oRtKQhc97NWSLfFp+S3MDJ0=;
        h=From:To:CC:Subject:Date;
        b=EFifNyF26m64h5Ac9yQ+0nm+bLY7r2/UH38jlrHBRUegrUKRrEmlBnZRETB/fCpsn
         DAMAKkZb18O8CNj7e7asLFKm8qBHbOcG9Nd7pou7/aJeowew+IVtzMO8EmpiiZzagL
         duW2wsbAT3G8H7EP8ZkKwJykk/Nf4BYyEQl5xVrw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04KCIf1F090299
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 07:18:41 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 20
 May 2020 07:18:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 20 May 2020 07:18:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04KCIfmO108587;
        Wed, 20 May 2020 07:18:41 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next v2 0/4] DP83869 Enhancements
Date:   Wed, 20 May 2020 07:18:31 -0500
Message-ID: <20200520121835.31190-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

These are improvements to the DP83869 Ethernet PHY driver.  OP-mode and port
mirroring may be strapped on the device but the software only retrives these
settings from the device tree.  Reading the straps and initializing the
associated stored variables so when setting the PHY up and down the PHY's
configuration values will be retained.

The PHY also supports RGMII internal delays.  Implement this feature as it
was done in the DP83867 device.

Dan Murphy (4):
  net: phy: dp83869: Update port-mirroring to read straps
  net: phy: dp83869: Set opmode from straps
  dt-bindings: net: Add RGMII internal delay for DP83869
  net: dp83869: Add RGMII internal delay configuration

 .../devicetree/bindings/net/ti,dp83869.yaml   |  16 +++
 drivers/net/phy/dp83869.c                     | 120 +++++++++++++++++-
 include/dt-bindings/net/ti-dp83869.h          |  18 +++
 3 files changed, 150 insertions(+), 4 deletions(-)

-- 
2.26.2

