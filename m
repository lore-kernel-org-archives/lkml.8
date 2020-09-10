Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3BEC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBEEC206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="m1sx4C55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgIJVuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbgIJMZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:25:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4AFC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 05:25:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so2955643pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJMQ3l7D9c1jHa3lkbxsVQsPn/mQ9PWhdKwZ9KNTL6I=;
        b=m1sx4C55eJpUl/NnpzeEMYTsIQfCoVNwoG8sK1YYCwSWbS6ebtldCBKjzYquGLJjNb
         QIkcdQuSa6qC23sA76PmOxA0DkhHCbwLrOhCEHp1G0PBy1xjZp/tUNmksgcasW7GOT0j
         E9LXqk9iqt+2QCWGibI/eDous4DmVn8USIg9HEQU3Kay7RmqvtCf+q4GWnMism4PPEgM
         SQymKP32ZUnheFlxQNdm9dPFNFQZjZDRu8ZIHOuCFTwW7TGer0Ztk/FbzPMimjfA9q1J
         izcM2lTlMcR61ypwwE6qfjLhQC7PrBL/SE/MpsfAFJXSHemJijDGeKQ7xQIGqWaTMYcG
         t7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJMQ3l7D9c1jHa3lkbxsVQsPn/mQ9PWhdKwZ9KNTL6I=;
        b=IrI13oFehvUqp7a/a7MGWtxwmq0oAdbjrkeyjgdqFbMZFg1aw2MkqX1zYa/nAUnBbz
         ItFGpddvyv8XgFgymkDbtxC+HO/91Sqf0W426YLKmCQyKnMWJFLVnQDNKzfYOeAs8mnb
         n5TrQTxhzZikBFig2xqZNzLbB/IB9uC/jH2ljLR6Uwbd72dv+5q1ugFlaAH/lI9/1Heo
         fM5f0zvNvBY/qNFs7r0jRjExZxFzH3OmIs6Fn7cLDJ2Sbhoy8gTkk2zTfwoxY8wgCSSc
         wlyViy62en+Cz35sVKLkhq5JcDpUSXgCxNlxjETIEZJKSpZggPBjVjmmtN6hd+pj0n8Q
         ouPg==
X-Gm-Message-State: AOAM53205x9B+LMR2ltZDsK0XVnCplVssoVfpBHUNjPz1jEq4cgSX/xu
        3LRDryvZA5y7rG8Z1PQvTydj6QrWxNKwcA==
X-Google-Smtp-Source: ABdhPJxF0L7lT3zbj43remcUB5Nu+6dRtVmxE0rsS/gucrCs0yEG8pClpd02cocKxEcMYApUlX0oyQ==
X-Received: by 2002:a17:90b:1046:: with SMTP id gq6mr4966136pjb.231.1599740748465;
        Thu, 10 Sep 2020 05:25:48 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.teksavvy.com ([69.172.145.184])
        by smtp.googlemail.com with ESMTPSA id z18sm5884124pfn.186.2020.09.10.05.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:25:47 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Handle init_iova_flush_queue failure in dma-iommu path
Date:   Thu, 10 Sep 2020 13:25:38 +0100
Message-Id: <20200910122539.3662-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_iova_flush_queue can fail if we run out of memory. Fall back to noflush
 queue if it fails.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4959f5df21bd..5f69126f3e91 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -343,8 +343,11 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
 			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
-		cookie->fq_domain = domain;
-		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
+		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
+					NULL))
+			pr_warn("iova flush queue initialization failed\n");
+		else
+			cookie->fq_domain = domain;
 	}
 
 	if (!dev)
-- 
2.20.1

