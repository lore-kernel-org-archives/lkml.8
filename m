Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BD5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29507208A9
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBwNrPdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgHaUjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgHaUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:38:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549B1C061573;
        Mon, 31 Aug 2020 13:38:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o16so496012pjr.2;
        Mon, 31 Aug 2020 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UkH8Mq/WpiesfkXrapLTRLCROpdsRyoJty+98OOSpss=;
        b=QBwNrPdfcSAA97dtBnIWUfFN68G3dlx1D0NnviFoEsXwwJ685l3hFpoUYeYtJQzsk/
         fa7q/UtZxp6YwHBe+lUXHOQ1+GfSZzVh/DlB4nJjGv8Y+GG4bROeovNbk90Dcxd5OiaP
         gYkpuhwWCgw69+Fd2vWpUnQw4H4CpId8WgPawlAj3OSXL312ysfq8SYTiTBN4xm5ThPO
         F5+hNzC4yo3iGIb2RECwzNn7zXfvrk0NhPLH5HEpZ91StyGiVU6TKHdKBob3F9RMPnA2
         XmuYHqTMy4gsXlEfIEJipnHZkQI0n3KRv58zBJxo9DDi8lOQS6j3A/NxhJQ1wSezy3yl
         U1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UkH8Mq/WpiesfkXrapLTRLCROpdsRyoJty+98OOSpss=;
        b=f4gmCNYC8HgL0tpB4OUyEFsSKK7tHjYFqFFYKlNIIH4saNvAF559TQ0K+iWOt3+Nef
         QyoDxNdEf38YtHGVEsuzC+mJbJbyYP8gq+UgCyQMO1UyB10MyUGaXMTNCLtKghbez/OR
         CQi8sIiGO78a8iS0kt6D21iceEqzunI/wyfBBkoAkRufPLg4EF2ixEn7oFpLYYRZC3vT
         SN6OXW34wkL/Fj5gKokerFRsk03UkwhPNlcYCxNWLX4MsT9W/xcQaoTWhc6H06zG5Z+2
         KJr4aoyQvsmplrMLThlBWFUATi/fj571Cu0jgL/iNmbsCI3u7YP+nxlNuW5Dgttfjurx
         WVPg==
X-Gm-Message-State: AOAM530MfMuABpDsLJrAtzHJ9S3II9I243f6ZMnI7pG+hpxfX9Ytb5cy
        wK9G7GWA1iXOAwNl+zSNqvg=
X-Google-Smtp-Source: ABdhPJyXoduzDrrOfdBPGH2aNf+3wAYQRVLuMBfbGQJgA2G8/prLtxMZHSUPNIUyBa+AP5hiPpK76w==
X-Received: by 2002:a17:90a:5a01:: with SMTP id b1mr918526pjd.27.1598906328871;
        Mon, 31 Aug 2020 13:38:48 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a26sm116850pfn.93.2020.08.31.13.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:38:48 -0700 (PDT)
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
Subject: [RESEND][PATCH 4/7] s390/pci_dma: Avoid overflow at boundary_size
Date:   Mon, 31 Aug 2020 13:38:08 -0700
Message-Id: <20200831203811.8494-5-nicoleotsuka@gmail.com>
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

