Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E11C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52720214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHRLDva7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgHaUjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgHaUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:38:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93804C06123A;
        Mon, 31 Aug 2020 13:38:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so491705pjb.4;
        Mon, 31 Aug 2020 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/pybmE7a8FIpjQvJ6DGP3d+JulP7r92A2J59iMGiCLM=;
        b=oHRLDva7bE8NCj84o3Pw6XZLnP1yvvF0hDph2uVI7flXevbbdOYILUTOYyZCQ8otre
         cCxr652BWFhSBLsdzy27Cb7Mddqacgb0iPwA8elKbwwEAVUBN15xECe0ThRuaHCOMdkR
         dc3HEMkslEYv9RGiOcoN0hJsz9vazpaaDe3s/dlsGh7DjUCEhA4GdnYvIBBSn8VtTHcx
         lvbLByvCgW0dL5AoLO91GPQcrbxAg2llOaYkOG9iH1BZqv6X0lnc9Cwlvy6dFLfDqm2M
         w4tgaSsKeklGE8LZkIFRnECIGasMSWsPpNmoSLShXelmGeMJiFCs2p43c9vhVvKrOpPS
         4Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/pybmE7a8FIpjQvJ6DGP3d+JulP7r92A2J59iMGiCLM=;
        b=UnSbHLKTXEq1A8r6vt0UX7AC46YWjUgPNwUSQmcDyh49u8duuD56N1q9VtIK8vZB33
         11c3dUM/7aPVdAn/V2NZJkNee7mBF38lvS2CQl1Za7dNdGPkkwvKJGPRlVncKjJWqXfn
         y3hO1EOkqq/pOiGvO8Obr4418D1uoqzS+dCQtFApcgtBH7mgzmxHBdcD/jP9aJJAlEyP
         jhcD+knCtmv8dLwFQBuxvM7mF/xVkuuHh8d6RGA0ITa1qJk1PhMzfPg3RAwCQy1jooM1
         7+pBr0CIMvxpywuLeib5AdtmsLJBcXQzRSsf+lnD5rd4cr9Dy1KZAEZz7aMJ5K1bg5j+
         3dwA==
X-Gm-Message-State: AOAM5319ivjbF5lsnhOXqIx1O0V3y2VLArZgw2lkuUOFbbVH6UdwGB6x
        JfOyZ9QVZyrGeBRReaSXaUM=
X-Google-Smtp-Source: ABdhPJzxmla8Fw1rXgmVa/RE16rISQFkMFWRT5MPsRMrCIi9V2DCsAyGzGk3H5CzIrYzvPZULqAD2A==
X-Received: by 2002:a17:902:a412:: with SMTP id p18mr2318693plq.283.1598906333078;
        Mon, 31 Aug 2020 13:38:53 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a26sm116850pfn.93.2020.08.31.13.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:38:52 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        tony.luck@intel.com, fenghua.yu@intel.com, schnelle@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, James.Bottomley@HansenPartnership.com, deller@gmx.de
Cc:     sfr@canb.auug.org.au, hch@lst.de, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [RESEND][PATCH 7/7] parisc: Avoid overflow at boundary_size
Date:   Mon, 31 Aug 2020 13:38:11 -0700
Message-Id: <20200831203811.8494-8-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831203811.8494-1-nicoleotsuka@gmail.com>
References: <20200831203811.8494-1-nicoleotsuka@gmail.com>
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
 drivers/parisc/ccio-dma.c  | 4 ++--
 drivers/parisc/sba_iommu.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index a5507f75b524..c667d6aba764 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -356,8 +356,8 @@ ccio_alloc_range(struct ioc *ioc, struct device *dev, size_t size)
 	** ggg sacrifices another 710 to the computer gods.
 	*/
 
-	boundary_size = ALIGN((unsigned long long)dma_get_seg_boundary(dev) + 1,
-			      1ULL << IOVP_SHIFT) >> IOVP_SHIFT;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	boundary_size = (dma_get_seg_boundary(dev) >> IOVP_SHIFT) + 1;
 
 	if (pages_needed <= 8) {
 		/*
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index d4314fba0269..96bc2c617cbd 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -342,8 +342,8 @@ sba_search_bitmap(struct ioc *ioc, struct device *dev,
 	unsigned long shift;
 	int ret;
 
-	boundary_size = ALIGN((unsigned long long)dma_get_seg_boundary(dev) + 1,
-			      1ULL << IOVP_SHIFT) >> IOVP_SHIFT;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	boundary_size = (dma_get_seg_boundary(dev) >> IOVP_SHIFT) + 1;
 
 #if defined(ZX1_SUPPORT)
 	BUG_ON(ioc->ibase & ~IOVP_MASK);
-- 
2.17.1

