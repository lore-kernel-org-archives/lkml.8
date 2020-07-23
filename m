Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F7DC433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A1920888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oKEKq4RR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGWIqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:46:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40002 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgGWIqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:46:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06N8kX58021672;
        Thu, 23 Jul 2020 03:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595493993;
        bh=DXOZAL0KKMNygS5AT4vKWF0z1NA/C310OctJYhvodDo=;
        h=From:To:CC:Subject:Date;
        b=oKEKq4RRJGUCQ/p6TjPxgt72bGbCu7xtcequzDC2Sgpni5AudRcK0kUZlJgHp1wF2
         wO9VbmyWvfIq/0SvNT+B6G3vCfu1YZPdbSWVKjfpACsGPWCI0DTqvVmrgpPOYLb2qb
         Pz7TUd+5m2Cl+8GihyE7H9OkVOjHSWDGhu/ldJKk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06N8kXLA083852;
        Thu, 23 Jul 2020 03:46:33 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Jul 2020 03:46:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Jul 2020 03:46:33 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06N8kTEK123087;
        Thu, 23 Jul 2020 03:46:30 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/4] arm64: Initial support for Texas Instrument's J7200 Platform
Date:   Thu, 23 Jul 2020 14:16:24 +0530
Message-ID: <20200723084628.19241-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds initial support for latest new SoC, J7200, from Texas Instruments.

The J7200 SoC is a part of the K3 Multicore SoC architecture platform.
It is targeted for for automotive gateway, vehicle compute systems,
Vehicle-to-Vehicle (V2V) and Vehicle-to-Everything (V2X) applications.
The SoC aims to meet the complex processing needs of modern embedded products.

See J7200 Technical Reference Manual (SPRUIU1, June 2020)
for further details: https://www.ti.com/lit/pdf/spruiu1

Testing:
- Boot log: https://pastebin.ubuntu.com/p/FvpzWjf7tw/
- ./scripts/checkpatch --strict
	- Few warningns about Line length exceeding 100 columns.
	  But these are corresponding to comments
- v8make dtbs_check
- DT_SCHEMA_FLAGS="-u"
  DT_SCHEMA_FILES="Documentation/devicetree/bindings/arm/ti/k3.yaml"
  v8make dtbs_check
- DT_SCHEMA_FLAGS="-u"
  DT_SCHEMA_FILES="Documentation/devicetree/bindings/arm/ti/k3.yaml"
  v8make dt_binding_check

Lokesh Vutla (4):
  dt-bindings: arm: ti: Add bindings for J7200 SoC
  dt-bindings: arm: ti: Convert K3 board/soc bindings to DT schema
  arm64: dts: ti: Add support for J7200 SoC
  arm64: dts: ti: Add support for J7200 Common Processor Board

 .../devicetree/bindings/arm/ti/k3.txt         |  26 ---
 .../devicetree/bindings/arm/ti/k3.yaml        |  28 +++
 MAINTAINERS                                   |   2 +-
 arch/arm64/boot/dts/ti/Makefile               |   3 +-
 .../dts/ti/k3-j7200-common-proc-board.dts     |  64 ++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 199 ++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  84 ++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  29 +++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          | 165 +++++++++++++++
 9 files changed, 572 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200.dtsi

-- 
2.27.0

