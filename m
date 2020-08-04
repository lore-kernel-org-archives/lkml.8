Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EDFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F8920792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i0q/abFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHDVR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:17:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37706 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDVR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:17:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 074LHijA092401;
        Tue, 4 Aug 2020 16:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596575864;
        bh=dnuKJu0JfecZdhyAST4+2sMtlGa18cLkeWz2YiyDzig=;
        h=From:To:CC:Subject:Date;
        b=i0q/abFpuKOV5IsD4azc5ksGsYqX3f7dyH5+8u9Uqb61EtLj7lQ5mSygjpvnyiA3M
         B23ZLI5O1CZVcgBuJKoG9JgIn37syx5fkfeqM0x0cwCIbqaHcRaZC/rM4iA5dQey7y
         eoeCiWMUQ3wrPxnr1wfHTT12bRC01HFpKEXNhVZg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 074LHi8l040102
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Aug 2020 16:17:44 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 4 Aug
 2020 16:17:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 4 Aug 2020 16:17:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 074LHgUF061484;
        Tue, 4 Aug 2020 16:17:43 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next 0/3] soc: ti: k3: add am65x sr2.0 support
Date:   Wed, 5 Aug 2020 00:17:29 +0300
Message-ID: <20200804211732.2861-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

This series adds support for the TI AM65x SR2.0 SoC Ringacc which has fixed
errata i2023 "RINGACC, UDMA: RINGACC and UDMA Ring State Interoperability
Issue after Channel Teardown". This errata also fixed for J271E SoC.
The SOC bus chipinfo data is used to identify the SoC and configure
i2023 errata W/A.

This changes made "ti,dma-ring-reset-quirk" DT property obsolete, so it's removed.

Grygorii Strashko (3):
  soc: ti: k3: ringacc: add am65x sr2.0 support
  bindings: soc: ti: soc: ringacc: remove ti,dma-ring-reset-quirk
  arm64: dts: ti: k3-am65: ringacc: drop ti,dma-ring-reset-quirk

 .../bindings/soc/ti/k3-ringacc.yaml           |  6 ----
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  1 -
 drivers/soc/ti/k3-ringacc.c                   | 33 +++++++++++++++++--
 4 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.17.1

