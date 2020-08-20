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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5B9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EFA207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6SRQTt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgHTXUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbgHTXUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:20:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970E6C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:20:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so116447pjx.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X3g/RFdq0XCD5HjHScp80cQCvDJiBf0FEu2sjpwx7PM=;
        b=H6SRQTt/e40/pQOyXkQ9JtJDyYqK27MLhVSs+T4x0VbMT2Ek2SyHxzAFwZ1ifIQ74Y
         iDpIZ2aV98EUqmIU4+GafEj8GP7Csi80NP0FyFdKeKSjrdEDx2D46CsdT68SxLIG0d9Z
         19uSfPNTXibsNjOKZe8dnldxR9WOKBSIODrOSzHpo6O9ijaZH0CITcn3OUccvGvuXsZi
         SDMGCg6wrvshrhCyYHSTPc6wSA6orbaDIv3XK0WffrRdMK8s8JjzKydHytCyEtGsd37g
         obP653B/poADTj6MYwyRpUYgCdwZDUULd0cgyD5m1EjgK5v65/yTx2kwtEw7mgB6MXuu
         mrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X3g/RFdq0XCD5HjHScp80cQCvDJiBf0FEu2sjpwx7PM=;
        b=sFhRF6aHakR3WjANsp3GTyMi6nRGXpOiDdjuczRYRNKv4XTTCOSJNuYz8mJEFDLTpE
         bU+ULE+sYZ3ejvifGfN2GwhVy3b8NxLVQqIMkYh2ZiqYWImX8qrEzDWNbSGd6H0hBLKF
         xOe954isuWkuOl0wof+J6nZ5MvFW/ax5MB7I/ClzO3Ecr7tIlMDbQJskH9KlCGIBB9pI
         5We5OkFLRGaRYsr1VKRDJP4GrU96QVRMvLerQ7+dwERnjtcEhcQAdkXE7OIePMxQ6Kj/
         03N9bFwrNM/O2JhT/4ssY0D+zJRvN2Y+VdqkEhV/vqabjzuqZi95Z3Y/mVx80tkfytrk
         mdhQ==
X-Gm-Message-State: AOAM533ZAIZ8pP4HoQeC/tbLkHb1iOi3cbphxO4uF1TdLKcXfjIILWHu
        nCApc7JWTuZWUvq/hfI802ymdvZKh2iqpA==
X-Google-Smtp-Source: ABdhPJymF9sP8ZVbRRbulyIKVw8BzxVOEH7wq+yuUEvAaTczXPJW5VOGEKa0aHe1o0ifMP4gvJ/e1Q==
X-Received: by 2002:a17:902:8bcc:: with SMTP id r12mr108273plo.314.1597965606080;
        Thu, 20 Aug 2020 16:20:06 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e29sm154527pfj.92.2020.08.20.16.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 16:20:05 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     sfr@canb.auug.org.au, hch@lst.de, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [RFT][PATCH 1/7] powerpc/iommu: Avoid overflow at boundary_size
Date:   Thu, 20 Aug 2020 16:19:50 -0700
Message-Id: <20200820231950.23719-1-nicoleotsuka@gmail.com>
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

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/iommu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 9704f3f76e63..c01ccbf8afdd 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -236,15 +236,14 @@ static unsigned long iommu_range_alloc(struct device *dev,
 		}
 	}
 
-	if (dev)
-		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				      1 << tbl->it_page_shift);
-	else
-		boundary_size = ALIGN(1UL << 32, 1 << tbl->it_page_shift);
 	/* 4GB boundary for iseries_hv_alloc and iseries_hv_map */
+	boundary_size = dev ? dma_get_seg_boundary(dev) : U32_MAX;
+
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	boundary_size = (boundary_size >> tbl->it_page_shift) + 1;
 
 	n = iommu_area_alloc(tbl->it_map, limit, start, npages, tbl->it_offset,
-			     boundary_size >> tbl->it_page_shift, align_mask);
+			     boundary_size, align_mask);
 	if (n == -1) {
 		if (likely(pass == 0)) {
 			/* First try the pool from the start */
-- 
2.17.1

