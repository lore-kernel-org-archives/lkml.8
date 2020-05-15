Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEFBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC6D20727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgEOSVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:21:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:44668 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgEOSVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:21:21 -0400
IronPort-SDR: 51k3mKnw3u3V15ZGOLRFcCVE2FgQ3oFLJMCCfwVGG8EVvm8SpucjVJIbGz+7J35EXwIvWnxsAm
 Pv261osh1lMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 11:21:21 -0700
IronPort-SDR: la1Joluqqqog1sYFmo2zqKPpXJ/1qclLofxeGdOhq7X+KiKvBNb4non6jphFhilzVJEeZPMdet
 efW5LLfhLF7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="252111415"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 May 2020 11:21:19 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZexS-0001jq-Ey; Sat, 16 May 2020 02:21:18 +0800
Date:   Sat, 16 May 2020 02:20:38 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: drivers/scsi/ncr53c8xx.c:5306:9: sparse: sparse: cast truncates bits
 from constant value (58f becomes 8f)
Message-ID: <202005160227.h6Ieqnmz%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   051e6b7e34b9bd24f46725f74994a4d3a653966e
commit: 06e85c7e9a1c1356038936566fc23f7c0d363b96 asm-generic: fix unistd_32.h generation format
date:   5 weeks ago
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-193-gb8fad4bc-dirty
        git checkout 06e85c7e9a1c1356038936566fc23f7c0d363b96
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/scsi/ncr53c8xx.c:5306:9: sparse: sparse: cast truncates bits from constant value (58f becomes 8f)

