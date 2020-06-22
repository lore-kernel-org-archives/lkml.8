Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9932C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B912076A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YZ3w+n5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgFVUCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:02:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60938 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgFVUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:02:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05MK1gA0118523;
        Mon, 22 Jun 2020 15:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592856102;
        bh=UnjtmQf18KHv3JEllemSjYzNN6dGsJqMcXI38xM2/bI=;
        h=From:To:CC:Subject:Date;
        b=YZ3w+n5H/tTKuBe/BFuUtyjzbyb2kY9YwBhSdTtLoDMccWHyygnOAqoJXgh9DUwaI
         NikZRkBFG3FvCkKZtusxO4TEi9Tkf2sdWo4g873NGSknBXyJ1OkCVluXXwkOety+3C
         7vmFQO7uyPv90vQedVYkW33tmQjFcI0rjinSmr5Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05MK1gH1118398
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 15:01:42 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Jun 2020 15:01:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Jun 2020 15:01:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05MK1eSn061651;
        Mon, 22 Jun 2020 15:01:41 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] soc: ti: k3-ringacc: fix: warn: variable dereferenced before check 'ring'
Date:   Mon, 22 Jun 2020 23:01:37 +0300
Message-ID: <20200622200137.30109-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warning in k3_ringacc_ring_cfg():

smatch warnings:
drivers/soc/ti/k3-ringacc.c:562 k3_ringacc_ring_cfg() warn: variable dereferenced before check 'ring' (see line 559)

  557  int k3_ringacc_ring_cfg(struct k3_ring *ring, struct k3_ring_cfg *cfg)
  558  {
 @559           struct k3_ringacc *ringacc = ring->parent;
                                             ^^^^^^^^^^^^
Dereference.

  560           int ret = 0;
  561
 @562           if (!ring || !cfg)
                    ^^^^

Check too late.  Delete it?

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/soc/ti/k3-ringacc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 5fb2ee2ac978..19156f15af0a 100644
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
+	ringacc = ring->parent;
+
 	if (cfg->elm_size > K3_RINGACC_RING_ELSIZE_256 ||
 	    cfg->mode >= K3_RINGACC_RING_MODE_INVALID ||
 	    cfg->size & ~K3_RINGACC_CFG_RING_SIZE_ELCNT_MASK ||
-- 
2.17.1

