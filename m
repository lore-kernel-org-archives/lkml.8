Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2C6C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A0B24673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cUIkrbLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAWLpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:45:00 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53834 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbgAWLo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:44:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00NBinIw023470;
        Thu, 23 Jan 2020 05:44:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579779889;
        bh=056yP0wQc7y1OMqVn54WtC4Yn6DYkshBLN9I0yRi7e8=;
        h=From:To:CC:Subject:Date;
        b=cUIkrbLol1zXrJYj+GSwPOJQauBCLtHn6ZqwzVlf4XZMxM9vcmV9zXYdeFC8Yz4yS
         edVrO//9G754yHYpOj6iw4XbW9nzbpUzBgW907Qk7JqWmMGZfBDBO5A7I3g8JfwQY8
         L9TKwkR43NYxF+PugcyaiePOoFHoo9J/2MhG2YRU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00NBimiW016993
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jan 2020 05:44:49 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 23
 Jan 2020 05:44:47 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 23 Jan 2020 05:44:47 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00NBijBD114078;
        Thu, 23 Jan 2020 05:44:45 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>, <lokeshvutla@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/9] arm64: dts: ti: UDMAP and McASP support
Date:   Thu, 23 Jan 2020 13:45:19 +0200
Message-ID: <20200123114528.26552-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2:
- Correct unit addresses for the McASP nodes
- Remove unit address and label for MAIN and MCU NAVSS

Changes since v1:
- rebased on ti-k3-next
- Corrected j721e mcu_udma node: s/udmap/dma-controller
- Moved the two McASP node patch at the end of the series

The ringacc and UDMA documentation and drivers are in next-20200122.

While adding the DMA support I have noticed few issues which is also fixed by
this series.

Tero: I have included the McASP nodes as well to have examples for other
peripherals on how he binding should be used.
The patches for the McASP driver is not in next, but they are only internal
driver changes (and Kconfig), not adding new DT dependencies.
Since the McASP is disabled in SoC dtsi due to board level configuration needs
it is not going to erroneously probe drivers.

It is up to you if you pick them or not, but I believe they serve a safe and
nice example how the dma binding should be used for UDMA.

Regards,
Peter
---
Peter Ujfalusi (9):
  arm64: dts: ti: k3-am65-main: Correct main NAVSS representation
  arm64: dts: ti: k3-am65-main: Move secure proxy under cbass_main_navss
  arm64: dts: ti: k3-am65: DMA support
  arm64: dts: ti: k3-j721e: Correct the address for MAIN NAVSS
  arm64: dts: ti: k3-j721e-main: Correct main NAVSS representation
  arm64: dts: ti: k3-j721e-main: Move secure proxy and smmu under
    main_navss
  arm64: dts: ti: k3-j721e: DMA support
  arm64: dts: ti: k3-am654-main: Add McASP nodes
  arm64: dts: ti: k3-j721e-main: Add McASP nodes

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 122 ++++++-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  46 +++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 313 ++++++++++++++++--
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  45 +++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   2 +-
 5 files changed, 491 insertions(+), 37 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

