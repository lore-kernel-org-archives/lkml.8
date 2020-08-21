Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F90BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09302078B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="stlLywnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgHUQI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUQIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:08:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45035C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=92eGX7MWPFjNhNX0NwOjIQ0sXPTJuWVAoSzAi/Jj5GU=; b=stlLywnRrzvVM8oQQ81BQX97tc
        cRayqTje0CRor0HOVRUn7EC+cQ/7O1TMj1OOKxZDR0omMH/aQqEvVDAh6SXszeOP+xvxBP8DDMeia
        dnZ1t21/MLZMFd45JqtPIJPAn7xB0OJ1EMbL58yh+Z+XJeMpAgURfPejkTYuWVIgd2oAWwY4WNRq/
        bMQpDiNUWJd1xlFXIVTYv8kPJgdBzqPdmZoH5v1fgooiiS7525CSYfCCMMlSTFVVVH7OI08lDKbuv
        0vVC9slIupv6+m6PhqQluAwZ73GTqBg5V6VQ1dYcgCH9OI6TmK/joa7RqwzWJWt5WR7Iyn+Z+qlPa
        1ifE+dyA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k99ai-0007DH-IK; Fri, 21 Aug 2020 16:08:32 +0000
Subject: Re: [PATCH v7 1/3] dma-contiguous: provide the ability to reserve
 per-numa CMA
To:     Barry Song <song.bao.hua@hisilicon.com>, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com, will@kernel.org,
        ganapatrao.kulkarni@cavium.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com, huangdaode@huawei.com,
        linuxarm@huawei.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
 <20200821113355.6140-2-song.bao.hua@hisilicon.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5eafce91-cc92-e6ed-23b0-98f253129e1b@infradead.org>
Date:   Fri, 21 Aug 2020 09:08:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821113355.6140-2-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 4:33 AM, Barry Song wrote:
> ---
>  -v7: with respect to Will's comments
>  * move to use for_each_online_node
>  * add description if users don't specify pernuma_cma
>  * provide default value for CONFIG_DMA_PERNUMA_CMA
> 
>  .../admin-guide/kernel-parameters.txt         |  11 ++
>  include/linux/dma-contiguous.h                |   6 ++
>  kernel/dma/Kconfig                            |  11 ++
>  kernel/dma/contiguous.c                       | 100 ++++++++++++++++--
>  4 files changed, 118 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bdc1f33fd3d1..c609527fc35a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -599,6 +599,17 @@
>  			altogether. For more information, see
>  			include/linux/dma-contiguous.h
>  
> +	pernuma_cma=nn[MG]
> +			[ARM64,KNL]
> +			Sets the size of kernel per-numa memory area for
> +			contiguous memory allocations. A value of 0 disables
> +			per-numa CMA altogether. And If this option is not
> +			specificed, the default value is 0.
> +			With per-numa CMA enabled, DMA users on node nid will
> +			first try to allocate buffer from the pernuma area
> +			which is located in node nid, if the allocation fails,
> +			they will fallback to the global default memory area.
> +

Entries in kernel-parameters.txt are supposed to be in alphabetical order
but this one is not.  If you want to keep it near the cma= entry, you can
rename it like Mike suggested.  Otherwise it needs to be moved.


>  	cmo_free_hint=	[PPC] Format: { yes | no }
>  			Specify whether pages are marked as being inactive
>  			when they are freed.  This is used in CMO environments



-- 
~Randy

