Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C60C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19150207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ddu8Xpcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgH2Sly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:41:54 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44496 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2Slx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:41:53 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07TIfk95048400;
        Sat, 29 Aug 2020 13:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598726506;
        bh=Gtsp2iYQB572vaL3zLmnoVXJyt/ZM6JOaeqNvshSISI=;
        h=From:To:CC:Subject:Date;
        b=Ddu8Xpcw9g5Z+U0QXXjNbHUzt1o61BXz0PTAhXJcwXCrQTlTTruMQhFMaVqU4A+OK
         iGxuTeqoLMHmmWC8/6Mll/zdl/Z/fB8+7F1ld4ZCgU28KFMMmKA0So/zKNEdrbEd/p
         ZhxAT3XJ1VCtbAnJRRQM1o3yzW42elddodPFP3HQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07TIfkvB084203
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 13:41:46 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 29
 Aug 2020 13:41:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 29 Aug 2020 13:41:45 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07TIfiAl110595;
        Sat, 29 Aug 2020 13:41:45 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next v2 0/3] soc: ti: k3: ringacc: add am65x sr2.0 support
Date:   Sat, 29 Aug 2020 21:41:36 +0300
Message-ID: <20200829184139.15547-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

I've rebased on top of  linux-next and identified merge conflict of patch 3
with commit 6da45875fa17 ("arm64: dts: k3-am65: Update the RM resource types")
in -next.

---
This series adds support for the TI AM65x SR2.0 SoC Ringacc which has fixed
errata i2023 "RINGACC, UDMA: RINGACC and UDMA Ring State Interoperability
Issue after Channel Teardown". This errata also fixed for J271E SoC.
The SOC bus chipinfo data is used to identify the SoC and configure
i2023 errata W/A.

This changes made "ti,dma-ring-reset-quirk" DT property obsolete, so it's removed.

Changes in v2:
 - no functional changes
 - rebased on top of linux-next
 - added ask from Rob Herring

v1: https://lore.kernel.org/patchwork/cover/1284233/
    
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

