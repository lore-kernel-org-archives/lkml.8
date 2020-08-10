Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA3DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5D520855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgHJQWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:22:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:42692 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgHJQWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:22:42 -0400
IronPort-SDR: YqhM1UwD4TUf2SMMhT6fq169eXEYuRsG25YH4LAUjMWIgnz75yVO5OphbOFvyU1lbXnivQwxRU
 dUYbeOzlweYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="141423602"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="gz'50?scan'50,208,50";a="141423602"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 09:22:35 -0700
IronPort-SDR: EQ9UBylLStV1ivaNTvJH1xIxOqVnXcA6LITkVJCA7R54cJD/U7U0v2H+E5/JjB2Xv28DAmfWtC
 mDWNDLorTm9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="gz'50?scan'50,208,50";a="332252433"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2020 09:22:33 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5AZE-00004W-SJ; Mon, 10 Aug 2020 16:22:32 +0000
Date:   Tue, 11 Aug 2020 00:22:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/i740fb.c:743:20: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202008110022.88UkC1ZX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc80c51fd4b23ec007e88d4c688f2cac1b8648e7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   8 weeks ago
config: xtensa-randconfig-s031-20200810 (attached as .config)
compiler: xtensa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-141-g19506bc2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=xtensa 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/i740fb.c:743:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *__s @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/i740fb.c:743:20: sparse:     expected void *__s
   drivers/video/fbdev/i740fb.c:743:20: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/i740fb.c: note: in included file (through arch/xtensa/include/asm/io.h, include/linux/fb.h):
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
--
>> drivers/pci/endpoint/functions/pci-epf-test.c:288:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *__to @@     got void [noderef] __iomem *[assigned] dst_addr @@
   drivers/pci/endpoint/functions/pci-epf-test.c:288:24: sparse:     expected void *__to
   drivers/pci/endpoint/functions/pci-epf-test.c:288:24: sparse:     got void [noderef] __iomem *[assigned] dst_addr
>> drivers/pci/endpoint/functions/pci-epf-test.c:288:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *__from @@     got void [noderef] __iomem *[assigned] src_addr @@
   drivers/pci/endpoint/functions/pci-epf-test.c:288:34: sparse:     expected void const *__from
   drivers/pci/endpoint/functions/pci-epf-test.c:288:34: sparse:     got void [noderef] __iomem *[assigned] src_addr
--
>> drivers/video/fbdev/kyro/fbdev.c:725:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *__s @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     expected void *__s
   drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/kyro/fbdev.c: note: in included file (through include/linux/fb.h):
   arch/xtensa/include/asm/io.h:39:25: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/xtensa/include/asm/io.h:39:25: sparse:     expected void [noderef] __iomem *
   arch/xtensa/include/asm/io.h:39:25: sparse:     got void *

vim +743 drivers/video/fbdev/i740fb.c

