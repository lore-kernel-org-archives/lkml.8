Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C538C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE22F2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ0GTxEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgIDNAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbgIDNAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:00:12 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FDBC061246;
        Fri,  4 Sep 2020 06:00:11 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w1so6018614edr.3;
        Fri, 04 Sep 2020 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ED83ClsltKl6ZtFlLHI8TWQIT9oSGeGONF7WLhe+X04=;
        b=SJ0GTxEmI87RApG2Nm2xqHkbFuk4dJ6yhm3b/beBjIC1TMCez8zUa9zx4QAYz0OSDQ
         6eR6wUSL0g9IBGcKMe6r1tILP2Z+egOoDLyjGj03xRL1y+sNWpie4PAVpPOJPwiDicCP
         ss23jzOxg11d1bkFN/mN8Ir9WNd1fygw1T7XQ4FztAzs40FPgKvhQT0xrCs+qb0ciMJN
         UB/CMqXjXf+83yzqRLjuGT24bkmj+GRuP3tYOYNuHadcrCdY6IVP6pa4jG4gIbAISd3M
         bpCOmwfAImflOLX/lig7SbLwJTO1XoC6LHq00r0ROAE9AlLMpNqkrBg7D2Ks0CE3bU68
         FhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ED83ClsltKl6ZtFlLHI8TWQIT9oSGeGONF7WLhe+X04=;
        b=fWG9KUrkp8qspmsKuXZoBJIIRPhp1gm5AJhxOhYOBzVQ0VRuMYwo+3VzPYnPAnw008
         QVZpvFViooizHGal5PnRWJVD3AOuM7NaOo+33pDbEwy9nPmTItFMML/vFEiRJTYimWAw
         ThVbToWZafR/conchP8f4crlAClF0kdGkHTqL8tbgN11kp0MhPFda20IRODYXhtF1Z5D
         QeBAyJ+3FTN9rOuYma0b3jlo2cOVqtsGnmv77PQGc/ow1116EK7lWCfa9AqW0sadHzZa
         j/wvzBOCTYrJGhbstUASJ0X9+bUqAwQKlIILFhSmBexF/VlTzt8OjC56B7gY9I+kErOW
         Dfdw==
X-Gm-Message-State: AOAM532p93wZkIuizbCuHp6D2qg5rO94xxeI0XwVQY3rKLmmxFSyXgH4
        7LBnE1MLWKy5rzVzFCdQslo=
X-Google-Smtp-Source: ABdhPJwnKE/4voTUtlCVakxWkblsJCw+pNCNo078hfIGVA8aCxC+aag5yU6c35xKJU1ZjgNkO0g6iw==
X-Received: by 2002:a50:f081:: with SMTP id v1mr8566185edl.161.1599224410229;
        Fri, 04 Sep 2020 06:00:10 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id g24sm2040948edy.51.2020.09.04.06.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:00:09 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] iommu: dma: Use of_iommu_get_resv_regions()
Date:   Fri,  4 Sep 2020 14:59:59 +0200
Message-Id: <20200904130000.691933-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904130000.691933-1-thierry.reding@gmail.com>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

For device tree nodes, use the standard of_iommu_get_resv_regions()
implementation to obtain the reserved memory regions associated with a
device.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5141d49a046b..1c36ca6ec2a3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -164,6 +165,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
 
+	if (dev->of_node)
+		of_iommu_get_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
2.28.0

