Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC34C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BEA2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgHJPsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:48:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:14133 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbgHJPs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:48:29 -0400
IronPort-SDR: 8WGNlJR4bvKuyYGJXdCPyb7Xh8OibkNFQx7d8Vjzv/2MdlIZNxTELfBFxE0FEY1uBfjUdxKJcT
 +BnlUjLx9EwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="151236357"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="gz'50?scan'50,208,50";a="151236357"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 08:21:18 -0700
IronPort-SDR: vdO2uVgD+O4YrbWScJhljtjFItTz/VxU1oJUYQfpH5fPsaB7m1IC3nLavh/crWbaolX7VIaDn4
 lNwL2e/MO4Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="gz'50?scan'50,208,50";a="494347923"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2020 08:21:16 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k59bw-00003A-2V; Mon, 10 Aug 2020 15:21:16 +0000
Date:   Mon, 10 Aug 2020 23:20:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/controlfb.c:373:13: warning: variable 'b' set
 but not used
Message-ID: <202008102324.weSyybZE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bartlomiej,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc80c51fd4b23ec007e88d4c688f2cac1b8648e7
commit: a07a63b0e24dd1316d11427601a9f83dc955bb40 video: fbdev: controlfb: add COMPILE_TEST support
date:   4 months ago
config: nds32-randconfig-r031-20200810 (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a07a63b0e24dd1316d11427601a9f83dc955bb40
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from ./arch/nds32/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/nds32/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/video/fbdev/controlfb.c:34:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/nds32/include/asm/memory.h:82:32: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      82 | #define pfn_valid(pfn)  ((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))
         |                                ^~
   include/asm-generic/bug.h:139:27: note: in definition of macro 'WARN_ON_ONCE'
     139 |  int __ret_warn_once = !!(condition);   \
         |                           ^~~~~~~~~
   include/linux/dma-mapping.h:352:19: note: in expansion of macro 'pfn_valid'
     352 |  if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
         |                   ^~~~~~~~~
   drivers/video/fbdev/controlfb.c: In function 'controlfb_setcolreg':
>> drivers/video/fbdev/controlfb.c:373:13: warning: variable 'b' set but not used [-Wunused-but-set-variable]
     373 |  __u8 r, g, b;
         |             ^
>> drivers/video/fbdev/controlfb.c:373:10: warning: variable 'g' set but not used [-Wunused-but-set-variable]
     373 |  __u8 r, g, b;
         |          ^
>> drivers/video/fbdev/controlfb.c:373:7: warning: variable 'r' set but not used [-Wunused-but-set-variable]
     373 |  __u8 r, g, b;
         |       ^
   drivers/video/fbdev/controlfb.c: In function 'control_set_hardware':
>> drivers/video/fbdev/controlfb.c:505:11: warning: variable 'cmode' set but not used [-Wunused-but-set-variable]
     505 |  int   i, cmode;
         |           ^~~~~

vim +/b +373 drivers/video/fbdev/controlfb.c

^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  367  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  368  static int controlfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  369  			     u_int transp, struct fb_info *info)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  370  {
c4e423239ca7cbc drivers/video/fbdev/controlfb.c Fabian Frederick 2014-09-17  371  	struct fb_info_control *p =
c4e423239ca7cbc drivers/video/fbdev/controlfb.c Fabian Frederick 2014-09-17  372  		container_of(info, struct fb_info_control, info);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16 @373  	__u8 r, g, b;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  374  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  375  	if (regno > 255)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  376  		return 1;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  377  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  378  	r = red >> 8;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  379  	g = green >> 8;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  380  	b = blue >> 8;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  381  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  382  	out_8(&p->cmap_regs->addr, regno);	/* tell clut what addr to fill	*/
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  383  	out_8(&p->cmap_regs->lut, r);		/* send one color channel at	*/
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  384  	out_8(&p->cmap_regs->lut, g);		/* a time...			*/
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  385  	out_8(&p->cmap_regs->lut, b);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  386  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  387  	if (regno < 16) {
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  388  		int i;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  389  		switch (p->par.cmode) {
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  390  		case CMODE_16:
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  391  			p->pseudo_palette[regno] =
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  392  			    (regno << 10) | (regno << 5) | regno;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  393  			break;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  394  		case CMODE_32:
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  395  			i = (regno << 8) | regno;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  396  			p->pseudo_palette[regno] = (i << 16) | i;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  397  			break;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  398  		}
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  399  	}
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  400  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  401  	return 0;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  402  }
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  403  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  404  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  405  /********************  End of controlfb_ops implementation  ******************/
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  406  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  407  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  408  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  409  static void set_control_clock(unsigned char *params)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  410  {
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  411  #ifdef CONFIG_ADB_CUDA
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  412  	struct adb_request req;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  413  	int i;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  414  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  415  	for (i = 0; i < 3; ++i) {
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  416  		cuda_request(&req, NULL, 5, CUDA_PACKET, CUDA_GET_SET_IIC,
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  417  			     0x50, i + 1, params[i]);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  418  		while (!req.complete)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  419  			cuda_poll();
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  420  	}
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  421  #endif	
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  422  }
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  423  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  424  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  425  /*
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  426   * finish off the driver initialization and register
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  427   */
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  428  static int __init init_control(struct fb_info_control *p)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  429  {
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  430  	int full, sense, vmode, cmode, vyres;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  431  	struct fb_var_screeninfo var;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  432  	int rc;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  433  	
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  434  	printk(KERN_INFO "controlfb: ");
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  435  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  436  	full = p->total_vram == 0x400000;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  437  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  438  	/* Try to pick a video mode out of NVRAM if we have one. */
066ac5c3c4bb467 drivers/video/fbdev/controlfb.c Finn Thain       2019-01-15  439  	cmode = default_cmode;
066ac5c3c4bb467 drivers/video/fbdev/controlfb.c Finn Thain       2019-01-15  440  	if (IS_REACHABLE(CONFIG_NVRAM) && cmode == CMODE_NVRAM)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  441  		cmode = nvram_read_byte(NV_CMODE);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  442  	if (cmode < CMODE_8 || cmode > CMODE_32)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  443  		cmode = CMODE_8;
066ac5c3c4bb467 drivers/video/fbdev/controlfb.c Finn Thain       2019-01-15  444  
066ac5c3c4bb467 drivers/video/fbdev/controlfb.c Finn Thain       2019-01-15  445  	vmode = default_vmode;
066ac5c3c4bb467 drivers/video/fbdev/controlfb.c Finn Thain       2019-01-15  446  	if (IS_REACHABLE(CONFIG_NVRAM) && vmode == VMODE_NVRAM)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  447  		vmode = nvram_read_byte(NV_VMODE);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  448  	if (vmode < 1 || vmode > VMODE_MAX ||
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  449  	    control_mac_modes[vmode - 1].m[full] < cmode) {
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  450  		sense = read_control_sense(p);
066ac5c3c4bb467 drivers/video/fbdev/controlfb.c Finn Thain       2019-01-15  451  		printk(KERN_CONT "Monitor sense value = 0x%x, ", sense);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  452  		vmode = mac_map_monitor_sense(sense);
066ac5c3c4bb467 drivers/video/fbdev/controlfb.c Finn Thain       2019-01-15  453  		if (control_mac_modes[vmode - 1].m[full] < 0)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  454  			vmode = VMODE_640_480_60;
066ac5c3c4bb467 drivers/video/fbdev/controlfb.c Finn Thain       2019-01-15  455  		cmode = min(cmode, control_mac_modes[vmode - 1].m[full]);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  456  	}
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  457  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  458  	/* Initialize info structure */
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  459  	control_init_info(&p->info, p);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  460  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  461  	/* Setup default var */
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  462  	if (mac_vmode_to_var(vmode, cmode, &var) < 0) {
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  463  		/* This shouldn't happen! */
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  464  		printk("mac_vmode_to_var(%d, %d,) failed\n", vmode, cmode);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  465  try_again:
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  466  		vmode = VMODE_640_480_60;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  467  		cmode = CMODE_8;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  468  		if (mac_vmode_to_var(vmode, cmode, &var) < 0) {
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  469  			printk(KERN_ERR "controlfb: mac_vmode_to_var() failed\n");
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  470  			return -ENXIO;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  471  		}
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  472  		printk(KERN_INFO "controlfb: ");
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  473  	}
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  474  	printk("using video mode %d and color mode %d.\n", vmode, cmode);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  475  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  476  	vyres = (p->total_vram - CTRLFB_OFF) / (var.xres << cmode);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  477  	if (vyres > var.yres)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  478  		var.yres_virtual = vyres;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  479  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  480  	/* Apply default var */
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  481  	var.activate = FB_ACTIVATE_NOW;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  482  	rc = fb_set_var(&p->info, &var);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  483  	if (rc && (vmode != VMODE_640_480_60 || cmode != CMODE_8))
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  484  		goto try_again;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  485  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  486  	/* Register with fbdev layer */
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  487  	if (register_framebuffer(&p->info) < 0)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  488  		return -ENXIO;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  489  
31b6780c15a4e3a drivers/video/controlfb.c       Joe Perches      2013-09-19  490  	fb_info(&p->info, "control display adapter\n");
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  491  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  492  	return 0;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  493  }
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  494  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  495  #define RADACAL_WRITE(a,d) \
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  496  	out_8(&p->cmap_regs->addr, (a)); \
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  497  	out_8(&p->cmap_regs->dat,   (d))
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  498  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  499  /* Now how about actually saying, Make it so! */
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  500  /* Some things in here probably don't need to be done each time. */
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  501  static void control_set_hardware(struct fb_info_control *p, struct fb_par_control *par)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  502  {
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  503  	struct control_regvals	*r;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  504  	volatile struct preg	__iomem *rp;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16 @505  	int			i, cmode;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  506  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  507  	if (PAR_EQUAL(&p->par, par)) {
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  508  		/*
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  509  		 * check if only xoffset or yoffset differs.
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  510  		 * this prevents flickers in typical VT switch case.
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  511  		 */
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  512  		if (p->par.xoffset != par->xoffset ||
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  513  		    p->par.yoffset != par->yoffset)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  514  			set_screen_start(par->xoffset, par->yoffset, p);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  515  			
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  516  		return;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  517  	}
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  518  	
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  519  	p->par = *par;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  520  	cmode = p->par.cmode;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  521  	r = &par->regvals;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  522  	
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  523  	/* Turn off display */
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  524  	out_le32(CNTRL_REG(p,ctrl), 0x400 | par->ctrl);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  525  	
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  526  	set_control_clock(r->clock_params);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  527  	
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  528  	RADACAL_WRITE(0x20, r->radacal_ctrl);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  529  	RADACAL_WRITE(0x21, p->control_use_bank2 ? 0 : 1);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  530  	RADACAL_WRITE(0x10, 0);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  531  	RADACAL_WRITE(0x11, 0);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  532  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  533  	rp = &p->control_regs->vswin;
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  534  	for (i = 0; i < 16; ++i, ++rp)
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  535  		out_le32(&rp->r, r->regs[i]);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  536  	
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  537  	out_le32(CNTRL_REG(p,pitch), par->pitch);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  538  	out_le32(CNTRL_REG(p,mode), r->mode);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  539  	out_le32(CNTRL_REG(p,vram_attr), p->vram_attr);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  540  	out_le32(CNTRL_REG(p,start_addr), par->yoffset * par->pitch
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  541  		 + (par->xoffset << cmode));
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  542  	out_le32(CNTRL_REG(p,rfrcnt), 0x1e5);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  543  	out_le32(CNTRL_REG(p,intr_ena), 0);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  544  
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  545  	/* Turn on display */
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  546  	out_le32(CNTRL_REG(p,ctrl), par->ctrl);
^1da177e4c3f415 drivers/video/controlfb.c       Linus Torvalds   2005-04-16  547  

:::::: The code at line 373 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
WFox/3+WnFJBmvQBAA==

--LQksG6bCIzRHxTLp--
