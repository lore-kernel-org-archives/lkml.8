Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D70FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE41D20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgGALuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:50:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:31863 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730159AbgGALuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:50:44 -0400
IronPort-SDR: UCDZqWTMsP5CE2So/I8Wt6tEr2JrOBK7yVazZ2HsSeFksEFb5scx4CFl4+f7DK+VObDJOR6bYC
 P81WFMSUTJaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134009345"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="gz'50?scan'50,208,50";a="134009345"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 04:30:58 -0700
IronPort-SDR: wK3cUkmiVcAkGhjB7Wm2slC3Usz1o/RQEcnK8/26ieWIfPHqjDYYvhjt0Dta1+Vxhy/8NCoTKE
 S/PWP6RFf41g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="gz'50?scan'50,208,50";a="386983226"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jul 2020 04:30:55 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jqax5-00031E-91; Wed, 01 Jul 2020 11:30:55 +0000
Date:   Wed, 1 Jul 2020 19:30:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/44x/warp.c:284:22: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202007011929.gwkQ9YF5%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7c30b859a947535f2213277e827d7ac7dcff9c84
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   13 days ago
config: powerpc-randconfig-s032-20200701 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/scsi/aacraid/aachba.c:796: warning: Excess function parameter 'dev' description in 'aac_probe_container_callback1'
   drivers/scsi/aacraid/aachba.c:796: warning: Excess function parameter 'cid' description in 'aac_probe_container_callback1'
   drivers/scsi/aacraid/aachba.c:1105: warning: Function parameter or member 'scsicmd' not described in 'aac_get_container_serial'
   drivers/scsi/aacraid/aachba.c:1961: warning: Excess function parameter 'phys_luns' description in 'aac_set_safw_attr_all_targets'
   drivers/scsi/aacraid/aachba.c:1961: warning: Excess function parameter 'rescan' description in 'aac_set_safw_attr_all_targets'
   drivers/scsi/aacraid/aachba.c:3394: warning: Cannot understand  *
    on line 3394 - I thought it was a doc line
   drivers/scsi/aacraid/aachba.c:3687: warning: Cannot understand  *
    on line 3687 - I thought it was a doc line
   drivers/scsi/aacraid/aachba.c:3752: warning: Cannot understand  *
    on line 3752 - I thought it was a doc line
   drivers/scsi/aacraid/aachba.c:3795: warning: Cannot understand  *
    on line 3795 - I thought it was a doc line
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/aty/atyfb_base.c:475:9: sparse: sparse: switch with no cases
   drivers/video/fbdev/aty/atyfb_base.c:3715:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *addr @@
   drivers/video/fbdev/aty/atyfb_base.c:3715:37: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/aty/atyfb_base.c:3715:37: sparse:     got unsigned char [usertype] *addr
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/44x/warp.c:284:22: sparse: sparse: incorrect type in argument 1 (incompatible argument 1 (different address spaces)) @@     expected int ( *threadfn )( ... ) @@     got int ( * )( ... ) @@
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     expected int ( *threadfn )( ... )
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     got int ( * )( ... )
>> arch/powerpc/platforms/44x/warp.c:284:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *static [assigned] [toplevel] dtm_fpga @@
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     expected void *data
>> arch/powerpc/platforms/44x/warp.c:284:22: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] dtm_fpga
   drivers/scsi/aacraid/linit.c:243: warning: Function parameter or member 'shost' not described in 'aac_queuecommand'
   drivers/scsi/aacraid/linit.c:243: warning: Excess function parameter 'done' description in 'aac_queuecommand'
   drivers/scsi/aacraid/linit.c:1176: warning: Excess function parameter 'inode' description in 'aac_cfg_ioctl'
   drivers/video/fbdev/aty/mach64_accel.c:420:49: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/aty/mach64_accel.c:420:49: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/aty/mach64_accel.c:420:49: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/aty/mach64_accel.c:420:49: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/aty/mach64_accel.c:420:49: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/aty/mach64_accel.c:420:49: sparse: sparse: cast to restricted __le32
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
--
         |                             ^~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:89:29: warning: 'ModeIndex_1280x1024' defined but not used [-Wunused-const-variable=]
      89 | static const unsigned short ModeIndex_1280x1024[]    = {0x3a, 0x4d, 0x00, 0x65};
         |                             ^~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:88:29: warning: 'ModeIndex_1024x600' defined but not used [-Wunused-const-variable=]
      88 | static const unsigned short ModeIndex_1024x600[]     = {0x20, 0x21, 0x00, 0x22};  /* 300 series only */
         |                             ^~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:87:29: warning: 'ModeIndex_1024x576' defined but not used [-Wunused-const-variable=]
      87 | static const unsigned short ModeIndex_1024x576[]     = {0x71, 0x74, 0x00, 0x77};
         |                             ^~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:86:29: warning: 'ModeIndex_1024x768' defined but not used [-Wunused-const-variable=]
      86 | static const unsigned short ModeIndex_1024x768[]     = {0x38, 0x4a, 0x00, 0x64};
         |                             ^~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:85:29: warning: 'ModeIndex_960x600' defined but not used [-Wunused-const-variable=]
      85 | static const unsigned short ModeIndex_960x600[]      = {0x20, 0x21, 0x00, 0x22};  /* 315 series only */
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:84:29: warning: 'ModeIndex_960x540' defined but not used [-Wunused-const-variable=]
      84 | static const unsigned short ModeIndex_960x540[]      = {0x1d, 0x1e, 0x00, 0x1f};  /* 315 series only */
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:83:29: warning: 'ModeIndex_856x480' defined but not used [-Wunused-const-variable=]
      83 | static const unsigned short ModeIndex_856x480[]      = {0x3f, 0x42, 0x00, 0x45};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:82:29: warning: 'ModeIndex_848x480' defined but not used [-Wunused-const-variable=]
      82 | static const unsigned short ModeIndex_848x480[]      = {0x39, 0x3b, 0x00, 0x3e};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:81:29: warning: 'ModeIndex_800x600' defined but not used [-Wunused-const-variable=]
      81 | static const unsigned short ModeIndex_800x600[]      = {0x30, 0x47, 0x00, 0x63};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:80:29: warning: 'ModeIndex_800x480' defined but not used [-Wunused-const-variable=]
      80 | static const unsigned short ModeIndex_800x480[]      = {0x70, 0x7a, 0x00, 0x76};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:79:29: warning: 'ModeIndex_768x576' defined but not used [-Wunused-const-variable=]
      79 | static const unsigned short ModeIndex_768x576[]      = {0x5f, 0x60, 0x00, 0x61};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:78:29: warning: 'ModeIndex_720x576' defined but not used [-Wunused-const-variable=]
      78 | static const unsigned short ModeIndex_720x576[]      = {0x32, 0x34, 0x00, 0x36};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:77:29: warning: 'ModeIndex_720x480' defined but not used [-Wunused-const-variable=]
      77 | static const unsigned short ModeIndex_720x480[]      = {0x31, 0x33, 0x00, 0x35};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:76:29: warning: 'ModeIndex_640x480' defined but not used [-Wunused-const-variable=]
      76 | static const unsigned short ModeIndex_640x480[]      = {0x2e, 0x44, 0x00, 0x62};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:75:29: warning: 'ModeIndex_640x400' defined but not used [-Wunused-const-variable=]
      75 | static const unsigned short ModeIndex_640x400[]      = {0x2f, 0x5d, 0x00, 0x5e};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:74:29: warning: 'ModeIndex_512x384' defined but not used [-Wunused-const-variable=]
      74 | static const unsigned short ModeIndex_512x384[]      = {0x52, 0x58, 0x00, 0x5c};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:73:29: warning: 'ModeIndex_400x300' defined but not used [-Wunused-const-variable=]
      73 | static const unsigned short ModeIndex_400x300[]      = {0x51, 0x57, 0x00, 0x54};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:72:29: warning: 'ModeIndex_320x240_FSTN' defined but not used [-Wunused-const-variable=]
      72 | static const unsigned short ModeIndex_320x240_FSTN[] = {0x5a, 0x5b, 0x00, 0x00};  /* FSTN */
         |                             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:71:29: warning: 'ModeIndex_320x240' defined but not used [-Wunused-const-variable=]
      71 | static const unsigned short ModeIndex_320x240[]      = {0x50, 0x56, 0x00, 0x53};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:70:29: warning: 'ModeIndex_320x200' defined but not used [-Wunused-const-variable=]
      70 | static const unsigned short ModeIndex_320x200[]      = {0x59, 0x41, 0x00, 0x4f};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/scsi/aacraid/comminit.c:100:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] *host_rrq @@     got unsigned int [usertype] * @@
   drivers/scsi/aacraid/comminit.c:100:31: sparse:     expected restricted __le32 [usertype] *host_rrq
   drivers/scsi/aacraid/comminit.c:100:31: sparse:     got unsigned int [usertype] *
   drivers/scsi/aacraid/comminit.c:134:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] msix_id @@     got int [assigned] i @@
   drivers/scsi/aacraid/comminit.c:134:49: sparse:     expected restricted __le16 [usertype] msix_id
   drivers/scsi/aacraid/comminit.c:134:49: sparse:     got int [assigned] i
   drivers/scsi/aacraid/comminit.c:545:33: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/comminit.c:549:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/comminit.c:552:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/comminit.c:555:48: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/comminit.c:558:48: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/aacraid/comminit.c:561:48: sparse: sparse: restricted __le32 degrades to integer
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/cfbfillrect.c:359:32: sparse: sparse: cast to restricted __le32
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
>> arch/powerpc/platforms/44x/ppc476.c:237:17: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     expected void [noderef] __iomem *
   arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     got unsigned char [usertype] *
>> arch/powerpc/platforms/44x/ppc476.c:244:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *[assigned] fpga @@
>> arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     expected void volatile [noderef] __iomem *addr
   arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     got unsigned char [usertype] *[assigned] fpga
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
--
     845 |     int data, pagemiss, cas,width, video_enable, color_key_enable, bpp, align;
         |                         ^~~
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/sis/init.c: In function 'SiS_SetCRT1ModeRegs':
   drivers/video/fbdev/sis/init.c:2652:49: warning: variable 'resindex' set but not used [-Wunused-but-set-variable]
    2652 |    unsigned short data, infoflag = 0, modeflag, resindex;
         |                                                 ^~~~~~~~
   drivers/video/fbdev/sis/init.c: In function 'SiS_Generic_ConvertCRData':
   drivers/video/fbdev/sis/init.c:3545:19: warning: variable 'A' set but not used [-Wunused-but-set-variable]
    3545 |    int            A, B, C, D, E, F, temp;
         |                   ^
   drivers/video/fbdev/sis/init.c:3543:34: warning: variable 'VBS' set but not used [-Wunused-but-set-variable]
    3543 |    unsigned short VRE, VBE, VRS, VBS, VDE, VT;
         |                                  ^~~
   drivers/video/fbdev/sis/init.c:3542:34: warning: variable 'HBS' set but not used [-Wunused-but-set-variable]
    3542 |    unsigned short HRE, HBE, HRS, HBS, HDE, HT;
         |                                  ^~~
   drivers/scsi/aacraid/commsup.c:599:17: sparse: sparse: context imbalance in 'aac_fib_send' - different lock contexts for basic block
   drivers/scsi/aacraid/commsup.c:754:17: sparse: sparse: context imbalance in 'aac_hba_send' - different lock contexts for basic block
   drivers/scsi/aacraid/commsup.c:1497:32: sparse: sparse: context imbalance in '_aac_reset_adapter' - unexpected unlock
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/kernel/process.c: In function 'enable_kernel_fp':
   arch/powerpc/kernel/process.c:216:16: warning: variable 'cpumsr' set but not used [-Wunused-but-set-variable]
     216 |  unsigned long cpumsr;
         |                ^~~~~~
   drivers/usb/host/ehci-q.c:1389:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-q.c:1389:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-q.c:1389:27: sparse:     got int
   drivers/usb/host/ehci-mem.c:188:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] *periodic @@     got restricted __le32 [usertype] * @@
   drivers/usb/host/ehci-mem.c:188:24: sparse:     expected restricted __hc32 [usertype] *periodic
   drivers/usb/host/ehci-mem.c:188:24: sparse:     got restricted __le32 [usertype] *
   drivers/usb/host/ehci-hcd.c:566:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     got int
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted __hc32 [usertype] *ohci_hcctrl_reg @@     got void [noderef] __iomem * @@
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     expected restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     got void [noderef] __iomem *
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
>> drivers/usb/host/ehci.h:787:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:787:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:787:36: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:793:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:793:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:793:35: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci.h:794:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
   drivers/usb/host/ehci.h:794:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:794:29: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:787:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:787:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:787:36: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:793:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:793:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:793:35: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci.h:794:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
   drivers/usb/host/ehci.h:794:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:794:29: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: too many warnings
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/usb/host/pci-quirks.c:1145: warning: Function parameter or member 'pdev' not described in 'quirk_usb_handoff_xhci'
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse: sparse: invalid assignment: |=
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    left side has type unsigned int
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    right side has type restricted __le32
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
--
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lastp @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse:     expected unsigned int [usertype] lastp
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lastp @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse:     expected unsigned int [usertype] lastp
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4903:34: sparse: sparse: too many warnings
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
>> drivers/video/fbdev/chipsfb.c:334:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     expected void *p
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     got char [noderef] __iomem *screen_base
   drivers/usb/misc/adutux.c:117: warning: Function parameter or member 'dev' not described in 'adu_abort_transfers'
   drivers/usb/misc/adutux.c:653: warning: Function parameter or member 'interface' not described in 'adu_probe'
   drivers/usb/misc/adutux.c:653: warning: Function parameter or member 'id' not described in 'adu_probe'
   drivers/usb/misc/adutux.c:762: warning: Function parameter or member 'interface' not described in 'adu_disconnect'
   drivers/usb/typec/altmodes/displayport.c:18: warning: Function parameter or member '_dp' not described in 'DP_HEADER'
   drivers/usb/typec/altmodes/displayport.c:18: warning: Function parameter or member 'cmd' not described in 'DP_HEADER'
   drivers/scsi/sym53c8xx_2/sym_hipd.c: In function 'sym_complete_error':
   drivers/scsi/sym53c8xx_2/sym_hipd.c:5356:18: warning: variable 'lp' set but not used [-Wunused-but-set-variable]
    5356 |  struct sym_lcb *lp;
         |                  ^~
   drivers/video/fbdev/pm2fb.c:1514: warning: Function parameter or member 'pdev' not described in 'pm2fb_probe'
   drivers/video/fbdev/pm2fb.c:1514: warning: Function parameter or member 'id' not described in 'pm2fb_probe'
   drivers/video/fbdev/pm2fb.c:1720: warning: Function parameter or member 'pdev' not described in 'pm2fb_remove'
   drivers/video/fbdev/pm2fb.c:1764: warning: Function parameter or member 'options' not described in 'pm2fb_setup'
   drivers/scsi/sym53c8xx_2/sym_hipd.c: In function 'sym_complete_ok':
   drivers/scsi/sym53c8xx_2/sym_hipd.c:5485:18: warning: variable 'lp' set but not used [-Wunused-but-set-variable]
    5485 |  struct sym_lcb *lp;
         |                  ^~
   drivers/video/fbdev/tdfxfb.c: In function 'att_outb':
   drivers/video/fbdev/tdfxfb.c:209:16: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
     209 |  unsigned char tmp;
         |                ^~~
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
--
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/xmon/xmon.c: In function 'xmon_print_symbol':
   arch/powerpc/xmon/xmon.c:3631:14: warning: variable 'name' might be clobbered by 'longjmp' or 'vfork' [-Wclobbered]
    3631 |  const char *name = NULL;
         |              ^~~~
   arch/powerpc/mm/mem.c:521: warning: Function parameter or member 'p' not described in '__flush_dcache_icache'
   arch/powerpc/mm/mem.c:521: warning: Excess function parameter 'page' description in '__flush_dcache_icache'
   arch/powerpc/xmon/ppc-opc.c:797:15: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:797:18: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:801:15: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:801:18: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:805:14: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:805:17: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:809:16: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:809:19: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:863:15: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:863:18: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:868:15: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:868:18: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:872:15: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:872:18: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:875:15: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:875:18: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:878:15: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:878:18: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:881:14: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/xmon/ppc-opc.c:881:17: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/lib/sstep.c: In function 'mlsd_8lsd_ea':
   arch/powerpc/lib/sstep.c:224:3: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     224 |   ; /* Invalid form. Should already be checked for by caller! */
         |   ^
   arch/powerpc/lib/sstep.c: In function 'analyse_instr':
   arch/powerpc/lib/sstep.c:1214:21: warning: variable 'suffix' set but not used [-Wunused-but-set-variable]
    1214 |  unsigned int word, suffix;
         |                     ^~~~~~
   arch/powerpc/lib/sstep.c:1210:31: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
    1210 |  unsigned int opcode, ra, rb, rc, rd, spr, u;
         |                               ^~
   arch/powerpc/xmon/xmon.c: In function 'show_tasks':
   arch/powerpc/xmon/xmon.c:3308:22: warning: variable 'tsk' might be clobbered by 'longjmp' or 'vfork' [-Wclobbered]
    3308 |  struct task_struct *tsk = NULL;
         |                      ^~~
   arch/powerpc/platforms/44x/idle.c:30:12: sparse: sparse: symbol 'ppc44x_idle_init' was not declared. Should it be static?
   arch/powerpc/platforms/44x/idle.c:30:12: warning: no previous prototype for 'ppc44x_idle_init' [-Wmissing-prototypes]
      30 | int __init ppc44x_idle_init(void)
         |            ^~~~~~~~~~~~~~~~
   arch/powerpc/sysdev/of_rtc.c:21:13: warning: no previous prototype for 'of_instantiate_rtc' [-Wmissing-prototypes]
      21 | void __init of_instantiate_rtc(void)
         |             ^~~~~~~~~~~~~~~~~~
   arch/powerpc/mm/init_32.c:66:5: sparse: sparse: symbol 'boot_mapsize' was not declared. Should it be static?
   arch/powerpc/platforms/44x/warp.c:284:22: sparse: sparse: incorrect type in argument 1 (incompatible argument 1 (different address spaces)) @@     expected int ( *threadfn )( ... ) @@     got int ( * )( ... ) @@
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     expected int ( *threadfn )( ... )
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     got int ( * )( ... )
>> arch/powerpc/platforms/44x/warp.c:284:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *static [assigned] [toplevel] dtm_fpga @@
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     expected void *data
>> arch/powerpc/platforms/44x/warp.c:284:22: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] dtm_fpga
   arch/powerpc/platforms/4xx/msi.c:109:6: sparse: sparse: symbol 'ppc4xx_teardown_msi_irqs' was not declared. Should it be static?
   arch/powerpc/platforms/44x/warp.c:104:5: warning: no previous prototype for 'pika_dtm_register_shutdown' [-Wmissing-prototypes]
     104 | int pika_dtm_register_shutdown(void (*func)(void *arg), void *arg)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/44x/warp.c:120:5: warning: no previous prototype for 'pika_dtm_unregister_shutdown' [-Wmissing-prototypes]
     120 | int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/4xx/msi.c:109:6: warning: no previous prototype for 'ppc4xx_teardown_msi_irqs' [-Wmissing-prototypes]
     109 | void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/mm/pgtable_32.c:87:19: sparse: sparse: Using plain integer as NULL pointer
>> arch/powerpc/platforms/44x/ppc476.c:237:17: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     expected void [noderef] __iomem *
   arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     got unsigned char [usertype] *
