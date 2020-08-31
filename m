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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571E8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2202078B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR5PpDjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgHaUjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgHaUiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:38:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2652C061236;
        Mon, 31 Aug 2020 13:38:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id l9so2105669plt.8;
        Mon, 31 Aug 2020 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BI+WbPuZGThU4BWLVNvoFFhzj5+C2fzEktzsEUkpSP0=;
        b=gR5PpDjGTc4mcdgzORFbKP4d1AiAwkVi/JzR7l/ib+cyHmQPGLbKfpUrikJPQaUIMo
         LpTR0X8Jg9eVhAatfNdZaFdJ0zFkFEJUG+8v5BMLR6kkb9oHqRfftQgWkgA6qxf9quse
         lROpA3J8t9mSvpbsMV9tU4LX7vcAEpkDa4s9wwoD4Qu++Vr5O5gPKrBlWuC/Ay0MdtgT
         qKg5RmGywHyRO8j6OpZlVQR61HYu15Th9bxrkdryA6DNBYCTDlAWdwWcJsgnwk8T67AL
         A7lXxZKuWxzGNAIA9+LsqrYFw9a8SZXlFzp3BzKuJNmh7Pec87dsL4CHM+5FO+8XcyTm
         E31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BI+WbPuZGThU4BWLVNvoFFhzj5+C2fzEktzsEUkpSP0=;
        b=IAo0+VYkXWWJQAUnpsn5JLhkd4EU6Jq6rDVBbfFazh4y2hGxw4QY/y1B4UHbSugKKi
         +q+M72iBN05ahSjdpINxkZntLixCROl+vwjThvFE/VvajCgQu0G5VzElx8+0POpDXm/6
         kHg7j2AkN/3CJoE/l0JtUTMwFXWEGhOxnqwE6kX6mnPHiZDw7LuX6ZS62KbkchmNJU1i
         8MwbxjRrOBJnybDu/N4uBfnlpwNrd785L7+VRzD1v3EgK6MHbhcloO+Fne4yQcYgNOmx
         euVsO8zxZ422vf2xYYM8NSIfJ/J33VWcwVW1AWYG7YPgaSDkCjmcxJknsWAJYUYz6+Z3
         bwJA==
X-Gm-Message-State: AOAM531+TUTfqGFxp8FIRehoZCrP3U5S061MdFGE5JJdftTZRAjLLRsm
        N7rWiXt/9mZdcdx/ZZ7tc2E=
X-Google-Smtp-Source: ABdhPJzE+1okR4PaSl3NyWN+d7c4HMg48AFq3FjgXSuZ/VyANvpvu1Ta+4fFzAJJuzjZQxhFKBo9PQ==
X-Received: by 2002:a17:90b:1b09:: with SMTP id nu9mr937639pjb.214.1598906330259;
        Mon, 31 Aug 2020 13:38:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a26sm116850pfn.93.2020.08.31.13.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:38:49 -0700 (PDT)
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
Subject: [RESEND][PATCH 5/7] sparc: Avoid overflow at boundary_size
Date:   Mon, 31 Aug 2020 13:38:09 -0700
Message-Id: <20200831203811.8494-6-nicoleotsuka@gmail.com>
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
 arch/sparc/kernel/iommu-common.c | 9 +++------
 arch/sparc/kernel/iommu.c        | 4 ++--
 arch/sparc/kernel/pci_sun4v.c    | 4 ++--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/iommu-common.c b/arch/sparc/kernel/iommu-common.c
index 59cb16691322..843e71894d04 100644
--- a/arch/sparc/kernel/iommu-common.c
+++ b/arch/sparc/kernel/iommu-common.c
@@ -166,13 +166,10 @@ unsigned long iommu_tbl_range_alloc(struct device *dev,
 		}
 	}
 
-	if (dev)
-		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				      1 << iommu->table_shift);
-	else
-		boundary_size = ALIGN(1ULL << 32, 1 << iommu->table_shift);
+	boundary_size = dev ? dma_get_seg_boundary(dev) : U32_MAX;
 
-	boundary_size = boundary_size >> iommu->table_shift;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	boundary_size = (boundary_size >> iommu->table_shift) + 1;
 	/*
 	 * if the skip_span_boundary_check had been set during init, we set
 	 * things up so that iommu_is_span_boundary() merely checks if the
diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 4ae7388b1bff..d981c37305ae 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -472,8 +472,8 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 	outs->dma_length = 0;
 
 	max_seg_size = dma_get_max_seg_size(dev);
-	seg_boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	seg_boundary_size = (dma_get_seg_boundary(dev) >> IO_PAGE_SHIFT) + 1;
 	base_shift = iommu->tbl.table_map_base >> IO_PAGE_SHIFT;
 	for_each_sg(sglist, s, nelems, i) {
 		unsigned long paddr, npages, entry, out_entry = 0, slen;
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 14b93c5564e3..233fe8a20cec 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -508,8 +508,8 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 	iommu_batch_start(dev, prot, ~0UL);
 
 	max_seg_size = dma_get_max_seg_size(dev);
-	seg_boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				  IO_PAGE_SIZE) >> IO_PAGE_SHIFT;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	seg_boundary_size = (dma_get_seg_boundary(dev) >> IO_PAGE_SHIFT) + 1;
 
 	mask = *dev->dma_mask;
 	if (!iommu_use_atu(iommu, mask))
-- 
2.17.1