5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  732  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  733  static int i740fb_set_par(struct fb_info *info)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  734  {
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  735  	struct i740fb_par *par = info->par;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  736  	u32 itemp;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  737  	int i;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  738  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  739  	i = i740fb_decode_var(&info->var, par, info);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  740  	if (i)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  741  		return i;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  742  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10 @743  	memset(info->screen_base, 0, info->screen_size);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  744  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  745  	vga_protect(par);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  746  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  747  	i740outreg(par, XRX, DRAM_EXT_CNTL, DRAM_REFRESH_DISABLE);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  748  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  749  	mdelay(1);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  750  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  751  	i740outreg(par, XRX, VCLK2_VCO_M, par->video_clk2_m);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  752  	i740outreg(par, XRX, VCLK2_VCO_N, par->video_clk2_n);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  753  	i740outreg(par, XRX, VCLK2_VCO_MN_MSBS, par->video_clk2_mn_msbs);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  754  	i740outreg(par, XRX, VCLK2_VCO_DIV_SEL, par->video_clk2_div_sel);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  755  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  756  	i740outreg_mask(par, XRX, PIXPIPE_CONFIG_0,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  757  			par->pixelpipe_cfg0 & DAC_8_BIT, 0x80);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  758  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  759  	i740inb(par, 0x3DA);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  760  	i740outb(par, 0x3C0, 0x00);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  761  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  762  	/* update misc output register */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  763  	i740outb(par, VGA_MIS_W, par->misc | 0x01);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  764  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  765  	/* synchronous reset on */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  766  	i740outreg(par, VGA_SEQ_I, VGA_SEQ_RESET, 0x01);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  767  	/* write sequencer registers */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  768  	i740outreg(par, VGA_SEQ_I, VGA_SEQ_CLOCK_MODE,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  769  			par->seq[VGA_SEQ_CLOCK_MODE] | 0x20);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  770  	for (i = 2; i < VGA_SEQ_C; i++)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  771  		i740outreg(par, VGA_SEQ_I, i, par->seq[i]);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  772  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  773  	/* synchronous reset off */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  774  	i740outreg(par, VGA_SEQ_I, VGA_SEQ_RESET, 0x03);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  775  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  776  	/* deprotect CRT registers 0-7 */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  777  	i740outreg(par, VGA_CRT_IC, VGA_CRTC_V_SYNC_END,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  778  			par->crtc[VGA_CRTC_V_SYNC_END]);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  779  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  780  	/* write CRT registers */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  781  	for (i = 0; i < VGA_CRT_C; i++)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  782  		i740outreg(par, VGA_CRT_IC, i, par->crtc[i]);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  783  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  784  	/* write graphics controller registers */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  785  	for (i = 0; i < VGA_GFX_C; i++)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  786  		i740outreg(par, VGA_GFX_I, i, par->gdc[i]);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  787  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  788  	/* write attribute controller registers */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  789  	for (i = 0; i < VGA_ATT_C; i++) {
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  790  		i740inb(par, VGA_IS1_RC);		/* reset flip-flop */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  791  		i740outb(par, VGA_ATT_IW, i);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  792  		i740outb(par, VGA_ATT_IW, par->atc[i]);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  793  	}
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  794  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  795  	i740inb(par, VGA_IS1_RC);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  796  	i740outb(par, VGA_ATT_IW, 0x20);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  797  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  798  	i740outreg(par, VGA_CRT_IC, EXT_VERT_TOTAL, par->ext_vert_total);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  799  	i740outreg(par, VGA_CRT_IC, EXT_VERT_DISPLAY, par->ext_vert_disp_end);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  800  	i740outreg(par, VGA_CRT_IC, EXT_VERT_SYNC_START,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  801  			par->ext_vert_sync_start);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  802  	i740outreg(par, VGA_CRT_IC, EXT_VERT_BLANK_START,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  803  			par->ext_vert_blank_start);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  804  	i740outreg(par, VGA_CRT_IC, EXT_HORIZ_TOTAL, par->ext_horiz_total);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  805  	i740outreg(par, VGA_CRT_IC, EXT_HORIZ_BLANK, par->ext_horiz_blank);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  806  	i740outreg(par, VGA_CRT_IC, EXT_OFFSET, par->ext_offset);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  807  	i740outreg(par, VGA_CRT_IC, EXT_START_ADDR_HI, par->ext_start_addr_hi);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  808  	i740outreg(par, VGA_CRT_IC, EXT_START_ADDR, par->ext_start_addr);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  809  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  810  	i740outreg_mask(par, VGA_CRT_IC, INTERLACE_CNTL,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  811  			par->interlace_cntl, INTERLACE_ENABLE);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  812  	i740outreg_mask(par, XRX, ADDRESS_MAPPING, par->address_mapping, 0x1F);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  813  	i740outreg_mask(par, XRX, BITBLT_CNTL, par->bitblt_cntl, COLEXP_MODE);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  814  	i740outreg_mask(par, XRX, DISPLAY_CNTL,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  815  			par->display_cntl, VGA_WRAP_MODE | GUI_MODE);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  816  	i740outreg_mask(par, XRX, PIXPIPE_CONFIG_0, par->pixelpipe_cfg0, 0x9B);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  817  	i740outreg_mask(par, XRX, PIXPIPE_CONFIG_2, par->pixelpipe_cfg2, 0x0C);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  818  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  819  	i740outreg(par, XRX, PLL_CNTL, par->pll_cntl);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  820  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  821  	i740outreg_mask(par, XRX, PIXPIPE_CONFIG_1,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  822  			par->pixelpipe_cfg1, DISPLAY_COLOR_MODE);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  823  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  824  	itemp = readl(par->regs + FWATER_BLC);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  825  	itemp &= ~(LMI_BURST_LENGTH | LMI_FIFO_WATERMARK);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  826  	itemp |= par->lmi_fifo_watermark;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  827  	writel(itemp, par->regs + FWATER_BLC);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  828  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  829  	i740outreg(par, XRX, DRAM_EXT_CNTL, DRAM_REFRESH_60HZ);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  830  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  831  	i740outreg_mask(par, MRX, COL_KEY_CNTL_1, 0, BLANK_DISP_OVERLAY);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  832  	i740outreg_mask(par, XRX, IO_CTNL,
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  833  			par->io_cntl, EXTENDED_ATTR_CNTL | EXTENDED_CRTC_CNTL);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  834  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  835  	if (par->pixelpipe_cfg1 != DISPLAY_8BPP_MODE) {
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  836  		i740outb(par, VGA_PEL_MSK, 0xFF);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  837  		i740outb(par, VGA_PEL_IW, 0x00);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  838  		for (i = 0; i < 256; i++) {
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  839  			itemp = (par->pixelpipe_cfg0 & DAC_8_BIT) ? i : i >> 2;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  840  			i740outb(par, VGA_PEL_D, itemp);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  841  			i740outb(par, VGA_PEL_D, itemp);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  842  			i740outb(par, VGA_PEL_D, itemp);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  843  		}
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  844  	}
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  845  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  846  	/* Wait for screen to stabilize. */
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  847  	mdelay(50);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  848  	vga_unprotect(par);
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  849  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  850  	info->fix.line_length =
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  851  			info->var.xres_virtual * info->var.bits_per_pixel / 8;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  852  	if (info->var.bits_per_pixel == 8)
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  853  		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  854  	else
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  855  		info->fix.visual = FB_VISUAL_TRUECOLOR;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  856  
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  857  	return 0;
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  858  }
5350c65f4f15bb drivers/video/i740fb.c Ondrej Zary 2012-02-10  859  

:::::: The code at line 743 was first introduced by commit
:::::: 5350c65f4f15bbc111ffa629130d3f32cdd4ccf6 Resurrect Intel740 driver: i740fb

:::::: TO: Ondrej Zary <linux@rainbow-software.org>
:::::: CC: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--VbJkn9YxBvnuCH5J--