vim +5306 drivers/scsi/ncr53c8xx.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  5243  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5244  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  5245  	**	Start at first entry.
^1da177e4c3f41 Linus Torvalds 2005-04-16  5246  	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  5247  	np->script0->done_pos[0] = cpu_to_scr(NCB_SCRIPTH_PHYS (np,done_queue));
^1da177e4c3f41 Linus Torvalds 2005-04-16  5248  	np->ccb_done_ic = MAX_DONE-1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5249  	np->scripth0->done_queue[5*(MAX_DONE-1) + 4] =
^1da177e4c3f41 Linus Torvalds 2005-04-16  5250  			cpu_to_scr(NCB_SCRIPT_PHYS (np, done_plug));
^1da177e4c3f41 Linus Torvalds 2005-04-16  5251  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5252  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  5253  	**	Wakeup all pending jobs.
^1da177e4c3f41 Linus Torvalds 2005-04-16  5254  	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  5255  	ncr_wakeup (np, code);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5256  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5257  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  5258  	**	Init chip.
^1da177e4c3f41 Linus Torvalds 2005-04-16  5259  	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  5260  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5261  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  5262  	** Remove reset; big delay because the 895 needs time for the
^1da177e4c3f41 Linus Torvalds 2005-04-16  5263  	** bus mode to settle
^1da177e4c3f41 Linus Torvalds 2005-04-16  5264  	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  5265  	ncr_chip_reset(np, 2000);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5266  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5267  	OUTB (nc_scntl0, np->rv_scntl0 | 0xc0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5268  					/*  full arb., ena parity, par->ATN  */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5269  	OUTB (nc_scntl1, 0x00);		/*  odd parity, and remove CRST!! */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5270  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5271  	ncr_selectclock(np, np->rv_scntl3);	/* Select SCSI clock */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5272  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5273  	OUTB (nc_scid  , RRE|np->myaddr);	/* Adapter SCSI address */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5274  	OUTW (nc_respid, 1ul<<np->myaddr);	/* Id to respond to */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5275  	OUTB (nc_istat , SIGP	);		/*  Signal Process */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5276  	OUTB (nc_dmode , np->rv_dmode);		/* Burst length, dma mode */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5277  	OUTB (nc_ctest5, np->rv_ctest5);	/* Large fifo + large burst */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5278  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5279  	OUTB (nc_dcntl , NOCOM|np->rv_dcntl);	/* Protect SFBR */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5280  	OUTB (nc_ctest0, np->rv_ctest0);	/* 720: CDIS and EHP */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5281  	OUTB (nc_ctest3, np->rv_ctest3);	/* Write and invalidate */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5282  	OUTB (nc_ctest4, np->rv_ctest4);	/* Master parity checking */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5283  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5284  	OUTB (nc_stest2, EXT|np->rv_stest2);	/* Extended Sreq/Sack filtering */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5285  	OUTB (nc_stest3, TE);			/* TolerANT enable */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5286  	OUTB (nc_stime0, 0x0c	);		/* HTH disabled  STO 0.25 sec */
^1da177e4c3f41 Linus Torvalds 2005-04-16  5287  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5288  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  5289  	**	Disable disconnects.
^1da177e4c3f41 Linus Torvalds 2005-04-16  5290  	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  5291  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5292  	np->disc = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5293  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5294  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  5295  	**    Enable GPIO0 pin for writing if LED support.
^1da177e4c3f41 Linus Torvalds 2005-04-16  5296  	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  5297  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5298  	if (np->features & FE_LED0) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  5299  		OUTOFFB (nc_gpcntl, 0x01);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5300  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  5301  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5302  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  5303  	**      enable ints
^1da177e4c3f41 Linus Torvalds 2005-04-16  5304  	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  5305  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @5306  	OUTW (nc_sien , STO|HTH|MA|SGE|UDC|RST|PAR);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5307  	OUTB (nc_dien , MDPE|BF|ABRT|SSI|SIR|IID);
^1da177e4c3f41 Linus Torvalds 2005-04-16  5308  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5309  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  5310  	**	Fill in target structure.
^1da177e4c3f41 Linus Torvalds 2005-04-16  5311  	**	Reinitialize usrsync.
^1da177e4c3f41 Linus Torvalds 2005-04-16  5312  	**	Reinitialize usrwide.
^1da177e4c3f41 Linus Torvalds 2005-04-16  5313  	**	Prepare sync negotiation according to actual SCSI bus mode.
^1da177e4c3f41 Linus Torvalds 2005-04-16  5314  	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  5315  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5316  	for (i=0;i<MAX_TARGET;i++) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  5317  		struct tcb *tp = &np->target[i];
^1da177e4c3f41 Linus Torvalds 2005-04-16  5318  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5319  		tp->sval    = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5320  		tp->wval    = np->rv_scntl3;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5321  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5322  		if (tp->usrsync != 255) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  5323  			if (tp->usrsync <= np->maxsync) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  5324  				if (tp->usrsync < np->minsync) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  5325  					tp->usrsync = np->minsync;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5326  				}
^1da177e4c3f41 Linus Torvalds 2005-04-16  5327  			}
^1da177e4c3f41 Linus Torvalds 2005-04-16  5328  			else
^1da177e4c3f41 Linus Torvalds 2005-04-16  5329  				tp->usrsync = 255;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5330  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  5331  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5332  		if (tp->usrwide > np->maxwide)
^1da177e4c3f41 Linus Torvalds 2005-04-16  5333  			tp->usrwide = np->maxwide;
^1da177e4c3f41 Linus Torvalds 2005-04-16  5334  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5335  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  5336  
^1da177e4c3f41 Linus Torvalds 2005-04-16  5337  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  5338  	**    Start script processor.
^1da177e4c3f41 Linus Torvalds 2005-04-16  5339  	*/
^1da177e4c3f41 Linus Torvalds 2005-04-16  5340  	if (np->paddr2) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  5341  		if (bootverbose)
^1da177e4c3f41 Linus Torvalds 2005-04-16  5342  			printk ("%s: Downloading SCSI SCRIPTS.\n",
^1da177e4c3f41 Linus Torvalds 2005-04-16  5343  				ncr_name(np));
^1da177e4c3f41 Linus Torvalds 2005-04-16  5344  		OUTL (nc_scratcha, vtobus(np->script0));
^1da177e4c3f41 Linus Torvalds 2005-04-16  5345  		OUTL_DSP (NCB_SCRIPTH_PHYS (np, start_ram));
^1da177e4c3f41 Linus Torvalds 2005-04-16  5346  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  5347  	else
^1da177e4c3f41 Linus Torvalds 2005-04-16  5348  		OUTL_DSP (NCB_SCRIPT_PHYS (np, start));
^1da177e4c3f41 Linus Torvalds 2005-04-16  5349  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  5350  

:::::: The code at line 5306 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
