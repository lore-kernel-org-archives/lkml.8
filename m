Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96059C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7140820738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLigo4EW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgHTXVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgHTXVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:21:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F84FC061385;
        Thu, 20 Aug 2020 16:21:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id v15so95171pgh.6;
        Thu, 20 Aug 2020 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/pybmE7a8FIpjQvJ6DGP3d+JulP7r92A2J59iMGiCLM=;
        b=MLigo4EWWIK3hAtZ+bD/qiSZbFYG3AlhwrpyMHGZzLf2qlx6QjvfXc++blYJU6IPaV
         gDjCkr2j743cs8ZPdpOgV/rsEwmiA9B7Pu/8Te+VB1+tIqpGUYWcQyb+F+ENWMfrBcX9
         jv61lnMHHcaITMX02R52+1WTooy4hcyelmnLFzOvOQH/sW16aJqLSxkQQvzmPZSKSBzz
         ue6vhHFs5Sv7ZG9Xd/F1vJLHPpAUD688fzigrOZWumGG4ptMoi9nLwAQ4saGzKBgsdHe
         Hk4cNoQGtAytPUrrUffhUsw2OBWJGeprj2zIGf8NL3qAmrEa4uNdPVesxVLBx3vg/S95
         wXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/pybmE7a8FIpjQvJ6DGP3d+JulP7r92A2J59iMGiCLM=;
        b=nhxo32J0b95XPvvX+JTbbABChQUcEDy4hFwEoh+TD6ftpP0XvXCHyy5C2dy4qe1s7D
         ZSXxHyaJJU67bmXKAo/3BIMQMLS3N6QjOuPCqzQvuvUTqg4XJueMSlSN8QMfvZS2rP5o
         6Ak1hHqasNJlMzPpwHrRbqyWmxZ/C10rk/JF48LGWJJBCC2zIlJpgMoTl8KlBrarbB9Q
         ledgvh2VZcR/eyZCz2cEPVdyHKZFzgsfrnFawio3pPu/kOcXDJdwXEJD+If05LSEv2NI
         fG1X/ww953PCY80k/jNoSfcxC9gUHJogya4ZUlC/KBTWWc0l16+3cVg3XOxrqTcNkn5u
         yXBw==
X-Gm-Message-State: AOAM532G3rmuTsi9E+sGDLYLf3HDIdzSvfzqBP+PEX4hsjFPbpQFGVfm
        /KhNpI5SL9SRpPwLHn+Oo6A=
X-Google-Smtp-Source: ABdhPJzDmGhZ4pAOH6X3eyc3gzc3mjKfsvD+8ODKBalRfgS9kWxokjXJHgxILbGrw7b0mSMJ5bWwzg==
X-Received: by 2002:a62:52d6:: with SMTP id g205mr175792pfb.144.1597965681066;
        Thu, 20 Aug 2020 16:21:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q7sm148749pfl.156.2020.08.20.16.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 16:21:20 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de
Cc:     hch@lst.de, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFT][PATCH 7/7] parisc: Avoid overflow at boundary_size
Date:   Thu, 20 Aug 2020 16:21:06 -0700
Message-Id: <20200820232106.23969-1-nicoleotsuka@gmail.com>
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