>> arch/powerpc/platforms/44x/ppc476.c:244:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *[assigned] fpga @@
>> arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     expected void volatile [noderef] __iomem *addr
   arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     got unsigned char [usertype] *[assigned] fpga
   arch/powerpc/kernel/process.c: In function 'enable_kernel_fp':
   arch/powerpc/kernel/process.c:216:16: warning: variable 'cpumsr' set but not used [-Wunused-but-set-variable]
     216 |  unsigned long cpumsr;
         |                ^~~~~~
   arch/powerpc/mm/ioremap_32.c:90:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   arch/powerpc/mm/ioremap_32.c:90:18: sparse:    void volatile [noderef] __iomem *
   arch/powerpc/mm/ioremap_32.c:90:18: sparse:    void *
   arch/powerpc/kernel/time.c:134:1: sparse: sparse: symbol 'rtc_lock' was not declared. Should it be static?
   arch/powerpc/mm/drmem.c:74:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   arch/powerpc/mm/drmem.c:74:14: sparse:     expected unsigned int [usertype]
   arch/powerpc/mm/drmem.c:74:14: sparse:     got restricted __be32 [usertype]
   arch/powerpc/mm/drmem.c:94:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] base_addr @@     got restricted __be64 [usertype] @@
   arch/powerpc/mm/drmem.c:94:28: sparse:     expected unsigned long long [usertype] base_addr
   arch/powerpc/mm/drmem.c:94:28: sparse:     got restricted __be64 [usertype]
   arch/powerpc/mm/drmem.c:95:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] drc_index @@     got restricted __be32 [usertype] @@
   arch/powerpc/mm/drmem.c:95:28: sparse:     expected unsigned int [usertype] drc_index
   arch/powerpc/mm/drmem.c:95:28: sparse:     got restricted __be32 [usertype]
   arch/powerpc/mm/drmem.c:96:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] aa_index @@     got restricted __be32 [usertype] @@
   arch/powerpc/mm/drmem.c:96:27: sparse:     expected unsigned int [usertype] aa_index
   arch/powerpc/mm/drmem.c:96:27: sparse:     got restricted __be32 [usertype]
   arch/powerpc/mm/drmem.c:97:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __be32 [usertype] @@
   arch/powerpc/mm/drmem.c:97:24: sparse:     expected unsigned int [usertype] flags
   arch/powerpc/mm/drmem.c:97:24: sparse:     got restricted __be32 [usertype]
   arch/powerpc/mm/drmem.c:132:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   arch/powerpc/mm/drmem.c:132:14: sparse:     expected unsigned int [usertype]
   arch/powerpc/mm/drmem.c:132:14: sparse:     got restricted __be32 [usertype]
   arch/powerpc/mm/drmem.c:151:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] seq_lmbs @@     got restricted __be32 [usertype] @@
   arch/powerpc/mm/drmem.c:151:43: sparse:     expected unsigned int [usertype] seq_lmbs
   arch/powerpc/mm/drmem.c:151:43: sparse:     got restricted __be32 [usertype]
   arch/powerpc/mm/drmem.c:164:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] seq_lmbs @@     got restricted __be32 [usertype] @@
   arch/powerpc/mm/drmem.c:164:27: sparse:     expected unsigned int [usertype] seq_lmbs
   arch/powerpc/mm/drmem.c:164:27: sparse:     got restricted __be32 [usertype]
   arch/powerpc/kernel/traps.c:158:13: sparse: sparse: function 'panic_flush_kmsg_start' with external linkage has definition
   arch/powerpc/kernel/traps.c:171:13: sparse: sparse: function 'panic_flush_kmsg_end' with external linkage has definition
   arch/powerpc/kernel/traps.c:1663:6: warning: no previous prototype for 'stack_overflow_exception' [-Wmissing-prototypes]
    1663 | void stack_overflow_exception(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/traps.c:1993:6: warning: no previous prototype for 'DebugException' [-Wmissing-prototypes]
    1993 | void DebugException(struct pt_regs *regs, unsigned long debug_status)
         |      ^~~~~~~~~~~~~~
   arch/powerpc/kernel/traps.c:2227:29: warning: no previous prototype for 'WatchdogHandler' [-Wmissing-prototypes]
    2227 | void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
         |                             ^~~~~~~~~~~~~~~
   arch/powerpc/kernel/io.c:36:24: sparse: sparse: dereference of noderef expression
   arch/powerpc/kernel/io.c:52:18: sparse: sparse: dereference of noderef expression
   arch/powerpc/kernel/io.c:67:24: sparse: sparse: dereference of noderef expression
   arch/powerpc/kernel/io.c:83:18: sparse: sparse: dereference of noderef expression
   arch/powerpc/kernel/io.c:98:24: sparse: sparse: dereference of noderef expression
   arch/powerpc/kernel/io.c:114:18: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/kernel/kvm.c:635:9: sparse: sparse: switch with no cases
   arch/powerpc/kernel/kvm.c:672:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const [noderef] __user *uaddr @@     got char const * @@
   arch/powerpc/kernel/kvm.c:672:39: sparse:     expected char const [noderef] __user *uaddr
   arch/powerpc/kernel/kvm.c:672:39: sparse:     got char const *
   arch/powerpc/kernel/epapr_paravirt.c:40:40: sparse: sparse: cast to restricted __be32
   arch/powerpc/kernel/pci_of_scan.c:23: warning: Function parameter or member 'np' not described in 'get_int_prop'
   arch/powerpc/kernel/pci_of_scan.c:23: warning: Function parameter or member 'name' not described in 'get_int_prop'
   arch/powerpc/kernel/pci_of_scan.c:23: warning: Function parameter or member 'def' not described in 'get_int_prop'
   arch/powerpc/kernel/pci_of_scan.c:61: warning: Function parameter or member 'ss' not described in 'OF_PCI_ADDR0_SPACE'
   arch/powerpc/kernel/pci_of_scan.c:61: warning: Excess function parameter 'addr0' description in 'OF_PCI_ADDR0_SPACE'
   arch/powerpc/kernel/pci_of_scan.c:61: warning: Excess function parameter 'bridge' description in 'OF_PCI_ADDR0_SPACE'
--
   drivers/video/fbdev/riva/riva_hw.c:845:50: warning: variable 'color_key_enable' set but not used [-Wunused-but-set-variable]
     845 |     int data, pagemiss, cas,width, video_enable, color_key_enable, bpp, align;
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/video/fbdev/riva/riva_hw.c:845:25: warning: variable 'cas' set but not used [-Wunused-but-set-variable]
     845 |     int data, pagemiss, cas,width, video_enable, color_key_enable, bpp, align;
         |                         ^~~
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/sis/init.c: In function 'SiS_SetCRT1ModeRegs':
   drivers/video/fbdev/sis/init.c:2652:49: warning: variable 'resindex' set but not used [-Wunused-but-set-variable]
    2652 |    unsigned short data, infoflag = 0, modeflag, resindex;
         |                                                 ^~~~~~~~
   drivers/video/fbdev/sis/init.c: In function 'SiS_Generic_ConvertCRData':
   drivers/video/fbdev/sis/init.c:3545:19: warning: variable 'A' set but not used [-Wunused-but-set-variable]
    3545 |    int            A, B, C, D, E, F, temp;
         |                   ^
   drivers/video/fbdev/sis/init.c:3543:34: warning: variable 'VBS' set but not used [-Wunused-but-set-variable]
    3543 |    unsigned short VRE, VBE, VRS, VBS, VDE, VT;
         |                                  ^~~
   drivers/video/fbdev/sis/init.c:3542:34: warning: variable 'HBS' set but not used [-Wunused-but-set-variable]
    3542 |    unsigned short HRE, HBE, HRS, HBS, HDE, HT;
         |                                  ^~~
   drivers/scsi/aacraid/commsup.c:599:17: sparse: sparse: context imbalance in 'aac_fib_send' - different lock contexts for basic block
   drivers/scsi/aacraid/commsup.c:754:17: sparse: sparse: context imbalance in 'aac_hba_send' - different lock contexts for basic block
   drivers/scsi/aacraid/commsup.c:1497:32: sparse: sparse: context imbalance in '_aac_reset_adapter' - unexpected unlock
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   drivers/usb/host/ehci-q.c:1389:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-q.c:1389:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-q.c:1389:27: sparse:     got int
   drivers/usb/host/ehci-mem.c:188:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] *periodic @@     got restricted __le32 [usertype] * @@
   drivers/usb/host/ehci-mem.c:188:24: sparse:     expected restricted __hc32 [usertype] *periodic
   drivers/usb/host/ehci-mem.c:188:24: sparse:     got restricted __le32 [usertype] *
   drivers/usb/host/ehci-hcd.c:566:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     got int
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted __hc32 [usertype] *ohci_hcctrl_reg @@     got void [noderef] __iomem * @@
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     expected restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     got void [noderef] __iomem *
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
>> drivers/usb/host/ehci.h:787:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:787:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:787:36: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:793:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:793:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:793:35: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci.h:794:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
   drivers/usb/host/ehci.h:794:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:794:29: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:787:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:787:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:787:36: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:793:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:793:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:793:35: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci.h:794:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
   drivers/usb/host/ehci.h:794:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:794:29: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: too many warnings
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long word @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     expected unsigned long word
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/core/sysfillrect.c:323:32: sparse: sparse: cast to restricted __le32
   drivers/usb/host/pci-quirks.c:1145: warning: Function parameter or member 'pdev' not described in 'quirk_usb_handoff_xhci'
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse: sparse: invalid assignment: |=
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    left side has type unsigned int
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    right side has type restricted __le32
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
--
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2640:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lastp @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse:     expected unsigned int [usertype] lastp
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lastp @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse:     expected unsigned int [usertype] lastp
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2650:9: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4594:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4903:34: sparse: sparse: too many warnings
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
>> drivers/video/fbdev/chipsfb.c:334:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     expected void *p
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     got char [noderef] __iomem *screen_base
   drivers/usb/misc/adutux.c:117: warning: Function parameter or member 'dev' not described in 'adu_abort_transfers'
   drivers/usb/misc/adutux.c:653: warning: Function parameter or member 'interface' not described in 'adu_probe'
   drivers/usb/misc/adutux.c:653: warning: Function parameter or member 'id' not described in 'adu_probe'
   drivers/usb/misc/adutux.c:762: warning: Function parameter or member 'interface' not described in 'adu_disconnect'
   drivers/usb/typec/altmodes/displayport.c:18: warning: Function parameter or member '_dp' not described in 'DP_HEADER'
   drivers/usb/typec/altmodes/displayport.c:18: warning: Function parameter or member 'cmd' not described in 'DP_HEADER'
   drivers/scsi/sym53c8xx_2/sym_hipd.c: In function 'sym_complete_error':
   drivers/scsi/sym53c8xx_2/sym_hipd.c:5356:18: warning: variable 'lp' set but not used [-Wunused-but-set-variable]
    5356 |  struct sym_lcb *lp;
         |                  ^~
   drivers/video/fbdev/pm2fb.c:1514: warning: Function parameter or member 'pdev' not described in 'pm2fb_probe'
   drivers/video/fbdev/pm2fb.c:1514: warning: Function parameter or member 'id' not described in 'pm2fb_probe'
   drivers/video/fbdev/pm2fb.c:1720: warning: Function parameter or member 'pdev' not described in 'pm2fb_remove'
   drivers/video/fbdev/pm2fb.c:1764: warning: Function parameter or member 'options' not described in 'pm2fb_setup'
   drivers/scsi/sym53c8xx_2/sym_hipd.c: In function 'sym_complete_ok':
   drivers/scsi/sym53c8xx_2/sym_hipd.c:5485:18: warning: variable 'lp' set but not used [-Wunused-but-set-variable]
    5485 |  struct sym_lcb *lp;
         |                  ^~
   drivers/video/fbdev/tdfxfb.c: In function 'att_outb':
   drivers/video/fbdev/tdfxfb.c:209:16: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
     209 |  unsigned char tmp;
         |                ^~~
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
--
   arch/powerpc/platforms/4xx/pci.c:1636:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/pci.c:1636:33: sparse:     got unsigned int [usertype] *
   arch/powerpc/platforms/4xx/pci.c:1687:24: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/4xx/pci.c:1687:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char volatile [noderef] [usertype] __iomem *addr @@     got unsigned char [usertype] * @@
   arch/powerpc/platforms/4xx/pci.c:1687:24: sparse:     expected unsigned char volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/pci.c:1687:24: sparse:     got unsigned char [usertype] *
   arch/powerpc/platforms/4xx/pci.c:1690:27: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/4xx/pci.c:1690:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
   arch/powerpc/platforms/4xx/pci.c:1690:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/pci.c:1690:27: sparse:     got unsigned short [usertype] *
   arch/powerpc/platforms/4xx/pci.c:1693:27: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/4xx/pci.c:1693:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/powerpc/platforms/4xx/pci.c:1693:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/pci.c:1693:27: sparse:     got unsigned int [usertype] *
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/44x/idle.c:30:12: sparse: sparse: symbol 'ppc44x_idle_init' was not declared. Should it be static?
   arch/powerpc/platforms/44x/idle.c:30:12: warning: no previous prototype for 'ppc44x_idle_init' [-Wmissing-prototypes]
      30 | int __init ppc44x_idle_init(void)
         |            ^~~~~~~~~~~~~~~~
   arch/powerpc/platforms/44x/warp.c:284:22: sparse: sparse: incorrect type in argument 1 (incompatible argument 1 (different address spaces)) @@     expected int ( *threadfn )( ... ) @@     got int ( * )( ... ) @@
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     expected int ( *threadfn )( ... )
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     got int ( * )( ... )
>> arch/powerpc/platforms/44x/warp.c:284:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *static [assigned] [toplevel] dtm_fpga @@
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     expected void *data
>> arch/powerpc/platforms/44x/warp.c:284:22: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] dtm_fpga
   arch/powerpc/platforms/4xx/msi.c:109:6: sparse: sparse: symbol 'ppc4xx_teardown_msi_irqs' was not declared. Should it be static?
   arch/powerpc/platforms/44x/warp.c:104:5: warning: no previous prototype for 'pika_dtm_register_shutdown' [-Wmissing-prototypes]
     104 | int pika_dtm_register_shutdown(void (*func)(void *arg), void *arg)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/44x/warp.c:120:5: warning: no previous prototype for 'pika_dtm_unregister_shutdown' [-Wmissing-prototypes]
     120 | int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/4xx/msi.c:109:6: warning: no previous prototype for 'ppc4xx_teardown_msi_irqs' [-Wmissing-prototypes]
     109 | void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/platforms/44x/ppc476.c:237:17: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     expected void [noderef] __iomem *
   arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     got unsigned char [usertype] *
>> arch/powerpc/platforms/44x/ppc476.c:244:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *[assigned] fpga @@
>> arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     expected void volatile [noderef] __iomem *addr
   arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     got unsigned char [usertype] *[assigned] fpga
--
   drivers/usb/isp1760/isp1760-hcd.c:1145:38: sparse: sparse: restricted __dw degrades to integer
   drivers/usb/isp1760/isp1760-hcd.c:1146:36: sparse: sparse: restricted __dw degrades to integer
   drivers/usb/isp1760/isp1760-hcd.c:1151:33: sparse: sparse: invalid assignment: |=
   drivers/usb/isp1760/isp1760-hcd.c:1151:33: sparse:    left side has type restricted __dw
   drivers/usb/isp1760/isp1760-hcd.c:1151:33: sparse:    right side has type int
   drivers/usb/isp1760/isp1760-hcd.c:1153:33: sparse: sparse: invalid assignment: &=
   drivers/usb/isp1760/isp1760-hcd.c:1153:33: sparse:    left side has type restricted __dw
   drivers/usb/isp1760/isp1760-hcd.c:1153:33: sparse:    right side has type int
   drivers/usb/isp1760/isp1760-hcd.c:1154:36: sparse: sparse: restricted __dw degrades to integer
   drivers/usb/isp1760/isp1760-hcd.c:1154:33: sparse: sparse: invalid assignment: |=
   drivers/usb/isp1760/isp1760-hcd.c:1154:33: sparse:    left side has type restricted __dw
   drivers/usb/isp1760/isp1760-hcd.c:1154:33: sparse:    right side has type unsigned int
   drivers/usb/isp1760/isp1760-hcd.c:1155:33: sparse: sparse: invalid assignment: &=
   drivers/usb/isp1760/isp1760-hcd.c:1155:33: sparse:    left side has type restricted __dw
   drivers/usb/isp1760/isp1760-hcd.c:1155:33: sparse:    right side has type int
   drivers/usb/isp1760/isp1760-hcd.c:1156:33: sparse: sparse: invalid assignment: |=
   drivers/usb/isp1760/isp1760-hcd.c:1156:33: sparse:    left side has type restricted __dw
   drivers/usb/isp1760/isp1760-hcd.c:1156:33: sparse:    right side has type int
   drivers/usb/isp1760/isp1760-hcd.c:1157:38: sparse: sparse: restricted __dw degrades to integer
   drivers/usb/isp1760/isp1760-hcd.c:1158:36: sparse: sparse: restricted __dw degrades to integer
   drivers/usb/isp1760/isp1760-hcd.c:1277:30: sparse: sparse: restricted __dw degrades to integer
   drivers/usb/isp1760/isp1760-hcd.c:1278:42: sparse: sparse: restricted __dw degrades to integer
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   drivers/usb/host/ehci-q.c:1389:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-q.c:1389:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-q.c:1389:27: sparse:     got int
   drivers/usb/host/ehci-mem.c:188:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] *periodic @@     got restricted __le32 [usertype] * @@
   drivers/usb/host/ehci-mem.c:188:24: sparse:     expected restricted __hc32 [usertype] *periodic
   drivers/usb/host/ehci-mem.c:188:24: sparse:     got restricted __le32 [usertype] *
   drivers/usb/host/ehci-hcd.c:566:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     got int
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted __hc32 [usertype] *ohci_hcctrl_reg @@     got void [noderef] __iomem * @@
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     expected restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     got void [noderef] __iomem *
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
>> drivers/usb/host/ehci.h:787:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:787:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:787:36: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:793:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:793:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:793:35: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci.h:794:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
   drivers/usb/host/ehci.h:794:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:794:29: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:787:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:787:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:787:36: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:793:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:793:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:793:35: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci.h:794:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
   drivers/usb/host/ehci.h:794:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:794:29: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: too many warnings
   drivers/usb/host/pci-quirks.c:1145: warning: Function parameter or member 'pdev' not described in 'quirk_usb_handoff_xhci'
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   drivers/usb/c67x00/c67x00-ll-hpi.c:269: warning: Function parameter or member 'sie' not described in 'c67x00_ll_usb_clear_status'
   drivers/usb/c67x00/c67x00-ll-hpi.c:269: warning: Function parameter or member 'bits' not described in 'c67x00_ll_usb_clear_status'
   drivers/usb/c67x00/c67x00-ll-hpi.c:404: warning: Function parameter or member 'dev' not described in 'c67x00_ll_write_mem_le16'
   drivers/usb/c67x00/c67x00-ll-hpi.c:404: warning: Function parameter or member 'addr' not described in 'c67x00_ll_write_mem_le16'
   drivers/usb/c67x00/c67x00-ll-hpi.c:404: warning: Function parameter or member 'data' not described in 'c67x00_ll_write_mem_le16'
   drivers/usb/c67x00/c67x00-ll-hpi.c:404: warning: Function parameter or member 'len' not described in 'c67x00_ll_write_mem_le16'
   drivers/usb/c67x00/c67x00-ll-hpi.c:443: warning: Function parameter or member 'dev' not described in 'c67x00_ll_read_mem_le16'
   drivers/usb/c67x00/c67x00-ll-hpi.c:443: warning: Function parameter or member 'addr' not described in 'c67x00_ll_read_mem_le16'
   drivers/usb/c67x00/c67x00-ll-hpi.c:443: warning: Function parameter or member 'data' not described in 'c67x00_ll_read_mem_le16'
   drivers/usb/c67x00/c67x00-ll-hpi.c:443: warning: Function parameter or member 'len' not described in 'c67x00_ll_read_mem_le16'
   drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'sie' not described in 'c67x00_hcd_irq'
   drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'int_status' not described in 'c67x00_hcd_irq'
   drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'msg' not described in 'c67x00_hcd_irq'
   drivers/usb/c67x00/c67x00-hcd.c:267: warning: Function parameter or member 'hcd' not described in 'c67x00_hcd_start'
   drivers/usb/c67x00/c67x00-hcd.c:279: warning: Function parameter or member 'hcd' not described in 'c67x00_hcd_stop'
   drivers/usb/c67x00/c67x00-sched.c:35: warning: Function parameter or member 'queue' not described in 'c67x00_ep_data'
   drivers/usb/c67x00/c67x00-sched.c:35: warning: Function parameter or member 'node' not described in 'c67x00_ep_data'
   drivers/usb/c67x00/c67x00-sched.c:35: warning: Function parameter or member 'hep' not described in 'c67x00_ep_data'
   drivers/usb/c67x00/c67x00-sched.c:35: warning: Function parameter or member 'dev' not described in 'c67x00_ep_data'
   drivers/usb/c67x00/c67x00-sched.c:35: warning: Function parameter or member 'next_frame' not described in 'c67x00_ep_data'
   drivers/usb/c67x00/c67x00-sched.c:71: warning: Function parameter or member 'ly_base_addr' not described in 'c67x00_td'
   drivers/usb/c67x00/c67x00-sched.c:71: warning: Function parameter or member 'port_length' not described in 'c67x00_td'
   drivers/usb/c67x00/c67x00-sched.c:71: warning: Function parameter or member 'pid_ep' not described in 'c67x00_td'
   drivers/usb/c67x00/c67x00-sched.c:71: warning: Function parameter or member 'dev_addr' not described in 'c67x00_td'
   drivers/usb/c67x00/c67x00-sched.c:71: warning: Function parameter or member 'ctrl_reg' not described in 'c67x00_td'
   drivers/usb/c67x00/c67x00-sched.c:71: warning: Function parameter or member 'status' not described in 'c67x00_td'
   drivers/usb/c67x00/c67x00-sched.c:71: warning: Function parameter or member 'retry_cnt' not described in 'c67x00_td'
   drivers/usb/c67x00/c67x00-sched.c:71: warning: Function parameter or member 'residue' not described in 'c67x00_td'
   drivers/usb/c67x00/c67x00-sched.c:71: warning: Function parameter or member 'next_td_addr' not described in 'c67x00_td'
   drivers/usb/c67x00/c67x00-sched.c:71: warning: Function parameter or member 'td_list' not described in 'c67x00_td'
   drivers/usb/c67x00/c67x00-sched.c:71: warning: Function parameter or member 'td_addr' not described in 'c67x00_td'
--
      70 | static const unsigned short ModeIndex_320x200[]      = {0x59, 0x41, 0x00, 0x4f};
         |                             ^~~~~~~~~~~~~~~~~
   In file included from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/rcupdate.h:31,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/hdmi.h:28,
                    from drivers/video/hdmi.c:28:
   In function 'strncpy',
       inlined from 'hdmi_spd_infoframe_init' at drivers/video/hdmi.c:230:2:
   include/linux/string.h:297:30: warning: '__builtin_strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
     297 | #define __underlying_strncpy __builtin_strncpy
         |                              ^
   include/linux/string.h:307:9: note: in expansion of macro '__underlying_strncpy'
     307 |  return __underlying_strncpy(p, q, size);
         |         ^~~~~~~~~~~~~~~~~~~~
   In function 'strncpy',
       inlined from 'hdmi_spd_infoframe_init' at drivers/video/hdmi.c:231:2:
   include/linux/string.h:297:30: warning: '__builtin_strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
     297 | #define __underlying_strncpy __builtin_strncpy
         |                              ^
   include/linux/string.h:307:9: note: in expansion of macro '__underlying_strncpy'
     307 |  return __underlying_strncpy(p, q, size);
         |         ^~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
