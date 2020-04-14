Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE186C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E3020767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdPvHOue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbgDNTbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504776AbgDNT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:29:50 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EF1C02C444
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:20:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so299831plk.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IlUPdhKtIbUzJOWhzH8G7CEIltrnGC+nIP0WHGWZMgU=;
        b=VdPvHOuedrUPrbOlD0+nUakV+M1CzUEwuJFqiS3Xx7oaGbOw2harQFQq1U59pVYsiG
         +QAD+SkkXgVARYN0MSOc0QwaB2Jgy8v3XTXlIsRTdRDSV8yk9zZHAQ2y4jvFiEyz3XHE
         7YXQrKCLBOBDCC/2P8bENLJ4utU8LnGnCk131xMn2eazCAg5NFPkJcVTAkcrtjoNjt8o
         umW7WurDWUYEqIfZJ68QphhKbw9EaCZb9BBq6Je3u0xwLEcXVEn2jxMK+RQ5r4Q0twdT
         2IuNMJY0g08zNEFIWsZWpLucJ4rmre2MUBIKozG0Ui0kmYPsm860qwPiHHd0LeKrhfpt
         CKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IlUPdhKtIbUzJOWhzH8G7CEIltrnGC+nIP0WHGWZMgU=;
        b=n0NRigkDbGTy8GBXo3xnTciGz4jIktHnUSL+bSs3ZbJM02TGH3K0AII6ypC3pJsJIB
         ZypRHOVIIkAx2Riyo/iBdysttx5SM2RTXMM0os3MghuiWhS2dDMgfUnzINSU7YZ8SnNm
         DmNGlVohsB8zYIRvT7jJZ92LubW4CEChCe4OEwvTKdNiLu+79inhQyu8F5F/FjV8ccHN
         orc/7qxuOi6dLp/B/K70hRpSjxhYq3J4O7ArZ5tP2RsRsb0EGzj3zMGJIgdCq9hi1+iU
         Wqamxl5IdOgQ2lbqwVq3OfEmpv85/BLlO0K1SX6hsVEcB6Fic/OPFwPoOnF+kBul2pTa
         xnAA==
X-Gm-Message-State: AGi0Puaj7MzAI0Xf4xWBXVfunjZp+sXY7dfu5tvE7ygQ3cyF1946JJPK
        LdlQDjUjkvJbm6GWHWEwteI/686Lr1w=
X-Google-Smtp-Source: APiQypLUUpRxtuhcuQO3KJ+niNqlHwUCt95RC6MVvVR+0zXpkrnql0jYr8IiLloI/8o87V94dEkE4w==
X-Received: by 2002:a17:90a:3086:: with SMTP id h6mr1912285pjb.49.1586892042521;
        Tue, 14 Apr 2020 12:20:42 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a1sm11692054pfl.188.2020.04.14.12.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:20:41 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:20:41 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc v2 4/6] dma-direct: atomic allocations must come from atomic
 coherent pools
In-Reply-To: <20200414064332.GB23359@lst.de>
Message-ID: <alpine.DEB.2.22.394.2004141218510.2583@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com> <alpine.DEB.2.21.2004081420060.19661@chino.kir.corp.google.com> <20200414064332.GB23359@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020, Christoph Hellwig wrote:

> > +	/*
> > +	 * Unencrypted memory must come directly from DMA atomic pools if
> > +	 * blocking is not allowed.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> > +	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp)) {
> > +		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
> > +		if (!ret)
> > +			return NULL;
> > +		goto done;
> > +	}
> > +
> >  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> >  	    dma_alloc_need_uncached(dev, attrs) &&
> >  	    !gfpflags_allow_blocking(gfp)) {
> 
> Can we keep a single conditional for the pool allocations?  Maybe
> add a new dma_alloc_from_pool helper ala:
> 
> static inline bool dma_alloc_from_pool(struct device *dev, gfp_t gfp)
> {
> 	if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
> 		return false;
> 	if (gfpflags_allow_blocking(gfp))
> 		return false;
> 	if (force_dma_unencrypted(dev))
> 		return true;
> 	if (dma_alloc_need_uncached(dev))
> 		return true;
> }

Looks good, fixed.  I renamed it to dma_should_alloc_from_pool() to avoid 
confusing it with the actual allocation function and added a 
dma_should_free_from_pool() as well.

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -75,6 +75,39 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
 }
 
+/*
+ * Decrypting memory is allowed to block, so if this device requires
+ * unencrypted memory it must come from atomic pools.
+ */
+static inline bool dma_should_alloc_from_pool(struct device *dev, gfp_t gfp,
+					      unsigned long attrs)
+{
+	if (!IS_ENABLED(CONFIG_DMA_COHERENTPOOL))
+		return false;
+	if (gfpflags_allow_blocking(gfp))
+		return false;
+	if (force_dma_unencrypted(dev))
+		return true;
+	if (!IS_ENABLED(CONFIG_DMA_DIRECT_REMAP))
+		return false;
+	if (dma_alloc_need_uncached(dev, attrs))
+		return true;
+	return false;
+}
+
+static inline bool dma_should_free_from_pool(struct device *dev,
+					     unsigned long attrs)
+{
+	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
+		return true;
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
+	    !force_dma_unencrypted(dev))
+		return false;
+	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP))
+		return true;
+	return false;
+}
+
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp, unsigned long attrs)
 {
@@ -124,9 +157,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
-	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_alloc_need_uncached(dev, attrs) &&
-	    !gfpflags_allow_blocking(gfp)) {
+	if (dma_should_alloc_from_pool(dev, gfp, attrs)) {
 		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
 		if (!ret)
 			return NULL;
@@ -202,6 +233,11 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 {
 	unsigned int page_order = get_order(size);
 
+	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
+	if (dma_should_free_from_pool(dev, attrs) &&
+	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
+		return;
+
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
 	    !force_dma_unencrypted(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
@@ -209,10 +245,6 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		return;
 	}
 
-	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
-		return;
-
 	if (force_dma_unencrypted(dev))
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
 
