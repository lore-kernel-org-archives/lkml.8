Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E3C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0233F20678
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cX2kXwJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgIGPOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:14:42 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56096 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbgIGOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:52:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087EqHfW020796;
        Mon, 7 Sep 2020 09:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599490337;
        bh=BiO2xGTFZ9AuNUE4ZBMLZe1ln1m1EdPZezT+KHBj8tE=;
        h=From:To:CC:Subject:Date;
        b=cX2kXwJKqboEK748JXGafVDPLNslC6LTpneWmVB3K9OtSY5zYZZsbPDt9HlBo9E4q
         L0yEeKCk+tDPrpstPn5DyUCfx9Ou2FggeaggSJkur8z4spJjhj6NTHuYCxpg3aVoeP
         roCC1K56JdcQWW5YaGiZglHxHJJJ4dPIufr3xY64=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 087EqH5I128061
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 09:52:17 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 09:52:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 09:52:17 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087EqEEL010923;
        Mon, 7 Sep 2020 09:52:14 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/6] arm64: dts: ti: Add USB support for J7200 EVM
Date:   Mon, 7 Sep 2020 17:52:07 +0300
Message-ID: <20200907145213.30788-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero/Nishanth,

This series adds USB2.0 support for the J7200 EVM.

Series is based on top of:

    Faiz's MMC/SD support series
    https://lore.kernel.org/lkml/20200907090520.25313-1-faiz_abbas@ti.com/
    Lokesh's initial support series
    https://patchwork.kernel.org/cover/11740039/
    Vignesh's I2C support series
    https://lore.kernel.org/patchwork/cover/1282152/
    Vignesh's Hyperflash series
    https://lore.kernel.org/patchwork/cover/1285326/

cheers,
-roger

Changelog:
v2:
- fixed warnings when built with W=2. Still one warning is present
as property name "dr_mode" by USB core contains underscore.

Kishon Vijay Abraham I (1):
  arm64: dts: ti: k3-j7200-common-proc-board: Configure the SERDES lane
    function

Roger Quadros (5):
  dt-bindings: mux-j7200-wiz: Add lane function defines
  arm64: dts: ti: k3-j7200-main: Add SERDES lane control mux
  arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
  arm64: dts: ti: k3-j7200-main: Add USB controller
  arm64: dts: ti: k3-j7200-common-proc-board: Add USB support

 .../dts/ti/k3-j7200-common-proc-board.dts     | 28 ++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 51 +++++++++++++++++++
 include/dt-bindings/mux/mux-j7200-wiz.h       | 29 +++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

