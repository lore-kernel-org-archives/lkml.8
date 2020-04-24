Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F233AC55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3F520736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Le6o+K1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDXWSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:18:09 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47098 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgDXWSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 18:18:08 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03OMHxjx002836;
        Fri, 24 Apr 2020 17:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587766679;
        bh=T0axgPiXjr3H0jD2jMNWOwBKqepTY1vs30dGpSgzzyU=;
        h=From:To:CC:Subject:Date;
        b=Le6o+K1qyHGjNstdY23h1uG95X2FRGIw+09DNBkrR77CVVuaYQJ7Lqf5gHenCaKt9
         YCd+pkI1hkz0R22ciU9As+KDL7xSpJYBRrGFWS1Xb0y0nFhxNw+hXp2o87VwCSggO1
         Ck16VQvSx5eNE9RsfIpGM+Jve7b3wLhUeOGbAdts=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03OMHx2H056150
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Apr 2020 17:17:59 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 17:17:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 17:17:59 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OMHx5P106506;
        Fri, 24 Apr 2020 17:17:59 -0500
Received: from localhost ([10.250.38.163])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 03OMHwDT081774;
        Fri, 24 Apr 2020 17:17:58 -0500
From:   "Andrew F. Davis" <afd@ti.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] dma-buf: heaps: Initialize during core instead of subsys
Date:   Fri, 24 Apr 2020 18:17:58 -0400
Message-ID: <20200424221758.15984-1-afd@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clients of DMA-Heaps probe earlier than subsys_initcall(), this
can cause issues when these clients call dma_heap_add() before the
core DMA-Heaps framework has initialized. DMA-Heaps should initialize
during core startup to get ahead of all users.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/dma-buf/dma-heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index afd22c9dbdcf..af6edfbeddfe 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -295,4 +295,4 @@ static int dma_heap_init(void)
 
 	return 0;
 }
-subsys_initcall(dma_heap_init);
+core_initcall(dma_heap_init);
-- 
2.17.1

