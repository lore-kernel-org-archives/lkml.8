Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47572C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8EAA207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Av7uVPpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgIHRAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:00:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54612 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbgIHQ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:59:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088Gxs55044654;
        Tue, 8 Sep 2020 11:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599584394;
        bh=eBf6w022kym9Gayagub/BbqxkLdQOasz/QgGk92lONg=;
        h=From:To:CC:Subject:Date;
        b=Av7uVPpbX104mK/Ea36tAyR7aUK1YEnwACP7H7KCyJrQ6ZHJGdPLU5MOtonKLtFFY
         PlALFh2N9E8pAevRPEmjnCFHoXtt2fu+xuywXK3XaDy2p5LLHTpGlycxDPxYADaQtI
         /TAO2lVwUn90JtIIilqxRslRyKXEfXU7exhNYLm4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088GxsMi081261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 11:59:54 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 11:59:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 11:59:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088GxquE111910;
        Tue, 8 Sep 2020 11:59:53 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 0/4] arm64: dts: ti: k3-j7200: add dma and mcu cpsw
Date:   Tue, 8 Sep 2020 19:59:38 +0300
Message-ID: <20200908165942.32368-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

arm64: dts: ti: k3-j7200: add dma and mcu cpsw nodes

This series adds DT nodes for TI J7200 SoC
- INTR/INTA, Ringacc and UDMA nodes for Main and MCU NAVSS, which are compatible
  with J721E Soc, to enable DMA support
- MCU CPSW2g DT nodes to enable networking

This series depends on:
 - [PATCH v2 0/4] arm64: Initial support for Texas Instrument's J7200 Platform [1]
   from: Lokesh Vutla <lokeshvutla@ti.com>
 - [PATCH] soc: ti: k3-socinfo: Add entry for J7200 [2]
   from: Peter Ujfalusi <peter.ujfalusi@ti.com>
 - [PATCH] dmaengine: ti: k3-udma: Use soc_device_match() for SoC dependent parameters [3]
   from: Peter Ujfalusi <peter.ujfalusi@ti.com>

[1] https://lore.kernel.org/linux-arm-kernel/20200827065144.17683-1-lokeshvutla@ti.com/T/#m141ae4d0dd818518c00c81806d689983d6e832e6
[2] https://lore.kernel.org/patchwork/patch/1283230/
[3] https://lore.kernel.org/lkml/20200904120009.30941-1-peter.ujfalusi@ti.com/

Changes in v2:
 - fixed DT build warnings (Nishanth Menon)

v1: https://lore.kernel.org/patchwork/cover/1301067/

Grygorii Strashko (3):
  arm64: dts: ti: k3-j7200-main: add main navss cpts node
  arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss node
  arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux
    and phy defs

Peter Ujfalusi (1):
  arm64: dts: ti: k3-j7200: add DMA support

 .../dts/ti/k3-j7200-common-proc-board.dts     |  45 +++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  73 +++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 118 ++++++++++++++++++
 3 files changed, 236 insertions(+)

-- 
2.17.1

