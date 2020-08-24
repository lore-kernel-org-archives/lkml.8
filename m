Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B356AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB0B2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgHXNq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:46:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:60445 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHXNq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:46:26 -0400
IronPort-SDR: 1ycB7PnZziF8D8pJuOrGzBGMVdmOCmJBlt2LtwS/lTN6TYwnBWjPpBHU+r0ZByzRiHB6wY9LWQ
 w0Ef+DYXPX+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="155881112"
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="gz'50?scan'50,208,50";a="155881112"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 06:34:27 -0700
IronPort-SDR: PlG2jy849qtZ62woFHSl3VuBpSs6dmit7gPIZAP+ZmVZVL9meRWMHYJJu9X91L/+g4KRB6ZaJr
 yseuBSedPHig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="gz'50?scan'50,208,50";a="322293740"
Received: from lkp-server01.sh.intel.com (HELO c420d4f0765f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2020 06:34:25 -0700
Received: from kbuild by c420d4f0765f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kACcC-00008d-Pn; Mon, 24 Aug 2020 13:34:24 +0000
Date:   Mon, 24 Aug 2020 21:34:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202008242103.QsiImxI4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d012a7190fc1fd72ed48911e77ca97ba4521bccd
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   10 weeks ago
config: h8300-randconfig-s031-20200824 (attached as .config)
compiler: h8300-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void * @@
   drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c:354:27: sparse:     got void *
>> drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse:     expected void *s
   drivers/video/fbdev/atmel_lcdfb.c:362:20: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c: note: in included file (through include/linux/scatterlist.h, include/linux/dma-mapping.h):
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:26:18: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     expected void *cpu_addr
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     expected void *cpu_addr
   drivers/video/fbdev/atmel_lcdfb.c:333:59: sparse:     got char [noderef] __iomem *screen_base

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +362 drivers/video/fbdev/atmel_lcdfb.c

14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  336  
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  337  /**
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  338   *	atmel_lcdfb_alloc_video_memory - Allocate framebuffer memory
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  339   *	@sinfo: the frame buffer to allocate memory for
1d01e83557105e drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  340   * 	
1d01e83557105e drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  341   * 	This function is called only from the atmel_lcdfb_probe()
1d01e83557105e drivers/video/atmel_lcdfb.c       Krzysztof Helt     2009-07-08  342   * 	so no locking by fb_info->mm_lock around smem_len setting is needed.
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  343   */
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  344  static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  345  {
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  346  	struct fb_info *info = sinfo->info;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  347  	struct fb_var_screeninfo *var = &info->var;
ea757acad5a518 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  348  	unsigned int smem_len;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  349  
ea757acad5a518 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  350  	smem_len = (var->xres_virtual * var->yres_virtual
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  351  		    * ((var->bits_per_pixel + 7) / 8));
ea757acad5a518 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-08-12  352  	info->fix.smem_len = max(smem_len, sinfo->smem_len);
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  353  
f6e45661f9be54 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  354  	info->screen_base = dma_alloc_wc(info->device, info->fix.smem_len,
f6e45661f9be54 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  355  					 (dma_addr_t *)&info->fix.smem_start,
f6e45661f9be54 drivers/video/fbdev/atmel_lcdfb.c Luis R. Rodriguez  2016-01-22  356  					 GFP_KERNEL);
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  357  
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  358  	if (!info->screen_base) {
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  359  		return -ENOMEM;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  360  	}
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  361  
01d3a5e7fab773 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28 @362  	memset(info->screen_base, 0, info->fix.smem_len);
01d3a5e7fab773 drivers/video/atmel_lcdfb.c       Haavard Skinnemoen 2008-04-28  363  
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  364  	return 0;
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  365  }
14340586148e7c drivers/video/atmel_lcdfb.c       Nicolas Ferre      2007-05-10  366  

:::::: The code at line 362 was first introduced by commit
:::::: 01d3a5e7fab7732cfc5d5d4533e9378ea435295a atmel_lcdfb: don't initialize a pre-allocated framebuffer

:::::: TO: Haavard Skinnemoen <hskinnemoen@atmel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2oS5YaxWCcQjTEyO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--2oS5YaxWCcQjTEyO--