>> drivers/video/fbdev/chipsfb.c:334:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     expected void *p
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/pm2fb.c:1514: warning: Function parameter or member 'pdev' not described in 'pm2fb_probe'
   drivers/video/fbdev/pm2fb.c:1514: warning: Function parameter or member 'id' not described in 'pm2fb_probe'
   drivers/video/fbdev/pm2fb.c:1720: warning: Function parameter or member 'pdev' not described in 'pm2fb_remove'
   drivers/video/fbdev/pm2fb.c:1764: warning: Function parameter or member 'options' not described in 'pm2fb_setup'
   drivers/video/fbdev/tdfxfb.c: In function 'att_outb':
   drivers/video/fbdev/tdfxfb.c:209:16: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
     209 |  unsigned char tmp;
         |                ^~~
   drivers/video/fbdev/cirrusfb.c:1851:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/cirrusfb.c:1851:28: sparse:     expected void *p
   drivers/video/fbdev/cirrusfb.c:1851:28: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/cirrusfb.c: In function 'WHDR':
   drivers/video/fbdev/cirrusfb.c:2465:16: warning: variable 'dummy' set but not used [-Wunused-but-set-variable]
    2465 |  unsigned char dummy;
         |                ^~~~~
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/udlfb.c:1008:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/udlfb.c:1008:19: sparse:     expected void const *addr
   drivers/video/fbdev/udlfb.c:1008:19: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/udlfb.c:1121:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/smscufx.c:821:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/smscufx.c:821:27: sparse:     expected unsigned int [usertype]
   drivers/video/fbdev/smscufx.c:821:27: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/smscufx.c:824:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/smscufx.c:824:27: sparse:     expected unsigned int [usertype]
   drivers/video/fbdev/smscufx.c:824:27: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/smscufx.c:826:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:826:16: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:826:16: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:827:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:827:16: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:827:16: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:828:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:828:16: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:828:16: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:829:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:829:16: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:829:16: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:832:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/smscufx.c:832:27: sparse:     expected unsigned int [usertype]
   drivers/video/fbdev/smscufx.c:832:27: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/smscufx.c:835:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:835:17: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:835:17: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:838:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:838:17: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:838:17: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:1141:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/smscufx.c:1141:19: sparse:     expected void const *addr
   drivers/video/fbdev/smscufx.c:1141:19: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/smscufx.c:1249:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/smscufx.c:1294:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *old_fb @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/smscufx.c:1294:37: sparse:     expected unsigned char *old_fb
   drivers/video/fbdev/smscufx.c:1294:37: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/smscufx.c:1311:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/smscufx.c:1311:35: sparse:     expected void const *addr
   drivers/video/fbdev/smscufx.c:1311:35: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/smscufx.c:1314:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got unsigned char *[assigned] new_fb @@
--
   arch/powerpc/platforms/44x/idle.c:30:12: sparse: sparse: symbol 'ppc44x_idle_init' was not declared. Should it be static?
   arch/powerpc/platforms/44x/idle.c:30:12: warning: no previous prototype for 'ppc44x_idle_init' [-Wmissing-prototypes]
      30 | int __init ppc44x_idle_init(void)
         |            ^~~~~~~~~~~~~~~~
   arch/powerpc/platforms/44x/warp.c:284:22: sparse: sparse: incorrect type in argument 1 (incompatible argument 1 (different address spaces)) @@     expected int ( *threadfn )( ... ) @@     got int ( * )( ... ) @@
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     expected int ( *threadfn )( ... )
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     got int ( * )( ... )
>> arch/powerpc/platforms/44x/warp.c:284:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *static [assigned] [toplevel] dtm_fpga @@
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     expected void *data
>> arch/powerpc/platforms/44x/warp.c:284:22: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] dtm_fpga
   arch/powerpc/platforms/44x/warp.c:104:5: warning: no previous prototype for 'pika_dtm_register_shutdown' [-Wmissing-prototypes]
     104 | int pika_dtm_register_shutdown(void (*func)(void *arg), void *arg)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/44x/warp.c:120:5: warning: no previous prototype for 'pika_dtm_unregister_shutdown' [-Wmissing-prototypes]
     120 | int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/platforms/44x/ppc476.c:237:17: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     expected void [noderef] __iomem *
   arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     got unsigned char [usertype] *
>> arch/powerpc/platforms/44x/ppc476.c:244:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *[assigned] fpga @@
>> arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     expected void volatile [noderef] __iomem *addr
   arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     got unsigned char [usertype] *[assigned] fpga
--
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   drivers/usb/host/ehci-q.c:1389:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-q.c:1389:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-q.c:1389:27: sparse:     got int
   drivers/usb/host/ehci-mem.c:188:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] *periodic @@     got restricted __le32 [usertype] * @@
   drivers/usb/host/ehci-mem.c:188:24: sparse:     expected restricted __hc32 [usertype] *periodic
   drivers/usb/host/ehci-mem.c:188:24: sparse:     got restricted __le32 [usertype] *
   drivers/usb/host/ehci-hcd.c:566:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     got int
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted __hc32 [usertype] *ohci_hcctrl_reg @@     got void [noderef] __iomem * @@
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     expected restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     got void [noderef] __iomem *
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
>> drivers/usb/host/ehci.h:787:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:787:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:787:36: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:793:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:793:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:793:35: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci.h:794:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
   drivers/usb/host/ehci.h:794:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:794:29: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:787:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:787:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:787:36: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:793:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:793:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:793:35: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci.h:794:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
   drivers/usb/host/ehci.h:794:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:794:29: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: too many warnings
   drivers/usb/host/pci-quirks.c:1145: warning: Function parameter or member 'pdev' not described in 'quirk_usb_handoff_xhci'
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   drivers/usb/host/ehci-platform.c:478:36: warning: 'ehci_acpi_match' defined but not used [-Wunused-const-variable=]
     478 | static const struct acpi_device_id ehci_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
--
      79 | static const unsigned short ModeIndex_768x576[]      = {0x5f, 0x60, 0x00, 0x61};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:78:29: warning: 'ModeIndex_720x576' defined but not used [-Wunused-const-variable=]
      78 | static const unsigned short ModeIndex_720x576[]      = {0x32, 0x34, 0x00, 0x36};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:77:29: warning: 'ModeIndex_720x480' defined but not used [-Wunused-const-variable=]
      77 | static const unsigned short ModeIndex_720x480[]      = {0x31, 0x33, 0x00, 0x35};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:76:29: warning: 'ModeIndex_640x480' defined but not used [-Wunused-const-variable=]
      76 | static const unsigned short ModeIndex_640x480[]      = {0x2e, 0x44, 0x00, 0x62};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:75:29: warning: 'ModeIndex_640x400' defined but not used [-Wunused-const-variable=]
      75 | static const unsigned short ModeIndex_640x400[]      = {0x2f, 0x5d, 0x00, 0x5e};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:74:29: warning: 'ModeIndex_512x384' defined but not used [-Wunused-const-variable=]
      74 | static const unsigned short ModeIndex_512x384[]      = {0x52, 0x58, 0x00, 0x5c};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:73:29: warning: 'ModeIndex_400x300' defined but not used [-Wunused-const-variable=]
      73 | static const unsigned short ModeIndex_400x300[]      = {0x51, 0x57, 0x00, 0x54};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:72:29: warning: 'ModeIndex_320x240_FSTN' defined but not used [-Wunused-const-variable=]
      72 | static const unsigned short ModeIndex_320x240_FSTN[] = {0x5a, 0x5b, 0x00, 0x00};  /* FSTN */
         |                             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:71:29: warning: 'ModeIndex_320x240' defined but not used [-Wunused-const-variable=]
      71 | static const unsigned short ModeIndex_320x240[]      = {0x50, 0x56, 0x00, 0x53};
         |                             ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/sis/init.h:70:29: warning: 'ModeIndex_320x200' defined but not used [-Wunused-const-variable=]
      70 | static const unsigned short ModeIndex_320x200[]      = {0x59, 0x41, 0x00, 0x4f};
         |                             ^~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
>> drivers/video/fbdev/chipsfb.c:334:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     expected void *p
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/pm2fb.c:1514: warning: Function parameter or member 'pdev' not described in 'pm2fb_probe'
   drivers/video/fbdev/pm2fb.c:1514: warning: Function parameter or member 'id' not described in 'pm2fb_probe'
   drivers/video/fbdev/pm2fb.c:1720: warning: Function parameter or member 'pdev' not described in 'pm2fb_remove'
   drivers/video/fbdev/pm2fb.c:1764: warning: Function parameter or member 'options' not described in 'pm2fb_setup'
   drivers/video/fbdev/tdfxfb.c: In function 'att_outb':
   drivers/video/fbdev/tdfxfb.c:209:16: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
     209 |  unsigned char tmp;
         |                ^~~
   drivers/video/fbdev/cirrusfb.c:1851:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/cirrusfb.c:1851:28: sparse:     expected void *p
   drivers/video/fbdev/cirrusfb.c:1851:28: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/cirrusfb.c: In function 'WHDR':
   drivers/video/fbdev/cirrusfb.c:2465:16: warning: variable 'dummy' set but not used [-Wunused-but-set-variable]
    2465 |  unsigned char dummy;
         |                ^~~~~
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/udlfb.c:1008:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/udlfb.c:1008:19: sparse:     expected void const *addr
   drivers/video/fbdev/udlfb.c:1008:19: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/udlfb.c:1121:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/smscufx.c:821:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/smscufx.c:821:27: sparse:     expected unsigned int [usertype]
   drivers/video/fbdev/smscufx.c:821:27: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/smscufx.c:824:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/smscufx.c:824:27: sparse:     expected unsigned int [usertype]
   drivers/video/fbdev/smscufx.c:824:27: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/smscufx.c:826:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:826:16: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:826:16: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:827:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:827:16: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:827:16: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:828:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:828:16: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:828:16: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:829:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:829:16: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:829:16: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:832:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/smscufx.c:832:27: sparse:     expected unsigned int [usertype]
   drivers/video/fbdev/smscufx.c:832:27: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/smscufx.c:835:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:835:17: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:835:17: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:838:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/video/fbdev/smscufx.c:838:17: sparse:     expected unsigned short [usertype]
   drivers/video/fbdev/smscufx.c:838:17: sparse:     got restricted __le16 [usertype]
   drivers/video/fbdev/smscufx.c:1141:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/smscufx.c:1141:19: sparse:     expected void const *addr
   drivers/video/fbdev/smscufx.c:1141:19: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/smscufx.c:1249:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/smscufx.c:1294:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *old_fb @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/smscufx.c:1294:37: sparse:     expected unsigned char *old_fb
   drivers/video/fbdev/smscufx.c:1294:37: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/smscufx.c:1311:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/smscufx.c:1311:35: sparse:     expected void const *addr
   drivers/video/fbdev/smscufx.c:1311:35: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/smscufx.c:1314:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got unsigned char *[assigned] new_fb @@
--
>> drivers/video/fbdev/chipsfb.c:334:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     expected void *p
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     got char [noderef] __iomem *screen_base
--
   arch/powerpc/platforms/44x/warp.c:284:22: sparse: sparse: incorrect type in argument 1 (incompatible argument 1 (different address spaces)) @@     expected int ( *threadfn )( ... ) @@     got int ( * )( ... ) @@
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     expected int ( *threadfn )( ... )
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     got int ( * )( ... )
>> arch/powerpc/platforms/44x/warp.c:284:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *static [assigned] [toplevel] dtm_fpga @@
   arch/powerpc/platforms/44x/warp.c:284:22: sparse:     expected void *data
>> arch/powerpc/platforms/44x/warp.c:284:22: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] dtm_fpga
--
>> arch/powerpc/platforms/44x/ppc476.c:237:17: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char [usertype] * @@
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     expected void [noderef] __iomem *
   arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     got unsigned char [usertype] *
>> arch/powerpc/platforms/44x/ppc476.c:244:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *[assigned] fpga @@
>> arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     expected void volatile [noderef] __iomem *addr
   arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     got unsigned char [usertype] *[assigned] fpga
--
   drivers/usb/host/ehci-q.c:1389:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-q.c:1389:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-q.c:1389:27: sparse:     got int
   drivers/usb/host/ehci-mem.c:188:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] *periodic @@     got restricted __le32 [usertype] * @@
   drivers/usb/host/ehci-mem.c:188:24: sparse:     expected restricted __hc32 [usertype] *periodic
   drivers/usb/host/ehci-mem.c:188:24: sparse:     got restricted __le32 [usertype] *
   drivers/usb/host/ehci-hcd.c:566:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     got int
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted __hc32 [usertype] *ohci_hcctrl_reg @@     got void [noderef] __iomem * @@
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     expected restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     got void [noderef] __iomem *
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
>> drivers/usb/host/ehci.h:787:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:787:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:787:36: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:793:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:793:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:793:35: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci.h:794:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
   drivers/usb/host/ehci.h:794:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:794:29: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:787:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:787:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:787:36: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci.h:793:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
>> drivers/usb/host/ehci.h:793:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:793:35: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci.h:794:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __hc32 [usertype] *ohci_hcctrl_reg @@
   drivers/usb/host/ehci.h:794:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/usb/host/ehci.h:794:29: sparse:     got restricted __hc32 [usertype] *ohci_hcctrl_reg
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: too many warnings

vim +284 arch/powerpc/platforms/44x/warp.c

