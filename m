Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E315C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350ED24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pIxo/H4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgAVIZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:25:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41962 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgAVIZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:25:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00M8PhHo103365;
        Wed, 22 Jan 2020 02:25:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579681543;
        bh=/WBowR+l+tLQLUOoW4H53obJ2M5b7KcGxJ8Z60UMmKE=;
        h=From:To:CC:Subject:Date;
        b=pIxo/H4F1y+C+7lYDGabsr8WFHjfVCZuZ4DFv3ZM4c6MkNmxc3yOyxIetL4Xw06oZ
         AzLCqFQ3wTv4c7kwA7y2NvWT93u65vHmXNX8WDC74goHU1tnjRnCnQ1/iZc8P7ja5N
         jksWqT7jZYkgPm+Pnh/kfjaHLefbPbPhY6HX+yMg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00M8Phv0085345;
        Wed, 22 Jan 2020 02:25:43 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Jan 2020 02:25:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Jan 2020 02:25:42 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00M8PeAG046830;
        Wed, 22 Jan 2020 02:25:40 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/9] arm64: dts: ti: UDMAP and McASP support
Date:   Wed, 22 Jan 2020 10:26:12 +0200
Message-ID: <20200122082621.4974-1-peter.ujfalusi@ti.com>
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

