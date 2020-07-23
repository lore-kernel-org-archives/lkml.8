Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D334AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C332080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F6Qe5q8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgGWIqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:46:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54328 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgGWIql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:46:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06N8kbPx010598;
        Thu, 23 Jul 2020 03:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595493997;
        bh=DuJZ/2z+67morWWGSFK35kna9LWJPlZ8DPkMvPDT4S8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=F6Qe5q8owszr4+90djTbk/kUCrNihklgerUGiSR9I4arb4mEO5ODaf3HZirzqZxg2
         OYw9DDi8SDjingni/AMugGDc/B3To08mGxaD2dkojvkCDYaHyqFKbAn7Kt7a3ssO8L
         nKrN+xd21IJk/JuCg2NxTPufajgxdbina2EKV40U=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06N8kbxf083903;
        Thu, 23 Jul 2020 03:46:37 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Jul 2020 03:46:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Jul 2020 03:46:36 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06N8kTEL123087;
        Thu, 23 Jul 2020 03:46:33 -0500
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
Subject: [PATCH 1/4] dt-bindings: arm: ti: Add bindings for J7200 SoC
Date:   Thu, 23 Jul 2020 14:16:25 +0530
Message-ID: <20200723084628.19241-2-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723084628.19241-1-lokeshvutla@ti.com>
References: <20200723084628.19241-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J7200 SoC is a part of the K3 Multicore SoC architecture platform.
It is targeted for automotive gateway, vehicle compute systems,
Vehicle-to-Vehicle (V2V) and Vehicle-to-Everything (V2X) applications.
The SoC aims to meet the complex processing needs of modern embedded
products.

Some highlights of this SoC are:
* Dual Cortex-A72s in a single cluster, two clusters of lockstep
  capable dual Cortex-R5F MCUs and a Centralized Device Management and
  Security Controller (DMSC).
* Configurable L3 Cache and IO-coherent architecture with high data
  throughput capable distributed DMA architecture under NAVSS.
* Integrated Ethernet switch supporting up to a total of 4 external ports
  in addition to legacy Ethernet switch of up to 2 ports.
* Upto 1 PCIe-GEN3 controller, 1 USB3.0 Dual-role device subsystems,
  20 MCANs, 3 McASP, eMMC and SD, OSPI/HyperBus memory controller, I3C and
  I2C, eCAP/eQEP, eHRPWM among other peripherals.
* One hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
  management.

See J7200 Technical Reference Manual (SPRUIU1, June 2020)
for further details: https://www.ti.com/lit/pdf/spruiu1

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.txt b/Documentation/devicetree/bindings/arm/ti/k3.txt
index 333e7256126a..33419cce0afa 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.txt
+++ b/Documentation/devicetree/bindings/arm/ti/k3.txt
@@ -16,6 +16,9 @@ architecture it uses, using one of the following compatible values:
 - J721E
   compatible = "ti,j721e";
 
+- J7200
+  compatible = "ti,j7200";
+
 Boards
 ------
 
-- 
2.27.0