4ebef31fa6e013 Sean MacLennan   2008-05-20  102  
4ebef31fa6e013 Sean MacLennan   2008-05-20  103  
4ebef31fa6e013 Sean MacLennan   2008-05-20 @104  int pika_dtm_register_shutdown(void (*func)(void *arg), void *arg)
4ebef31fa6e013 Sean MacLennan   2008-05-20  105  {
4ebef31fa6e013 Sean MacLennan   2008-05-20  106  	struct dtm_shutdown *shutdown;
4ebef31fa6e013 Sean MacLennan   2008-05-20  107  
4ebef31fa6e013 Sean MacLennan   2008-05-20  108  	shutdown = kmalloc(sizeof(struct dtm_shutdown), GFP_KERNEL);
4ebef31fa6e013 Sean MacLennan   2008-05-20  109  	if (shutdown == NULL)
4ebef31fa6e013 Sean MacLennan   2008-05-20  110  		return -ENOMEM;
4ebef31fa6e013 Sean MacLennan   2008-05-20  111  
4ebef31fa6e013 Sean MacLennan   2008-05-20  112  	shutdown->func = func;
4ebef31fa6e013 Sean MacLennan   2008-05-20  113  	shutdown->arg = arg;
4ebef31fa6e013 Sean MacLennan   2008-05-20  114  
4ebef31fa6e013 Sean MacLennan   2008-05-20  115  	list_add(&shutdown->list, &dtm_shutdown_list);
4ebef31fa6e013 Sean MacLennan   2008-05-20  116  
4ebef31fa6e013 Sean MacLennan   2008-05-20  117  	return 0;
4ebef31fa6e013 Sean MacLennan   2008-05-20  118  }
4ebef31fa6e013 Sean MacLennan   2008-05-20  119  
4ebef31fa6e013 Sean MacLennan   2008-05-20  120  int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
4ebef31fa6e013 Sean MacLennan   2008-05-20  121  {
4ebef31fa6e013 Sean MacLennan   2008-05-20  122  	struct dtm_shutdown *shutdown;
4ebef31fa6e013 Sean MacLennan   2008-05-20  123  
4ebef31fa6e013 Sean MacLennan   2008-05-20  124  	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
4ebef31fa6e013 Sean MacLennan   2008-05-20  125  		if (shutdown->func == func && shutdown->arg == arg) {
4ebef31fa6e013 Sean MacLennan   2008-05-20  126  			list_del(&shutdown->list);
4ebef31fa6e013 Sean MacLennan   2008-05-20  127  			kfree(shutdown);
4ebef31fa6e013 Sean MacLennan   2008-05-20  128  			return 0;
4ebef31fa6e013 Sean MacLennan   2008-05-20  129  		}
f9bdedb2c5f295 Sean MacLennan   2008-01-22  130  
4ebef31fa6e013 Sean MacLennan   2008-05-20  131  	return -EINVAL;
4ebef31fa6e013 Sean MacLennan   2008-05-20  132  }
f9bdedb2c5f295 Sean MacLennan   2008-01-22  133  
4ebef31fa6e013 Sean MacLennan   2008-05-20  134  static irqreturn_t temp_isr(int irq, void *context)
f9bdedb2c5f295 Sean MacLennan   2008-01-22  135  {
4ebef31fa6e013 Sean MacLennan   2008-05-20  136  	struct dtm_shutdown *shutdown;
805e324b7fbddf Sean MacLennan   2009-04-06  137  	int value = 1;
4ebef31fa6e013 Sean MacLennan   2008-05-20  138  
4ebef31fa6e013 Sean MacLennan   2008-05-20  139  	local_irq_disable();
4ebef31fa6e013 Sean MacLennan   2008-05-20  140  
805e324b7fbddf Sean MacLennan   2009-04-06  141  	gpio_set_value(green_led, 0);
805e324b7fbddf Sean MacLennan   2009-04-06  142  
4ebef31fa6e013 Sean MacLennan   2008-05-20  143  	/* Run through the shutdown list. */
4ebef31fa6e013 Sean MacLennan   2008-05-20  144  	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
4ebef31fa6e013 Sean MacLennan   2008-05-20  145  		shutdown->func(shutdown->arg);
f9bdedb2c5f295 Sean MacLennan   2008-01-22  146  
805e324b7fbddf Sean MacLennan   2009-04-06  147  	printk(KERN_EMERG "\n\nCritical Temperature Shutdown\n\n");
4ebef31fa6e013 Sean MacLennan   2008-05-20  148  
4ebef31fa6e013 Sean MacLennan   2008-05-20  149  	while (1) {
4ebef31fa6e013 Sean MacLennan   2008-05-20  150  		if (dtm_fpga) {
4ebef31fa6e013 Sean MacLennan   2008-05-20  151  			unsigned reset = in_be32(dtm_fpga + 0x14);
4ebef31fa6e013 Sean MacLennan   2008-05-20  152  			out_be32(dtm_fpga + 0x14, reset);
4ebef31fa6e013 Sean MacLennan   2008-05-20  153  		}
4ebef31fa6e013 Sean MacLennan   2008-05-20  154  
805e324b7fbddf Sean MacLennan   2009-04-06  155  		gpio_set_value(red_led, value);
805e324b7fbddf Sean MacLennan   2009-04-06  156  		value ^= 1;
4ebef31fa6e013 Sean MacLennan   2008-05-20  157  		mdelay(500);
4ebef31fa6e013 Sean MacLennan   2008-05-20  158  	}
a22ebd069d5b53 Josh Boyer       2009-07-05  159  
a22ebd069d5b53 Josh Boyer       2009-07-05  160  	/* Not reached */
a22ebd069d5b53 Josh Boyer       2009-07-05  161  	return IRQ_HANDLED;
4ebef31fa6e013 Sean MacLennan   2008-05-20  162  }
4ebef31fa6e013 Sean MacLennan   2008-05-20  163  
4ebef31fa6e013 Sean MacLennan   2008-05-20  164  static int pika_setup_leds(void)
4ebef31fa6e013 Sean MacLennan   2008-05-20  165  {
805e324b7fbddf Sean MacLennan   2009-04-06  166  	struct device_node *np, *child;
f9bdedb2c5f295 Sean MacLennan   2008-01-22  167  
805e324b7fbddf Sean MacLennan   2009-04-06  168  	np = of_find_compatible_node(NULL, NULL, "gpio-leds");
4ebef31fa6e013 Sean MacLennan   2008-05-20  169  	if (!np) {
805e324b7fbddf Sean MacLennan   2009-04-06  170  		printk(KERN_ERR __FILE__ ": Unable to find leds\n");
4ebef31fa6e013 Sean MacLennan   2008-05-20  171  		return -ENOENT;
4ebef31fa6e013 Sean MacLennan   2008-05-20  172  	}
4ebef31fa6e013 Sean MacLennan   2008-05-20  173  
805e324b7fbddf Sean MacLennan   2009-04-06  174  	for_each_child_of_node(np, child)
2c8e65b595cf0b Rob Herring      2018-12-05  175  		if (of_node_name_eq(child, "green"))
805e324b7fbddf Sean MacLennan   2009-04-06  176  			green_led = of_get_gpio(child, 0);
2c8e65b595cf0b Rob Herring      2018-12-05  177  		else if (of_node_name_eq(child, "red"))
805e324b7fbddf Sean MacLennan   2009-04-06  178  			red_led = of_get_gpio(child, 0);
4ebef31fa6e013 Sean MacLennan   2008-05-20  179  
f9bdedb2c5f295 Sean MacLennan   2008-01-22  180  	of_node_put(np);
4ebef31fa6e013 Sean MacLennan   2008-05-20  181  
4ebef31fa6e013 Sean MacLennan   2008-05-20  182  	return 0;
f9bdedb2c5f295 Sean MacLennan   2008-01-22  183  }
f9bdedb2c5f295 Sean MacLennan   2008-01-22  184  
3984114f056203 Sean MacLennan   2009-06-19  185  static void pika_setup_critical_temp(struct device_node *np,
3984114f056203 Sean MacLennan   2009-06-19  186  				     struct i2c_client *client)
4ebef31fa6e013 Sean MacLennan   2008-05-20  187  {
4ebef31fa6e013 Sean MacLennan   2008-05-20  188  	int irq, rc;
4ebef31fa6e013 Sean MacLennan   2008-05-20  189  
4ebef31fa6e013 Sean MacLennan   2008-05-20  190  	/* Do this before enabling critical temp interrupt since we
4ebef31fa6e013 Sean MacLennan   2008-05-20  191  	 * may immediately interrupt.
4ebef31fa6e013 Sean MacLennan   2008-05-20  192  	 */
4ebef31fa6e013 Sean MacLennan   2008-05-20  193  	pika_setup_leds();
4ebef31fa6e013 Sean MacLennan   2008-05-20  194  
4ebef31fa6e013 Sean MacLennan   2008-05-20  195  	/* These registers are in 1 degree increments. */
4ebef31fa6e013 Sean MacLennan   2008-05-20  196  	i2c_smbus_write_byte_data(client, 2, 65); /* Thigh */
048040a36d46dc Sean MacLennan   2008-07-26  197  	i2c_smbus_write_byte_data(client, 3,  0); /* Tlow */
f9bdedb2c5f295 Sean MacLennan   2008-01-22  198  
4ebef31fa6e013 Sean MacLennan   2008-05-20  199  	irq = irq_of_parse_and_map(np, 0);
ef24ba7091517d Michael Ellerman 2016-09-06  200  	if (!irq) {
4ebef31fa6e013 Sean MacLennan   2008-05-20  201  		printk(KERN_ERR __FILE__ ": Unable to get ad7414 irq\n");
4ebef31fa6e013 Sean MacLennan   2008-05-20  202  		return;
f9bdedb2c5f295 Sean MacLennan   2008-01-22  203  	}
f9bdedb2c5f295 Sean MacLennan   2008-01-22  204  
4ebef31fa6e013 Sean MacLennan   2008-05-20  205  	rc = request_irq(irq, temp_isr, 0, "ad7414", NULL);
4ebef31fa6e013 Sean MacLennan   2008-05-20  206  	if (rc) {
4ebef31fa6e013 Sean MacLennan   2008-05-20  207  		printk(KERN_ERR __FILE__
4ebef31fa6e013 Sean MacLennan   2008-05-20  208  		       ": Unable to request ad7414 irq %d = %d\n", irq, rc);
4ebef31fa6e013 Sean MacLennan   2008-05-20  209  		return;
4ebef31fa6e013 Sean MacLennan   2008-05-20  210  	}
f9bdedb2c5f295 Sean MacLennan   2008-01-22  211  }
f9bdedb2c5f295 Sean MacLennan   2008-01-22  212  
4ebef31fa6e013 Sean MacLennan   2008-05-20  213  static inline void pika_dtm_check_fan(void __iomem *fpga)
4ebef31fa6e013 Sean MacLennan   2008-05-20  214  {
4ebef31fa6e013 Sean MacLennan   2008-05-20  215  	static int fan_state;
4ebef31fa6e013 Sean MacLennan   2008-05-20  216  	u32 fan = in_be32(fpga + 0x34) & (1 << 14);
4ebef31fa6e013 Sean MacLennan   2008-05-20  217  
4ebef31fa6e013 Sean MacLennan   2008-05-20  218  	if (fan_state != fan) {
4ebef31fa6e013 Sean MacLennan   2008-05-20  219  		fan_state = fan;
4ebef31fa6e013 Sean MacLennan   2008-05-20  220  		if (fan)
4ebef31fa6e013 Sean MacLennan   2008-05-20  221  			printk(KERN_WARNING "Fan rotation error detected."
4ebef31fa6e013 Sean MacLennan   2008-05-20  222  				   " Please check hardware.\n");
4ebef31fa6e013 Sean MacLennan   2008-05-20  223  	}
4ebef31fa6e013 Sean MacLennan   2008-05-20  224  }
f9bdedb2c5f295 Sean MacLennan   2008-01-22  225  
f9bdedb2c5f295 Sean MacLennan   2008-01-22  226  static int pika_dtm_thread(void __iomem *fpga)
f9bdedb2c5f295 Sean MacLennan   2008-01-22  227  {
3984114f056203 Sean MacLennan   2009-06-19  228  	struct device_node *np;
4ebef31fa6e013 Sean MacLennan   2008-05-20  229  	struct i2c_client *client;
4ebef31fa6e013 Sean MacLennan   2008-05-20  230  
3984114f056203 Sean MacLennan   2009-06-19  231  	np = of_find_compatible_node(NULL, NULL, "adi,ad7414");
3984114f056203 Sean MacLennan   2009-06-19  232  	if (np == NULL)
3984114f056203 Sean MacLennan   2009-06-19  233  		return -ENOENT;
4ebef31fa6e013 Sean MacLennan   2008-05-20  234  
3984114f056203 Sean MacLennan   2009-06-19  235  	client = of_find_i2c_device_by_node(np);
3984114f056203 Sean MacLennan   2009-06-19  236  	if (client == NULL) {
3984114f056203 Sean MacLennan   2009-06-19  237  		of_node_put(np);
3984114f056203 Sean MacLennan   2009-06-19  238  		return -ENOENT;
4ebef31fa6e013 Sean MacLennan   2008-05-20  239  	}
4ebef31fa6e013 Sean MacLennan   2008-05-20  240  
3984114f056203 Sean MacLennan   2009-06-19  241  	pika_setup_critical_temp(np, client);
4ebef31fa6e013 Sean MacLennan   2008-05-20  242  
3984114f056203 Sean MacLennan   2009-06-19  243  	of_node_put(np);
805e324b7fbddf Sean MacLennan   2009-04-06  244  
3984114f056203 Sean MacLennan   2009-06-19  245  	printk(KERN_INFO "Warp DTM thread running.\n");
f9bdedb2c5f295 Sean MacLennan   2008-01-22  246  
f9bdedb2c5f295 Sean MacLennan   2008-01-22  247  	while (!kthread_should_stop()) {
048040a36d46dc Sean MacLennan   2008-07-26  248  		int val;
048040a36d46dc Sean MacLennan   2008-07-26  249  
048040a36d46dc Sean MacLennan   2008-07-26  250  		val = i2c_smbus_read_word_data(client, 0);
048040a36d46dc Sean MacLennan   2008-07-26  251  		if (val < 0)
048040a36d46dc Sean MacLennan   2008-07-26  252  			dev_dbg(&client->dev, "DTM read temp failed.\n");
048040a36d46dc Sean MacLennan   2008-07-26  253  		else {
048040a36d46dc Sean MacLennan   2008-07-26  254  			s16 temp = swab16(val);
4ebef31fa6e013 Sean MacLennan   2008-05-20  255  			out_be32(fpga + 0x20, temp);
048040a36d46dc Sean MacLennan   2008-07-26  256  		}
f9bdedb2c5f295 Sean MacLennan   2008-01-22  257  
4ebef31fa6e013 Sean MacLennan   2008-05-20  258  		pika_dtm_check_fan(fpga);
f9bdedb2c5f295 Sean MacLennan   2008-01-22  259  
f9bdedb2c5f295 Sean MacLennan   2008-01-22  260  		set_current_state(TASK_INTERRUPTIBLE);
f9bdedb2c5f295 Sean MacLennan   2008-01-22  261  		schedule_timeout(HZ);
f9bdedb2c5f295 Sean MacLennan   2008-01-22  262  	}
f9bdedb2c5f295 Sean MacLennan   2008-01-22  263  
f9bdedb2c5f295 Sean MacLennan   2008-01-22  264  	return 0;
f9bdedb2c5f295 Sean MacLennan   2008-01-22  265  }
f9bdedb2c5f295 Sean MacLennan   2008-01-22  266  
f9bdedb2c5f295 Sean MacLennan   2008-01-22  267  static int __init pika_dtm_start(void)
f9bdedb2c5f295 Sean MacLennan   2008-01-22  268  {
f9bdedb2c5f295 Sean MacLennan   2008-01-22  269  	struct task_struct *dtm_thread;
f9bdedb2c5f295 Sean MacLennan   2008-01-22  270  	struct device_node *np;
f9bdedb2c5f295 Sean MacLennan   2008-01-22  271  
f9bdedb2c5f295 Sean MacLennan   2008-01-22  272  	np = of_find_compatible_node(NULL, NULL, "pika,fpga");
f9bdedb2c5f295 Sean MacLennan   2008-01-22  273  	if (np == NULL)
f9bdedb2c5f295 Sean MacLennan   2008-01-22  274  		return -ENOENT;
f9bdedb2c5f295 Sean MacLennan   2008-01-22  275  
4ebef31fa6e013 Sean MacLennan   2008-05-20  276  	dtm_fpga = of_iomap(np, 0);
f9bdedb2c5f295 Sean MacLennan   2008-01-22  277  	of_node_put(np);
4ebef31fa6e013 Sean MacLennan   2008-05-20  278  	if (dtm_fpga == NULL)
f9bdedb2c5f295 Sean MacLennan   2008-01-22  279  		return -ENOENT;
f9bdedb2c5f295 Sean MacLennan   2008-01-22  280  
805e324b7fbddf Sean MacLennan   2009-04-06  281  	/* Must get post info before thread starts. */
805e324b7fbddf Sean MacLennan   2009-04-06  282  	warp_post_info();
805e324b7fbddf Sean MacLennan   2009-04-06  283  
4ebef31fa6e013 Sean MacLennan   2008-05-20 @284  	dtm_thread = kthread_run(pika_dtm_thread, dtm_fpga, "pika-dtm");
f9bdedb2c5f295 Sean MacLennan   2008-01-22  285  	if (IS_ERR(dtm_thread)) {
4ebef31fa6e013 Sean MacLennan   2008-05-20  286  		iounmap(dtm_fpga);
f9bdedb2c5f295 Sean MacLennan   2008-01-22  287  		return PTR_ERR(dtm_thread);
f9bdedb2c5f295 Sean MacLennan   2008-01-22  288  	}
f9bdedb2c5f295 Sean MacLennan   2008-01-22  289  
f9bdedb2c5f295 Sean MacLennan   2008-01-22  290  	return 0;
f9bdedb2c5f295 Sean MacLennan   2008-01-22  291  }
4ebef31fa6e013 Sean MacLennan   2008-05-20  292  machine_late_initcall(warp, pika_dtm_start);
4ebef31fa6e013 Sean MacLennan   2008-05-20  293  

:::::: The code at line 284 was first introduced by commit
:::::: 4ebef31fa6e013e5cd3d4522e6018eb6d55046be [POWERPC] PIKA Warp: Update platform code to support Rev B boards

