Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D897CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C97C2124A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vB1EXxBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbgEMNNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:13:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39080 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733082AbgEMNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:13:06 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DDD5LJ115655
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589375585;
        bh=CpGCEBA726pte9LHHgczZG0fUxnIVdibgI7dXAA064U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vB1EXxBiw6xBKHRH6JnJGg/pv2v2bkk9IsTEjEscOiyfY5JOxEGQVd9Ek4GXmMvnt
         Tb3Cw/4dDWkT70CxQsNtvWlKFMp9d2QKf2b+3hlqdY+v32tvL+fcKeyXA9kwpEDMoK
         WJjP63374PJnRfw3iAejWPc1+IcdWQmN21RSvap4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DDD5x5093814
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:13:05 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 08:13:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 08:13:05 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DDD16d043420;
        Wed, 13 May 2020 08:13:03 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <vigneshr@ti.com>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] phy: ti: am654: show up in regmap debugfs
Date:   Wed, 13 May 2020 16:12:53 +0300
Message-ID: <20200513131254.10497-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513131254.10497-1-rogerq@ti.com>
References: <20200513131254.10497-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max_register property must be set in order to
show up the registers in debugfs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/ti/phy-am654-serdes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index 88a047b9fa6f..29e34d29895a 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -77,6 +77,7 @@ static struct regmap_config serdes_am654_regmap_config = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.fast_io = true,
+	.max_register = 0x1ffc,
 };
 
 static const struct reg_field cmu_master_cdn_o = REG_FIELD(CMU_R07C, 24, 24);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

