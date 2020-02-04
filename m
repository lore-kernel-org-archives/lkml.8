Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92512C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E2A20730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cpzndZJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBDP1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:27:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35546 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgBDP1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:27:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 014FRZwG018552;
        Tue, 4 Feb 2020 09:27:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580830055;
        bh=wl/OqPoMT6P6lJijjVt5Lv2nuvg3PQGO2DJhjkelb0M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cpzndZJcZ4iG52HB27Wy3pNjMKQAP71+karP/wtmxJaaD4OBvNZaKTDjKP0roycLJ
         pM4SQhKz6MsEZaH2eoAdCd5Y4PI2wy9eyOT5cgz84Y/Y9Qps+nO5Nz86jRbtY2avaD
         5hl42dhLV8T8S+hO58cw4I9/lJfkHMp5jk3NBNPA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 014FRZ6E073376
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Feb 2020 09:27:35 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 4 Feb
 2020 09:27:34 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 4 Feb 2020 09:27:34 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 014FRR8l118803;
        Tue, 4 Feb 2020 09:27:32 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 2/3] firmware: ti_sci: Export devm_ti_sci_get_of_resource for modules
Date:   Tue, 4 Feb 2020 17:27:26 +0200
Message-ID: <20200204152727.26028-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204152727.26028-1-peter.ujfalusi@ti.com>
References: <20200204152727.26028-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow devm_ti_sci_get_of_resource() to be usable from modules.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/firmware/ti_sci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index f13e4a96f3b7..3d8241cb6921 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3332,6 +3332,7 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 
 	return ERR_PTR(-EINVAL);
 }
+EXPORT_SYMBOL_GPL(devm_ti_sci_get_of_resource);
 
 static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 				void *cmd)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

