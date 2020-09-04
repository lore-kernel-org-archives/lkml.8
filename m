Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20A3C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706362074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OSKCiZVY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OSKCiZVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIDPep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:34:45 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47250 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgIDPem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:34:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E23378EE112;
        Fri,  4 Sep 2020 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599233681;
        bh=aqBYVVDxSPcR+4WRGd2XXdbYUrXI1R2tpGt8e2CxOqk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OSKCiZVY/HICluT+E+gBea2klKfGTnSyh+e5emDR2r1NB8op0pvrrhFcgY6WpLXfi
         BgwwbeRb5VG2jPAx3sUPZQpMPsfm8M1dAfUAh8brrNXhqqe8gVtdtzwSB3orIrDD7l
         YoD02xMi9/Vnz3qACuvRNiD5YpaTVrPCKQCyS0ro=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0lY_VcvizQiN; Fri,  4 Sep 2020 08:34:41 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 432438EE064;
        Fri,  4 Sep 2020 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599233681;
        bh=aqBYVVDxSPcR+4WRGd2XXdbYUrXI1R2tpGt8e2CxOqk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OSKCiZVY/HICluT+E+gBea2klKfGTnSyh+e5emDR2r1NB8op0pvrrhFcgY6WpLXfi
         BgwwbeRb5VG2jPAx3sUPZQpMPsfm8M1dAfUAh8brrNXhqqe8gVtdtzwSB3orIrDD7l
         YoD02xMi9/Vnz3qACuvRNiD5YpaTVrPCKQCyS0ro=
Message-ID: <1599233679.5231.4.camel@HansenPartnership.com>
Subject: Re: [PATCH] dma-direct: zero out DMA_ATTR_NO_KERNEL_MAPPING buf
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Hillf Danton <hdanton@sina.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri, 04 Sep 2020 08:34:39 -0700
In-Reply-To: <20200904152550.17964-1-hdanton@sina.com>
References: <20200904152550.17964-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-04 at 23:25 +0800, Hillf Danton wrote:
> The DMA buffer allocated is always cleared in DMA core and this is
> making DMA_ATTR_NO_KERNEL_MAPPING non-special.
> 
> Fixes: d98849aff879 ("dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING
> in common code")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -178,9 +178,17 @@ void *dma_direct_alloc_pages(struct devi
>  
>  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>  	    !force_dma_unencrypted(dev)) {
> +		int i;
> +
>  		/* remove any dirty cache lines on the kernel alias
> */
>  		if (!PageHighMem(page))
>  			arch_dma_prep_coherent(page, size);
> +
> +		for (i = 0; i < size/PAGE_SIZE; i++) {
> +			ret = kmap_atomic(page + i);
> +			memset(ret, 0, PAGE_SIZE);
> +			kunmap_atomic(ret);

This is massively expensive on PARISC and likely other VIPT/VIVT
architectures.  What's the reason for clearing it?  This could also be
really inefficient even on PIPT architectures if the memory is device
remote.

If we really have to do this, it should likely be done in the arch or
driver hooks because there are potentially more efficient ways we can
do this knowing how the architecture behaves.

James

