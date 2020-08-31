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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AABC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 555252078B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okj7fpWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgHaUi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgHaUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:38:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CD8C061755;
        Mon, 31 Aug 2020 13:38:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ls14so480912pjb.3;
        Mon, 31 Aug 2020 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WWik1+r7ug1ahh3ihIBeIV7cbQz02Md5UqkfuQNEKrg=;
        b=Okj7fpWGg9YFfyZ+dRvcEQiQ7iYaNcxPLqiq9ImnYm94y1t9sfUfXMWAjv4FUQwlhM
         fh8D+RSxU4t3clsLQsQCgEgfq+QF+9pjiwrVGlGKlvyxD3+cSWXGO+w0JiH/FI0PPAb1
         QeMTY5fHsFDxWqBlTtsGJFwbX9XsCW9p0AmGpDQ0oZhv9Yu74QWoV3vXLOpniaYS7gKe
         F7yYAjP8/4STfz32tCbou/bMWvPtSe0j+wPoFI2VjqOmN2Ihwv3Whu0F10nlaKbJ0/+9
         oGWK2xB8owNJZgtTI/cGbVR/o9XAewzP/dRMACRZJKQ3btWQGUUwCDv0CHPYkGN2iV9l
         Gjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WWik1+r7ug1ahh3ihIBeIV7cbQz02Md5UqkfuQNEKrg=;
        b=pSFZj8uBG1T4oWku7w3skeJsAHpRmL8rVBs+aMjX+yiAHYSjql7j+6zgI6nwwKur8c
         zIUdSmiQXHLH1ENCV+1RfHyXyjAe+0Hx4oBYv3ns8vV8m8XUDUObBQF8S40dhp76tgyS
         DBHcK6cE/MnYja75nVZYk74LoFkfERTPOS+vv0AqDiJFQ7l2zwSJIf05DNQ6Vg5pPjcw
         q9plHMkOrsVtkZQlRiMK1J9JAu9vfUKEIie3Mrxs9NZ2/uaSPHRbsLBHdgbVOTRe8Pae
         zPF2mIIn1nt3Tf7pdnSq9qs+TAafDkwRjJ9UzAF3P9Lo3bbS6T7Qc0p0ma6wAanxnL0f
         jbRA==
X-Gm-Message-State: AOAM532RcWnqcBY4aK+78XECYmx5+VeOzvwaOL92PWIPgPBn/xYcpRT+
        LsL7CKaLQCrhJYRfEQgYvWw=
X-Google-Smtp-Source: ABdhPJzb64ZD7SZ8Zo3vceH3nOEuontqr0yZrVSPKjB0ptcnTiJ0jR2bKfMnjBq6bhBFFVVzWLBPEQ==
X-Received: by 2002:a17:90a:b10a:: with SMTP id z10mr1044115pjq.102.1598906327541;
        Mon, 31 Aug 2020 13:38:47 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a26sm116850pfn.93.2020.08.31.13.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:38:47 -0700 (PDT)
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
Subject: [RESEND][PATCH 3/7] ia64/sba_iommu: Avoid overflow at boundary_size
Date:   Mon, 31 Aug 2020 13:38:07 -0700
Message-Id: <20200831203811.8494-4-nicoleotsuka@gmail.com>
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
 arch/ia64/hp/common/sba_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 656a4888c300..945954903bb0 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -485,8 +485,8 @@ sba_search_bitmap(struct ioc *ioc, struct device *dev,
 	ASSERT(((unsigned long) ioc->res_hint & (sizeof(unsigned long) - 1UL)) == 0);
 	ASSERT(res_ptr < res_end);
 
-	boundary_size = (unsigned long long)dma_get_seg_boundary(dev) + 1;
-	boundary_size = ALIGN(boundary_size, 1ULL << iovp_shift) >> iovp_shift;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	boundary_size = (dma_get_seg_boundary(dev) >> iovp_shift) + 1;
 
 	BUG_ON(ioc->ibase & ~iovp_mask);
 	shift = ioc->ibase >> iovp_shift;
-- 
2.17.1

