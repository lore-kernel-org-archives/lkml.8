Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57FBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 03:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23B220747
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 03:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgGFDAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 23:00:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:24369 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgGFDAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 23:00:05 -0400
IronPort-SDR: qh82vPwbH/o3jtbGngbtCsrJeQhyhF6f+5UhuzPQN5gbtsIy7p/ftuoOw6hEYLeUenb3FB+V9s
 6dSY5KK9vATA==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="212338167"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="gz'50?scan'50,208,50";a="212338167"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 19:56:00 -0700
IronPort-SDR: A8a8VWFomuB/6Y34218oxSwzPJ10/65NQPb2jFrFOAHawrxbothrVrdXNu8rwmkvR5gcGkW7Cs
 zS16Du2ag60w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="gz'50?scan'50,208,50";a="313818930"
Received: from lkp-server01.sh.intel.com (HELO 82346ce9ac16) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Jul 2020 19:55:58 -0700
Received: from kbuild by 82346ce9ac16 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsHIT-00002y-Q6; Mon, 06 Jul 2020 02:55:57 +0000
Date:   Mon, 6 Jul 2020 10:55:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/geode/lxfb_ops.c:604:28: sparse: sparse:
 incorrect type in argument 2 (different address spaces)
Message-ID: <202007061034.ztKKn4NT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   2 weeks ago
config: i386-randconfig-s002-20200706 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-14-g8fce3d7a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/geode/lxfb_ops.c:604:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got void [noderef] __iomem *gp_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:604:28: sparse:     expected void const *q
   drivers/video/fbdev/geode/lxfb_ops.c:604:28: sparse:     got void [noderef] __iomem *gp_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:605:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got void [noderef] __iomem *dc_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:605:28: sparse:     expected void const *q
   drivers/video/fbdev/geode/lxfb_ops.c:605:28: sparse:     got void [noderef] __iomem *dc_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:606:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got void [noderef] __iomem *vp_regs @@
   drivers/video/fbdev/geode/lxfb_ops.c:606:28: sparse:     expected void const *q
   drivers/video/fbdev/geode/lxfb_ops.c:606:28: sparse:     got void [noderef] __iomem *vp_regs
>> drivers/video/fbdev/geode/lxfb_ops.c:607:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:607:38: sparse:     expected void const *q
   drivers/video/fbdev/geode/lxfb_ops.c:607:38: sparse:     got void [noderef] __iomem *
   drivers/video/fbdev/geode/lxfb_ops.c:635:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:635:44: sparse:     expected void const *q
   drivers/video/fbdev/geode/lxfb_ops.c:635:44: sparse:     got void [noderef] __iomem *
>> drivers/video/fbdev/geode/lxfb_ops.c:761:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem * @@
   drivers/video/fbdev/geode/lxfb_ops.c:761:29: sparse:     expected void *p
   drivers/video/fbdev/geode/lxfb_ops.c:761:29: sparse:     got void [noderef] __iomem *

vim +604 drivers/video/fbdev/geode/lxfb_ops.c

