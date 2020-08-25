Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1665C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F522078A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgHYHE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:04:59 -0400
Received: from verein.lst.de ([213.95.11.211]:57670 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbgHYHE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:04:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 166B268BEB; Tue, 25 Aug 2020 09:04:55 +0200 (CEST)
Date:   Tue, 25 Aug 2020 09:04:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: kernel/dma/pool.c:79 cma_in_zone() warn: always true condition
 '(end <= ((((32) == 64)) << (32)) - 1))) => (0-u32max <= u32max)'
Message-ID: <20200825070454.GB29268@lst.de>
References: <202008251334.2KKCn4PE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008251334.2KKCn4PE%lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like we might have to replace the IS_ENABLED with an ifdef to
cater for the 32-bit phys_addr_t and overzealous compilers.

On Tue, Aug 25, 2020 at 01:45:38PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6a9dc5fd6170d0a41c8a14eb19e63d94bea5705a
> commit: d7e673ec2c8e0ea39c4c70fc490d67d7fbda869d dma-pool: Only allocate from CMA when in same memory zone
> date:   11 days ago
> config: arc-randconfig-m031-20200824 (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> New smatch warnings:
> kernel/dma/pool.c:79 cma_in_zone() warn: always true condition '(end <= ((((32) == 64)) ?~0:((1 << (32)) - 1))) => (0-u32max <= u32max)'
> 
> Old smatch warnings:
> arch/arc/include/asm/thread_info.h:65 current_thread_info() error: uninitialized symbol 'sp'.
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7e673ec2c8e0ea39c4c70fc490d67d7fbda869d
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch --no-tags linus master
> git checkout d7e673ec2c8e0ea39c4c70fc490d67d7fbda869d
> vim +79 kernel/dma/pool.c
> 
>     59	
>     60	static bool cma_in_zone(gfp_t gfp)
>     61	{
>     62		unsigned long size;
>     63		phys_addr_t end;
>     64		struct cma *cma;
>     65	
>     66		cma = dev_get_cma_area(NULL);
>     67		if (!cma)
>     68			return false;
>     69	
>     70		size = cma_get_size(cma);
>     71		if (!size)
>     72			return false;
>     73	
>     74		/* CMA can't cross zone boundaries, see cma_activate_area() */
>     75		end = cma_get_base(cma) + size - 1;
>     76		if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
>     77			return end <= DMA_BIT_MASK(zone_dma_bits);
>     78		if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
>   > 79			return end <= DMA_BIT_MASK(32);
>     80		return true;
>     81	}
>     82	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


---end quoted text---
