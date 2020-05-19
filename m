Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3C6207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OAWhflxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgESOSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:18:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58228 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgESOSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:18:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04JEIFDL072918;
        Tue, 19 May 2020 09:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589897895;
        bh=lveTRFgFsCYfbjIVbrg/oRtKQhc97NWSLfFp+S3MDJ0=;
        h=From:To:CC:Subject:Date;
        b=OAWhflxJGa5knRuIVzWNho7IwUkPsXc4Tuu100XRXvBdHxy6Ak46xGJCmw75b4pcH
         XPpdGp8x8XlJ1uc6c45BOwnH7RC8n85FArcei3vjBUiqU3ZRFcPX2iYgeE5+vFFd0I
         k+tpa/Gb0tFswXfnMDB9Ub7xdoywALP/3IX6eicE=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04JEIFUt026317;
        Tue, 19 May 2020 09:18:15 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 09:18:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 09:18:15 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04JEIEcK116770;
        Tue, 19 May 2020 09:18:14 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next 0/4] DP83869 Enhancements
Date:   Tue, 19 May 2020 09:18:09 -0500
Message-ID: <20200519141813.28167-1-dmurphy@ti.com>
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

