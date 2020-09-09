Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3EBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297BE21D7D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s85dDtWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIIToH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:44:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45718 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:44:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 089JhhQ1004659;
        Wed, 9 Sep 2020 14:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599680623;
        bh=/wApmn7ZtwxFJNgG8a6wEP9k6l5peo+pVV8h6xcv3Bc=;
        h=From:To:CC:Subject:Date;
        b=s85dDtWEjsBhdKOqKf7Hv9G+ulrt3LB9aUTOQ06RSdMmDV8JiJs5nmKPMKwIflz1Z
         3M8Yr2XFMJoOUVBvFyUaLuzBXbfN8LjFNFbuyYFz097glPDqhDS5pQ39a3ytVroZWX
         SWBPpd6FLyOAWdGvUPiw6YUI/Kfb7eWtg4KTbfVs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 089Jhhh6113741
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Sep 2020 14:43:43 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Sep
 2020 14:43:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Sep 2020 14:43:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 089JhfZB019570;
        Wed, 9 Sep 2020 14:43:42 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RESEND PATCH next v2 0/2] soc: ti: k3: ringacc: add am65x sr2.0 support
Date:   Wed, 9 Sep 2020 22:43:36 +0300
Message-ID: <20200909194338.21840-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

soc: ti: k3: ringacc: add am65x sr2.0 support

Hi Santosh,

This is re-send of v2 with DT patch dropped.

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

v2: https://lore.kernel.org/patchwork/cover/1297255/
v1: https://lore.kernel.org/patchwork/cover/1284233/

Grygorii Strashko (2):
  soc: ti: k3: ringacc: add am65x sr2.0 support
  bindings: soc: ti: soc: ringacc: remove ti,dma-ring-reset-quirk

 .../bindings/soc/ti/k3-ringacc.yaml           |  6 ----
 drivers/soc/ti/k3-ringacc.c                   | 33 +++++++++++++++++--
 2 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.17.1

