Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7295C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 12:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5FF20702
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 12:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FuzVi8r1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgBVMED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 07:04:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60714 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgBVMEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 07:04:02 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01MC3xhj101985;
        Sat, 22 Feb 2020 06:03:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582373039;
        bh=CVChufTOjcuGHdRUZGB/Icn/+ZXJucgtIEXbsDyXks8=;
        h=From:To:CC:Subject:Date;
        b=FuzVi8r1+t7CGCIub8szbwn2hk1qARRwaYPB7OZkkhy/vQewlLW/5RGU87WrXxpPJ
         7pjBYM5zMq3CTyeVVpzLMwJqQCnqprQdyjmOSX+MVAcUrvzF1mjhB/W2Fadt65k01v
         nYknmC2KPC5o71ZirnaQQQsRx7aaB6f/IM4KYBEk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01MC3xga130990
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Feb 2020 06:03:59 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sat, 22
 Feb 2020 06:03:59 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sat, 22 Feb 2020 06:03:59 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01MC3wX4006751;
        Sat, 22 Feb 2020 06:03:58 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [for-next PATCH 0/5] phy: ti: gmii-sel: add support for am654x/j721e soc
Date:   Sat, 22 Feb 2020 14:03:53 +0200
Message-ID: <20200222120358.10003-1-grygorii.strashko@ti.com>
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