:::::: TO: Sean MacLennan <smaclennan@pikatech.com>
:::::: CC: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICLJW/F4AAy5jb25maWcAjDxLd9u20vv+Cp10c++ivfIjTnK+4wUEghIqkmAAUJK9wXFk
JfWpY+fKcpveX//NgC+AGirNwjFnBoPXYF4Y+Oeffp6w18Pz17vDw/bu8fHvyZfd025/d9jd
Tz4/PO7+b5KoSaHsRCTS/grE2cPT6/f/fHv+a7f/tp28/fX9r9Nf9tuzyXK3f9o9Tvjz0+eH
L6/A4OH56aeff+KqSOXcce5WQhupCmfFxl6/aRj88ojsfvmy3U7+Nef835MPv178On0TNJPG
AeL67xY071ldf5heTKctIks6+PnF5dT/6/hkrJh36GnAfsGMYyZ3c2VV30mAkEUmC9GjpP7o
1kove8isklliZS6cZbNMOKO07bF2oQVLgE2q4AeQGGwKK/PzZO5X+nHysju8fuvXaqbVUhQO
lsrkZdBxIa0TxcoxDZOVubTXF+fApR2yyksJvVth7OThZfL0fEDG3eoozrJ2Ad68ocCOVeEa
+Gk5wzIb0C/YSril0IXI3PxWBsMLMdltzmjM5nasRdBzzL+bYcA8nOAQv7k9hYWOiNVJRMqq
zPo1DmbbghfK2ILl4vrNv56en3b/7gjMmkVDNDdmJUtODqBURm5c/rESlSAJ1szyhRvHc62M
cbnIlb5xzFrGFyRdZUQmZySKVXCKifn7rWAauvcUMA0Qi6yVUxD5ycvrp5e/Xw67r72czkUh
tOT+RJiFWgdndIBxmViJjMbL4jfBLUolieaLUMgQkqicySKGGZlTRG4hhcZp3Rwzz41EylEE
2U+qNBdJc6ZlMe+xpmTaCJqj5yZm1Tw1Xlh2T/eT58+DZR028gpl1e/EAM3h5C5hVQtrCGSu
jKvKhFnR7qF9+Lrbv1DbaCVfgrIRsFGB2iqUW9yiUsn9znQSBMAS+lCJ5IQc1a1kkokBp4iF
nC+cFsZPUZtYUJu1ORpuy63UQuSlBa5eKfenq4GvVFYVlukb+gzWVMTI2/ZcQfN20XhZ/cfe
vfwxOcBwJncwtJfD3eFlcrfdPr8+HR6evgyWERo4xj2PWjq6nldS2wHaFczKlSAGgwLj95/m
NTMJjFdxAeoAKCw5VTQ0xjJr6IUwklz3fzBjvzKaVxNDyVJx4wDX7z58OLEBkQlky0QUvs0A
hGP3TRuJJlBHoCoRFNxqxk8jnDfQ+Sw8m/H8un1Z1r8ESmHZyY/i4R7J5QK4DsS7M7poXVNQ
jTK11+fTXgZlYZdgclMxoDm7qJfdbH/f3b8+7vaTz7u7w+t+9+LBzaAJbOfQzLWqShOOEAwJ
nxOjm2XLhjzwh/y3M3whkh6aMqkdieGpcTNWJGuZ2EXYKRyCoAFt5mqCUia06DZ4nYy4AQ0+
hQN9KzQxwYYgESvJxdEc4QTgmQoH3WBmZXqKG+j3sBH6C2AU4JDSo1wIviwVbDiqQqs0pQf8
Inm3rN2P0NOANU4E6C0Oaj4hWmuRscDw4b7CnL2Po4O98t8sB25GVWDeAv9HJwMnDwAzAJxH
W5qMu2SAi92xsI064nJJMpkphXoZf6fWnztVgrKUtwLNM1on+C9nBY/sw5DMwC9jjhC4vQmq
BK5ApYARZU6gv43qOnRT/iEZmnCbDb9BKXJRWh8QoSIK9qlM+4+h6szBHZXg4OlIFubC5qDT
XOMtUJLkxeXIm0gXcEhDY107qbVhDqBeMYWhQSTqIkthETTttc4YuEVpRY4qrSAYDEaDn3Dw
g+mXKhyukfOCZWkgvH6kIcC7RCHALEDRhaNlkooApHKVHthZlqwkDL5ZNfocA/MZ01qSmmaJ
zW7yYCVbiIu2oYP6xcJzi45BJBLB3oWOvvYBSkodf+/OYxTbD9Ehhxnjy8gQgN/6kZwbtBNJ
QuoWf07wqLmhD1rys+ll60A1SYFyt//8vP9697TdTcSfuydwKBiYLI4uBbh5ta/VNO95kg7K
P+QYOF55za727GiDjLEzsxB4BzJuMjaLDllW0TGVydSMOnHQHpZez0UbRsa8vYHKpAH9D2dQ
RSJqFlWaQixfMmgNWwZBOlgI+lhbkdfKB6J4mUreap/A51WpzEC0yfWMcxDdJpb8IlLyALiK
tLPfs3L/vN29vDzvwVH/9u15f4h2suSoupcXxl19/057oQHJ9GyU5P3bE+3fj+Aup9+JBbu8
/B5prvPplKDq4qgy8BqxszQEXH7/HhxRmEaoR61wV5czGWx6ubgxRzDgmecVRDNwUBdjcDfY
C0B4fU6LY16SG328V21nq8Qo30N7GiBKmeHiFIlkgSG7OI/GDuPrP7yyyXMGflkBPoK0oHbY
Bv3WEwQQXb+j8e2B/BGfiC5kV2gMosz127Pz7qxYUHy102+qsoyTdB4MLdKMzc0xHoNt8LWO
Ea2kLNYCotp4ZwOjxHR2c2RFS1Y0cb6qwMV/38UBtduncmlBSYAb6byf6G1+tArsptHDIJgJ
j6WnSmZzd3b19u00aIW5Hd/2eAK1SW+Abd6rkjlooEG3CzkTunZy0F0wcpYNSUxlSpAeAo1D
S7huQt8j+BEfv9ym9q69OvTacIysAl03EyZmC1a8aa/FfBQnGTfXlzQuQdz5CG51Asc4Kvdw
Bct5nSP2CbG4IagT2EmJLh9EBPFAEbcAAcbk1BFiCPMZLDgSuc9N1or68e6A9jLQ052sqTxI
TgVcLt+F6o3loOGiJERWYdxS0F6fmKmCTsEYll9eTkVJWTPxsVKShb1YJg34qHRGl8EUJYnS
DKIa0iVbM13G4hPKC2fFjSoyMMhhVi1jXMYetxbJWik6fgVFEPfcYW6UEXCoyYyPMbU56QOW
Clw2W/El5TebMtDXbImrHW2OhP+pJBcIzOV3zJaWWZw9qyVpXpK+sd+vwO7hZ+C2X15NQy/+
8t1VWkbca4gTWl9eUXOf1RLhCYJ5LcF1m6OQhfEAKyHEY5phPi2wRWWYI8IvOARzHeTxJul+
99/X3dP278nL9u6xTt31iw0mD/yxj6TlpFu3jOX9425yv3/4c7cHUNcdgoc9YF50tIe6QQAJ
GbczU6nTNsozgf5GEG3yh6c+9Mmfv+ENXeR7Y2IWggVSdhe37iz2lULU+VvKjQLExXQ6yB4D
F5r2Gu/y+riK2QUEIFXmDc1YeCMKr02bO5GFsmUW2jGaRsNvq0hAl2IjqHQ2RGLoerNZfFq4
RqcsqXJKifk+wY2w0GHTd5BryTIxZ1lr0N2KgRbt7yONTWayqKzMzOB0usulN38j2VwgOLsi
KAL8Vcsh1vI+xGiSjFedO1TfWXa5x9YtwDBjSOuvRNBJc7dgDJROQFO+C9YqT/D+FP1jKgPQ
oIOck9iAMwZ6HwInCCsB3luO2qugZbB3SugVykl7w9GBDPO+g8PRq2fmkpw55pMT/szMXl+C
MzTwphr6eKkl+NNacItWPooinIlzx6nJXDajz3TYbefsqgIz/dBvfcnZDpHd/4kB8n13wRxm
NjBBlvicGLQ+iuyS3ee710cPwKT/ywT0yOSu5bcNL/nb4Uzu9rvJ68vuvl+OTK3xFGCu7Xr6
/WIaX8p70VNpaoQF7HaAbe5rYWKaQmM0BcFuTzAdEFifEKt77hp3yzhYmi4UAqtSsUzetlF0
dE9/t9/+/nDYbTG1/sv97hvw2j0djqXAO+WqjrtjPVP7p6SE/gbqxGVsJqhj4jmKFMJ7iamM
qoAxzgvMDXMe+Ype+1RG+Nt7Kws3a66oQ0ZSgQqECApGYweo5dCDrqFaWBpRQ7FWIR2kMT0+
rQp/t4umXWnqrre/efbtFxBGHwcnENN649kopmFAwgxqISvTmzaFHRP4wBUlzQ2niwUeuUqa
Aojh7DBecOAL1qFjs9aNDojowHEdgHwaK443ejjm7RqeaESoxeilIQq43RzMIjSugwjMIJFo
vNT6AUmt9/F4DBcThlDksr6F4nm54YuhRV0LtkTbKDBbyfjHCtTakISBmEpvX/BavC08IWba
KGEHZyUKccfgvqVfPBRfECcVIJu6nRh9dFcco8eOG3FjOzxH5DVtSAGy1cyyFByzc8FeqKTK
4OjgYcUEOmZ9Cf5ig6Jb1FUOOG5C+H1zn0SM9rNf4yjvcipp0ydQfGOuypvWGbDZUJZ982Kl
WQ7KLgyiMoUGH8YKwVYYSCmsJ5Lzxo4fwdlANTTJnfr04joPRl7bLjABjanQ6w2xOMaCBrEx
TSAJA+SpPLpP4FkVG3bMDIUJZtMZDa5Wv3y6A3s4+aN2Kr7tnz8/DCMPJGv6P9W3J2ssimuv
AdoU7omeog3D0jl0kGURuZcB+GSK+Afmr3OarcvxIic0Fv5ew+Q48LPBAQhHUoMalzJTjPb1
GqqqOEXRqvRTHIzmXelbfD91RCnnp9AoqZizOUWDiau1yyHQr0s/mtthB7E45q7oSq4CtAOc
jZt8pkbun0CA85ZuiXdI5I2+CvUGXgSDNvGZtMG5QpThRoI2+hhH3n1VABwT9DZjFF4sz8yc
BGZydgzH+GeupSUvqBuUs2fTYzSGGckxGNSUsjaLdPAxDl3SwaSaAMUbqijJg9j1jK6uCZZD
Kgj2RMFvyJUPyLgaLmidJgwTbyG0m2nUq/FeO6O0BaLrclUIPLm+KYdXQSSBS5tLwePrnbv9
4cG7+Pbvb7vAwYW1stK3bQOJsBfGlS56GkqtyU2PD+yASSNwzzEH63CaI0QBkuKZM07zzE2i
DM2zo8mS/AcUZi5/QFFlcEQ3JwdvqoIe45Lp/PS8RSrppliJevX+B2MLZJ+iatNIAzEIxS3/
GEezDQx9J6laUyhVX5oUSBHQSVXfdWAdRVxmHSCXN7P4YLaIWUon7OL+OhExxVnPvyqag2BK
iJLQlhy5Vt21ArPgWXGn8/X1sX8BzqVTYEYyVpaoYFiSoClwXru3KyC+77avh7tPjztfVD/x
d9eHYC1mskhzi55ckOzMUqyqCBa3JjJcyzIqUGoQYFyoLBYyaeKMbonGBuRHm+++Pu//nuR3
T3dfdl/JELdJcPVjQwCsReITbS4/ijlTZqybV4PcO3g+ovQFCvH6N8k6aVQ2rKYpM/AGS+v9
LvDO8dImqoGvvUg6CYQxjxa4qYPr8LZbOdds6ISCXz93g2sn7wriTjs7vNL1YQN4ibMqLPsw
wVK1t2ve885l4RldX04/dDm1QoB0l1ivAeHHMioN4BB1FZyB/FP3AhpGGwf8PI/uU+Czti9k
Lo4d3wQhkEEAEIQGt8Oqdw/onCAIuNoZwv9oG4m+RpsMysJG6d5fnpN7fIIxXV12qsGCruQf
bXJrLFUsM0Z//ebxf89vYqrbUqmsZzirkuPlGNBcpBBAnRjogNy74YpSFAT59Zv/fXq9fzNk
2TIjbZJn0EvQ0RyOxtuxzttjFnRXw7qL07xWsyPTbYjRPz1R1lFfxzdZsMiwJG3RDSajlrSS
qK/kV23mIaxcwuM6XnM9xxpS8LsWOdPUrV4faFpRJwxYFOeNq+Veb3Sl68Xu8Nfz/g+IAamb
HtCSS0EtEZjFTWQkN2BuIgXkYYlk9BbYkTBlk+rc571ILIwbLAF9X7xJSsyPw3Cp0EbWU+53
sKxLJDkztOMOBF3yG/xyS14SA1FZhM9O/LdLFrwcdIZgrE8txzpDAs00jcd5y1KeQs411o/l
FZWZqCmcrYo66R84fwWoG7WUI7nmuuHK0pfniE1VdQrXd0t3gNviGP08yeMg+B1HyhJ15chu
99MNgSiQA5DlZQuO2VdJOS7AnkKz9Q8oEAv7YqxWtNhi7/Brf9VCTKej4dUsTA222rXFX7/Z
vn562L6JuefJW0NWRMPOXsViurpqZB2fuaQjogpEdYW0wZukZCS1grO/OrW1Vyf39orY3HgM
uSyvxrEDmQ1RRtqjWQPMXWlq7T26SMBj9l6rvYlLFjy6lrQTQ0VNU2bNu8+Rk+AJ/eqP442Y
X7ls/aP+PBlYD9orqbe5zE4zykuQnbGjje9aMfE+YqBQ8Etb4mtaY2R6Ey5Y2xo8Y59TAjOY
jxpqIK7T+nRupTyBBMWT8JEZSHxWMqKK9chrEjv2XBPiGzoncD7Sw0zLZD76psArDcMGS4Yg
ktkqY4V7Pz0/oyuzE8ELQRu4LOO0Z8wsy5YkZnP+lmbFSrrkuVyose6vMrUuRwq2pBAC5/SW
9sRxPcafBSWcqrJOCoPvZxS+Yb7+GmwG1ob59BTJTJWiWJm1tCNPaFeExxGOM5PFctxC5OWI
WcQZFobucmHGfaN6pImgJ4MU2QV4xgY1/BjVR23HOyj48D1gG/7VyUt/8nVcHEbR1JqB0rfe
rG4wKr5x8aOO2cfId8G3Dr/Fj5RDh3Zy2L0cBncofnRLC+796AQTrcBiqkIOLvw65/qI/QAR
OtLBprFcs2RsXUaOwUhKmaWwQHpMG6VuyakalrXEi1gTXaPwdI7H7OxoDTvE0253/zI5PE8+
7WCemAa69xUeYFs8QZCkayAY1zhfjI6lPnVdRd/jWgKU1rvpUpJvf3BXPgQ+dv3dZw6j7ftQ
HmctgnWWtE/DRblwY0/hi3Tkmb5hWB057jenNI6yuq2SMnAyMGUTVDZoBcPLwjtVL6Zihaol
SDRhMNrE011XKZMZphypfLBdWAzfGx01SMLx5nC1QWKy+/Nhu5skvshwWMAS5XXrK7kINPxo
HsybGEg8WwKwz8GBLiBmgFhmyjxi4yHBO5qIl8eVai20YSt6c2IyzOz+I+L+KeEoIThE1LHE
qcd12TWA/MsCiMMiivhZll/SUaFHrK6r4dsKR3wnOkprbEXZT0Th4zLAxuNhdrCRUq1iANiD
4XBLRiv/pjCzEZlee/Zgx+HH6ZbOLPybivpqCqi3z0+H/fMjvne+H0ow0qcWfp7FBagIx7/m
0eaCxvd1g2+mNkcqNNm9PHx5WmOtG46BP8Mvhnj8hCyStSsxLY4djnfUUgnarfSCAx4OfTdz
ajh1Lv/5EyzNwyOid8fDbVNL41T1rO7ud/jUzqP7dX8h333hpDhLRIEa48fzj0iHi9CWQ/+w
/+6yihaMTmjE0/2354enQywqokh8SW4s4S20eXycHh1PAUdn+Pd2opF0vXX9v/z1cNj+/kPZ
NevG6bOChznA0yx6DpyFT7xLnvP4XUUN8TUWjsuRJ+rAY6Cjm2n8sr3b308+7R/uv+yivOKN
KCyj1Exy9e78Q5CgeX8+/XAeDhA76wtZe4xmpUykOgI4H7q3j6cupkN0oxPB5bQb56/xwul3
THIGlHNZUHFbRySix1F9D1WOhS3EaB3meItjsC/1cBysfKvH9N23h3u8r6z39EgW2pbWyLfv
NkRHpXEbAo70V++pKWMLUH7nJyasN57kIhS8kYH29bEP28aPmKjjfHNVV0gtRFaSbgusiM3L
+IC1MHDbq4LWHyAsRcIyRW5fqetOU6nzNdN1SWzSLnz6sP/6F6rNx2fQLfvgZnPtT0VYctiB
vDuW4N/lCG5pfb1620lQyN638vWe9dwjN44iIKsxiCZ0yVGzWcPJdcECVmViQUx0JdyGGL5A
KcSOpB780zYtVyMZmoZArPRISqwmQL3ZsHH1iww6P4NkzNwUvCX2JcfEfgePdr0r5OmCi2PF
4ztZLebRNXX97eQ5P4KZsOS3geV5pJWaxuGff2obcx74VqhxzAIkxYtRGksEIlNvDH0xNLm3
I4ete5Nw7336sMxCbWx8SZIvpBso9uh9QcsiMAUKQpuRYtl5ERag/z9nV9bcOI6k3/dX+Gmj
O2JqSqQOUw/9APGQYPMyQUlUvTA8Xe5tx3iqK8ruOf79ZgI8cCSkjX2oQ5lJ3EciM/EBf/Uw
nJXvSicWCG0zMqaUlTxvsoFHDgIpdNx1hMxYpdbwMcJPOXKIzWsKZvn+/OPdjEdpMVj3XkbD
aDVCsh4oY7GqjKJC/0rYkissdRkEwxxU8MOnwJuADPiXV5FSp5qmIIbqVmV+oTUSp+6ySY7w
X9AAMVxGoSi0P56/vb+pyx3583+cRtrljzC9rWpZERyZDnlSql/a2bvFaFvSw2N82GSJmZIQ
xk1nUZhs2SFGMDJSzIgIpEwBTzANld1s2pBZ8bmpis/Z2/M76Fi/v353N2U5IjJuJvmQJmls
rTlIxwt6I9noOEhB3hUmruBoUriC7Fj52EsopT4wE7e44VXuyhrTkD8PCFpI0Mo2zRG30+Gw
IhFt4tJha2YuFa+2OQOY0YZ2yauow7WcqDuRlq2hofh7Tp2Enr9/RyveQJT2Lin1/CsCI1jd
W6ERqBvDDawBheE/hTOmFHEIW6d542WlyLyrpIvkqQZQqjOwJxWeVkixq4zOEiOcQaXOU5q9
TwtecrtPJm4N6iCGJ3l6wbABKYJ90pipPQP9/gLanG+sy1HWn/DCRuMkAadDZ6SMp9cbPaug
017efvuEZ6bn128vX+8gzWGfo+d3XcTrdeCUQlIRLCHjlEdek3EAwZCHNyiznJkuAH3Gxoc6
XD6G6421gok2XFvrnMihPexOVSQjT/hjNZy9aodq91T2jdf3v3+qvn2Ksf0c+6BZmSreL8kO
ud3WehlKJpE8GmuEwuKMHLs6A1nB3Vz6c0NfqNdFZxBBMiVf9IYuE3a4iO/9DSml0jjGk/uB
gXKox6F7BGD7ik0hDDygKq1/vDN9VsMx8l+fYU9/fnt7ebtD4bvf1Co4m0rM4S0TTFK8R0gU
UzFsc53NTqgAokmoTDKnxVVPs8zXYZJfdG5XqW6sPY6WSQIXCbTYXpcaDE7XhVjDhOm/UZvI
6/uvZkuCCjKhpDptgEASvCA4MByrA924XDxWJcLeehoJDiPjGJFFymtcn/9b/RvewVp79w8V
KUYubFLMLNGTBKeelZRhFt9O2ClWZaU8EOUlt5UMLQCF19pMjzvuEPpzLu+diUMFR3Y9NHYU
2KW7AQQ7XNg8jDV2tmdk7PNjSuVmRx8D+XCBw7hxXkxabbLK3XZ2J2cYFtd6oLeBi2GwrXEV
E4gqDJFkPVa7B4OQXEpWcKMAY6S5QTMOoPBbhcfNvwvDloZwEimcqU6oBuvR3IqBXnWDpuLc
L2bJZNSwCliCMZ02qW5GVVcMERppgioC3dvEUPIR+tpYB0bqlXPi/GGf8czjDJllpBvIs6Zo
Ykp7uSrFuii631LgJqNEEEYrt4ZlNdRyoA8XlvRqj3eYymOe4w/apTwIZXTsBGTHEw884/Al
muKFQG2B18uwo525X3y6+pjK0QcfMgrkcDq7KpA0O7oOUzvc4Isuusr3VSFO4PCAYQRxcqJz
QPQLnAHoZKXjaKTLCF2ejvFmkFDe7ZvdeKsNGtG5nqnyVKSab2f4BKmWcjW15KkwDqVSVMW0
MU8NpcjhXJBx35KZsR3sbbpbW1JjJyMrDM1gSfAPKwlFlAPITUvxPB59XcQJfhujPPTGm3Z6
15jGknW47vqk1pETNOJgPpzHjMaCzZC2hx6L4oIrN7V8HFjZVtrK3PKssPpTku67TjvLQw9s
l6FYLTQa6Dx5JY5Niivoicfm1dtD3fOcXgpZnYhttAhZTkZgizzcLhZLLXNJCbWrm3BUF7Dv
9y1wDES6kbE7BPf3BF1mvV1oDo5DEW+Wa81EkYhgExn4iLihQvVAX66XBG7w7D3wLQWG78+z
qY9zPclSXYdHp1TTCq3A9alGnD+9gHGIi78zgdO0RnuHA9Gm6LD8hNoOMhPXDhExhuKLQy5Y
t4nuXfHtMu6MgOGJ3nUkYNfA50nbR9tDnerVHXhpGiwkDOx848ys3Sgf7+6DhTWgFc1yu2nE
nglxLJTZbNSC25d/P7/f8W/vHz/+/IfEg33//fkHHD4/0JiJWd69wWH07itM69fv+F/9ONui
wYpcGP4f6WojbBjGORdL7/Q3hGD5IBqcYTgsQ+tRPT/K8e0DznqgE4KG/uPlTT7Y4wydU1UP
To95C7I34PHS5JX0ps6ND5U12FkeI+i2YQcaJ4FzgJwYR0EFoxzYjpWsZ1wfN8Y6PEsiPEai
I2sl02XL+u3l+f0FEn65S/74VfaatGV/fv36gn/++uP9Q9qIfn95+/759dtvf9z98e0OFSR5
rtFWe6D1XQY7flFZeaHn2bQLIhE0hNqo8XSlHZiCka5xZO0TM519gknpCc3UmgqT0fKJhacA
MRWZo/Eh6dTOUoIo8SpuKZ8LCuCzB+oCuxqU0IhoeQOpcfB8/tuf//Pb67/1Zp10zuG47qom
kI50lGXZL1rAj5b6uzvWtW+tcacoOBphLvQSouxKU1RZtqtU+ITTjETUkP01LEubMPBWySra
yGVpvLG0blsi58G6W5IfF8n96urHcZFsVp1bqLbhWZ4SjEPdLjcbKrMHWCIazwXbqWM5aR2d
mqKNgvuQHKZtFAbL65+GAVHeUkT3q2DtMuokDhfQsggyQ+U48cuU8kdNp4rT+dGBaQAytxBy
J0YehXGwIAok8ni7SOm2bZsCNKerTXviDFLurvZ2G0ebeLHwDsJxTiHSx2iYJYBhBcd1b06k
YRxXoFY34KCU+cuEx5EUa5GQ2Q753X385/vL3U+we/79L3cfz99f/nIXJ59AUfjZndhCf2Dk
0ChaS7WjIJ/9GD/ZE8nokMiyzJO2rKcvObEMUnLw6XWRvNrv6cujki1ivJqAMQ1Gk7SjRvFu
9QJa0cZ2NzPKYsXwF4XLvx0hI3l86c7tVknP+Q7+IRhqf7KpMrTSeLVOsZpaq8DoJLDq/F9m
C57HN8PmZVxyfNeXFFe6wq+Ao8sO7Pa7pZK/LrS6JbQru/CKzC4NrzCHsbo89zCbOzm7fD10
qIXd2vDZttMjv0aq213MDAZUNBZjhjaVx/dGogMB9w8hAQmGR3OWoS2BdkSMLcrZpS/EL2vN
uzmKKN3dhkQ1ufiMiX6xYE5eBnS17QCj7msplN/aNdjerMH2dg22V2uwtWvgJG6W35nJILil
93C1EJ9Uv5ofSaoXz0ETQT0u100qA+9YcCfRpEYrBm0KUEXFG60wx65INHFBrsFqaYUShbqj
AI6rcm+BLRgULIJRFBSR8XxXGXBuE0+dgCkHyijhThM4UC5JaogtKG+9wE4fhBH1lcG3Okml
4F19C9a09ZPbD8dMHEidfVgS4PhbOx+BggubD6mhqsJcmp3zkSj9HyRFtwy2QeJuPcMTi1bc
vim0T1rK1a12ptod0PgWFQlBPnKZiuc3tIuauekUtGVHMb/wuk/rOqDvGc8yAgMiY8+1OdVy
beqdsuJSrJdxBJM/tLfDiSMxhZUbB/3B8pgZ+GTHW+EMjp0z/rIlheNQSmxWdllnmeJKG9eN
25p1QwUk2iIeQGzJf5KjEr0gCyf5p5zd2miTeLldU++5qOUGK7a9X1nNXIp6aTf9ObkPtp27
5nnv2aghVsT29mwLRAvzARudO91pozQcf3A+O7BgHdKemEFkmITXREpePrDe27yD1JOzatgS
avisSfB21Ya2Cp0c+iZhsUs9wNQ6u32AeO/+degAJ+AjcxRI6/gy7buGeoqem4OBvjc8mLSr
RKqwiU2WvO5mlBCptTm+lQFRu4zyr9eP34H77ZPIsrtvzx+v/3y5e8X3qH57/tUwN8rU2IG8
8TTxCPOIJMfpiVmkp6rhT05xYbmMg01ILlAyE3nnAhOwmkrwPFwZXoxW2mKo/ZRAYtRphXq+
MEkRa9fYqmGT5mXK6MW1SKQ+TB+FByY13UbWwigBklbrjZU96ema2XKx1dEprRuc6rcb5jXQ
h9MjoZ3Zkiq4HRRELmCRpWH+Ju9oMQJ7u82eGJFfSeHVC2Uimb4gjcIqEAL2kJLtQVXGH0Yc
kyWnIKxxZ7CldhzjSbjQo2ISeaFSQC3xVkZizNAEMUwRjLfWoT2BKkEqrXqJktX4WDHtTCv6
9sBlyO2JI7SrD4MCE/fAqAFLhpWNPa5/k+4oTQ4ZDbNEY8/FFGAVfFhzdHl88hVvgkjkQF+Z
vfsQ8L6kDfm4eTGPdaNxJ2r/lHsYwm78mXUg/WJyiKgYEWMsHn3S8sl1YyDIazsGKcvZY3ox
SBj+11KkMTCwqapW3lcXfG8VZhDMUnrDwyHmQEOY3SSHh7CSnXBr6e8s3NrBIW25cmNIZoxG
mr1TQEXgZ0+oCrJr7waPXBxV1IUvdKbv5BwePe62sUXSyXSzo7DWKuUBSNP0LlhuV3c/Za8/
Xs7w52fqlmjGmxSxC4hSjay+rMRF3/Cvpj0t3bgatRU+0CLvC5kA0yzGR2UwBjndtdRKe+Zl
kjF90y3TVtkM9Lg1bpzXyqEjKdddExsxWOo3KMK6eXYkLsyI44HcsDPZAwM7ZrRBbGRXxXbh
eSPRFPEMr7EUHIbmjVTCxSJcOEMieX3/+PH6tz/RozhcH2QalLgWpjhfa/4/fjI2YIpvGhjt
bAa6YflgVUmqpl/G5lubg3oLqu09DUszC0RbOqinauhjYHupD5W+BWrFYAmrWz10YCDIKwKZ
8aCC/hVsy8aOlLbBMvBhw40f5SyW25muoOc8rvTYQUO+TfVSw25kBTAoinqhsOV7fJ7A77Vu
hacuBfviaxxdhYQfURAE2MczscYhZz2LOZx3ijj3AK/oOTwdWdl6ovp0ucYTU6SJ4Nir/IA/
o9gRdnzKAazJ7JqKJdb43K1WxEe7uEBfpOn9KDsa+Smm7Tuy5wyHoqJ4A7wwA933hj970Shk
iPnsId+ktSNc5m9aI4V2SkCnZbnE6aiyDK+7WkxZPHv5nVsQw7tvdQYRAk4Jnfix8GQEmmEu
SDOKLgS7qLYKDdOIkJOIxJo+rG7l6MvarGiUJHCnllqSWrm0x1x/xD1Jw2Che4MHQp+IfLZc
jx/NgwMJfXH2qBmKW/h0FMku6eiFJF11mqcUtuBdVSZ9tNKOcUmxDRaaNQfSW4ebjmzOxIS+
SfJQf9f5WCbD4/AWxbrSqyWI79AZXvI0NDYb9XsamCYV/jFm6Ugl3dyKmWNxGicl8Xg5sPMj
XcQveGVAG2vyd1/WYjjOFXjqSo1ia59nxwfeiiOxnmbF6SGIaCuUlsC+qvZXUJMGqcORnVNq
CGgyPArXHd2xfGdMR/gJXcOotU3/CG+VaQ1jWJDxl/1Tj/TZG9Zy+OldHIF30q7g8W6/M3+Z
wTVIcNMy+SfK4sJXRgGZkSnwTsbNBE4uclkRLB7NitHb3ENxs0sL1pxSL8LXKAQSrLScNXm3
6j2QbcBbOxq1zhVnn8INzOxMjh4MXNFHwqOIonVg/4YEDK/zo/gSRavO9nPQyVfDJJz1szIO
o4cNZTQFVheugGdYxKGZ7lfLm9NNZoavyd4o08UEacLfwYJEqcxSlpdGB2nplKy1MyPF0hYv
VNzUvuC/TVVWxY0NuNQMk7AbdvuUWMvI9E884Td0repRSx022oremhVS9gASY0ZMgwIL3U3k
ckkRSiPjtHJbp6XAx7o8Zb9iideljhh46fFyaXJNcjMpRBFrUx/e6yRUppYHWuciWqYfXXKQ
EqyArZaySOpCafrkyQUfg2gy+HNj2Aie6+A7It6Gi2XgS5RT9jxdoBD6ww+DM6SIt0GsIxil
NY9N3yR8tw30WDVJWelx8UblYoQj6OjtWbRywhtqdltIa4bvpob28fHmhBSXsqotl74r1aaH
Y2usJ4py4yvzC4R6g9UbcYIFiZbYqt6jinm6fWA78y8+aFpNygV3o2SauCqcrkdyqCNMZEmi
rSRJmnWd9dNSLMVjZuwRsGWQanGhwKdkuIph1zBxbBQFrXwlL3R3m2LwdseMu8hDAn1x7Giq
vGjrYWFNmtST3ASI3enKq5QgkjxwjCJIVZE1xwyweP20WgS0tWUUiBYb6mAs2TDRYrTRFU7K
xckKPTfZXR2TmJSHi/GImTgD5Zchdg/yuYOfXjQBlqA74mBYxFkhMRZoc9pgmrAFRra6argb
khxPCHEh46SsfIAc3SsybURQ2LlW9UYzBJHaehWsFt6iY3arKAq8AjGHk7evZsMp2KxYAofw
uSgjsY6WURja5UNyG0eBk7/+2SqiPos2995CK/7Wk2jGuzSxk+RxnR+F5wsFc9Gd2cWsVY6x
UW2wCILYYnStSRh0bpoI+p3FkHqvS5PKqo/cBgQHdUCTrJ7cZlbqZQcJPDDY/ZwRydposfQN
yCc3g0E7sZMZ9BFPOqiPuJXD/ddOR7Rw5OuosBW0XcLk4LGwvzmh70eknryHi2F7WBbCZq8c
BWZHwDlju10br4Mb9pm6Nn/0O5EM75RrxOFtJePEXo/P5VJrGDCLunY+kGs2Gkzob6rUzHYM
W9ZI0n/d6s44YdRH5AdjiUfuhF/nQXuXMjI0zs/GaCn5P+qOGizzA/C34wRCVsxaWjFG5iM7
+9QqZNfpngkbPk3jN20eBWs6dmHm06Za5OMRMPLcwEY+/PGpOMjm9SElgxrOlmI1Qof354Ta
9FB89lYUMAk1E53Oaw/mBD9ciXkA7vrRc5Y2Ey30o7rO0ozkBNcyueosyxBksxphYlNhwJDH
tYahDcWaUj/0RIcFmc6xSOGE6m3ThpkmTIOnVkQPU7+OoTP04Ced3nrkv1wSPRZWZ0n9JC1L
KmatYZfYBd1LJcT83fkVUeJ/chH1f0Yoeryv9/H7KOWoUWdz8EJ5ZBMSfXBIcm2Fwl/oQnUp
g0dp7nCky/HjSbTPGkceFkCnut1fw/Vn+XjGeMsFJL6+vkucfQsqOVwsYP0kRxnUuPPgXMTL
xaKtqHJmrDFXaCgkN39hjOgvUxSzcm8L7jg6KJR5LTwg8UAAGMmcQHGzwA6Gy6vf//zwXj3i
ZX3Uhqv82edpYqziipplCFyS+95eVkL43oTvWQwlIeTrv4+FZ74roYLhS6620ASh+Pb87esc
7megZQ3fY9TB9XI8VJfrAunpFt9aebXm9qH9qy8f04tz7XGkwfpfr9cRDaxhCW2JYTGLtI87
OocnUHw9e6Yhc39TJgw2N2SS4fmWZhPRD99MkvnjoweKYxLxolIZEnIMenSdSbCN2WbliUrX
haJVcKMr1FC9UbciWobL2zLLGzKwmtwv1/RhfRaK6Qk6C9RNEAbXZcr03HqMy5MMvuyDnoEb
2RG2SEKorc4Mjmk3pI7lzUEi2qKmfRlzwWFdoQNQtK5fwvy60a1tEfZtdYwPvgcVJ8muvVnu
mNV4iLsutItpM/Tcty2ofAWn/HTayqidk/BnX4uQIPUsN+BdJ/ruklBktKbDv/qRambCTsnq
1oCrIZhwDjENbpNIfKlNBK6ZJR8QHd8UmI1MEz/NUYnyPD+lFSJFpdXjD9Bykx3OSUC+SSir
YtQc9TAgLaPCwolQrCtgW0qA1XWeyuyvCKHhaOsJr1IS8YXVtG1X8bG5bHAMS+Qkuq5j1xLx
Awiquk4dfj2jWc5nS5w2c3xKkYZ6UiLy4UDPQ6VKAFtWxE3qcZQO88d6+Hs2kxR85ThKpUpw
eP7xVULE88/VnX3pGJ148yAhMNwsCfmz59FiFdpE+HsAd5sP75IBGpe1/JjsmBsLgKLmfEdQ
De1ekQYrTFeLnvhgiExTHLtcIkSTiLdg0BpkkvWOTE5t/oKKvj2OrTh9smdFagdOTTGRVI/N
4C2EPq000N+ffzz/+oGPhNhYVspkM5u1fO8Bb6O+bi/G4qDuV0oy8VEu3+bAex9D9NYAwPvj
9fnNPdipJUahIcbGU++KEYUmYtRE7JMUll8Jij6CaNNywWa9XrD+xIBUmg+B6GIZWgEoM5gu
BCRR6bd/daYBg6Mz0o41vmxJj4MuUDb9UcLIryhucyzxFZRJhMwj7eDAnvhsbZogEzW+PX86
MjJ8z2gukfuqlNABy0ax2zDyRBUNYgisT+C5Kqy7P759wmSAIgeVPGS7EBYqIVBQl9YzUAaH
vCClBLAZcm5aWS3WOCJuJzJ3ZGBJmJcANKJ3uD2IgiiT4Bk/XSmJiOOyq6kPJeN2VUQcbLhA
jxJZ5Int55jvazhcYeInDfxhvX5o2f76wBwEUcjJRONhx6s3gewppQvt2DFp0MQeBOtwBgMg
JOdeskvOs27Tec6jg8iwVcFOZdfNaQZPMPLAbmpqlxmYMFv7vCYbZmZdqYgU4iWiBV3vghij
GOQ7M3zPY9gBqIXPFaLGnjNK6yYht0Zra7Hnf9w2+eiBttNUT06VCbOTHsRq0HbSmtVNfzjB
GQPVZ190eb8Xnnic6kvlC55CVNe29bwhjneu/5exK2mOG0fWf0XHmYiZZ+7LYQ4sklVii5sI
1mJdKqoldbdiZMtPlifsfz9IgCCxJFjjCNlWfknsSyaQyKSTGr2buT2IiDjSySal7YvNzuhi
eB+o6DASnbUOLYIups2+KnABlkGWmybuwlbIFdznqbGSVVQlpAJlW9RyFRiVhYJTXwhyOnhS
PIv3YYsQvGDwhhA1MWI83JiCn/Zvs1wvjHx2zgl0QdVIxwwi8XY7vWRgr95tVe7NSoa3Ryq2
toVq6z8TWWAzKhxq7nQNNjNa6oLltGPRpgCVreIXKJNrNebf+NEuKcKJMjszkzVleD0MMZYD
R91bF3qAvxUfPNn4vOqVELZznDtLmZZ8aNvavA1T6M6GtQfciT9cCOjzCZwpMDpEu/HC2ecC
/V31WD3m9Ke39WWP5cc+qYjYSJdpx+krX2h7pEQ+50OItblgoXuvfrMmQ3R5r1rl6Y+MtvtD
N6oPLwBm6VnyPIwQRXXoTp/NJMno+w+9+s5cxyzuMA02JT4X3U/rz8piJyjMyTVCnpy5i1iT
K2NO9OiwJyPzNcWjsZkH7rTc5rWGLPlAi7LTMfC9ryxmFOAhZLBVDMBb+pW8wAKRG3Nxe6Qf
rx8v316ff9IaQDlYJA+sMFSe2HD9lCZZ12UrO7KbEtUMtxaqYj0myPWYB74TmUCfZ2kYuDbg
p94AAA0luo5PaFOf8n5y6Sc8ha5VXP5+irQHCqpaIu2gj7VRves28gtlQaQlFy0Omc3aOQRQ
W1p7WmBvaMqU/tfb9w889KdSe+bq0Q8ttWdo5OslEt4hZWJTxKrbg4kK7+ksqVeJ4+pfUG0e
sycACDw9BmquLXOe4emJcJtsOnL2+EEWNH9FwjC11Zuike9oHVaRNNIG4qHKDELPbGeXqfnr
+8fzl5vfIdbdFDPob19o37z+unn+8vvz09Pz082nieufVNUEp6N/V+dODguHOTmKklS7loWb
1Bd2DSa1Lf60xogpwRZO+fgBsLIpD0ZH6KegckdvmnNVaavUXdnwiSbPwF5j6tidi0qjMwTx
YQLIcOef9I5slNewQOOKkei38iddkr9SKZ9Cn/h0ujxdvn1gEXRZu1QdnBnv9UW3qFtPK6ce
f4IVsdt043b/8HDuVCGQYmPWESqFapUaq/YznAjrgw/iiEwXq6wi3cdffIGaaiGNQvkJtHVR
0eYMHtebQTDCtGYG0uSj2xyb4NnD+uhmYYHV7wqLLbqkvC/O5fJV5+hFS4A2xeVD6lYcJVxS
abSjgx5x6yRhyOdTDBR+WtlXN83lOwyvxcWPeXfOXHOykwA1pezE3XbydyMqZphkM+J+BB2h
/qzXYS1aEa+jmP+Wik4DXvkIDntAlbf6JKc81tsSAOsmds51jZtLAAOcF6yl3vEJYykz1bqD
nz/VFupPmaecLM003akyIMIE1JIByd2E7ifyi1JGZgdo2qA4ySsiUE7w8kYjibVKoj18bu+b
/ry7R0Ym3YQNoZENOUmGQbxmsPLszdgf8Gn//vbx9vj2Og3b7/p39MdmO8J6dPYFggc8AJ6x
LiPv5Ghtpi4zM4npsHq9OcKfiMORwDh0mPJA+kbaym6J+osiOPPbLFJpsc4W8usLuO1fpiwk
ADL0kmSveiKkv5orBxfkeiLSMyVq+IxqyfA07Y6p70oGAmJ3IyhihkFasEnQmAvxJwQBvny8
vZuy5tjTIr49/hsp4Nif3TBJwDERczAj2+bxNwA3YMPUluOxG5jJNetDMmYNBMGUjfQuT08s
kizdj1lu3/9PsWtTcoJAEYnXW+xITF7dnEAcCRg1kxKpWjjGQkYStJzyuGEisCBhzI8RjyIW
urND2G6rCXbik2q419938u3OIlIx3Yo5I1bTkgISylRmSOMsehyPtfbl8u0bFUdZFoi+wL4E
7+82r448hKe2RXGtj+8sGrU4Zr3y6JlR4QIL7T6Gbkf4x3Gxswe5wrI4qKawG9ba8LY+FsYn
7J3kATsf4K25SSISn7TakazJwsKjA6bb7I0krfcnoidz+XCEEfWFnzc3+I/LbxXl1N6bs1rC
qM8/v9FJqAgZUxRWZoJnlHmiW+IHTSxtr4/A41kR6qUB6GBUT6/iRJ0CzqlFYkq9j12rTfA2
CY2eGfsq9xLXkRsNaRQ+NbaF2VhaswzVQ9di5sEM3hSxE3qJVoZNkYax2xwP+pzIUicMdaIm
VzHib1n7cB7RcBkM15UpPpJ7Pw18g5jEvt5IQAwjvSTQF3EU6h3HjM6MEiJGZGo3EJpSEhm9
Q8mp65jJcQC7eeL4fXMyUzvWkROYiR2bBPdmJNA0VWIKIeNgDhayOpk2Y3LS2xZChFTwCNDV
iwvHhhySIzAxaChynwekkI6ujcxnGW21UHQVdyM9A3ZFnbro9JNdiHFq7vtJoo+DviIdGYzG
Pg2ZGzj4psxT606jbpwkLtzMunA7aLJZr6OiDs/JIZ/p03m3G8pdNnaYQjiVNr/bK3vzETvj
Yhc15+ygSHz38MIw7/Edjn/BvMNb0yP7vq+lQ26ZqgeyUjDNZUwPjyMBX0h8TpxBNN/3Blkw
L0foVFzjVLQymwzUzM/nJOmbJEJNH0A2Bu+fsLE4kXIYKL7Oj57j4qbTgqUgXpxYQpnILLjJ
r8KCv5QSLAR1yCkqQdGlzYRfU4Uo0tnce1PsAyOLCbLcRsxlpZuE72Df08nqxtptmI0JW0hF
ZSrSA8tSdgHQb5PUUVx5CQh2DC9eSVS/F1/SZI218mU9+pHqsFAqjxuEcYxWWDBxn8DdxB2F
2Cs+KUGxw2GZUSzF3CkJFtqBgRuesK8ZZIm5I/N44XptgCf28Tkh8dCtFxOS5+HabPwgxsrJ
9+XVjxmL58bm2N5l+10JtzNeKl/CCHgYQ8f3zWE1jGkgiz2Cvs+J6zge2pxcrlpvhiJNU/T1
nLYasl/pllHopOmokuti3CCMe9tGjAunQJJF7Luyg/iFHrjKHaSCJEghF4bGdTwX/xYg7CJD
5YiwAgGQWlP18QVT5nFjbL5LHKkXOFjOY3xyHTznkTYfepsvcQT2jwP3WrEpT4SbL0kcaIhQ
BoRozsSPVwtN8jiy9OAJwoi3a0dUcyJgMYmUazz1aNLMyAA8JK4kWpDIQxsTop16aKABwaCp
KoJehXdULd1gaW7j0I9D3AqVczS568eJT9s6RxMYyVjux2ws1xLZ1aGb6GaLM+Q5FuOpmSeO
HEydk3DPrDY/nlCfjgrstrqNXH9tgFSbJpPDokv0vjyZ9N/yACkDlcYG18Pi4TIP+LsSKxxf
rPH9ROWJrc8VdD6CuplRuFKslGNOd08XBzwXGWwM8DxLvQIvWFsaGUeEjn4OrQ1/kCXoH7NI
AEROhBSWIW5qAaIEB9IYpftujNebY6ujDeLzKqEjFcDHSxhF2JBjABZomQH2smPd3+S9b9nn
xjwK8Vc9y+qc40GtRI82kY/2dGN56Ckx4KqrxHBl9jSr+ySFka6vmwSbIVQZQ6nY3GiSGK8x
KtxJMNLPlGppvjT0fEzEUjgCtFc5tDZF2zE/g2vapiKjHDplxvORKn9IeQFIHVTeanvmwmgl
V3ZumErzo280m9aJDyeDaOThgsIG3ONscbv3ecU/59ttj6RbtaTfDxDOCkUHP/SwSU0BcGGF
FacaehIGeDwhwULqKKGbMjYkPKq2I5IlW9/RMc0BMLja1xnaoZTFT7CVflpW0Wrw9dNZl/wo
k+dcXRcpC7YB8UULm2WABEGA7iKgLUfJmmjfn0q6JWAB7HsSUB0dXeEpFvpRjD+EFkz7vEgd
Z31pAx7vCs+p6EsqU6zyPNS0DmsN2x+bSTbSAHI7uuhEocCq9Elx/6flw3z1Q276ZRalpLJn
4CCrKwU810FXPwpFcEK1ll9D8iBuXGxRJeNI4hBdGknT0H11VU3JXS8pEheZZ1lB4sSzATEy
vjNakQTfeqs28xzM14LMcEJkVEr3Pdt2Hq9tGeNtk2Myxdj0LrbYMzraQQxZm4CUIXDwMlLE
4idAYgnRINKC4VBlURJlZokPY+L5aLbHxI9jH7UlkjgSF1EEAdADKMqQhz+ClTjQNmTIuoRD
WWq6Oo5rWhnnidodmoftPoZt/pny/m8iQfyKsYJ3z6gJ+8RUNuWwK1t4Qjo9nFgCrzo6s+Hv
XwAd5h9bgBCiB15XQ4xz1b5DcIiAirsO4kiX/flYEUwGwPi3WTXQRS3TbPcRTnjlezZCOmkf
XE/yfy0k8IF12Vk1MZPhpUQmDp7umUs/E1KdmMI5Q+ShA6ECZ7YCQYpqPqERFO1V4Uxuu2P2
udsrj35mkD8h4pGfeWhebELN7OAghJm1QHqOAQtzDXaqeLx8PP719PbnTf/+/PHy5fntx8fN
7u0/z+9f31TXVNPHEOGXpwwNjVREZaDzrP7XF6RKGlvbddhhkY29z5Q4ExibPEAFu1pjw1nQ
sjh023FOFLsP4UfASDfzsykLQAeTBGj3wvbcpnswM83pWaUJPFTVAEZoJjIZxKDlKI5oKWZ8
aMMxcpN1JtC+/dNprT5kBE8pLlK6rK6a2HUoVMi2ypHvOCXZTNQ5K25oAFT8UrO6y3RQ9F/X
3ZVqJjNpCUI7TSBfsDR0VmWeKJy4hf/n75fvz0/LqMov70/SxAEnDzmyHBQjt+gUd8pXkqEc
WDIEfDV2hFRKtG4iW2gzlrxiYesl1mWsLzjWVwyFh2pXEhAsljRIUXV6CgisUvlbNc1SbZM3
GZIKkDUmnh9EGUVKrXBgQ2TGiew2n5GncmkmuQwi2zoj2EsS+cMdeDXPmxZPFqmuuF5fHj/9
8ePrIxgnWl0yN9vCeJ4BtCwfkzQILT5kgIH4Mfp0RoCqaghTmRtoeZgexj7KRi+JHW3nYwg8
rGNW2oqzywW6rXP1PB4g5mrHQc9RGGxaOLEET73nnDDa9GpNyaOBN2/YWTyrL7sHP+nfsLXf
s5qESyz4LfvMEKql5FsHlluEnw9OsIs+lGSgZtcFtF02lmATS847YisdXJJoBgQS2XL4LnNg
Ld17kWfxg07h2yqiypDhW2vmoUo33d5JlWPaEIA0S8Ucre4pTXYQBQSS3+rlqu4JHlgYQGYD
lzedEoEPAN34DWjMEEW2OVyIIUKM9FEqTA3MMQpWAdZpZ5rMLVTZXG2hpj5CTQIfyThJHdxY
YMY9XHGb8RQ7mV7QxMh0jHw0yIwAU7OBynbruZsGHznlA3ubiYmdbPEETG0PzbJLQqjYib/5
A7DPtyGdqtgAZd/O9nUyUdgrqNnk4Rgm1oTuEifRkuEim0okZY5uDaQK4ui0EpMIeJrQctrJ
0LvPCR2q2CU3/1h+F5BtTqGj7wrZBvzY4MRu1PpDWH9y28OxeXl8f3t+fX78eH/7+vL4/Ya7
JKyEv1JU0gcW++0iQ40FXVgI/u85KqXWbKyBNsJzGd8PT+eR5PwKWkJ141lOS+IkMVKpm73e
rX1WNxl6UtGTyHVUmyFug+PiJ7McjG2LomlXu1BTB6EqhjyiAppNsETmVsFK3aZkcGOcmSGJ
VouculjhUtfDqeojdwXRXkFNGF37LSYt47EOHN+xxfmabIjRyXqsXS/21ydr3fihddmZjKS1
mmimzGzVOyWh0fB1l9+22S7DjOeYZMVt0zVxixPNBhQA0n45CeLas/hVhHZoQtfBLwkEbBnN
HNY3IhO2Dy4KB+jtwwT6riEqTbq8XQCcGJCWACR01j/lxuPyBtDdNnBc4SrG4DIyvRFQ95n5
Kw87wuZrL1PijQV5a1Y5L1I/wP2gsVMK0iPDWHZ4YFN2RNbIrd5M0k2TF4BHNTl09ZjJXiEW
BvA8s+eenMheeey28MzB7GWupXozH5XsdtoyhHOBpIg0ucYTOTGeD6h3CXp9I/EUoZ8mWG0m
Tc2SNNuFr9SAK4jr2WuK2IIgo1EB3QRV+mSeRfVDksgt4p40WIRihyKyYqYisl2Wgnjy3qIh
Ljoqszb0Qzwn9WRgoVekTn0nxCsN1+he7GK67MJEd4pIVWgljEofMb5/aUz4MiwzJTGqUqks
9oJQGQDXKjSmKxNglp2w7/m+uP495YniCE8AMwxHmUJ5o1Ugww5cQZMoWC8e44nQccd0q9Cz
p23b7vTyJZgpu84k65Maljj2QlDUu5L8dJygqgkqHid47hRKUnS6Nnnv0oa3FawPbY7rZaYk
sfiJV5mubgVNfx+n3rXlFvRei92xyuRhYqDKklq2lH67fyhxKwuJ6ZAkDj7mGJRYxjMDLW8T
JK4jbji7cLDnTfCk/gof05FXa2KozBKkPSJYEOI1feagCzpABF/rSdgkcWRpdlLvQte50uyG
FCZBVBV3ZAsABUoUB3ULBBY+Lh0uFkzoiyjm+fgA4BqghzacUCntWGJZZ1dei2hMrm+Z0kIJ
vZ4Eby1bEqlFwzDYrm2QB8sL/4Vj1iowRDwdFVhuUyzz5QRICOoQaIjR4dWe5iaTRQTb16RM
gAOtAwv6lVUtuc2K7qizKZkgGSgAEt/NYNwUw4E5NyNlXebKpdPkWODp5SLUhY9f32RPj1NV
swZ82y6FUdCszeqOKuAHGwM4dR2pbmDnGDJ4TWsBSTHYIOE/wIaz149yG86v740qS03x+PaO
RCE6VEXJ4q8aA6Fjb0IUt6XFYbOcRCiZKomzTA8vT89vQf3y9cdPEQBLz/UQ1NIqs9DU0wGJ
Dr1e0l5XNWPOkBUHqyckzsG1vaZqWeixdid78uIc476Vq8vybMrGoz9qEzGE3fNBxKZzTv9H
dPTYdkWp5bDZb8FLBEIt4OZwhwCHJqvrLpebHGtapaNnT05Lw2vzZ+ld6FTrRJXYhvJ+D+OO
Nz6/+n59vnx/hi/ZgPvr8sG8pjwzXytPZmmG5///8fz94ybjp6nlqS+HCqKcZ7XsE8xaC8ZU
vPz58nF5vRkPWO1ghDYNquIBxIOpy7zZiY6crIfAeP9yIxkqPrcZ3PSxAaOYVjG0BP+MhK48
Vdee644QcNWBrljAvq9LLF7gVGOkTvIaZlzssr6B9XZZBLhdy/Pvj5cvkmdbZXHmY5yNVaR5
gGNHuL9HidSEivsolul4cCL1CpB9XCcWF+Bz0udN2d5fYcnBafZa+agOX2WuWiQOFGNOtCuT
BSzHrrFHs+Q84Bi2r9Zz/60Ek5vfsPx/qz3HCTd5gZfgjqae2yNaTkxdW+X41fzC1GTDahee
myGFp4wZVsr2mMhnLwvQHUI3xYtOIR8/gNV4zpheuvD0We6p51YKFvuWc1yNCzVOWHhIqZnV
SlCb0hJYnu7qbOsDgdCeOm2whmQIOkLgr1C+B9YhW7EZiB1p6DzRWgJXqw1c6MszlcfVjugk
9D69VkzgyNEWuE+5Yygs3fHOca+NQMrkupbX6TIXXb4sThskrn0Lwa1Xq0KVRMtiM3b9gPl5
kjn2vRLfVIIOSajqKwt2yB0fPT+TWOj60eBfn6qBOzhHY2gtfA+5f9KWiP6YGwT9YF2QpSCO
uoQFa7e2nTwMfhTo2dGuPJYbpCLE89QDQLbLZV8vr29/wv4JTlYMz+487/4wUNSQOCey7sJM
BekeboqcMwjNUG0xfYcz3haUVU+ajdYIrvYaxR+AgoqdnVfw09MiKKgV1YXhvYPf20y9cPKo
CnkyazQBukyoC16WvJmgA4IGvogDPI7AsNkXO0tAsIWpsOiZpGEhyc5U/7OmsPFybzIq663x
y4AxI9rVoSRH/QOq+reL0vJ/X293qitoFxTcMOHtjw/m4fbp+Y+Xr1Q0fr88vbzhYxWqllUD
6T/rQ/82y+8G7DEAk9NI5Sk7y6RK5pUuJE7i9eXbxw+7Qjgew0T20iSo7KGwmcynyzwBEX+e
0yQoT9W+oeoPFagxIzGFqxsqc040J2QSFqPvIisCVrxPf/36/f3lSS2lPv7DRH7HOE3GLItd
PzAznwB9vmBcUWApozSnwQ414+6ejYmVHWLbNTYb8WxK2Y0BjFmh2bwqjHTnGzv7JO5H/LyZ
Y7hBItO+wEGiFS2KzVDRStg/L8d9D7HabK3Nz1uEOre6+gXyCdo0uA+zx2hNB/e0k7KFjpxg
MHpTNl2vbyYMAT0ftOoK0fU9SdlHPzQOCPjQCiIL+XwwNmB2NjH2ckJBvZw4cQNkguwM2bY8
53ll3+QWR5vGp/zBQU6XqAG/9DAZR0zImTY3zRfJtDjsjR7VvVbKVK0NZOQwKhaq0D7zIRBv
npWJo7YjUgc490Oamy8ITf4J7OBvYIRfkIUA9j5g0Dc/qajscHBJV+38qjEP1irF9ZBEhCNc
HIBTExYtJgqMDDx9AoFA2hWlcoKlHmxIi+Hl6+PL6+vl/Zft1CMbx4xZ6nKx6Afso0/Pj2/g
Tu8fN9/e3+hm+h08BoOP3y8vP5UkxETP9orV7kQusjjwDfGQktNE9iQ0kUuIYh0aDcTonsHe
kN4PHIOcE9+XDTYFlWrSIUatfS8zcqwPvudkVf5fyp5tyW1cx1/x09ZMbZ0aXSxb3q3zIEuy
zWndIlK+5MXVkziTrulLqtM5Z7JfvwAl2byASs7DTNoAxAsIggQJAkG4NnFdlsDyZPXpUMZL
PUbADR7Sd5fDUDbBkpeNe26C6Xs6r8XmDETqgP/cQMkxbTN+JTSHDvTaYgwPO5Sskd9Onp1F
JBkspLE1Ej04pMDz2NIhCF541v5oAA8Txz6gXsZk5LsevxaxGp/lCows7Q7AhQW8454fLC25
K+IFtGlhIeQK4Vts6MGEZSB9ImB+TAiH2DeR7/DyUijIJwlX/NLz7Cl4CGKb2eKwWnnWgEmo
xRyE2p3dN8ewj1ikyA2K470mrYQQLv2lJRNy7zjXIvsakqjUcnm+lk1tFgPaIVGhiOljDkWY
yaBgKt7SMAgO5+QcCFckOPKtvfIAds2BVRivqPuGAX8Xx8TObMfjwCM4e+WiwtmHJ9At/7o8
XZ7fZpjRxhq+rskWcy/0LUXaI+LQrscu87b6/NaTfHgBGtBo6KNIVouqaxkFO26pRWcJve2Y
tbO3b8+XV7NY3Ehg0BB/0OSjS7pB3y+uD18/XGBdfb68YIKmy+MXu7wrr5ehPa3KKNDCJvVQ
4p6OY57uhmWDD8243rvr72fA/dPl9R7k4RmWBNf5DaYjr/B2tLAFa8ciMrTm0M4S2ESYbxI+
td4hQeQ+R0H00lEu6ZZwRYe2qkdoZM3Jeh8s7N0HQqOVXTHCY3fFEk2s+wBfkmkMR3REtgGg
RHsBaq029V4P1HWjXdJQstwVAV0GkaWCALoMiDUM4AtHfNobwYTaxHIpPsTEGl3vVyTPViQf
/DCOrG3gni8WgbXslWJVep7VZwm2d68I9m0lDeDGCymwoMsWvh/YDAXE3nM4nykUoXvTg/i+
feYi13qh16RkyKSeoqrryvMlja2tyrqwrJ/292he2Wc70d0isdYCCbW0IEDnebq1FiiAR+tk
Q/SiZElDXUb36FzE+Z017jxKl2GpLUO0fpSqswAYlTJjXHCjmHweOK63y9Cea9lhtfQtwQNo
7C3P+7RUW6ZVL+vfPN5//ezU4Rk6WFqMxWcqejDEK3wxNzwuh4r1aq6x56fWti33FwttXbK+
UExRxCmHcUNJ6TEL4tjrc061exnYQjNqtc9023V0L+mH6dvXt5enh/+74MGfXLAJNw35BaaN
a8h85SoR2Kk+Jou/sdbAxsFqCqluaO1yl9oUNfCrOCZfcqpUeRItF76jColc0siSM89z1l6K
wPEM3CBaOPoucaETF6iGloHzQ0d/3gnf06MEq9ijdQFNEkVGwmEdO6fdQrUWHgsoI+KO9kvs
0vYt67HpfM5jz8UX3HUaL/EsiXG9yFMIN6nnWj0sMvJBqUkU/qBJjkdiCmH+E4zdpLAndIlT
HLd8AWU4GCu6ZKWtsPo8D/zIMQ2YWPlGvAEF24KSp+/TjDEPPV+/QiIJ35V+5gND5z9mmCRd
Q4fnpJamtJyq/r5e5Fnn5vXl+Q0+ueY0k4++vr6BMX7/+nH2y9f7NzAfHt4uv84+KaRDe/Dk
lYu1F69WoI91IAYHNIF7b+X9TQB9m3Lh+wTpArcsGhCn0/FowOI44yEGh3siO/VBpiT77xms
FGD3vb0+4PWio3tZe7zTSx/1chpkmdFAJmen3pYqjufLgAJemwegf/Cf4XV6DOa+ySwJDEKj
BhH6RqXvCxiRcEEBzdGLdj4epVoDBQuwPc4eNc6BLRFySCmJ8Cz+xngYYDHdQ390izRYGBKx
z7l/XJnfD3M5863m9qietXatUP7RpE9s2e4/X1DAJTVcJiNAckwpFhyWK4MOxNpqP2YiS8yq
e34tfVXExOyXn5F43sT4DvHJgh2tjgRLgg8ADAh5Cg0gTCxj+hRgv8Y+1Y+5UXV1FLbYgchH
hMiHkTGoGVsjE8s1DU4t8BLBJLSxoCtbvPoeGBMn2aw8U9rylFSZ4cKSINgJB15LQOd+boBb
UQRx6FHAgATi8Rah1oz2v898WNHQGbfOiHbEnip46aBynSKHUzY2Zb1nXEAKhKnuepWzHCtN
BIc6q5fXt8+zBAy4hw/3z7/dvbxe7p9n4jYFfkvlQpCJvbNlIGmB5xniV7eRH5gLEQJ9k6fr
FOwrU+sV20yEoVnoAI1I6CIxwQH6KNmzzDPUbtLFURBQsDN0m4Tv5wVRsH9VJYxnP69LVub4
wRyJaRUWeFyrQl8R/+s/qlekGOuJWnXn4fEqmoP/h1Lg7OX58fuwXfqtKQq9VDwAJZYO6BKo
WnJVkajVdTLwPB3d60cDevbp5bXfAFj7jnB1PP1ujHu13gWmiCBsZcEak/MSZrAEHyjPTZmT
QPPrHmhMOzRtQ1MyebwtLCkGoLm+JWINGzVTNcH8XiwiY+fHjmBfR4a4yh1/YMkSatbQaNSu
bjseGnMo4WktgtygzIu8ysfxSl+enl6elZgyv+RV5AWB/6v6SsK6MB/VoGdtgppAPbdwbcVl
3eLl5fEr5sQFQbk8vnyZPV/+rYm77sPTleXpvHEEcnDc8MtCtq/3Xz5j/BzCfyzZkkdo2+Sc
tOqVdw+Q3gnbppPvOW6ta7X3o71+Bpjqyjdeyijg/kTr9f7pMvvj26dPmBzdPNjaAJfLrNAS
oAOsqgXbnFSQarxtWFtiNvMzmFJUINcN+kOlWoEy9CssUcSLNWwC/LdhRdHmqY1I6+YElSUW
gpXJNl8XTP+EnzhdFiLIshBBl7Wp25xtq3Negc2oxTeWXRK7AUPzYA3/kF9CNaLIJ7+VvdC8
sJCp+SZv2zw7q/4fG5QZDOWW68SYjbBg253eI6TDCdpoDjaAEKyQ/ResukZq1ETnM5h9vRuo
OVVxOFjbdnqBTRmYv2FcNvUZs2vXVdUPj8qW9LTO24A+wgB0vdElQCyiSA8zsEGFxApgKn2c
IGWGCycS5qBP3cNh5U1eoR8dN+rjfiaf8ruKrPYMBpkus2X7xCgOQY4IOSPWcFsfwfRwM+3K
R4qKaOsjATqXMGfyinUliTxxwd51udHcAUu9WrxhtXtWbG6S5bU5JXrgRNd7vNpL4nPXE0oU
DHHy1cD+V5CDc4A0RUuczo4XUAN26xQDxF7rcRFx2j8FMck+2VJn6Ihjlkwyfg5ds0gi9cwR
KKZ5DQqQ0T7rgL87kS9CABNmesSkAXRO0jSnnoKPeCOSJs6+us7qmj5RRbSIF2QUCFReLcvy
yhSKpL2jyZsyNFUPLJuscnG45Gm30SdNlxX6RFuXMPxirnmxY6v7GEzmvMlhZlR16agQt/LB
0WTrAJVe8dvMMU9GooKV+oo+Imy+N7CQs4oJ+Nspf647HMRxNGOXWmW8XPraVRW5CZFrzPr+
w1+PD39+fgPrpEiz8QG45eIOuP71J/puMjUuPmKK+QYM2nkg9GQWElVyMMm3G/JllyQQ+zDy
3u31EmEZWQVqSvURGOpZ/xAssjqY0xE+EL3fboN5GCRU4g7Ejw61el1JycPFarNV/cGG/kSe
f7dR7zcQvjvGYbQ0m1aLMgyCiFqBrvrI5Ou1gBsF+r63jE6tO9I0h5L+uA9KRbLnRiQDoByM
xAAEnTPfxY0kyTBAjUc3RiIdictuVBO5l5WirtHGLJSMR6W+YDVQK7pxRRNH0XSlduynG24i
HogylEYyYaXofRR4y4IyV25E62zhe0uqY0mbHtOqcpRtDuygGH4w/RXrCJOWKLN+l5VaHIWi
3tZkDZZtdvuG112lNUtqpB3YNJb62THtXTT8vGW3Fm1ebcWOFCkgbJMD/VxzRxpPWPQw3cZ9
OP9y+YAHK/gB4SyBXyRzkafOJuBq3Im6m6RoO3qOSmxj6H8by+iIJxLPO/rVgUR2YI8VTvQ6
L+5YNYEWdXPe0LeCkoBt13k1RZHuwKg6TaAZ/JrA1y1PJjqf1p0RZlRDg+2WFMVE8fK+0o0G
5gmGQSjXXuRwD5N0J1jmuXsUQEq3ddUaiWs0krzkU2zMi8Q9TBjlpqZXyB5du3Hv73I3e7Z5
uWYtvWhI/KZ1V7st8KXehGzu6kLkd+7vxSIO3UML7Z6ec3cnN7e7FDSaY0OO+ENSCD3ljIbe
s/yAL/ndBWxPrcwi5CRg+KLJjRVu3O/JunWLrDiwajchK3d5xRko1ImmFanMSeXGO7YRPa6q
925xQ65PqlJpJ5UgNe7+lzA27UTzy+RkpdnQCNq8n4/uElja1pjlx01RV7A6TcycsisEm5bP
StCvLHtcy+iIMYit26l50yQVpp6C2ecepiavgMmOg5yeQCTFqXKvWQ3obdxSOPGgsHCYjDRo
Ok3LysRdRYt23MQkaes0TdxdgHVjik0cTICucjOZTy1L8pkhxktwU4g8cetGwOYFh11I7uYO
EWZC774jnKFUP22eVwmfWNp4mbTi9/o0WQWsfe65DAqS5xOqQOxAz7hZIHZtx0UJO88JVdPh
/u7cOM5uJEWweZ+37lYekqml8cBYWU/o2iODeeLEYsWT/Ht/ymDnN6Fp+jyD511HHw7IHVzR
uCso0yYIzGyQowMrsa8d80nR23AZScDeijeMHuSBHCxbsn6zmv7eNEiNuq/FAeq8M6sayrI+
GxFaBUq76l3K9JuAm3GD+BzxtysEI7cfRZHl3AhzYt21IPAaskNjU1c0UJgzZgz8WRnxm2Ws
hzbdnXcJP+/STMPoZEamKfllVYF6T/NzlR+GowetbuLlDw6XFYyvD7bRZzzDSw3GrdCPeiw0
RwdrsT0fdqCPC6IERK4LacxyYc4FtVMY0bED1VtlfbLMfwYqumf7TcJfvr7N0tsdaGZerEjG
L5ZHz7P4ez7i4O/saF0Snq23dKTwKwUxIiMcVrUq52TGjRuZdWR1FUirpRLa4v0fMO4sBIEV
AsWAgyVGfWu09dj0IVSgouHRu6Ol8uMNL+hGnpsm1e6UdOStg7okHLvA93YNEjlVDuON7y+O
Jo1CsQGJgnKoAZRpsQN/soJ6aKaToPshgR8GkwS8iP3pRrQxehmslpNEyEtMATdJwB0xbka8
jApQGhut6zQa0mCmj/dfybckcmKmpWMkYIeHG2VzFA4ZvSQjTugJmWRdFazR/zPrgz/VLV7W
fLx8QSeD2cvzjKeczf749jZbF3eo6848mz3dfx/dhe8fv77M/rjMni+Xj5eP/wuFXrSSdpfH
L9LF5QnjlD48f3oxuzdSUuxhT/d/Pjz/6YqrWGZp7MiKINFoaLg2qUDAqNwXqvrKKsfWSJYu
RzhrqYNlqbkPaahPUISch0yLQxjP+zfgzdNs+/htzFc049S+of800RMNXxH1hrjlMMnc8f3S
Hb4bzalz9lEjLNVXHArQ1phXBKZvbOsiV1cN7Jh9By/nNOfLwKgDd/D69dMNKlN+1BM9Hsjc
h/8KUc88qnIMCJUmaxeyvQvR6ZfC9Wd/JCrdhXOfxMhFfJcn1iI+4DHycX87mePeaLpXsHn1
zXiTI6o/UTuXVjDBgSAvm5y6jFZINiJjwLnaUcKewdZ7ugTWJO/I5jFLpY3NyrY/0fGRCgws
svhN7Ad2mL8bMgpdq/IoVPLGlW56c6DhXeeo8C4/8QZ2wE3mmoA6oauYglOxvVSKes1A1lOX
cJWpAHsvdOuJkQ4PDn5IVPPlknz/aBBpEV5U3LGzt/8Drkr2pWlyDKimCELPig05IGvBFjH5
qlwhepcmHT1r3nVJgQaIo3TepE18dMXgHImSDa1LEHFuErD3MhrP8hasddbC3FdDXqskp3Jd
u/Sl+IF0SAem38FMcHx/BEVYuzYio/o6OEalbvSc7yqqrJgWHNr4LHV8d0Tj/ly6hPnA+G5d
k14RKsd45+uP/dThFtTTN4Wga7JlvPGWIS3BWuJgXP10i5BcBvOSLYwonQAKjCUmyTrRWfFa
eb7nTqVd5Nta4LmzXlJhLt/jypCelukiNHF48mmJP8usE2XVWsBlAu9XjC7gtVsGmwU0NJUC
JfxcbsD4SbhId0nriEsne8zAYF3vty7FWVgGimgTsNv3bN1i3ga3EVQfkrZlExS4rXeabjwX
/b5/w46i0/MH9nskvFfeOK5WgeAEHzktw/eSrUdrAUMLFf4NIv/osvF3nKX4RxjZOnLEzRce
5ewh+YkhbGHA5Mthbh7N7JKawxqlSnzz+fvXhw/3j7Pi/jvlKC2NmJ3iq1v1UUPPxzRne7OF
eIRz3q8dJ4Lj5jM0c6QqB2aO9hjVJGaM1AEpTo0eWkcCziJtaHurR++ykHOMduQqcUhQImNd
XTknvn+5/CPtHy5+ebz8fXn9Lbsov2b83w9vHz5TJ319oRgkv2EhDrYXmYu6wpL/tCKzhcnj
2+X1+f7tMitfPhIOtn1rsuacFKLU8jL0mN7JVMFSrXNUoooRmhpnfmBCTS9dltp4NYeW5+9A
ozqyEg/4CVsKvjyvizqlbUoZILBLyP0pfjlMGiXiYB908IeHafix4TuLIJ7tUkaAzhiME6wE
zmvVU/qGb8zPwESqdwO7bOpCbDStf0OB5Zm0CXfciOp08lbHwZkblVj5VBsAleNfzmbsigN9
kqNRgR1c8h2ZH+dKdgunaaE2+G/o0Y0oWbHOk841+D2Rfj6L8MOauxuOG05HNh6UJ7YpzxNf
O3LCy8b0I54a4pGul1pCXgDtZcocSzT2HT6X1GEdtweog36zBcxORyJYFL48QVcFMzCu2qx3
O/0cFYE7/s41z2q+Y+vEFvNS3NFjd8yrmnrNoAhPKTOSE98m5SKiVswyLznsX/UaB5jt7T3E
P3l6ef3O3x4+/EWF4Ry+7SppLMA+rVMdZUvetHWvnVTgFWLV8GO1M9YoBa3UAloMmN/lIVt1
DuMj2c82WrlCGYwUk6OPNyywUVSqxl9m3p8brM8NZGDWLe63KtzX7g64Uam20srqw/jkpGOa
/HDClVLikyr0gmiVGPUlPFzMI+19RA8/BJ5Pnyj27UzLRUhGKLmh1WhVfbcxsaoJaz0Pn2zO
rSbkhR8FXkg/VJEUMnG1Z30owfRQjviFI2rFFb8KaHeEK4FHesdKdJ9I0WoWdH4VkWGuJFq/
9evrwYTuNmMQHDnLKZookjkv9YwBV5waufwGDAngIiCqjiOPyv0xYrVk8yMwVo9kb7zQU8qr
cMkMVy1Is1Cz70romBBbJKIzp5uZrncApn4w514cmW07lAZETRxtTIMsiD33UIgwWpmctZKO
SqhIE0xwaEKLNFoZSRj6Qobsr24ZHVOrTs2d6G+jvjuRBQs166mEMh76myL0V3Y7BlRA5DO4
KSt5qfLH48PzX7/4fW6EdrueDc5j354/4s7ddlGY/XLzHfnVUndrNPCoMx6J5Sd8+2ZzrTi2
5LGDxGKObqPnGMBrfVL9ofthYcC+jrjhv6kPyjn8iu3jQWol3nJm6oXxbRn6usPplbvi9eHP
P6m1AH3GtnRk8X6vzdasYPrLKwb/r2AnUlH73hwmC+x3a7ze52nbKX4HEmU5QLQiBRNce82K
ICuv2BWblYnLOwFQ625juyTwU5XiE1RldPhBQhVrv/9YbUcPOZf1Ph/e37oahGQ8LzZoCzlb
jUS7PDFdc8akbXrbr6PQHYkDpV02ny8dSYcwcjOZkZaVW3wezthwQHYrTfiLu5Ca/03SyjuH
Jqly5dZe/hyR//QMcFtLVkeKCSoR/RYF9kicJ47zLzwaw0cy6wLsGio3iUqgzScFYXlyqq24
dWL4QpEAzZcGrM2UbXRAg0lCt3nF2nfaMQ5G0Md4/j2KOmdC21U/ZkEQqJG05hTjZW34rOz6
7kBBVLk4Gg1rO87N0svNIqC28PgCjgrp3wr93quHwHhVHTlY+6yhzij38pKU1aJQH9MPN8Qa
DZasVSihFXlM1ePw3t7+Aj1v+ehzVeTbJD1ZqqF8+PD68vXl09ts9/3L5f8Zu7LmtnFl/Vdc
ebq3anJjrZYf8gCBkMSIm0nKlv3C8tiaRBVvJdl1JufX326AILE0lDzMOOqviX3pBhrdh8/X
Z99l8EjzqKnzLnyaVRdpWYrb+cZq9pYEWj2104PEsVSPufUQzPEtgfvbPRTpqMqmSq418Z1o
1vOvw/Px7AQb7Owm57nDmsYV9wdCC87zLPKI9gFpS9TrgDkbFRJX7EToCv05mkcFCjEbTia2
wtsCLIL/3bCar6J8SeQscYZJD2h/sT6f9VCUgM0rcQI2wxv5sBPg0mMY/mEph8OTpRwNhifh
iekr0Ie3Zty0Dk6wB6ZDM7CEjV1sR8HvZoPpmKy5RC8HZOxFj4nK+hqxgXWy42JkY2hsdAKj
i9yiU0rLtJkaKyCIxtIi4YhAH9KDWjIUfDiansano5N4PKQr0MEjWnJo+eBXLbiuRriuEQOV
yLUF1Fgd0MY1fpvJk6zBOTHklrAsrQpiYYQdbUvVLOaFej1xqloRu5rnrIwC/ixarm8l3bZr
ge/GWsM0p72kOS20BrEEdBhR6haLaFM8iymNSOtPhydifotJD6RE5qnABjmVcxY308mQ0k5M
BqL7kD49p+kXND1h84KT7Z7JDSKyJRMLS2PabqNlKutoQl5TtXg1HfoLexqbmlyfHchDPI2I
ohQ85fEfbHbSbM0PitXNmssZ6Zq2LwEkMHXiuvZJR4EHoxYHXkGfLCDwVPEy9QfTdbqeUfMV
dml/5OPWTe/nlZ/yWv1VemB41Ty1YvryEi5PwcEW6F2KXOab1gePoaEms8HlkJaLAYSK0NDs
YhD8qoJxSns5Vg4cJr5uX73t7n9+vKHfruPr0+7s+LbbPfwwhdkAhyOSKh+8+vD4+PrQPNgu
4t1D9DbESTW/jqu4N6JnL4+H1/2j5f6qJbk5yrXYOsSoRbOMUth86UG8rJpFsWTot4q+Ks/i
6raqCkYZ6KkDmIYn62abZFv8x81daQi46LNk4forAUrDlulgOB2vQa0k0m2Z5tF0OhqbZzUt
gD4gxudz17lOB13Q91wGy2QUcOjVMVxEROroGGMwDXlnaRlGw3OvxIruuqPpEDKuh8UwIJMc
zwaBJMez6ak2KHg0m4wpPbZlKNlsdkGVt5pG50NGyZc9w2AwpMpViQJmI2X1phlWg4EdHFsD
VTQYzuggMAbLiHR+YjFMvXaU9BFZXkQmp6paX1yMJqWfJNBnl9dEkrDk3SbkcwnNkGAYJX/I
b/hgOqAKCcAFeSOg8SKCLy+IJG+kY4e8tubnuoLUqNGolXBcKawAnBrQ3vIozZ12AaFRz9NV
B+T0q9Aezwv0vXEi7aI1ZPO+ddxVOKg2+6K+VBFQI7RGos7D4vFopFfu5f3x5+6d8l/oIPrr
bZw0bBtX0oWc0WOxSCLM24rWvUrxWhHLVDVz89IFXZS0iNQ7yjxJ7FbAT+WRYhYI8byG7Z8W
6a+Spd3HeRItYvJscMWuBW4Kxv6frPFhCHTcemPcRGpGdNJUsNKWEtstxhHO9MbjO8rpuQBe
VRE1PIwE1EXNbErliSAspZNA3iVIbtSZsMFSxRO1eFPfI0iuLzbPYEyWDZBxELlw1RON8YiL
i3PK/Z/DdDmckIlz6Ui14UWoUsO0qOgDCEDrm2R6Pj4nU7Yu/gz6NadLMo8uBjNHctbYIt7C
FLUfk65uqiLOTBMH/vT68POsev04POyom31psYBvXmBa19OxI35q16xUIjrPlMXJ3PRE2IWV
TVfWMS1aNpSsSYGZNoJQCXnWpP0FElR+o2+CPJm23D2/vu8woqcvdpYCn17DcmCFfyW+UCm9
PR+/E4kUaWVL80iQ9wHEUFCgdIa1xJvEvn1cBAl+suoUnewOu3ydgIw+kNAkXnc99NfL483+
sDOcxSog52f/U/06vu+ez/KXM/5j//a/KOA/7P/ZPxiGL0o0f356/Q7k6pVb40eL6QSsvkON
4TH4mY8qJ3KH1/vHh9fn0Hckrt7tbYsvi8Nud3y4B3Xl6vUQX3mJ6PV9E3PeiGwZcBRYJc1y
U1sREn+Xukx+/3/pNlRwD5Pg1cf9E9QmWF0S7zucq0c98ovt/mn/8q+TUL/nyojSfGPWifqi
U//+aIgYN3UpbtyLUlC3WGJb817XE/++g1KpH3tGfvcodugGBhsTtT+3DK7/s5YMG9pgPLmg
Q5f2PKPRhI5d2rN41g0kz2xMaUstR1FnGGq2n/wtvaxnlxcj5tGrdDIxI8+2ZG3wbVYXg7sH
vF3F5PFrVhunJPADY1qZCSIpjqgzHkSUNXFtX0YiABvOssgzyugB4TrPEzvbQpQLryDOFZH8
smRZ5d4QXaci4NzA2lvhB5poLKzTMiR6poYWyupUJM0K9BeOv+lc5AKxqFM3aWlLRd6GAyhN
ikxDIFnCOi265RpvgDH6m+8rAxDcoe29FPZ/Tu4OXjrGuChAlQg0XynwoQYtSytsXvK0gn6B
Xzzg500x4jtsWEIp7UMx1HFvP6Pe/oKiUX38fZQLTl/x9hbbfhVhEGWM1yay4DlPm3WeMfn6
o/2y7yb4prVohoFZliKjJQ2TLwpoQQaLeo4WyqhiScC1DXLhYIrT7Sy9whIHMkpB1kus2lpp
FFvWDGdZKp+tBHPquLBlglwpK4pVnokmjdLplNSPkC3nIsnxwKOMhLVT2l1ppI1qquPLol/L
eODckwWft4w9AdA8RNTTJIvKPODnpTtg7E8S43l2HcUpNe8jZki4GaxCqfPTX25acpHCaI+Y
7/d/dXP2frh/wCf9xMMVWBsoWxw5teqVmY+muUbDPoPj29KF02pDpxu4IOsYiEVV+8zx69iJ
WcXS2P9a5aAom9YRAaE59KDUMeizMki1SZdl903lGv4HWfk15Wil42qFKEjNOLXQYMzF+LzF
/AxSxlfbfBh4giDZ1JGL1x4gUYk74aFtWaBBIsHzTZGY14syvVIsrUem+YKmS2K0SHxKwxYb
gurc2y7Ih9byUhVKte0DjZqvqHxr/s22YdHy4nJoDImWWA3G5n0MUj1RCGipd5+nzXKIjI1p
FueUlXWVxKljo4MkpbXxuqS3P+mAhKuQCOTxg3MRDEIEvqOOIluqSnNXAda2frbMrEI77PF2
Rq625j0LS+KI1QL6B+1sLLtTIMXtA45eyhw29uLVkpotq2tKvQV8pD6xCbDOVzE6jU+c1CRY
Cb4p45raT4Fl7CY4dhN0IJ2ck9U4GD7g2zyyLM7xdzjWQNWkcw5T11qLShFDawK2oKSobxKw
sjCrQI6ab4GGsRjCcqv8vGZ1jC9IqDJtdZmM31ebvGY2iWhnJJs2t/g7zzDGjGujayB4vmn7
rEDwhpX0s7jtycotF9XQaekOy7kPaiGwLr2O0LTf9EbHBv0OwjJO6WWwZzrmcgO6G8uAr/Fs
eS1ex0ZPEVkFQ6omC1uKRXMN8u6CmjNZnKgmsFbkoTc4O+wOBLvQ0MXCmUJOaOqhRmbPU0VR
T6saO9RNnIgGyZb5YgpiGV493Lq4sas0IDqXt4Xr17bHsVGcyB6aeGpGtxzzTQw7FPRZvMwY
vko3C111QZO6tCPfjrtb8yXi2PYvmJ+GnHNkt0gEDVjlcaDcRRaMU2dTkpPXRoegp7pFZS+d
iuaOCyhhcCpBsyTs1oGVOHr/8MOKM1V5S2JLkqsQnb7mWMEilS9LRom2mkfPEO/jfP4N9tUG
PffRlyHIhSOKNpRvK6IqFX0u8/RLdB3J/dPbPuMqvwTlx2rUb3kSC2uS3gEbOZU20UI3vs6c
zlC9PsirLwtWfxFb/D9opHaRerGgAs5QD17Dt/S8lsk6OytStMFvnOMJNqjlXz99vP8z+2Se
7hAriRZFThVa6fTH3cfj69k/VPviSbwzPCVp7bogM0E8MjBHviQWDJ8G5LDy5qUD8VWcRKDi
9+S1KDOzIbTK1v6s08IukyTQ+4XFIYUkY30T6aJ16G7d8+Gfflpqfdlvpi4dtLOWA/q2qoX5
4jQv8UmEs6+ziCY0peGFiS28hUHIhZYePCsnSfiNXmgt2twtiCS4G52fbViG6jY1h9Imem4K
Py1yA8s6gItFwMOvYqw2acoCh6ZdUp7I67CACiDdwsDW1PryCdfizjJNU7SyViF9+tOMeRxq
Cw5rpd1siqI2W8cdrs2R1oaZUgVqRrWyxn5LUXuwt6bbcBSXtErTsaEemhYN+ntP6IRajrC9
LcmJp8W8oE3fug/CPdax3DmmdS6e3I3JUid31FF6n/Md0aJ3FdX0zVi6jJzL2+s7QTCIdC5s
l1d9L5RsmYqsbtqdFhMYGav/NjSA0jiDxcvs+Dz1puKqCIuMV9l2fBKdhrIu+5wsCtqziKiZ
33aP8XvlymGAMUyfC7oJ5eTJlmLDaHO2H4AC3WwK9zfuiAnqzHqCewwwGE6BYxPsN7YOXvGO
gT5+VZyz8fCP+HCYkYw2W7DAbnW1REAWPvfYThXNbAuKny5hV4BPj7t/nu7fd588Runmkigg
XpmHM4AFkfgGZiI1tW+ra2d6bMLjX5R5aPiDOH+Tl2t6A8+cmYG/r4fOb+uBv6IExBAJjmU0
XYNS3QSO2xV7Q0fokw6es0B9VbnlIhTEUc9Qr+lAbSJbpmVCcUwkyGRXPIor9DIKYnRhvPs1
86Bt7UBlwu0izo0VVG6Tzk9sKitD15NBtclK09Rb/W6WVWU2cUsNH15wUawC2zps+GZS+Fup
T6QVP6IsSfIb0A3lSZFuYEswQK4bwdDKCD2509FAJNemwFBFYTx06CdBTz/rqfStUo9jYOZC
uu48wfgH5Ts1AnkesdBsZeGJfFkEZnFiDs7EWKP2x9fZbHL5efDJhCF7IXWS8ejC/rBDLkZW
cD8bu6CNEiym2YS6lXNYhsE8ZgHDB4eJesFjs5g+NxxkEESGQWQURMZBZBJEpuH6T2kza4vp
ckQZENosk1D9L0ehWl6OL8PluhgHyxVXOQ62hrLFtBIZDIOlAmjgZi7f9QfS1Hk6fanJQ5o8
crPQAGWKb+KT0IehjtC4N5s0EO7mrmqUuYbFMKZrOXAG3jqPZ03pFkRSad0F4ZRxFFHJyOEa
5wKUIG5npuhZLTZlTiBlzmorCEmH3JZxklCpLZmg6aUQa58cc/RhGhFAtolrtxW6atIx0jVL
vSnXsemtCoFNvbC8ckdJwJt/FnMnrECLxHlzc2UeuFgXZsoecvfwcdi///IdgOBWZWaPv5tS
XG3Qn2l4D2rDl6C+Bl+UoBNTW0uNQYlEpDPREqU69+7pZuZNtMIA5ireG5WmvkdCvxKVNLep
y9h2cn3iDk5D1okPGq6vWBmJDMq0ka4nilspjnD3/YDHRh3zgjSH5+VVvilNv4LyCovLL9H3
pYps/xu4KVi9+vrpy/Hv/cuXj+Pu8Pz6uPv8Y/f0tjt0u7I+5+ybhhkjPanSr5/QvPnx9T8v
f/26f77/6+n1/vFt//LX8f6fHRR8//jX/uV99x1HyCc1YNa7w8vu6ezH/eFx94K2Df3AMfzK
ne1f9u/7+6f9f+8RNU6XMUYzVIivmyzPLHVGQqCwyubtih6I6qSZ0UggyKtvwekiaThco84i
1J0kujbbvFT6tXnyKD3ncEvJVrRUpLy4dalb8/BWkYorl1KyOJrCkOa58UJEThZcBdVJ+eHX
2/vr2QOG13g9nKmR0De8YobGXTLTisMiD326YBFJ9FmrNY+LlfXW2wb8T1aWhz6D6LOWlg+Q
jkYyGsq8U/BgSVio8Oui8LmB6KeAmrzPCks/yB9+ui3dklRbCOc5ebRpftgpivLK1Ut+uRgM
Z+km8YBsk9BEqiTyD6Vv6jpv6pXIOPFlwCt2iyrzcz1wi4+/n/YPn3/ufp09yDH8HYMd//KG
blkxIqeIOvzS+XDu1VXwyB9zgpcRmTosm9diOJkMLHlKmdx9vP/YvbzvH+7fd49n4kWWHVaH
s//s33+csePx9WEvoej+/d6rDOep32kEja9gp2XD8yJPbvEFJDEZl3EFne1PO3EVe4sF1HTF
YO281o0/l89bcO84+mWcU13LF9RhsgZrf6hzYnwKPieSTkraE3oL56dyLujSbgO3snomi9ub
kgwypqfGKtzy6Dup3vh9hvcjXQOv7o8/Qu2bMn98rijiVlXOJl4rTnWPuv++O777OZR8NPS/
lGQ/ky25Hs8TthZDqrsUQl/d6HzqwXlkugTTQ53MKtjUaTQmaBTfBCOiEWVNYxj40o6YNhLW
a0yKT5HDNUJ8ek6kD8BwQr6763Dr5biepCs2IIltNTwAMqHIkwGxIa/YiChplVKKnwZrkKfm
ub/X1stycOnncVOonJUEsn/7YZk2dktURZQDqHQsEo1nm3nsrxys5P5YABnsZhGTg1cB/TGn
t5yxVIBiSHll6zhQ4Ql/X9XUu3QDnhKfRYGItC28kH/Dya5X7I6QzCqWVIwYZnoXITYJEVFj
RJSF8z7AHUR+J9SC+bSbnOyXlt43qxpAr89vh93xaGkMXYPJGxsvpeQuJyowG5OHyfqTMfGJ
vKQKf9RebKpHkvcvj6/PZ9nH89+7w9ly97I7aDXHG+VZFTe8KMk3Qrpq5XypHfsRSLsjeCNI
YrTbRpOF2pIR8IjfYvQYIPARTHFLZIhyaQNawokDdodRS/5/xFwGgkS7fKh9hKuMZUNvq65a
9LT/+3APSuDh9eN9/0Jsxkk8bxcqgq7WHG/EAPTbPRCZ1PQzHFNSKSmmU00guUiB1OfDlynP
BF1vsSBN4z364BTL6fJqtt+W2JFgT5c7sMWtbvwxLK5xkxybT8RXN6ApZ1GeeojxkXroFg/J
SdXhoDucmFgdG5b3fOwvfMjhuwc1QPTcv+UicNPT83EOO/LvmFia5MuYN8stdUPKqtsUY7UB
A56jYbgV63xBg8VmnrQ81WYeZKuLlObZTs4vGy7wjCvmeLveWd/3p4NrXs0wXOk14piK4iEr
qDPyWYzULrRzXM/WX6Ey/JKKRtTS0e4VHXwIZd8jLYyxvIZPJr47vONrX9DfjtK/9nH//eX+
/eOwO3v4sXv4uX/5bnpKxgtu80iztEx+fbz6+skwNWxxsa3xIU7ffLRRj4B/RKy8dfOjr/Mx
4T7mc6hoRlRoXD5l8GhZQm3B+QfNofxmB1dZdYBlHmxpSjMXGYc9rjQO29GYnpWNtPSzDUqY
tJcmKjuPQXRFH3HGgNTPJUGqzXhx2yzKPHWMlU2WRGQBNBN1s6njxHFAV0YBbQIGeCqabJPO
ac926hCbJX5OhQzaY71QAS0KVoG4ts6zuOVaFTh8RYs3cb1p7K9stQ9+di647WVKIrAYiPkt
rQ0ZDGPiU1behEaw4oDuotOdusnRF4MAkE7g47mv83LjcMRVctV2YbdDC6HZHIoStth5p3ZX
h0pbRyFVGfS59DHJPSa5LVsnh0zxb+8a51GVojTbgNewFpavVAt6QLcsMZtSV5ktysxQ6j2t
XsE8IIqDbueoPbaF5/wb8VHgYLFvh2Z5FxuTxwDmAAxJROkQzkw0b3n0YAFtqanyJLcsZkwq
XmHNAhBkaECsqnIewzpwLaCRSmZsUDBCcQ0wn9kqkvQrb60NSI9Mt5OZzFH6zm9gPVvWKwdD
AJKQl0rm/l7ylcRYFJVN3UzH89iYC4hA+RMmLdFWUk0wtpEb7bq8v6zEpIo4+BylWiaqhY2J
Kh8dda9SjMyvzIUyyef2L2LqZoltld71qQyyYPmcTe6amhkpxuUVirZGjmlhO9mM4tT6DT8W
kZF5HkfyqSlsKUanLvKs9iM5SOrsX3MxlyR8xQLVEtxsZXxIbjqUkH2GI6DAx9bWtU4HAVIK
7G8c7AwSTqB9Cb6NCl3RLBKM3dVaROuMYShYow4vVrOlvXW0ooInAdiXhlp0ktS3w/7l/ecZ
KNNnj8+743f/DlrGtceoU7bReEtGQyn6qkTZSqKHuQRkgqS7ELoIclxt8IHLuOvzVqb0Uhgb
Q/w2YxiyI2wEZ3E0gfcdKlgvcImyBHZz3MvP4D8Qa+Z5ZcVEDLZdd5Cyf9p9ft8/tyLaUbI+
KPrBb2mVV6s4ezQYz9GG20dFBqoXUkFbLBucVZHEtPWswRTdsHJBb/vLaI7PL+OCfGYoMnkl
lm7wwA5XE2NWldC08iXm18H5cGyO5ALWYnRhYNqoloJFMi2AzEqvgA4iHdoi1o6ZnlUPENNR
wsNnLCmzIlG6iCwTvh+99Rt3kZdctHaNomy8twBaPP/T3lZeC/G4av+g5+T/V3Ysu43bwF8J
9tQCRZAAxd56kGUqVi1LXj1i716ENCsExWITI7Hb/fzOg5LI4VDZ3hLOeERR5Lw4j/Xw1+Xp
Ca+98+e38+vl+/B8drPTE7QrwU6oHdXdGZzu3nnt/7j5cathcSdkncLYghlDS7Dd4ocP/loG
ERnEtLawFdwVw/8123dicKsmsXmq2N4hcTk8wVxijNzqN0MMXGHJsUbQoLQlOSaeKR5CDHkX
K8ZC1ishql/+p76lv5oceCwPuZ23G8ExEXPYMbJEsFNN2XiFFJgGQoVIF4DxgGrB9ki6OpS6
nU/mfZU3VemZr/54X1Y2DzmK8cXUAX/j1MomMqzaRz5GJhw0KhKKML9+uQ/HcPl3idRpRxwo
ToYzhsZqC+8SFN/jVjCxwlWM6OjZPQRaRQFcSa7Ze+OojZAOw0k8tx9vbm7km0y4UU3fw5pC
f7IsXJUJC9UpkBtqDJ59VwpJ6lDou3QaECNrCzTlmqXKEpthavfwmnctMcRgUvd6FJ/84U88
JK/bLgmOcmSYS6ZR3JT6TekdMRc6K6qD/HEEmKY0nS32/Q3bLvEw/RR2lozGmtmLXINmIxpC
8Q034l9VL6e3366Kl8dvlxMLuc3D85OrMQIDSDEwrPKS8b1hrBDSOb5vDODq9vD0Fg6Fa+81
VdaGwGm6WCwZbNhk5yLSkzT/VBTZTsc7CfiwftMBy2qTRttwh09qKx+SF0xcFRjLq8gRoaBB
fL1QG9hQAvB5EPmtPOjrjjRGWR2u1qrRlp8fOeXWmL1w87F/EYNVZin3y9vp72cMYIG3+X45
Dz8G+GM4P15fX/86z5lKMxBtKqKvZNXsa2xXZ2sxaF4lpIAvI88FmuNda44mEB9OLVr/GOro
hwNDgOdWB4rsDPhGfWjMTtN6GUxzFOKX82T3IS0LiBIbmxEWxuzlVO0y8QXf2L/PfQTNBI4K
GvExLj6/r2ZD/o+vPCvywGZaTIOa50uaNSwJ9kk2Zg17lL19iqBggbjAmC0GGAYgUBoTYU/f
WA/7+nB+uEIF7BF95IGVRf51qSPZQckLte3IICqykQulgoR72a+TNkF7s+6CKiKCFURmLOeR
ggEIOiro6WGVDNBKNFbh7gDHsAIVBotg9lKnQkBs0/hItV4eBGHmk5ujNZYM9uYn3wwYKZtZ
tWJg+YY4bWxQf/HKTdvU6BIu089tJWufZ13JRh/NvY5B78De2Og4oychE1ucCdBgvyOtj4KE
3S4dhIL1I/AkECbow2UrjarU/pCpzED8RYRtZsGnmPUm7DJjNG7lKDFUIzC36X1zH+7Ty7/D
6+lRNUAw59AGvh5MXft1L/JyDC0H3gYs9OPv7u/MDrsMszbnRSRWa7w7BFkqfFrzW2K9cZDW
mimA5VvZPTaBNQMGno+ORRT9YPs2WylCj55H+cjuYhHEzKPw9g0IglXxWcfv66rHLAHBYO78
e9gVdnGiqrb6/RWuV1IXSjkhD2ffYlajyl7Cr+h6Atvh7Yy8HXWP9OWf4fXhaXCjZ7ZdGfET
jWyvp88PWsef7FBRkW2VFw1HbsetH1rPmi0osDDMp6b34woRX+NCcHjw7g83AjcJ8vt1Ftt1
qxsArLrhJWwjSrz7KLu8pJa4cYzo71ejjKS9usBmVxgGuAB3rzXiJevRBAXdtl8mZk3WyMkZ
Pfbq4XNzI6L0aUk25hjuVG/N2KXNuTV6aN6I16R7vYoKhxoARqvWVSQwcSnnmpYGJ/+6TwqG
qTXIgmeokwVeXeiR7pXi8NGgi2PUeFkamKNiaWPRYATNI636eLdvF44CvH0l+z678PsdabsL
i4MRYzITSzxjny0AMSpiU5F/5F5nL3m5xnnOIQxxamMDnYWtRTWeFt5nbYqlz2nTxKIp5oTk
+QgWmIzZpQns1tg2JjFrfQnBL/MY7wZYeEz9LCxdMASpWnyP9B/jJlpVVPgBAA==

--Nq2Wo0NMKNjxTN9z--
