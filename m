Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F75C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2E0206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoOgqZhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgHTXUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgHTXUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:20:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62031C061385;
        Thu, 20 Aug 2020 16:20:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g15so26313plj.6;
        Thu, 20 Aug 2020 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UkH8Mq/WpiesfkXrapLTRLCROpdsRyoJty+98OOSpss=;
        b=hoOgqZhGHiVLpZeCypo4yuc1a8zxVmMSd4yoH7tyVhF3yOb7NtMj1zSNv5XfOuI8DT
         AlWGPfC0Tt9WPeOHXgkAJrJ/ujCTJum25ZaPdnCViQhCDmL0ejq62ZpTP2MGf4xcxoG8
         //dWA4yoVM2FcKhy57jS98tWjNVY/WXBREVn+qyRrzr0dNU9BFecxR1XvgAZn8URED5w
         +wPjTvUxEMZMZxwJorp0FAVs6Dzx3oks+bUOWlOL32lAOOxtFLtLFbeFQ7+BB6ZrSXwE
         1dNhIXaStLdULE8UgwJGkL+NBxfVbloj5Xsb4QHOV2z6TzlIER2wWcUh9flW3IGobrpm
         XDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UkH8Mq/WpiesfkXrapLTRLCROpdsRyoJty+98OOSpss=;
        b=VfzOpAUGCub3lAiIZ5YKZdKAWNV05Y2N8OuKnUgfP4btaJT8iEFY3dt8shIlSz03ft
         R1fCGpsckPZ/UwyPl1gzsEWCoafKa3uJCBaMQh0/5BOZNRn1WyNiHkBgdByRYImAJvix
         G9WI5evU/FVLx/FsECZz77aS+pXka9SwqdU0yqiHHQv4mwsNwjYHA3si5GOSFKobhXvd
         H3AG5CDCAXJJeVufKNgJ64W52HxzznVSVQraC+6+hb2Xx+mL3aYkbNaIfoumWjQHlAax
         zRO1LXG/hM8Uw/VSdha2itdajHCqNyDWZyHlMqmtITk6vHPOsuvvTdL1KYPXVp5f5Cr0
         L4Wg==
X-Gm-Message-State: AOAM530DznaMRkTOLg1iCszwYwNjc/g/S4Nb84TSf3Ee0yCGHluCHO7U
        w9zNk5kr2vSPsznoHXrPm+rp94TNC3sQ3Q==
X-Google-Smtp-Source: ABdhPJy6feg2kk7nTvSUH+AHBQAq+ZwdrDgcKqcb43pyrkAEQJqGzIlQH6xWUZuZ1neelwbWE1oCvA==
X-Received: by 2002:a17:90b:255:: with SMTP id fz21mr202213pjb.50.1597965646928;
        Thu, 20 Aug 2020 16:20:46 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b15sm112786pgk.14.2020.08.20.16.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 16:20:46 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     schnelle@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com
Cc:     hch@lst.de, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFT][PATCH 4/7] s390/pci_dma: Avoid overflow at boundary_size
Date:   Thu, 20 Aug 2020 16:20:32 -0700
Message-Id: <20200820232032.23846-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boundary_size might be as large as ULONG_MAX, which means
that a device has no specific boundary limit. So either "+ 1"
or passing it to ALIGN() would potentially overflow.

According to kernel defines:
    #define ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
    #define ALIGN(x, a)	ALIGN_MASK(x, (typeof(x))(a) - 1)

We can simplify the logic here:
  ALIGN(boundary + 1, 1 << shift) >> shift
= ALIGN_MASK(b + 1, (1 << s) - 1) >> s
= {[b + 1 + (1 << s) - 1] & ~[(1 << s) - 1]} >> s
= [b + 1 + (1 << s) - 1] >> s
= [b + (1 << s)] >> s
= (b >> s) + 1

So fixing a potential overflow with the safer shortcut.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/s390/pci/pci_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 64b1399a73f0..ecb067acc6d5 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -263,8 +263,8 @@ static unsigned long __dma_alloc_iommu(struct device *dev,
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	unsigned long boundary_size;
 
-	boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-			      PAGE_SIZE) >> PAGE_SHIFT;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	boundary_size = (dma_get_seg_boundary(dev) >> PAGE_SHIFT) + 1;
 	return iommu_area_alloc(zdev->iommu_bitmap, zdev->iommu_pages,
 				start, size, zdev->start_dma >> PAGE_SHIFT,
 				boundary_size, 0);
-- 
2.17.1

