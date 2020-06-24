Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687BFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42FA92088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CWrjYWYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390440AbgFXMQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:16:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38782 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388296AbgFXMQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:16:19 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OCGCSd066061;
        Wed, 24 Jun 2020 07:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593000972;
        bh=4i/GtgXzaE4o8MhETtpPJ0dJbtJx23GHh6y7ROguMRQ=;
        h=From:To:CC:Subject:Date;
        b=CWrjYWYX/N1SyHgIiR1pmw62HelnV9IN414lBxYHxfT3qeDsjnJm7Y01UHAZ8yX//
         LmGPU1Z2ur0xMqTHicN2noYcmP1BQpNvg0IY6TGw4wPZf/xHNl6pCh+IzT/PhP/teW
         BzPWj9MJ2gR5sWDmYcNhVk1+qZaueOLV39gqurdQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OCGCov068786
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 07:16:12 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 07:16:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 07:16:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OCGC3o070089;
        Wed, 24 Jun 2020 07:16:12 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <robh@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next v11 0/5] RGMII Internal delay common property
Date:   Wed, 24 Jun 2020 07:16:00 -0500
Message-ID: <20200624121605.18259-1-dmurphy@ti.com>
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

The RGMII internal delay is a common setting found in most RGMII capable PHY
devices.  It was found that many vendor specific device tree properties exist
to do the same function. This creates a common property to be used for PHY's
that have internal delays for the Rx and Tx paths.

If the internal delay is tunable then the caller needs to pass the internal
delay array and the return will be the index in the array that was found in
the firmware node.

If the internal delay is fixed then the caller only needs to indicate which
delay to return.  There is no need for a fixed delay to add device properties
since the value is not configurable. Per the ethernet-controller.yaml the
interface type indicates that the PHY should provide the delay.

This series contains examples of both a configurable delay and a fixed delay.

Dan Murphy (5):
  dt-bindings: net: Add tx and rx internal delays
  net: phy: Add a helper to return the index for of the internal delay
  dt-bindings: net: Add RGMII internal delay for DP83869
  net: dp83869: Add RGMII internal delay configuration
  net: phy: DP83822: Add setting the fixed internal delay

 .../devicetree/bindings/net/ethernet-phy.yaml | 12 +++
 .../devicetree/bindings/net/ti,dp83869.yaml   | 16 ++-
 drivers/net/phy/dp83822.c                     | 79 +++++++++++++--
 drivers/net/phy/dp83869.c                     | 53 +++++++++-
 drivers/net/phy/phy_device.c                  | 99 +++++++++++++++++++
 include/linux/phy.h                           |  4 +
 6 files changed, 249 insertions(+), 14 deletions(-)

-- 
2.26.2