f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  584  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  585  static void lx_save_regs(struct lxfb_par *par)
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  586  {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  587  	uint32_t filt;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  588  	int i;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  589  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  590  	/* wait for the BLT engine to stop being busy */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  591  	do {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  592  		i = read_gp(par, GP_BLT_STATUS);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  593  	} while ((i & GP_BLT_STATUS_PB) || !(i & GP_BLT_STATUS_CE));
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  594  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  595  	/* save MSRs */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  596  	rdmsrl(MSR_LX_MSR_PADSEL, par->msr.padsel);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  597  	rdmsrl(MSR_GLCP_DOTPLL, par->msr.dotpll);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  598  	rdmsrl(MSR_LX_GLD_MSR_CONFIG, par->msr.dfglcfg);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  599  	rdmsrl(MSR_LX_SPARE_MSR, par->msr.dcspare);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  600  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  601  	write_dc(par, DC_UNLOCK, DC_UNLOCK_UNLOCK);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  602  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  603  	/* save registers */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28 @604  	memcpy(par->gp, par->gp_regs, sizeof(par->gp));
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28 @605  	memcpy(par->dc, par->dc_regs, sizeof(par->dc));
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28 @606  	memcpy(par->vp, par->vp_regs, sizeof(par->vp));
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28 @607  	memcpy(par->fp, par->vp_regs + VP_FP_START, sizeof(par->fp));
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  608  
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  609  	/* save the display controller palette */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  610  	write_dc(par, DC_PAL_ADDRESS, 0);
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  611  	for (i = 0; i < ARRAY_SIZE(par->dc_pal); i++)
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  612  		par->dc_pal[i] = read_dc(par, DC_PAL_DATA);
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  613  
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  614  	/* save the video processor palette */
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  615  	write_vp(par, VP_PAR, 0);
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  616  	for (i = 0; i < ARRAY_SIZE(par->vp_pal); i++)
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  617  		par->vp_pal[i] = read_vp(par, VP_PDR);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  618  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  619  	/* save the horizontal filter coefficients */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  620  	filt = par->dc[DC_IRQ_FILT_CTL] | DC_IRQ_FILT_CTL_H_FILT_SEL;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  621  	for (i = 0; i < ARRAY_SIZE(par->hcoeff); i += 2) {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  622  		write_dc(par, DC_IRQ_FILT_CTL, (filt & 0xffffff00) | i);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  623  		par->hcoeff[i] = read_dc(par, DC_FILT_COEFF1);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  624  		par->hcoeff[i + 1] = read_dc(par, DC_FILT_COEFF2);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  625  	}
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  626  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  627  	/* save the vertical filter coefficients */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  628  	filt &= ~DC_IRQ_FILT_CTL_H_FILT_SEL;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  629  	for (i = 0; i < ARRAY_SIZE(par->vcoeff); i++) {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  630  		write_dc(par, DC_IRQ_FILT_CTL, (filt & 0xffffff00) | i);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  631  		par->vcoeff[i] = read_dc(par, DC_FILT_COEFF1);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  632  	}
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  633  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  634  	/* save video coeff ram */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  635  	memcpy(par->vp_coeff, par->vp_regs + VP_VCR, sizeof(par->vp_coeff));
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  636  }
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  637  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  638  static void lx_restore_gfx_proc(struct lxfb_par *par)
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  639  {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  640  	int i;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  641  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  642  	/* a bunch of registers require GP_RASTER_MODE to be set first */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  643  	write_gp(par, GP_RASTER_MODE, par->gp[GP_RASTER_MODE]);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  644  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  645  	for (i = 0; i < ARRAY_SIZE(par->gp); i++) {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  646  		switch (i) {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  647  		case GP_RASTER_MODE:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  648  		case GP_VECTOR_MODE:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  649  		case GP_BLT_MODE:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  650  		case GP_BLT_STATUS:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  651  		case GP_HST_SRC:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  652  			/* FIXME: restore LUT data */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  653  		case GP_LUT_INDEX:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  654  		case GP_LUT_DATA:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  655  			/* don't restore these registers */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  656  			break;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  657  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  658  		default:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  659  			write_gp(par, i, par->gp[i]);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  660  		}
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  661  	}
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  662  }
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  663  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  664  static void lx_restore_display_ctlr(struct lxfb_par *par)
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  665  {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  666  	uint32_t filt;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  667  	int i;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  668  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  669  	wrmsrl(MSR_LX_SPARE_MSR, par->msr.dcspare);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  670  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  671  	for (i = 0; i < ARRAY_SIZE(par->dc); i++) {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  672  		switch (i) {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  673  		case DC_UNLOCK:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  674  			/* unlock the DC; runs first */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  675  			write_dc(par, DC_UNLOCK, DC_UNLOCK_UNLOCK);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  676  			break;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  677  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  678  		case DC_GENERAL_CFG:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  679  		case DC_DISPLAY_CFG:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  680  			/* disable all while restoring */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  681  			write_dc(par, i, 0);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  682  			break;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  683  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  684  		case DC_DV_CTL:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  685  			/* set all ram to dirty */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  686  			write_dc(par, i, par->dc[i] | DC_DV_CTL_CLEAR_DV_RAM);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  687  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  688  		case DC_RSVD_1:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  689  		case DC_RSVD_2:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  690  		case DC_RSVD_3:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  691  		case DC_LINE_CNT:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  692  		case DC_PAL_ADDRESS:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  693  		case DC_PAL_DATA:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  694  		case DC_DFIFO_DIAG:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  695  		case DC_CFIFO_DIAG:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  696  		case DC_FILT_COEFF1:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  697  		case DC_FILT_COEFF2:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  698  		case DC_RSVD_4:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  699  		case DC_RSVD_5:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  700  			/* don't restore these registers */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  701  			break;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  702  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  703  		default:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  704  			write_dc(par, i, par->dc[i]);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  705  		}
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  706  	}
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  707  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  708  	/* restore the palette */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  709  	write_dc(par, DC_PAL_ADDRESS, 0);
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  710  	for (i = 0; i < ARRAY_SIZE(par->dc_pal); i++)
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  711  		write_dc(par, DC_PAL_DATA, par->dc_pal[i]);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  712  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  713  	/* restore the horizontal filter coefficients */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  714  	filt = par->dc[DC_IRQ_FILT_CTL] | DC_IRQ_FILT_CTL_H_FILT_SEL;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  715  	for (i = 0; i < ARRAY_SIZE(par->hcoeff); i += 2) {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  716  		write_dc(par, DC_IRQ_FILT_CTL, (filt & 0xffffff00) | i);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  717  		write_dc(par, DC_FILT_COEFF1, par->hcoeff[i]);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  718  		write_dc(par, DC_FILT_COEFF2, par->hcoeff[i + 1]);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  719  	}
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  720  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  721  	/* restore the vertical filter coefficients */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  722  	filt &= ~DC_IRQ_FILT_CTL_H_FILT_SEL;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  723  	for (i = 0; i < ARRAY_SIZE(par->vcoeff); i++) {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  724  		write_dc(par, DC_IRQ_FILT_CTL, (filt & 0xffffff00) | i);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  725  		write_dc(par, DC_FILT_COEFF1, par->vcoeff[i]);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  726  	}
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  727  }
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  728  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  729  static void lx_restore_video_proc(struct lxfb_par *par)
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  730  {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  731  	int i;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  732  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  733  	wrmsrl(MSR_LX_GLD_MSR_CONFIG, par->msr.dfglcfg);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  734  	wrmsrl(MSR_LX_MSR_PADSEL, par->msr.padsel);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  735  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  736  	for (i = 0; i < ARRAY_SIZE(par->vp); i++) {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  737  		switch (i) {
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  738  		case VP_VCFG:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  739  		case VP_DCFG:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  740  		case VP_PAR:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  741  		case VP_PDR:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  742  		case VP_CCS:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  743  		case VP_RSVD_0:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  744  		/* case VP_VDC: */ /* why should this not be restored? */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  745  		case VP_RSVD_1:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  746  		case VP_CRC32:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  747  			/* don't restore these registers */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  748  			break;
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  749  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  750  		default:
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  751  			write_vp(par, i, par->vp[i]);
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  752  		}
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  753  	}
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  754  
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  755  	/* restore video processor palette */
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  756  	write_vp(par, VP_PAR, 0);
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  757  	for (i = 0; i < ARRAY_SIZE(par->vp_pal); i++)
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  758  		write_vp(par, VP_PDR, par->vp_pal[i]);
16cdd4336fdca9 drivers/video/geode/lxfb_ops.c Daniel Drake   2010-11-30  759  
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  760  	/* restore video coeff ram */
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28 @761  	memcpy(par->vp_regs + VP_VCR, par->vp_coeff, sizeof(par->vp_coeff));
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  762  }
f694e53bd0db69 drivers/video/geode/lxfb_ops.c Andres Salomon 2008-04-28  763  

:::::: The code at line 604 was first introduced by commit
:::::: f694e53bd0db69557ee8e0db2d1602818ff173b0 lxfb: add power management functionality

:::::: TO: Andres Salomon <dilinger@queued.net>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vkogqOf2sHV7VnPd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--vkogqOf2sHV7VnPd--
