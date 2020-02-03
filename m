Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E3EC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C797D2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vCJnleBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgBCKJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:09:30 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45648 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgBCKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:09:29 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 013A9KwI034849;
        Mon, 3 Feb 2020 04:09:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580724560;
        bh=2hUUozdIkXgPq4UCQpd7JyChjZz/QfVlLVWE+xS6/ek=;
        h=From:To:CC:Subject:Date;
        b=vCJnleBgkmlugF98liU5HWSItdoPV4r3aHSsVKgVzCaIK+5/u/EjF2/ZCiMF35h/y
         Iifj9ALiB37FXTVKXUNlCyIa0LdxAHjDfIxJ4eD4WrNEa7p1C0Uqh6fYmIEoDYXOdV
         pYimNP+Liq1PLp3awnLZSr5HBs9WarHjFRzeOcAU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 013A9JU2025522
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Feb 2020 04:09:20 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 3 Feb
 2020 04:09:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 3 Feb 2020 04:09:19 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 013A9H5l002834;
        Mon, 3 Feb 2020 04:09:17 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <grygorii.strashko@ti.com>, <ssantosh@kernel.org>,
        <santosh.shilimkar@oracle.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dan.carpenter@oracle.com>,
        <t-kristo@ti.com>
Subject: [PATCH] soc: ti: k3-ringacc: Fix dereference before NULL check in k3_ringacc_ring_cfg()
Date:   Mon, 3 Feb 2020 12:09:16 +0200
Message-ID: <20200203100916.19057-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only dereference ring->parent after we have checked that ring is not NULL.

Fixes: 3277e8aa2504 ("soc: ti: k3: add navss ringacc driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/soc/ti/k3-ringacc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 5fb2ee2ac978..8f90cc56d44d 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -556,11 +556,13 @@ static int k3_ringacc_ring_cfg_sci(struct k3_ring *ring)
 
 int k3_ringacc_ring_cfg(struct k3_ring *ring, struct k3_ring_cfg *cfg)
 {
-	struct k3_ringacc *ringacc = ring->parent;
+	struct k3_ringacc *ringacc;
 	int ret = 0;
 
 	if (!ring || !cfg)
 		return -EINVAL;
+
+	ringacc = ring->parent;
 	if (cfg->elm_size > K3_RINGACC_RING_ELSIZE_256 ||
 	    cfg->mode >= K3_RINGACC_RING_MODE_INVALID ||
 	    cfg->size & ~K3_RINGACC_CFG_RING_SIZE_ELCNT_MASK ||
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

