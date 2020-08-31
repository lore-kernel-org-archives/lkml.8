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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E308C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A31D208A9
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 20:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7f9KtGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbgHaUjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbgHaUiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:38:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26201C061239;
        Mon, 31 Aug 2020 13:38:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id n3so493068pjq.1;
        Mon, 31 Aug 2020 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9lkO17MTf1PvM2bYbtDswYPNjHPfse5Uqsd7G1Ozxzk=;
        b=C7f9KtGN6f9jn52H6vQ9qIM5jGWuoLJsZ/RKNr/lbkpPxTWSk5dxFfynXA0FMAYioq
         OxyAGzkgkPNh5e9cbfdo3dNv5UU8aAZV6AP6s2gvl5+DT9DVURrgFlAen5QW57oDKcmS
         OeBDz3aRzBm+A0c4rJ2IeiRUaHerUUToq2LfGlKk09Crc5w+8/6iqhYQwmdpaRYBJw/W
         qCzkNkO9kbzK7YJL/M2gaGN7xY2ZgCRmcAEs0pmIegG3sgCM7y3BK7uAEioOaUDCWQX7
         o2McdgM03YS24UfiiKYj67GqZYb3vI0E35EC+O14k3kW4wCeVY/ckjYJN1iq9G/PFpfE
         xlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9lkO17MTf1PvM2bYbtDswYPNjHPfse5Uqsd7G1Ozxzk=;
        b=chlSaS//tmzLFq3E/Z4glsvTRKkeXG6dKzKyw38J/1u4yPLihCvIQR6dwPZFV9gZmN
         s2aw5oOe7kC3FfglteCHDVrDmIXp1NvOraSk6Lw/BaYz42a3X/RldZ7ftTxR5ZH7Q38c
         4F1q48wTBSMRMQIO23M91a2rZMHZ0cg8MfEZq7mohfjG5CAVlMBBpxspJBjmW9R+SLjn
         /55nJwCPS7OA9/t+O2XPVexpxpErOHxZnGw9fRU/l3sqxg1ZCTHNekhDR1iAmknYPP+O
         +lRnqqVbmdxK44ouzfslKPeuuw/FxV4W1PI7COmnHjW+F5Dj3BBkRe4xbW+pZK3D5/0V
         FjDQ==
X-Gm-Message-State: AOAM532Mlh9XzhwTq7LD9nBD2pYkF6cCXVwSI3iEWTWDH5xFzgumR9uz
        aB4mxp7xXY9bkG+ar2+blKI=
X-Google-Smtp-Source: ABdhPJwNe6SMal3ghr336eWQ9OQ27rxWY9eWRgjp87ARIjTK34cksm8DqThZeCN/pPb0zdeAnklq5Q==
X-Received: by 2002:a17:90a:9d8b:: with SMTP id k11mr915199pjp.169.1598906331693;
        Mon, 31 Aug 2020 13:38:51 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a26sm116850pfn.93.2020.08.31.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 13:38:51 -0700 (PDT)
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
Subject: [RESEND][PATCH 6/7] x86/amd_gart: Avoid overflow at boundary_size
Date:   Mon, 31 Aug 2020 13:38:10 -0700
Message-Id: <20200831203811.8494-7-nicoleotsuka@gmail.com>
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
 arch/x86/kernel/amd_gart_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index e89031e9c847..7fa0bb490065 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -96,8 +96,8 @@ static unsigned long alloc_iommu(struct device *dev, int size,
 
 	base_index = ALIGN(iommu_bus_base & dma_get_seg_boundary(dev),
 			   PAGE_SIZE) >> PAGE_SHIFT;
-	boundary_size = ALIGN((u64)dma_get_seg_boundary(dev) + 1,
-			      PAGE_SIZE) >> PAGE_SHIFT;
+	/* Overflow-free shortcut for: ALIGN(b + 1, 1 << s) >> s */
+	boundary_size = (dma_get_seg_boundary(dev) >> PAGE_SHIFT) + 1;
 
 	spin_lock_irqsave(&iommu_bitmap_lock, flags);
 	offset = iommu_area_alloc(iommu_gart_bitmap, iommu_pages, next_bit,
-- 
2.17.1

