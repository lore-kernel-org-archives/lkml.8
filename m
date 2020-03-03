Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BEFC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7240320CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UGiVRK6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgCCQAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:00:41 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56840 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgCCQAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:00:41 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 023G0cEW086942;
        Tue, 3 Mar 2020 10:00:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583251238;
        bh=HOj/EzId8wXlbX2yukSDaFJ94slyk8N2M7YFoG5EhpM=;
        h=From:To:CC:Subject:Date;
        b=UGiVRK6SSiuZQ+J3hCm6tehu+XxkvZMfoHQbjQpTzLe4NplPyRzJKmymsyV357jPg
         QHV/U1UzH4ocVZ5+HEuZ/StoTOZlZ1HDKjKI2xp9CQxWXJU/bprWXIeKKyU5jkzNKV
         N1E4PDh+uYfHS/bn6e+kqEDx7/DWijudcUpFzHU0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 023G0b8L103985;
        Tue, 3 Mar 2020 10:00:37 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 10:00:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 10:00:37 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 023G0aFb126032;
        Tue, 3 Mar 2020 10:00:37 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        "David S . Miller" <davem@davemloft.net>
CC:     Sekhar Nori <nsekhar@ti.com>, Rob Herring <robh+dt@kernel.org>,
        netdev <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [for-next PATCH v2 0/5] phy: ti: gmii-sel: add support for am654x/j721e soc
Date:   Tue, 3 Mar 2020 18:00:24 +0200
Message-ID: <20200303160029.345-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

This series adds support for TI K3 AM654x/J721E SoCs in TI phy-gmii-sel PHY
driver, which is required for future adding networking support.

depends on:
 [PATCH 0/2] phy: ti: gmii-sel: two fixes
 https://lkml.org/lkml/2020/2/14/2510

Changes in v2:
 - fixed comments

v1: https://lkml.org/lkml/2020/2/22/100

Grygorii Strashko (5):
  phy: ti: gmii-sel: simplify config dependencies between net drivers
    and gmii phy
  dt-bindings: phy: ti: gmii-sel: add support for am654x/j721e soc
  phy: ti: gmii-sel: add support for am654x/j721e soc
  arm64: dts: ti: k3-am65-mcu: add phy-gmii-sel node
  arm64: dts: ti: k3-j721e-mcu: add scm node and phy-gmii-sel nodes

 .../bindings/phy/ti-phy-gmii-sel.txt          |  1 +
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  6 ++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 14 ++++++++++++++
 drivers/net/ethernet/ti/Kconfig               |  1 +
 drivers/phy/ti/Kconfig                        |  3 ---
 drivers/phy/ti/phy-gmii-sel.c                 | 19 +++++++++++++++++++
 6 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.17.1

