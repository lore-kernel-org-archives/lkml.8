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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02E9C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71987208A9
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTBIoSkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgHaUjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgHaUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:38:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEE9C061573;
        Mon, 31 Aug 2020 13:38:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id g6so487382pjl.0;
        Mon, 31 Aug 2020 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X3g/RFdq0XCD5HjHScp80cQCvDJiBf0FEu2sjpwx7PM=;
        b=FTBIoSkSFCuYfdZZaBdmEHEhwrbZcdgJQEmZ6+shh7rWUbYFsVNhqAvIZ76+x5Agay
         HZGd1vGAqH8QZN271wpNdm5UMhzNI4fjZxpDIzQoQQOkYhhXQV4pGykHjIkWUcRA+os0
         cfATZ79F07KBkEiXisWvSKSKRlB4nNLiJWGlc+KoC+c9cNTLJbaRwkGPyOMfTgCsij4L
         AIXUcsy6y/nvNko5LI3a7lMyuCUxiq3vv5/NauqeVADCoaX5kExpDbcxIi+KIEtcENxO
         D5VqKn4IFfj/HP7QtYhkIJMrqIKq81+SfGjp//+umfJhEqXXpj1hdk14thzK3bwfoS2D
         lu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X3g/RFdq0XCD5HjHScp80cQCvDJiBf0FEu2sjpwx7PM=;
        b=LNpJ8+j5m8jlnVm/imqaUJfQXArd0ABnQIEGirQumaEtosrz/Onp1Co4MgXUK8tjA+
         J9UIIg5u+G7xJF+5YPWnlLAgcxY2CiCBQhOa8ZGGSiyBs8POcw6jUsQ7cT+7OYCmhpZX
         ElePni5gNGplAZPiCM5NtWnS9EyWIRvtWG3yO1k+Fh4Ciloo6p1duXJD9GHK+ms6hBFb
         nAGJ/6JtgLc+Hmumstx6iWCrofKTK4SlTQr6/s7OCUVtQckHT1qVX8hOuakdSHSvKLYn
         PQDb3pv1zwY1KWa4jG9QnEoD2ZVXqBDxmdgxN9A7Z9baHcc+Sw/kA4N5vwdQIetcRZFi
         8ORQ==
X-Gm-Message-State: AOAM530quTibBSvhrcPAavXF1+FXR4fnXVHJDI1pZbiNX3IRcZ9+gl3X
        gCSv0LpmxEWDZSfm0VIiekg=
X-Google-Smtp-Source: ABdhPJzEZnz05KuonW+slQotpW/KiNfPxzeDAkLgmc5mo6VYw9R1Q8hucg2SB2LlI1X3IRYPBhim3A==
X-Received: by 2002:a17:902:8605:: with SMTP id f5mr2376275plo.263.1598906324684;
        Mon, 31 Aug 2020 13:38:44 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a26sm116850pfn.93.2020.08.31.13.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:38:44 -0700 (PDT)
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
Subject: [RESEND][PATCH 1/7] powerpc/iommu: Avoid overflow at boundary_size
Date:   Mon, 31 Aug 2020 13:38:05 -0700
Message-Id: <20200831203811.8494-2-nicoleotsuka@gmail.com>
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

