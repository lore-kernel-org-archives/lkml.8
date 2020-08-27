Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D89C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B122080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgH0PQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:16:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35622 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgH0PPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:15:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id i10so6884194ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vee510hlaKXEjilUzfAAyKIFzgEM6FJYt8Ol80rJ/4g=;
        b=t/o2WDYxUN0aHwsD9rZ1xk22+koLQmPHqh4SGTMOCytHpSE038ixLdGHHmns8OPjVo
         R4YnYe7ULRp1tM06XJzPEUn5eogarylJBT1Ejn/I9NHYiH0kk2rP6p78+OZuKW93B5Ts
         wYt2Rn7H04+eL9aIN2ekS43119uawFtXBqoXYYzyNTiML+DT4MO0JSrElHNxO1Aii+6P
         B4HAqFE5Gw3qPvdzZt5cMAS07JGi3ZaHwL5raENV+9UuJ2BHNrr0BtxvBTiaQvhd5NRi
         FtBn8d2XEgm/izwnh3/ITXIlVNr93YQoNC2PV8OSSAsB8LhXuLys9FMnvMxuHATv3Ih5
         mwag==
X-Gm-Message-State: AOAM533xw4hYSFCavGsylWZzNkhV7crqqX3xQ5UUILG/S13JXYFTFYhw
        BlsDJHFqDCIMf0iNzjeV1iE=
X-Google-Smtp-Source: ABdhPJwXlSIz+YWou16eoxNonKiNs689uN3pfPogY0WqVFeBhVt5XbmYDxq34O0s8zLwVcqzGrEzCA==
X-Received: by 2002:a2e:918f:: with SMTP id f15mr9729215ljg.86.1598541350578;
        Thu, 27 Aug 2020 08:15:50 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id y9sm532209lji.106.2020.08.27.08.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:15:50 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Denis Efremov <efremov@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM/dma-mapping: use kvzalloc() in __iommu_alloc_buffer()
Date:   Thu, 27 Aug 2020 18:15:41 +0300
Message-Id: <20200827151541.39662-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvzalloc() in __iommu_alloc_buffer() instead of open-coding it.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/arm/mm/dma-mapping.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8a8949174b1c..9def10affa70 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1203,10 +1203,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	int i = 0;
 	int order_idx = 0;
 
-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, GFP_KERNEL);
-	else
-		pages = vzalloc(array_size);
+	pages = kvzalloc(array_size, GFP_KERNEL);
 	if (!pages)
 		return NULL;
 
-- 
2.26.2

