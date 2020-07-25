Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A081C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F369A2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MxMM3/xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGYTFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 15:05:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56358 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGYTFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 15:05:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06PJ4w0q121634;
        Sat, 25 Jul 2020 14:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595703898;
        bh=bcrO5JPPfqTrmrdXgi6Q4PUCXzcq2EQExq4hKiOKZfY=;
        h=From:To:CC:Subject:Date;
        b=MxMM3/xuWah6ncNIsnlmZYsgQi4gEcjg5APH+7zDSB8UreiTMTyz66F6LMwfATqlx
         QJC6M0SJ+3SA/Aj9XT/gfxm79nZYXZEl8o+u8rW7AF2RyjCKkqqHqOQVhqq/E7OYER
         AueBz2Z3TGa3xZrFX9MzWYESlvT2M5j7xSrbsOnM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06PJ4wwM051644
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 25 Jul 2020 14:04:58 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 25
 Jul 2020 14:04:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 25 Jul 2020 14:04:58 -0500
Received: from pxplinux063.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06PJ4uAG024528;
        Sat, 25 Jul 2020 14:04:56 -0500
From:   Sekhar Nori <nsekhar@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 0/3] phy: ti: am654: improve PCIe enumeration performance
Date:   Sun, 26 Jul 2020 00:34:52 +0530
Message-ID: <20200725190455.43500-1-nsekhar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series updates AM654x PCIe serdes settings to
latest recommended by hardware. This fixes Gen2 enumeration
issues and significantly improves Gen3 enumeration failures
seen previously.

Sekhar Nori (3):
  phy: ti: am654: simplify regfield handling
  phy: ti: am654: simplify return handling
  phy: ti: am654: update PCIe serdes config

 drivers/phy/ti/phy-am654-serdes.c | 325 +++++++++++++++++++-----------
 1 file changed, 212 insertions(+), 113 deletions(-)

-- 
2.17.1

