Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78200C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA3621481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NqFgAkPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgIGWkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgIGWkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 18:40:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA28C061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 15:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=N4/b9pqCDjgvuQCDbaJFfoH9fBkuhVGaRtyVqnDnAKc=; b=NqFgAkPoi6TBBRzxOs5y4VvJes
        SjSGdEbir8t5QnN7h2hjZ9rW1VW9QyKGLP68LcCBMrQIFQnZD8xh94TanG0Pn2+ECnzBQJcnUrbGo
        e0S+MBKsnm35eX3Xg27H00W/F9M+ppWmBj4tR6incLVhvqxvkS6qBWNouEReyarbMI2VQdpmX6K7S
        240eyDYg7K58XEjK6BjDZzgOmb1QbZ1JWdvqb7HljGXTb/W1uadr87NKLSvXwNKJGDwpDGrE7q4Cd
        QrUCMw7+ez5mgyRMtm80bkmvQeVJaNcW1EOrpDCJ+kpl+2u9O5E+ei/7tFar9ySLysNy+ieHKbk1C
        5T4ijtOw==;
Received: from [2601:1c0:6280:3f0::1fce]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFPo3-0007Q4-7T; Mon, 07 Sep 2020 22:40:12 +0000
Subject: Re: undefined reference to `start_isolate_page_range'
To:     kernel test robot <lkp@intel.com>, Michal Simek <monstr@monstr.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Mike Rapoport <rppt@kernel.org>
References: <202009070030.oNDEAZTG%lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ef63d7a3-4793-6b1d-3dc5-229589abc56c@infradead.org>
Date:   Mon, 7 Sep 2020 15:40:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009070030.oNDEAZTG%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkp, (or is it ktr?)

This is sort of a shame-on-you post. As a robot, I hope that you
don't have any hard feelings about it.  :)


On 9/6/20 9:17 AM, kernel test robot wrote:
> Hi Michal,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dd9fb9bb3340c791a2be106fdc895db75f177343
> commit: 2602276d3d3811b1a48c48113042cd75fcbfc27d microblaze: Wire CMA allocator
> date:   7 months ago
> config: microblaze-randconfig-r021-20200906 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 2602276d3d3811b1a48c48113042cd75fcbfc27d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=microblaze 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    microblaze-linux-ld: mm/page_alloc.o: in function `alloc_contig_range':
>>> (.text+0x10c8c): undefined reference to `start_isolate_page_range'
>>> microblaze-linux-ld: (.text+0x10f14): undefined reference to `test_pages_isolated'
>>> microblaze-linux-ld: (.text+0x10fd0): undefined reference to `undo_isolate_page_range'

When I (easily) reproduce this build error, I also see a Kconfig warning:
(or the same warning repeated 3 times)

WARNING: unmet direct dependencies detected for CMA
  Depends on [n]: MMU [=n]
  Selected by [m]:
  - DRM_ASPEED_GFX [=m] && HAS_IOMEM [=y] && DRM [=m] && OF [=y] && (COMPILE_TEST [=y] || ARCH_ASPEED) && HAVE_DMA_CONTIGUOUS [=y]

WARNING: unmet direct dependencies detected for CMA
  Depends on [n]: MMU [=n]
  Selected by [m]:
  - DRM_ASPEED_GFX [=m] && HAS_IOMEM [=y] && DRM [=m] && OF [=y] && (COMPILE_TEST [=y] || ARCH_ASPEED) && HAVE_DMA_CONTIGUOUS [=y]

WARNING: unmet direct dependencies detected for CMA
  Depends on [n]: MMU [=n]
  Selected by [m]:
  - DRM_ASPEED_GFX [=m] && HAS_IOMEM [=y] && DRM [=m] && OF [=y] && (COMPILE_TEST [=y] || ARCH_ASPEED) && HAVE_DMA_CONTIGUOUS [=y]


This is the cause of the build errors.
You shouldn't omit Kconfig warnings from your reports.

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


cheers.
-- 
~Randy
