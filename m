Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47429C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FBC12064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YFULLve1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgFJHY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJHY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:24:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D5BC03E96B;
        Wed, 10 Jun 2020 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6c/vE/ozxTPwS24BUkYxi15LaZy1is3YVzeL7qEF/KU=; b=YFULLve167EFJAUFIFsBXuS464
        4Jdpz0CHZIZV99sZXhwNfjkc0tbGoC8x5EHEe5oCi0RMjn8Yn48HVzwOTatYxuWFlGVAicqgPCoIr
        FbDj4HlG7sW61Wcc9mGwBHLqWWsp/DjpHH0mgdWLLZKv0PH1SRnL/gvL7ygJx9RnPNXzFHq0fmm85
        fGVfLeXUUKn+UU/6hx4L7zrN/HbBNo8I/Y6edXdqCqGJLSyhd7nUyL14kxthvpTgBQ6zSv16a261R
        QbmU2cU6oUks3aM4x49C3FsnOGUa26mxaTTQuZs5vpOen8MhMhVqVdo6+1LPv/EPMa6la3219xAEy
        jxC9aLlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiv6K-0001gz-CH; Wed, 10 Jun 2020 07:24:44 +0000
Date:   Wed, 10 Jun 2020 00:24:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     dillon.minfei@gmail.com, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux@armlinux.org.uk, kstewart@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm-nommu: Add use_reserved_mem() to check if device
 support reserved memory
Message-ID: <20200610072444.GA6293@infradead.org>
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
 <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com>
 <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I finally found the original patch from Vladimir.  Comments below:

> +++ b/kernel/dma/direct.c
> @@ -456,14 +456,14 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>  #else /* CONFIG_MMU */
>  bool dma_direct_can_mmap(struct device *dev)
>  {
> -	return false;
> +	return true;
>  }
>  
>  int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>  		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>  		unsigned long attrs)
>  {
> -	return -ENXIO;
> +	return vm_iomap_memory(vma, vma->vm_start, (vma->vm_end - vma->vm_start));;

I think we should try to reuse the mmu dma_direct_mmap implementation,
which does about the same.  This version has been compile tested on
arm-nommu only, let me know what you think: (btw, a nommu_defconfig of
some kind for arm would be nice..)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index d006668c0027d2..e0dae570a51530 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -71,6 +71,7 @@ config SWIOTLB
 # in the pagetables
 #
 config DMA_NONCOHERENT_MMAP
+	default y if !MMU
 	bool
 
 config DMA_REMAP
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 0a4881e59aa7d6..9ec6a5c3fc578c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -459,7 +459,6 @@ int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return ret;
 }
 
-#ifdef CONFIG_MMU
 bool dma_direct_can_mmap(struct device *dev)
 {
 	return dev_is_dma_coherent(dev) ||
@@ -485,19 +484,6 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
 			user_count << PAGE_SHIFT, vma->vm_page_prot);
 }
-#else /* CONFIG_MMU */
-bool dma_direct_can_mmap(struct device *dev)
-{
-	return false;
-}
-
-int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		unsigned long attrs)
-{
-	return -ENXIO;
-}
-#endif /* CONFIG_MMU */
 
 int dma_direct_supported(struct device *dev, u64 mask)
 {
