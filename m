Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E879C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B892070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgGFOsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:48:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:35226 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbgGFOsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:48:36 -0400
IronPort-SDR: uJ95YHnYmo7BiIw0/RnZi0SZK1Exd+U4RWt2YxFESuZh2SMP5dgvLYUa52yxyXWgNrsrMvLw58
 ymxytIc4Th4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="212408847"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="gz'50?scan'50,208,50";a="212408847"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 07:48:16 -0700
IronPort-SDR: ATkDoHybP9Dmm5Xhecsc6+zUO3W56OUvlSJl0NCpSm2FFg3lHS27OlB6OPjJcv5jayqCoEaWhZ
 KfCSmX7HyTbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="gz'50?scan'50,208,50";a="297031829"
Received: from lkp-server01.sh.intel.com (HELO 82346ce9ac16) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2020 07:48:14 -0700
Received: from kbuild by 82346ce9ac16 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsSPm-0000Ea-5X; Mon, 06 Jul 2020 14:48:14 +0000
Date:   Mon, 6 Jul 2020 22:47:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/i740fb.c:743:9: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202007062218.2nJJ8nqf%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: xtensa-randconfig-s032-20200706 (attached as .config)
compiler: xtensa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-14-g8fce3d7a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=xtensa 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/i740fb.c:743:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *__s @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/i740fb.c:743:9: sparse:     expected void *__s
   drivers/video/fbdev/i740fb.c:743:9: sparse:     got char [noderef] __iomem *screen_base
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
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value

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

--Kj7319i9nmIyA2yE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
2wEA

--Kj7319i9nmIyA2yE--
