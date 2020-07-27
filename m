Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714EFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7982074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G8FBqiqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgG0TqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:46:08 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57110 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0TqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:46:07 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06RJk6BP072038;
        Mon, 27 Jul 2020 14:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595879166;
        bh=EntCQY4OOVYt5CBV7Khjuda4IV8i20/sUu6EEAxV8FY=;
        h=From:To:CC:Subject:Date;
        b=G8FBqiqFnucS+qBvMZeLmbNsNe9EUzIpREac1lCaxatnHI8kQhIQVgzIYneikypY7
         dcqGBiee39IH5G0y0KgXaDnhvZDjKLS+OSTwfaEu8+nkqwCoTOgCPiT+hy4KX/Ixsv
         u7i5EwpNwdRAlxk1kWK3CkB+G2oGPlc0Ov/j70JQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06RJk6X4022780
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 14:46:06 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Jul 2020 14:46:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Jul 2020 14:46:05 -0500
Received: from pxplinux063.india.englab.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06RJk3mW036731;
        Mon, 27 Jul 2020 14:46:04 -0500
From:   Sekhar Nori <nsekhar@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 0/3] phy: ti: am654: improve PCIe enumeration performance
Date:   Tue, 28 Jul 2020 01:16:00 +0530
Message-ID: <20200727194603.44636-1-nsekhar@ti.com>
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
issues seen previously.

Series applies to v5.8-rc3

changes in v2:
- Fix W=1 warning
- Remove references to Gen3 issues because Gen3 is not
  supported due to errata on AM654x device.

Sekhar Nori (3):
  phy: ti: am654: simplify regfield handling
  phy: ti: am654: simplify return handling
  phy: ti: am654: update PCIe serdes config

 drivers/phy/ti/phy-am654-serdes.c | 325 +++++++++++++++++++-----------
 1 file changed, 211 insertions(+), 114 deletions(-)

-- 
2.17.1

