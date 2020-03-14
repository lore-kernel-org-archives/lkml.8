Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA46C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B75206E7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP89160w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCNAAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:00:09 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52057 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCNAAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:00:09 -0400
Received: by mail-pj1-f65.google.com with SMTP id hg10so1042502pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F1pA8I6qcaZlWcjwnRAs8TnrPPPQ0hCgFlpwmxQ+nAg=;
        b=DP89160wPxqR7NlCIDr3dcbuICiikU1SQ2Ihh9o7IH0D4jfoUJvpXD8Ur+TmEjBbp8
         57Y7LqM4tKCZTHpZUJ0Bt7C3NxH91QQISz4F74OF+Olo0yYV5xdrq8rh1zbrRb48cK2N
         sJiEkX4p4MHNFo33p05/nP2lDPqeSJ6r052KmbXs7vN5m8JbXUKi/6waPiM2wVZrH63c
         x1xwKUoWmy4HqRfCDhP/7qqpjFjObCnNyD5/Sy2xrKo7BZhRW4g2WzzKxqsGikIPU/jr
         sqO+mA16DoAOSpanmC+rtZjVLsqydrjSkzidDJ2VC1ICDxrDoy6xznXmeG9uUIPpwc08
         WYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F1pA8I6qcaZlWcjwnRAs8TnrPPPQ0hCgFlpwmxQ+nAg=;
        b=G25YJZ/lyFb6/JrRDE3SLl74Mxs5NA1rPkbCGOV4SaM4Xjw1GjRtDEY0XElT+pnlc7
         Rs9JiyqjR5w3SRwyf2uWqtya3cpmwwgeQd+dM0sHm64jnMishsjEC96y7uFyzVXpDDDn
         Kd0D8IQGcT+uSU51jCiT7F0EXPcjABtBJmCflSf2J/v77pp2Xx089ORZTwmAlr+sEGXV
         AB5tMnui3sji+dRwo6J6XzZydTeH64lWSddFiyde5T/Ptk/t3p/CJnDKJE37Zxb4RSS1
         eIfgNyTR7Ljb00QHwUGW0S79M9LoJA4QgcVT3ocgXBBN679SfIzZrCpjzZYp0xpqH+/b
         2BaA==
X-Gm-Message-State: ANhLgQ3NvV24Ipfij7j/hYUThthdaprHxSEJRQFaOFAMfSEdOG67I2Nt
        Ow9+JtfB8WQqxt9StGgOreY=
X-Google-Smtp-Source: ADFU+vs9FQC3C1QjAMHIEA/p8eRKRIlA9KNGtJyFYQfe8Mw8yp5WDzG7vbzV9YmfU6KzBAypnnkoBg==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr15216856pln.185.1584144008118;
        Fri, 13 Mar 2020 17:00:08 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e187sm7011450pfe.50.2020.03.13.17.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 17:00:07 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [RFC][PATCH] dma-mapping: align default segment_boundary_mask with dma_mask
Date:   Fri, 13 Mar 2020 17:00:07 -0700
Message-Id: <20200314000007.13778-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More and more drivers set dma_masks above DMA_BIT_MAKS(32) while
only a handful of drivers call dma_set_seg_boundary(). This means
that most drivers have a 4GB segmention boundary because DMA API
returns DMA_BIT_MAKS(32) as a default value, though they might be
able to handle things above 32-bit.

This might result in a situation that iommu_map_sg() cuts an IOVA
region, larger than 4GB, into discontiguous pieces and creates a
faulty IOVA mapping that overlaps some physical memory being out
of the scatter list, which might lead to some random kernel panic
after DMA overwrites that faulty IOVA space.

We have CONFIG_DMA_API_DEBUG_SG in kernel/dma/debug.c that checks
such situations to prevent bad things from happening. However, it
is not a mandatory check. And one might not think of enabling it
when debugging a random kernel panic until figuring out that it's
related to iommu_map_sg().

A safer solution may be to align the default segmention boundary
with the configured dma_mask, so DMA API may create a contiguous
IOVA space as a device "expect" -- what tries to make sense is:
Though it's device driver's responsibility to set dma_parms, it
is not fair or even safe to apply a 4GB boundary here, which was
added a decade ago to work for up-to-4GB mappings at that time.

This patch updates the default segment_boundary_mask by aligning
it with dma_mask.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 330ad58fbf4d..0df0ee92eba1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
 		return dev->dma_parms->segment_boundary_mask;
-	return DMA_BIT_MASK(32);
+	return (unsigned long)dma_get_mask(dev);
 }
 
 static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
-- 
2.17.1

