Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A63C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0365920730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pj+ZN03x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgBDP1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:27:42 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38564 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgBDP1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:27:42 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 014FRWOn024186;
        Tue, 4 Feb 2020 09:27:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580830052;
        bh=APUqZ/Ex3brLOMfrqG1EG0g6D3kLPOBu7au9AjExCi4=;
        h=From:To:CC:Subject:Date;
        b=pj+ZN03xkXD+VZJekvSEg6q4oxmflWKpWM7CZnUr2BsH/Flga6fiJSD+ERxp/V67g
         iRhoRtg4C1M97rz8ShoYHcZBQQNI0UWEzmAccU5Ox24/Ryrq2WLBQDenrpPFwTRSIa
         pRXml8VVbSQ/CGkXe3es1QutDPNyzblCGgh3es8s=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 014FRWvI068466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Feb 2020 09:27:32 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 4 Feb
 2020 09:27:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 4 Feb 2020 09:27:30 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 014FRR8j118803;
        Tue, 4 Feb 2020 09:27:28 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 0/3] firmware: ti_sci: tx_tdtype and export ti_sci_do_xfer()
Date:   Tue, 4 Feb 2020 17:27:24 +0200
Message-ID: <20200204152727.26028-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

Changes since v1s:
- one series
- Added Reviewed-by from Tero

I have collected the three patch under one series, the first one is needed for
the UDMA driver, the second is required for the UDMA and ringacc drivers to be
buildable as modules.
The last one is a small fix.

Regards,
Peter
---
Peter Ujfalusi (3):
  firmware: ti_sci: rm: Add support for tx_tdtype parameter for tx
    channel
  firmware: ti_sci: Export devm_ti_sci_get_of_resource for modules
  firmware: ti_sci: Correct the timeout type in ti_sci_do_xfer()

 drivers/firmware/ti_sci.c              | 4 +++-
 drivers/firmware/ti_sci.h              | 7 +++++++
 include/linux/soc/ti/ti_sci_protocol.h | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

