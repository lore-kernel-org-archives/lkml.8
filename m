Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44B1C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB68821473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgIGWtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:49:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:13456 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgIGWtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 18:49:42 -0400
IronPort-SDR: vREx3M6zHqZEnvOKIyT8pcTC/dvx0SZvyJtALkFWB+hoIIB7sJLRRRDBa6Ewc2hALxj+b2JxV7
 X9cSLH6sfXQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="145760663"
X-IronPort-AV: E=Sophos;i="5.76,403,1592895600"; 
   d="scan'208";a="145760663"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 15:49:41 -0700
IronPort-SDR: BTcNct0RfmcjPpIa1ls/eAAciui7VjavR7huUPGdOYcHwQlZsWL19s4lZ/AiOGIU/qPyZY/Urh
 zQU1jad8KvNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,403,1592895600"; 
   d="scan'208";a="284310418"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga007.fm.intel.com with ESMTP; 07 Sep 2020 15:49:39 -0700
Date:   Tue, 8 Sep 2020 06:45:39 +0800
From:   Philip Li <philip.li@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Michal Simek <monstr@monstr.eu>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [kbuild-all] Re: undefined reference to
 `start_isolate_page_range'
Message-ID: <20200907224539.GA4034@intel.com>
References: <202009070030.oNDEAZTG%lkp@intel.com>
 <ef63d7a3-4793-6b1d-3dc5-229589abc56c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef63d7a3-4793-6b1d-3dc5-229589abc56c@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 03:40:08PM -0700, Randy Dunlap wrote:
> Hi lkp, (or is it ktr?)
> 
> This is sort of a shame-on-you post. As a robot, I hope that you
> don't have any hard feelings about it.  :)
Hi Randy, thanks for the input, below warning is helpful to identify
issues, we will add this to plan to show kconfig related warnings
in the report.

Thanks

> 
> 
> On 9/6/20 9:17 AM, kernel test robot wrote:
> > Hi Michal,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   dd9fb9bb3340c791a2be106fdc895db75f177343
> > commit: 2602276d3d3811b1a48c48113042cd75fcbfc27d microblaze: Wire CMA allocator
> > date:   7 months ago
> > config: microblaze-randconfig-r021-20200906 (attached as .config)
> > compiler: microblaze-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 2602276d3d3811b1a48c48113042cd75fcbfc27d
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=microblaze 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    microblaze-linux-ld: mm/page_alloc.o: in function `alloc_contig_range':
> >>> (.text+0x10c8c): undefined reference to `start_isolate_page_range'
> >>> microblaze-linux-ld: (.text+0x10f14): undefined reference to `test_pages_isolated'
> >>> microblaze-linux-ld: (.text+0x10fd0): undefined reference to `undo_isolate_page_range'
> 
> When I (easily) reproduce this build error, I also see a Kconfig warning:
> (or the same warning repeated 3 times)
> 
> WARNING: unmet direct dependencies detected for CMA
>   Depends on [n]: MMU [=n]
>   Selected by [m]:
>   - DRM_ASPEED_GFX [=m] && HAS_IOMEM [=y] && DRM [=m] && OF [=y] && (COMPILE_TEST [=y] || ARCH_ASPEED) && HAVE_DMA_CONTIGUOUS [=y]
> 
> WARNING: unmet direct dependencies detected for CMA
>   Depends on [n]: MMU [=n]
>   Selected by [m]:
>   - DRM_ASPEED_GFX [=m] && HAS_IOMEM [=y] && DRM [=m] && OF [=y] && (COMPILE_TEST [=y] || ARCH_ASPEED) && HAVE_DMA_CONTIGUOUS [=y]
> 
> WARNING: unmet direct dependencies detected for CMA
>   Depends on [n]: MMU [=n]
>   Selected by [m]:
>   - DRM_ASPEED_GFX [=m] && HAS_IOMEM [=y] && DRM [=m] && OF [=y] && (COMPILE_TEST [=y] || ARCH_ASPEED) && HAVE_DMA_CONTIGUOUS [=y]
> 
> 
> This is the cause of the build errors.
> You shouldn't omit Kconfig warnings from your reports.
> 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> cheers.
> -- 
> ~Randy
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
