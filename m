Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39392C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3FD020791
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pJv2eeNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgH1IkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:40:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38468 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgH1IkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:40:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07S8e2gW069898;
        Fri, 28 Aug 2020 03:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598604002;
        bh=OidMWMav238pDStqzzJV7Lh67PqN4gvpiR7Kj9YEOls=;
        h=From:To:CC:Subject:Date;
        b=pJv2eeNC6z4zKgZ74YpR1URNRwVljhDxFVHrQjFhr6ytCmuI2DiYM2whyjT4bBVkt
         b/REzAepa5AAOVPnK3uR29wB2SmhMvG/Jj8mDqE5ITuJwuiBtM2B8zZ1XiB5hatTb9
         KeIuRdS57FzVqSN88HVpdBJUwltOtja6DGDPUBxQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07S8e2Ns009875
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 03:40:02 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 28
 Aug 2020 03:40:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 28 Aug 2020 03:40:01 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07S8dxhB065831;
        Fri, 28 Aug 2020 03:40:00 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: Remove unused define for dma_request_slave_channel_reason()
Date:   Fri, 28 Aug 2020 11:41:41 +0300
Message-ID: <20200828084141.14902-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users left in the kernel, it can be removed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/dmaengine.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 6fbd5c99e30c..011371b7f081 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1527,8 +1527,6 @@ static inline int dma_get_slave_caps(struct dma_chan *chan,
 }
 #endif
 
-#define dma_request_slave_channel_reason(dev, name) dma_request_chan(dev, name)
-
 static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)
 {
 	struct dma_slave_caps caps;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

