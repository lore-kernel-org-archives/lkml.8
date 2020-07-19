Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14CBC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 03:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D78205CB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 03:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgGSDta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 23:49:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:18566 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgGSDt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 23:49:29 -0400
IronPort-SDR: 4UxoTfvTPgW913YXJBN19bq1CGVuo8VmAZEtQ5SBYScSzR9OoXCw7VKgM+xrHL3CP51POilu6N
 3aUR8fcYAAMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="129860771"
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800"; 
   d="gz'50?scan'50,208,50";a="129860771"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 19:36:12 -0700
IronPort-SDR: fUQeSI3h4bNrrMJwYLKuPtKzPjj0rZCKo3Ydd/d6q8M+GRT4WnARbs/pTcBwxc/tfJnziIeV2P
 Kx+USGritEDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800"; 
   d="gz'50?scan'50,208,50";a="486855323"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2020 19:36:10 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwzBS-00011P-Bw; Sun, 19 Jul 2020 02:36:10 +0000
Date:   Sun, 19 Jul 2020 10:35:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/powermac/setup.c:215:25: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202007191049.4vkJocE8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f932d58abc38c898d7d3fe635ecb2b821a256f54
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 weeks ago
config: powerpc64-randconfig-s031-20200719 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   arch/powerpc/platforms/powermac/setup.c:74:5: sparse: sparse: symbol 'ppc_override_l2cr' was not declared. Should it be static?
   arch/powerpc/platforms/powermac/setup.c:75:5: sparse: sparse: symbol 'ppc_override_l2cr_value' was not declared. Should it be static?
   arch/powerpc/platforms/powermac/setup.c:76:5: sparse: sparse: symbol 'has_l2cache' was not declared. Should it be static?
>> arch/powerpc/platforms/powermac/setup.c:215:25: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/char/agp/uninorth-agp.c:174:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/agp/uninorth-agp.c:188:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/char/agp/uninorth-agp.c:188:31: sparse:     expected unsigned int [usertype]
   drivers/char/agp/uninorth-agp.c:188:31: sparse:     got restricted __le32 [usertype]
   drivers/char/agp/uninorth-agp.c:217:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/agp/uninorth-agp.c:424:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem *gatt_table @@     got void * @@
>> drivers/char/agp/uninorth-agp.c:424:28: sparse:     expected unsigned int [noderef] [usertype] __iomem *gatt_table
   drivers/char/agp/uninorth-agp.c:424:28: sparse:     got void *
   drivers/char/agp/uninorth-agp.c:434:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int static [assigned] [toplevel] [usertype] scratch_value @@     got restricted __le32 [usertype] @@
   drivers/char/agp/uninorth-agp.c:434:31: sparse:     expected unsigned int static [assigned] [toplevel] [usertype] scratch_value
   drivers/char/agp/uninorth-agp.c:434:31: sparse:     got restricted __le32 [usertype]
>> drivers/char/agp/uninorth-agp.c:463:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got unsigned int [noderef] [usertype] __iomem *gatt_table @@
   drivers/char/agp/uninorth-agp.c:463:22: sparse:     expected void const *addr
>> drivers/char/agp/uninorth-agp.c:463:22: sparse:     got unsigned int [noderef] [usertype] __iomem *gatt_table
   drivers/char/agp/uninorth-agp.c:510:32: sparse: sparse: symbol 'uninorth_agp_driver' was not declared. Should it be static?
   drivers/char/agp/uninorth-agp.c:538:32: sparse: sparse: symbol 'u3_agp_driver' was not declared. Should it be static?
   drivers/char/agp/uninorth-agp.c:437:35: sparse: sparse: dereference of noderef expression
--
>> drivers/i2c/busses/i2c-hydra.c:112:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *static [addressable] [toplevel] data @@     got void [noderef] __iomem * @@
   drivers/i2c/busses/i2c-hydra.c:112:29: sparse:     expected void *static [addressable] [toplevel] data
>> drivers/i2c/busses/i2c-hydra.c:112:29: sparse:     got void [noderef] __iomem *
>> drivers/i2c/busses/i2c-hydra.c:122:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *static [addressable] [toplevel] data @@
>> drivers/i2c/busses/i2c-hydra.c:122:39: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-hydra.c:122:39: sparse:     got void *static [addressable] [toplevel] data
   drivers/i2c/busses/i2c-hydra.c:133:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *static [addressable] [toplevel] data @@
   drivers/i2c/busses/i2c-hydra.c:133:31: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-hydra.c:133:31: sparse:     got void *static [addressable] [toplevel] data
>> drivers/i2c/busses/i2c-hydra.c:41:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
>> drivers/i2c/busses/i2c-hydra.c:41:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-hydra.c:41:23: sparse:     got unsigned int *
>> drivers/i2c/busses/i2c-hydra.c:35:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/i2c/busses/i2c-hydra.c:35:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-hydra.c:35:22: sparse:     got unsigned int *
>> drivers/i2c/busses/i2c-hydra.c:41:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
>> drivers/i2c/busses/i2c-hydra.c:41:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-hydra.c:41:23: sparse:     got unsigned int *
>> drivers/i2c/busses/i2c-hydra.c:35:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/i2c/busses/i2c-hydra.c:35:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-hydra.c:35:22: sparse:     got unsigned int *
>> drivers/i2c/busses/i2c-hydra.c:41:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
>> drivers/i2c/busses/i2c-hydra.c:41:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-hydra.c:41:23: sparse:     got unsigned int *
>> drivers/i2c/busses/i2c-hydra.c:41:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
>> drivers/i2c/busses/i2c-hydra.c:41:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-hydra.c:41:23: sparse:     got unsigned int *
>> drivers/i2c/busses/i2c-hydra.c:35:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/i2c/busses/i2c-hydra.c:35:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-hydra.c:35:22: sparse:     got unsigned int *
>> drivers/i2c/busses/i2c-hydra.c:35:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/i2c/busses/i2c-hydra.c:35:22: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-hydra.c:35:22: sparse:     got unsigned int *
--
>> sound/ppc/pmac.c:61:54: sparse: sparse: cast removes address space '__iomem' of expression
   sound/ppc/pmac.c:145:58: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/ppc/pmac.c:199:41: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/ppc/pmac.c:201:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected int format @@     got restricted snd_pcm_format_t [usertype] format @@
   sound/ppc/pmac.c:201:22: sparse:     expected int format
   sound/ppc/pmac.c:201:22: sparse:     got restricted snd_pcm_format_t [usertype] format
>> sound/ppc/pmac.c:260:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile [noderef] __iomem * @@
>> sound/ppc/pmac.c:260:35: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
>> sound/ppc/pmac.c:260:35: sparse:     got restricted __le16 volatile [noderef] __iomem *
   sound/ppc/pmac.c:275:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile [noderef] __iomem * @@
   sound/ppc/pmac.c:275:35: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   sound/ppc/pmac.c:275:35: sparse:     got restricted __le16 volatile [noderef] __iomem *
   sound/ppc/pmac.c:446:32: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:211:24: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:222:17: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:223:17: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:225:17: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:229:9: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:230:9: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:299:16: sparse: sparse: dereference of noderef expression
>> sound/ppc/pmac.c:301:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile [noderef] __iomem * @@
>> sound/ppc/pmac.c:301:34: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   sound/ppc/pmac.c:301:34: sparse:     got restricted __le16 volatile [noderef] __iomem *
   sound/ppc/pmac.c:299:16: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:299:16: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:299:16: sparse: sparse: dereference of noderef expression
>> sound/ppc/pmac.c:301:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile [noderef] __iomem * @@
>> sound/ppc/pmac.c:301:34: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   sound/ppc/pmac.c:301:34: sparse:     got restricted __le16 volatile [noderef] __iomem *
   sound/ppc/pmac.c:299:16: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:299:16: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:446:32: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:446:32: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:395:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/ppc/pmac.c:395:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/ppc/pmac.c:405:15: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:406:15: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:407:15: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:398:17: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:399:17: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:405:15: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:405:15: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:406:15: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:406:15: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:407:15: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:407:15: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:409:9: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:410:9: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:411:9: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:412:9: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:414:9: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:417:9: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:460:25: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:461:25: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:725:24: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:726:24: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:727:24: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:728:24: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:729:24: sparse: sparse: dereference of noderef expression
   sound/ppc/pmac.c:741:24: sparse: sparse: dereference of noderef expression
--
   drivers/video/fbdev/platinumfb.h:346:19: sparse: sparse: symbol 'vmode_attrs' was not declared. Should it be static?
>> drivers/video/fbdev/platinumfb.c:588:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile [usertype] *fbuffer @@     got unsigned char volatile [noderef] [usertype] __iomem *base_frame_buffer @@
   drivers/video/fbdev/platinumfb.c:588:17: sparse:     expected unsigned char volatile [usertype] *fbuffer
>> drivers/video/fbdev/platinumfb.c:588:17: sparse:     got unsigned char volatile [noderef] [usertype] __iomem *base_frame_buffer
--
   drivers/usb/host/ehci-dbg.c:381:44: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] list_end @@     got restricted __hc32 @@
   drivers/usb/host/ehci-dbg.c:381:44: sparse:     expected restricted __le32 [usertype] list_end
   drivers/usb/host/ehci-dbg.c:381:44: sparse:     got restricted __hc32
   drivers/usb/host/ehci-dbg.c:384:15: sparse: sparse: restricted __hc32 degrades to integer
   drivers/usb/host/ehci-dbg.c:384:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/host/ehci-dbg.c:392:28: sparse: sparse: restricted __hc32 degrades to integer
   drivers/usb/host/ehci-dbg.c:392:45: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/host/ehci-dbg.c:429:36: sparse: sparse: restricted __hc32 degrades to integer
   drivers/usb/host/ehci-dbg.c:429:53: sparse: sparse: restricted __le32 degrades to integer
   drivers/usb/host/ehci-q.c:1389:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-q.c:1389:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-q.c:1389:27: sparse:     got int
   drivers/usb/host/ehci-mem.c:188:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] *periodic @@     got restricted __le32 [usertype] * @@
   drivers/usb/host/ehci-mem.c:188:24: sparse:     expected restricted __hc32 [usertype] *periodic
   drivers/usb/host/ehci-mem.c:188:24: sparse:     got restricted __le32 [usertype] *
   drivers/usb/host/ehci-hcd.c:566:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     got int
>> drivers/usb/host/ehci-ppc-of.c:140:47: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted __hc32 [usertype] *ohci_hcctrl_reg @@     got void [noderef] __iomem * @@
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     expected restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     got void [noderef] __iomem *
--
>> sound/aoa/soundbus/i2sbus/core.c:96:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
>> sound/aoa/soundbus/i2sbus/core.c:96:30: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> sound/aoa/soundbus/i2sbus/core.c:96:30: sparse:     got restricted __le32 volatile [noderef] __iomem *
>> sound/aoa/soundbus/i2sbus/core.c:99:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
>> sound/aoa/soundbus/i2sbus/core.c:99:22: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   sound/aoa/soundbus/i2sbus/core.c:99:22: sparse:     got restricted __le32 volatile [noderef] __iomem *
--
>> sound/aoa/soundbus/i2sbus/pcm.c:478:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
>> sound/aoa/soundbus/i2sbus/pcm.c:478:28: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> sound/aoa/soundbus/i2sbus/pcm.c:478:28: sparse:     got restricted __le32 volatile [noderef] __iomem *
   sound/aoa/soundbus/i2sbus/pcm.c:479:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
   sound/aoa/soundbus/i2sbus/pcm.c:479:28: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   sound/aoa/soundbus/i2sbus/pcm.c:479:28: sparse:     got restricted __le32 volatile [noderef] __iomem *
>> sound/aoa/soundbus/i2sbus/pcm.c:491:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
>> sound/aoa/soundbus/i2sbus/pcm.c:491:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   sound/aoa/soundbus/i2sbus/pcm.c:491:25: sparse:     got restricted __le32 volatile [noderef] __iomem *
   sound/aoa/soundbus/i2sbus/pcm.c:500:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
   sound/aoa/soundbus/i2sbus/pcm.c:500:30: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   sound/aoa/soundbus/i2sbus/pcm.c:500:30: sparse:     got restricted __le32 volatile [noderef] __iomem *
   sound/aoa/soundbus/i2sbus/pcm.c:503:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
   sound/aoa/soundbus/i2sbus/pcm.c:503:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   sound/aoa/soundbus/i2sbus/pcm.c:503:25: sparse:     got restricted __le32 volatile [noderef] __iomem *
   sound/aoa/soundbus/i2sbus/pcm.c:506:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
   sound/aoa/soundbus/i2sbus/pcm.c:506:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   sound/aoa/soundbus/i2sbus/pcm.c:506:25: sparse:     got restricted __le32 volatile [noderef] __iomem *
   sound/aoa/soundbus/i2sbus/pcm.c:507:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
   sound/aoa/soundbus/i2sbus/pcm.c:507:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   sound/aoa/soundbus/i2sbus/pcm.c:507:25: sparse:     got restricted __le32 volatile [noderef] __iomem *
   sound/aoa/soundbus/i2sbus/pcm.c:578:50: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
   sound/aoa/soundbus/i2sbus/pcm.c:578:50: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   sound/aoa/soundbus/i2sbus/pcm.c:578:50: sparse:     got restricted __le32 volatile [noderef] __iomem *
   sound/aoa/soundbus/i2sbus/pcm.c:619:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
   sound/aoa/soundbus/i2sbus/pcm.c:619:29: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   sound/aoa/soundbus/i2sbus/pcm.c:619:29: sparse:     got restricted __le32 volatile [noderef] __iomem *
   sound/aoa/soundbus/i2sbus/pcm.c:663:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
   sound/aoa/soundbus/i2sbus/pcm.c:663:37: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   sound/aoa/soundbus/i2sbus/pcm.c:663:37: sparse:     got restricted __le32 volatile [noderef] __iomem *
   sound/aoa/soundbus/i2sbus/pcm.c:663:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile [noderef] __iomem * @@
   sound/aoa/soundbus/i2sbus/pcm.c:663:37: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   sound/aoa/soundbus/i2sbus/pcm.c:663:37: sparse:     got restricted __le32 volatile [noderef] __iomem *

vim +/__iomem +215 arch/powerpc/platforms/powermac/setup.c

14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   73  
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  @74  int ppc_override_l2cr = 0;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   75  int ppc_override_l2cr_value;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   76  int has_l2cache = 0;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   77  
d2515c806ea2b60 arch/powerpc/platforms/powermac/setup.c      Olaf Hering       2006-01-22   78  int pmac_newworld;
9b6b563c0d2d25e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-10-06   79  
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   80  static int current_root_goodness = -1;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   81  
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22   82  extern struct machdep_calls pmac_md;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   83  
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   84  #define DEFAULT_ROOT_DEVICE Root_SDA1	/* sda1 - slightly silly choice */
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   85  
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22   86  #ifdef CONFIG_PPC64
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22   87  int sccdbg;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   88  #endif
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   89  
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   90  sys_ctrler_t sys_ctrler = SYS_CTRLER_UNKNOWN;
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22   91  EXPORT_SYMBOL(sys_ctrler);
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22   92  
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20   93  static void pmac_show_cpuinfo(struct seq_file *m)
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   94  {
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   95  	struct device_node *np;
018a3d1db7cdb61 arch/powerpc/platforms/powermac/setup.c      Jeremy Kerr       2006-07-12   96  	const char *pp;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26   97  	int plen;
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20   98  	int mbmodel;
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20   99  	unsigned int mbflags;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  100  	char* mbname;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  101  
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  102  	mbmodel = pmac_call_feature(PMAC_FTR_GET_MB_INFO, NULL,
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  103  				    PMAC_MB_INFO_MODEL, 0);
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  104  	mbflags = pmac_call_feature(PMAC_FTR_GET_MB_INFO, NULL,
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  105  				    PMAC_MB_INFO_FLAGS, 0);
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  106  	if (pmac_call_feature(PMAC_FTR_GET_MB_INFO, NULL, PMAC_MB_INFO_NAME,
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  107  			      (long) &mbname) != 0)
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  108  		mbname = "Unknown";
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  109  
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  110  	/* find motherboard type */
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  111  	seq_printf(m, "machine\t\t: ");
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  112  	np = of_find_node_by_path("/");
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  113  	if (np != NULL) {
e2eb63927bfcb54 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-03  114  		pp = of_get_property(np, "model", NULL);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  115  		if (pp != NULL)
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  116  			seq_printf(m, "%s\n", pp);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  117  		else
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  118  			seq_printf(m, "PowerMac\n");
e2eb63927bfcb54 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-03  119  		pp = of_get_property(np, "compatible", &plen);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  120  		if (pp != NULL) {
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  121  			seq_printf(m, "motherboard\t:");
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  122  			while (plen > 0) {
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  123  				int l = strlen(pp) + 1;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  124  				seq_printf(m, " %s", pp);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  125  				plen -= l;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  126  				pp += l;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  127  			}
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  128  			seq_printf(m, "\n");
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  129  		}
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  130  		of_node_put(np);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  131  	} else
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  132  		seq_printf(m, "PowerMac\n");
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  133  
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  134  	/* print parsed model */
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  135  	seq_printf(m, "detected as\t: %d (%s)\n", mbmodel, mbname);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  136  	seq_printf(m, "pmac flags\t: %08x\n", mbflags);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  137  
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  138  	/* find l2 cache info */
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  139  	np = of_find_node_by_name(NULL, "l2-cache");
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  140  	if (np == NULL)
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  141  		np = of_find_node_by_type(NULL, "cache");
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  142  	if (np != NULL) {
e2eb63927bfcb54 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-03  143  		const unsigned int *ic =
e2eb63927bfcb54 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-03  144  			of_get_property(np, "i-cache-size", NULL);
e2eb63927bfcb54 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-03  145  		const unsigned int *dc =
e2eb63927bfcb54 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-03  146  			of_get_property(np, "d-cache-size", NULL);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  147  		seq_printf(m, "L2 cache\t:");
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  148  		has_l2cache = 1;
d8731527acee53b arch/powerpc/platforms/powermac/setup.c      Mathieu Malaterre 2018-04-13  149  		if (of_get_property(np, "cache-unified", NULL) && dc) {
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  150  			seq_printf(m, " %dK unified", *dc / 1024);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  151  		} else {
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  152  			if (ic)
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  153  				seq_printf(m, " %dK instruction", *ic / 1024);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  154  			if (dc)
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  155  				seq_printf(m, "%s %dK data",
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  156  					   (ic? " +": ""), *dc / 1024);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  157  		}
e2eb63927bfcb54 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-03  158  		pp = of_get_property(np, "ram-type", NULL);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  159  		if (pp)
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  160  			seq_printf(m, " %s", pp);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  161  		seq_printf(m, "\n");
0dd194d02d2584c arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-20  162  		of_node_put(np);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  163  	}
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  164  
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  165  	/* Indicate newworld/oldworld */
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  166  	seq_printf(m, "pmac-generation\t: %s\n",
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  167  		   pmac_newworld ? "NewWorld" : "OldWorld");
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  168  }
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  169  
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  170  #ifndef CONFIG_ADB_CUDA
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  171  int find_via_cuda(void)
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  172  {
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  173  	struct device_node *dn = of_find_node_by_name(NULL, "via-cuda");
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  174  
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  175  	if (!dn)
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  176  		return 0;
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  177  	of_node_put(dn);
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  178  	printk("WARNING ! Your machine is CUDA-based but your kernel\n");
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  179  	printk("          wasn't compiled with CONFIG_ADB_CUDA option !\n");
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  180  	return 0;
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  181  }
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  182  #endif
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  183  
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  184  #ifndef CONFIG_ADB_PMU
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  185  int find_via_pmu(void)
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  186  {
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  187  	struct device_node *dn = of_find_node_by_name(NULL, "via-pmu");
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  188  
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  189  	if (!dn)
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  190  		return 0;
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  191  	of_node_put(dn);
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  192  	printk("WARNING ! Your machine is PMU-based but your kernel\n");
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  193  	printk("          wasn't compiled with CONFIG_ADB_PMU option !\n");
a575b807172ca7d arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-23  194  	return 0;
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  195  }
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  196  #endif
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  197  
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  198  #ifndef CONFIG_PMAC_SMU
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  199  int smu_init(void)
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  200  {
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  201  	/* should check and warn if SMU is present */
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  202  	return 0;
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  203  }
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  204  #endif
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  205  
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  206  #ifdef CONFIG_PPC32
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  207  static volatile u32 *sysctrl_regs;
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  208  
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  209  static void __init ohare_init(void)
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  210  {
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  211  	struct device_node *dn;
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  212  
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  213  	/* this area has the CPU identification register
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  214  	   and some registers used by smp boards */
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26 @215  	sysctrl_regs = (volatile u32 *) ioremap(0xf8000000, 0x1000);
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  216  
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  217  	/*
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  218  	 * Turn on the L2 cache.
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  219  	 * We assume that we have a PSX memory controller iff
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  220  	 * we have an ohare I/O controller.
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  221  	 */
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  222  	dn = of_find_node_by_name(NULL, "ohare");
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  223  	if (dn) {
30686ba6d568586 arch/powerpc/platforms/powermac/setup.c      Stephen Rothwell  2007-04-24  224  		of_node_put(dn);
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  225  		if (((sysctrl_regs[2] >> 24) & 0xf) >= 3) {
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  226  			if (sysctrl_regs[4] & 0x10)
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  227  				sysctrl_regs[4] |= 0x04000020;
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  228  			else
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  229  				sysctrl_regs[4] |= 0x04000000;
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  230  			if(has_l2cache)
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  231  				printk(KERN_INFO "Level 2 cache enabled\n");
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  232  		}
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  233  	}
35499c0195e46f4 arch/powerpc/platforms/powermac/setup.c      Paul Mackerras    2005-10-22  234  }
14cf11af6cf608e arch/powerpc/platforms/powermac/pmac_setup.c Paul Mackerras    2005-09-26  235  

:::::: The code at line 215 was first introduced by commit
:::::: 14cf11af6cf608eb8c23e989ddb17a715ddce109 powerpc: Merge enough to start building in arch/powerpc.

:::::: TO: Paul Mackerras <paulus@samba.org>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--fUYQa+Pmc3FrFX/N
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICDOmE18AAy5jb25maWcAlDxNc9s4svf5FarMZfeQWVl2PEm98gECQQkrkmAIULJ8YSm2
knGNY2VleWayv/51g18A2FRmt2onUXejATQa/YVmfv7p5wl7PR2+7k6P97unp++TL/vn/XF3
2j9MPj8+7f9vEqlJpsxERNL8AsTJ4/PrX//6dvhzf/x2P3n3y/tfpm+P9xeT1f74vH+a8MPz
58cvr8Dg8fD8088/cZXFclFxXq1FoaXKKiNuzc2bhsHbJ2T39sv9/eQfC87/Ofnwy+Uv0zfO
MKkrQNx8b0GLntXNh+nldNoikqiDzy6vpvZ/HZ+EZYsOPXXYL5mumE6rhTKqn8RByCyRmXBQ
KtOmKLlRhe6hsvhYbVSx6iHzUiaRkamoDJsnotKqMD3WLAvBImAeK/gPkGgcCvL6ebKw8n+a
vOxPr996Cc4LtRJZBQLUae5MnElTiWxdsQJEIFNpbi5nwKVbbZpLmN0IbSaPL5PnwwkZdzJT
nCWtWN68ocAVK13J2G1VmiXGoV+ytahWoshEUi3upLM8F5PcpYzG3N6NjcCZu804M7h7CfE4
zzn87R0hCW/GBhaJmJWJsTJ2dtuCl0qbjKXi5s0/ng/P+392BHrDHBHorV7LnA8A+Cc3ibvB
XGl5W6UfS1EKcgcbZviyGuDbwy6U1lUqUlVsK2YM48t+1lKLRM7d2VgJV5pgY0+AFTCRpcBl
siRp1RM0ffLy+unl+8tp/7VXz4XIRCG5vQh6qTbOhQ0wVSLWIqHxfOkqD0IilTKZ+bBYFVxE
zR2S2cIRbc4KLZDI3ag7QyTm5SLWvnT3zw+Tw+dga+H67F1e99II0BwuzQp2lhlNIFOlqzKP
mBGtHM3j1/3xhRKlkXwF91yAsByLkalqeYf3OVWZuzkA5jCHiiQnzrIeJaNEuGMslFSwpVws
q0Jou9uCFtNg5e1keSFEmhtgn3nTtfC1SsrMsGJLTt1QEZtox3MFw1v58bz8l9m9/D45wXIm
O1jay2l3epns7u8Pr8+nx+cvgURhQMW45VHrTDfzWhYmQFcZM3JNX0JUI6sMPTlJN9cRLF1x
AZcSSA1JhJZfG2Y0tW8tPTFq2dmeSGr0KhF5QH9DNFaEBS8nmtK/bFsBzp0bflbiFhSNOh9d
E7vDdTu+WZI/VXeZV/VfnOu96s5ccXcBcrWEyx6oZOeu0C/FYF1kbG5m015vZGZW4KxiEdBc
XNYS0Pe/7R9en/bHyef97vR63L9YcLNoAtuZ2kWhyly7KwS7yxfE6ubJqiF3ggj7u9J8KaIe
GjNZVCSGx7qasyzayMgsvXMx7gBSw5q5chnpc/gi8r2mj43hCt6Jwp26wURiLTnpjWo8KCMq
PzkSTDFls8CngiGHe+N4L6OrzBM3etCM3hG4uiLAtRoho5pNO5Uw3m8QIl/lCtQGjSCEeJ4d
szK28ZDdADk3+Ac4q0iAzeJg7SNiEYVI2NaJqEA/QIg2yiicM7e/WQrctCrB4TkRSBEFYRYA
5gCYeaoRjUdCgCOjIDtGeXyTuyuX61wpNMT4d+rMeaVysI3yTqCXRs8Ef6Qs454gQzINfxkL
RCDajDBU5ioSFThQVgkMc9E+Kycu6IIp7zfYLC5yY9OOgnEnjLe8c67zFawyYQaX6ZxJHrvr
HbV8KdhiiermTLwQJgWjXg0ihVo1BuB4CRc7cZZWR4G1A3ag1pi5gbhjNkUSg4AKl8no1hgE
SHHpraCEnCz4CVfFYZ8rbyNykbEkdnTVLtYF2EDIBegl2Mf+J5OOlklVlYUXx7FoLWGZjawc
KQCTOSsK6Up8hSTb1LMOLayCP6lov0VbaeCFRG/v6Xket9OP2hjrimPqitvoGTPIfr0Vspoz
vnJ2A7GqF6gCsYgi0mjU+gpzVl2MaV1Vk3bn++Pnw/Hr7vl+PxF/7J/B2zNwYhz9PQRrdcTU
aEbPhIwe/ibHdmHrtGZWR2eeyuqknNdW3k2f05wZyGZXnmVN2JwKLIBBSAYiLRaiDYRoG4xk
6LESqcGQw/VS6d8gXLIignid9qJ6WcYxJNI5g8nhJCFDBvdArXmrjUhrSwUptIwlb02VE+qq
WCZB3NheJbRT1gVpN4DyqwLdLc/5pWf0AXB9RTk+8JZguleXurIDrELkx8P9/uXlcIRY/tu3
w/HkqUk/4vqvv86zvJ5eBIuo3r/zB/nIEdzVdAR+RcPFbDolVtZlXbkXw4rL6ZTPEEozQ/Tl
KHpxFaIGcnCsL8Bif3aWoImhcjQkrqsepa0beKJCGC3HtKw9Cq2uaU7MlFnfvRSFva8Mwpkg
9KmBLQ3fuho41JbOBERaWa1qWUEqNUeJZpFkjo++nM2lk9GmqZM1WIuZpgwC0QyCGQnxXspu
by5+PUcgs5uLC5qgtTM/YuTRefyyAjM9ffPuYtbdbQP2217QSpd57lf0LBhGxAlb6CEeywMQ
Fg4RrbYuNwKSb+MpkeNQWZFsB0FAzrKmMqFKyGred6lPHaqqVBqwbxBPV9aiuF6zFgPbtpFQ
FUfcV+Aymi+qi+t376bOKKwI2bHDDXh2vk1US5mCxQymXcq5KOoIDqMdLedJSNKISdf+w5pd
a3XHyEqwqXM3Y7hTGXgJt+KYL+pKrK0/6ZtZYwSfdid0dJQN1KAdVMXIERJfFoM7m+YclGbc
/CF+NmpT85TxgTWdnbOml+eQ1yPINtagjTtL5YIpt+69Ake/KCEpcsNClkOIyQqGFRRfebJB
RIVQFdcJBCY2EFPKjK6wWM0rDMRPANAqoZKDNJeemPB3leoF5ZNxavl+9u6Dv0acwQnGcD5R
FJCPJGqx8OLRlhrcukjdtMMCm1qFf8IX02unVDWJj/v/vO6f779PXu53T151Cs0lBCEffQOK
kGqh1ljIhQxJmBH0sCLYobGuRCVpLb69o8hmLFMjadUG4jw2Uh4jh2C4bHP6vz9EZZGA9YwU
NagRqCyiWA8qd5TY/P2SFO0ub76S+G5LpLzGdkAfYb9uV2c+hzozeTg+/tGG832xj1Culod8
eNo3owDUcUawr4BhibiF2QUmDCwFdbE8qlRk5SgLI9ToQXZESwiSMNV0KWsjjWeR827tk2go
iHEaV1T1zh2IKyE/jp5eQICVgWOUtyOl25FIUWRgF7iPaxcZehs3iTt8w0dTL1nDejzkkFRC
eFddTKfBS8Ds3ZRcEqAup6Mo4EOF0cu7m4v+CdW6W5FZD9o8MS2VyRPX6dM0Bfxt7XoScSsc
e8kLppdVVLqvmpYRBFIGuDQMnXJBkogFS9qQplqzpBT9oy7a36uVjRiCiNzmbk0BuIvpmpfY
BnzVC8ZmcBaMPouqIvQUN7OOn32cwpDTRiAKUsoCg8pe4dMI/d4YzwbtFPvELXhLUDbIeiEl
BLijHF0YRTk9p9ySp2EeDhAWrdH8RQSqDenq1zdHjJuPtV2sRAyJrcQ8orHA58aD33eqAoJj
0O2mFoH+dwetGUZwFbO1KHst5q8vzjXp6YbRaDPY1wAJGUkhuIF41ylvxTqpkjl3V+TOYydm
D39gKeQhfJbvhKhsmdErQiVqg/qL1c2x43ZIbqZ/XU6btoXeDqHKqjgG/z/GwiEBFvcDFs3L
NgQDxSgPlwaZzPz2iXy51ZKznmA6C2cxtuR5Zqcdgb/IRt6BeP23uZIl8m6g5l6zxO54/9vj
aX+PrzRvH/bfgO3++TRUldrY+KVSa48CmE2KVF2n8fziqs4ziA3+GywYeMq58J70MQYDbVyJ
LeSEIolHGjHsfP2dKjPY8iLD1waO74eBZYTQwzZiGJlVc7/bwDKSsBdMcGGtJkCtwjyphhbC
0Igaim0nMVVBj8uM2zSuDpxl9m/B/cJ8301gxy+VWg0vqwbR2SigtsZhuggxNphVI+Nt+xbi
E9jCAt6BKtwudvCkKmp6WcLdFQIydQjQ6sS+kXVjbjw67UbnfSkWx1Nw+wBV8/T9Wi8MT1va
FCYtqwUzSxhcZ6pYmiTR+Bz7A5La2eF9C4UJS8hSWT+L8jS/5cvQhW8EW2FVXGB1nPGPpSxC
NhsGaiqtU8WOi7aHiNhpY+8hjEq8AsQY3I60wkP1Fdho5QQLdWOWj24bDvor5491L6M7TJtC
kTVYuwSiKyC8ZsNGgIACVK8RQi44loKdo1JRmcDNwruMzzf4CEHwF7eo2VndPYPLJ+6GHW6r
3N5x90fglc3O1dyc8pcdzVW+bSMkk4S6bsdna8jlwVS6zXDgeudlcJF4ggUZfADZsCJyqBX2
k8mFLkFGWTSAs8CeNAW7+sqj9KlFrXFTgbgomCWuPTd4t8YLFptbQsigLBICB4rmDKobji60
MqoJSZwQAWyE836ihx6Oq/XbT7sX8I2/12HSt+Ph82NTQuiTDiBrVnDuPcqSNW6tqp8h+yeG
MzN5IsYWTAz8vcjwB0CwdQZ3Cf8vQKlcGThEqMV1dyWZPf1Nb98XZ6oU3zJdr2Yf/HSKW58G
VzG8m00onyjXITWoMiPB9YgO2RenehdEJmHNcF3wruty5N2xpZR0z1GDxktSgC87R4Pl1E2V
Sq3rfqem6aKSqa2oElpUZmCs4FJu07lKBuIC9QZfBOJSK7fVZY4q7v5cdR0nGwyOXDG1rRBz
PdJR1eMTST0Y9r0URiwKacg2iwZVmYvpEI1JWzQEgw1UxiSehR/iMJwPttpke9ZLFuFeN3Mq
FnREJJW9NnwbjuzwXGn6EbReHdbOydo1orVNW1gSMq9bnuGq8mKbk2F3vjueHvGyTcz3b3v/
eRkyBGlDwjY1Gisv96SOKjFOgnWkNIUQsfTAfaElWKG77/Sjn/81MHT4blsCgm0SXfe9qr4f
zEkoYJxU9WsLtqn4veIOcrWFXP3mq9O/1CDm8Ue6GdWbrxOczi4cR1sflM7BdKLRAV9St776
eOu+a/w5HDl2A1dFjA12kf5o/3GGGQhNeFWkm5uhZ4TgrVJg9hKW53iHWBSh6ara2mqbpHcd
aPY4xF/7+9fT7tPT3n6mMLG9CifnYOYyi1ODsZGjLUnMg54u/G2D9K6SjNHUeK9hw1bzQuZO
stGAwZq6lS3g3cT/3bGOrdtuKt1/PRy/T9Ld8+7L/iuZwDZFMUcuAAAZRrbiBvcnzDZipk21
KMPi2kqI3Han+AfbVO2kRsPjN1jlCQRcubFnDWGxvrlypQhBGQ9NhV/FKAQqA930AOagYGGc
BwH1ogoe/eYQJLlaYYN0CKsg3PSzoExBuih9k7vSVCG1PXcbCKcyswp4czX9cN1SZALuaY4t
PJANrBzZc8iQsuAdPYacwvg5OfdjPvg57H0cYkmzjVgGd1bfdO/Zd81kHQcL6EIAyHO6pmGB
ykI9jYwOCb7AGKV7fzUjd3OG8dX/PGDJ/7chd9pQzmeM/ubN038Pb3yqu1yppGc4L6OhOAKa
yxgylzMLDchtLKqovhCC/ObNfz+9PrwJWbbMyDqwZdArY7OH9pddreuXziyordbUvQhNkclx
ClHbH4WVnpWfDadgmyTWiNybgo0J6yDDh3uG18z2xDuJBAQ7cwhIlikrqBQ4N6LOsZmX0owb
1P5ud18UZPvTn4fj7/jORrzEgH1bCSpcKzPpJHz4C7xD6qqJhUWS0Rce8moSfhsXqa0kkVjs
XF6JLbEeWW/JaZSu21Q5G4kUgaCrYkNUaciXPiDKM/ew7e8qWvI8mAzB+MhPty01BAUraDzu
S+YjH3jVyAV6bJGWt8Qya4rKlFkW1GG3GVx5tZKClnY9cG3kKDZW9HNfg+unpSfAY6nYchwH
6dc4UuZor0ZOu9+uC0SFC0CG5y3YZ19G+biCWoqCbX5AgVg4Fyyq0R/44Ozw18W5xKCj4eXc
rZa1Fq7F37y5f/30eP/G555G7zTZlw4ne+2r6fq60XX8uigeUVUgqvvUNdbwI0abddz99bmj
vT57ttfE4fprSGV+PY4NdNZFaWkGuwZYdV1QsrfoLIIQ1saTZpuLweha084sFS1NnjQfvY7c
BEtopT+O12JxXSWbH81nycAp0JFBfcx5cp4RnIEtxNPFkhwUa2wYfvGLdWx0Smdp8uXW1irB
q6X52PdiQFzXwul8Pj+DBNsT8ZF1Svw4aMQaFyPfBMEZ0hKF5IOEJ7ORGeaFjBajH3dYu6G9
6LgBkczWCcuq99PZxUcSHQmeCdrHJQmnA1RmWEKf3e3sHc2K5XMSkS/V2PTXidrkjE6OpBAC
9/SODohRHuMfd0WcKoNFmcbvlxR+w+3GdnM4PmYLMyQzlYtsrTfScNqWrTV+4hp+NuDcIpmt
xp1Emo94xvojLHrKpR4Pf+qVRoLeDFIkl5AQazTyY1QfCzM+QcY1HQ401TekyQs50tjU0/CE
aS0pk2s96y1mr9vK/8Zm/tEvy+Vx9W//a203Zp2c9i+n4EXArm5lIGgf3WBUKHCaKpPBpwxd
/DxgHyDcWNk5NJYWLBqTy8g1mNM3h8UgoGLMGsXVilM5/Ubi66X2ujF4vMBrdjGQYYd43u8f
Xianw+TTHvaJNZoHrM9MwL1YAqfq10AwTcH8Y2kbfuruhn7GjQQobXfjlSQ/TMJT+eCE2fXv
tjT51T++D8Q3lI6cJR3WcJEvq6B83rONaUnnGhxXQvtrG5/GNI5yvK2R0oNvEODKwPLqD746
FjGTCdYHCRbCLA1mx43tCSpfvLk0bX4X7f94vHdbB11ivyHIPuN4oPDHsDUKgf3Hfb3kuLSF
L7jjxA4Qy7TXqtVAnL4qj5fFne/A9cmwDPu3iPuO2FFCyLNp/4+bTzUViCIGGwhWOtjJGd21
ojQl5doQ5VUGECA4S0PuUq1HhoPJ9ofnDKyzO75pbETk8OkDYPeH59Px8IRfhrsduQ7L2MB/
L8i2SkTjPx3Sd26HiKbO4utEdYtfjN32yvzy+OV5szvu7Yr4Af6inS8YGjt9jqwuOR8+wQYe
nxC9H2Vzhqre+e5hjx8KWnQvnRfywzLcDGeRyPCOYfV6OXjDattzf8i2e+6hT6U7MfH88O3w
+BwuBD9Rsm2k5PTewI7Vy5+Pp/vfaB1w9XfTBChGcGu4HabjLHoOnBVR33me85RLFv62b9MV
l76fg4GBsWnW/vZ+d3yYfDo+Pnzx3+y2IjN0xJ1H17/OPlDJ4vvZ9MPMe9B6P7u8fkeQGi75
YOW2r8zVcFw2vgXVDXPuhgqWyyCa6Hv/Hu8bgz5Rw5pdWXdWLEWSk/4DokKT5rEnvhYGcVGZ
kf/ahWFZxBKv5Sgv6pliWaQbVtTdeVF7V+PH49c/8Qo+HUChj85jzsaeoNv91IFsJTXCf7PC
eb+yrcDtJE6PcD/Ktp7VG/acKEUArrX+JJk8+n4I3U3Q6HO4uS4EY7Y3eO2+grVhm+08oHEB
1DkWfMqOCrkeSYEbArEuRsoONQH2XzZsqroxndJYJGK2+b8hrdW1U2LnC1P770EE2lyIhVcZ
r39XcsYHMO32SDWwzcUAlKbuy3TLz31xxUZpvQS1sDoT+8ePyNgaXNuESR7kyHXq2q4fbPjk
Pn2rW+OXmrXEIBEbwAMD1CeBSznEOT3X7SSOOVMQP3L6W+tFBiH+V/dXBdqNbwA+MMV/BYZC
aFnEPaab0+LK+W2DImZOjWOc4YdVGVxL0B7xbXd88fsFDHYE/mqbFrTPwukVCVEqpqBw1vZr
ujOout0dn3Trh963zpcIAxa27dh+2T5SbRiOwPYBlSVb2n8OxGClU8JfIaLAzob63xQwx93z
y5P9FwMnye77QF7zZAX3OthhvZ8h6P85u5Imx3Ed/VfyNNF96ChLXtI+vAO12GZZW4qyLefF
kV2VPZUxWdUVVdkx/f79AKQWggLT/eaQXW0AoriJBEDg47UmdtK2Yc0sII/P4q9rbcUmyI5v
2WuJW9I46dU24Y0mlXter4cUQyZJ9fU5LqEMkS3wURtHRr+l1CL/UJf5h+3r009QJL68fJ9q
IXpObSUt8mOapLGzmiEdk5YYMjyP7iIuu6FnFyVW3DtfUCSCDfGCJ3SOoCOWWWLcm3ZpmadN
zR16oQguiZEoDleNknS1FlGGG77LXVAuvlwGDM0pBcwGrt4YcpbB3v1O00UO5jA5h+05oG5w
uEw9+9jIzPn0wRaihNIhiEiBsmIrpe9MJ2MlPH3/buUfaq+Ilnr6hJgAzpwrcRdosU/R1z2Z
NBgKm3snAhra9CNwVN+RdhWgL15AT5u8Qvf49YSR4dy+oYsAy8N01Wjl3GilgQx7fv3jN9Tc
n16+PX++g6K6TYszBfWL8ni5DDy1wBSybSbUnrZvIHchVhpI5OK2cpTynbbqqR3vq3B+CJf8
GZJeeVQTLj3nH8jOoKN83bifzDf4c2kYIt6UDWYQoY/MDq7puGmtA3ORG4Tryaoemg3XmL4v
P//nt/LbbzEOjc+po/unjHfzsR5RvDfordccE/0m1EZHNPXYbzeH2X5TITSURO2snrBwI4cl
dmNqBthZRjqJ3g/grAo9+71B72XCFlf1nX/8tFQax2iv7gWomcWOVpcRgI0tpjXG0+FpS+1H
I40YYfaup//9AArBExi+r3coc/eHWXZGA9/9hnRJSYpZUa5TZioXiy0LGNDz89a2RwfyrqIe
1oHRY2jdeqv2aLwvJGCWi2k4bf7y8xOduqA6dO6haUXxP6BpMxyYLOWebUMi1aEsEF7V0zNg
h/QjqKuUVUlS3/2X+Te8gwX37qsJpmH1DC1Ga/SgwY17nWL4sG4XPKlWWbtt6sg6eWahj2AR
jtnb98eI80wiZ38BOxiDB4eqJ401t0sCAwda+LGQjSeFD7gYXteQhCwgmmgplnUoo4+EkFwK
kUtSgT4eltCI5Qe/CxseosRkIgQUQK3RDhU1DDwVJDQTfGuFypu8IASjGcBhQBOlqDU94atD
AGF7sHrq1JCaiCAEjdzyh0aWjPZmU2/QVGjiLutYol2v7zerKQP2nMWkcRovyQbhMRFQY62K
7gAGulkpzDefOt1+/Pn256c/X2m2Momk6tIIyGlfl1lQHLMMf/AHZp3Q1mOrCejPrKwqD9qu
qGXCr1Z9weioVQr3c1nNw5Y/yeqFjw5KwUQgA4PnXYGkjviWDL1xg6/a9bt8ZxMcPQwJqL54
VBonJ/4NmOePXwkeOPEn4/p87uZQ3WphrWgvmyPeU55aPvneZgWqk7M89BOwyFEhiprAHOGp
vxbZn3M2gFQztyKC3cWGTtVU4qjVJG+4jGZqFAP+qNlu5rArTr1OYLooWOuvmVTz7DQLLZ1D
JMtw2V6TqmxYonbAsQz0wo07wDHPLy6GeLUXRVNyWlQjt7mj+2nSfdsGxD8eq808VItZwPYP
KA9ZqY51imvlScZsjvm+usqMaCmiStRmPQtFxslLlYWb2cxSgg0ltDKf+g5tgEOwvnpGtA/u
7xm6fvVm1trV2efxar4MmaokKlitLXsZ90NoJeiH1bwDlLVeUQt6JDoc1GhH29gccyh2VcnW
hhTBNIxr3SgrLrc6VYiVZgXlh92GZtJJUlBUcuu4qh8VTYcFICQouCOZjxHq+IhTEnPuio6f
i3a1vl8yJW/mccvba4NA2y5W/qJl0lzXm32V2p3Q8dI0mM0Wdpy00/yhj6L7YObMbUNzUT1H
4lUodcwHd5HBun/+++nnnfz28+3HX181lOjPL08/wKx6Q88fvvLuFcysu8/wxb98x/+1DYAG
nSDsmvH/KJdbRujnTzh0xcD4O4EemWq8DuHbG1gxoLOBSvvj+VXfmzKZRaeyohkqQLB14vcK
GcYu3pNUDD3HRRYjynLMqrf9R9DFLtAnNeOouCP2vYhEIa5Ckkh6ezEeJTFLPaFholSrMD4T
DKTqzOdJ5yATU0jpkZ9MNPCZB91yEpjVW+3Mi8g2zvUTk+6ZU1cc2DeyAD2efVpXdmbZPoYS
TClTocVyRWjDLk2oOg7kQgL5dOAMU51Bmcp7gJBp4xJraU0mwED6ya192tTLdP71HCbHLq11
6rpzkYIjaRAw8MSJz/rCV0k0EaWy4yASHYuipNIJ4+jkIrwj3r8jKztLF6g6VdWpiypEhZdo
8K9u9lK7vE8SE65JtgqWRyOTegoY5g/2QABdO3Am42FLpBG3Nyfa6eUUplESeOEufYbK47UG
LLbeKILzzFJu8utjWtPRHWcdS70+ZB6GapzqjKy9J9lETxGwNvm6JkflDiLC4PtKMuf7fFFg
cB/Si1MY+twaz7tNtAbTv3qAPSPIJJpjD+skcqsko/fqnZQpZ3uk2Cnmtwkp3BF/aMcZ8SnN
HpSm6V0w3yzuftm+/Hg+w9+v03V2K+v0TIBcesq13NMdYmAUbMbTyC4VgQh+tyLDgobLQVMi
5ps+W7cBSZKI/LjGx4QEhyOtyvk8HMRNBUM8kbB9cUOMz+K7beD5ojo2yNhLG8sByknzI54r
pFFjeeAQVwe+d1kkXcKNwxFJc79YEX0Yhbei5uwGUagstkN88L2YOJenDQ3bHhTunJuFMEbm
Dg7nXgs30zkqi8SXeqBNHpaD47w7ipo3XNMHjc31To5ak3qsbmgthvOzPFl5WafWx0FvuSfG
MRJ1ekx4u3Tn86KLWKX8uS60K57i0o7sJuoGhWXD3PHRryc9cPoaL0/hpxsuCF8GQpHlnuRs
UbtZE/0py9uPl9//Ql1UmXg1YcGucFCk//SRQaXFz4a4LrH5sKQnoNTO45LEdKbZnP/szVHg
PF7e8wkUo8B6w/cc2IGpB+LzUu1L3iky1lQkomrSmK5TmqTx8nC1vFEAqFPkU02bYB740hv7
hzIRa82D3AekMhmXyrNMjI82KYUMBuUBjGN+ehijp1G3GpGLR3sTIyyi3MPPdRAEXmdahfNx
zqfrdINZ5LGzDDBvrSoK3Zf74IcjJ3+MKQvWuaKRgm9eHfN0nN4lOZsWTeZLQ8p4txAy+Foj
xzdkt+bOETRJurFqyrWI1ms2aNl6OKpLkTgfZ7Tgv70oznFZ9iDUFC3fGbFvLjZyVxb8MoCF
8d+wuZADnT2+BzkdhzYYD/dIewvOkrSe6U4D2XkRi5M85jxrn2ZKEju/I10bfn4MbL5bBjY/
PiP7tL3RILA+joqvtFQxqbK7ljCPaCQQMgN3aQ6q/rAn8GoKr49aBSd0HTbJ0Rl76mk/1WWP
jC/KQt6Tr45F4mZITMsD7THTNyqNEyYNb9Y9feyuvxw7UlOuRaU6qzs3EGq3StoeP8pGETDu
buHc5qePwfrG8rAry13Gz939UZxTybIQYL9teRaG45CG8akRSJ65cjNPlvCOz2AC+smTz936
HgGG5yUL79v5FepjfmNq5KI+pTRDKD+tFvO29e6H+Sn3JdOpw46vnzpcOCe8XRGohShKMkvz
rF1cPfmCwFtODFibq87vsrfnG/WRcU0nyUGt10t+1TMsKJY/Uj6ox/V60Xoco85Ly8lXV8Th
+uOKh0sHZhsugMuzoUvvYTD/wVsVrHfsx5Jfauquhd/BzDPO21RkxY3XFaLpXjaui4bEWwpq
PV+HN5SAAm1U51YrFXpm6allM8BpcXVZlDm/6BS07vIK5f1nC+J6vpkxq6FoveYSXi3FDzGw
Dt4gpD67xZuIfsyamk+1OSfr2d/zG/10kokk26a5C9lZOqYPlgfShyDPIvxYTxi8G+jbnSxS
osTuQdWHb4ZtxCXF3I6tvKGbV2mhELCWHe6HrNzRDKCHTMACyat3D5lXXYQy27S4+tgPLAKJ
XZEjnq/kRNN9iMU9zAw8MuIL7fhH4dE3H/BOodSHWFHnN+dyndDsqNVsceNjrVM04oiCsw7m
G89BPbKakv+S63Ww4rLByMtgugheU6wRP6BmWUrkoFuR0wSF27K7KzJPpjY4t80oM7C+4Y9e
4urJcAY65kPFt6x9JTNBl714E87mXIAveYp8QvBz41legBVsbgyoyhWZAyqPN8HmXfeHFoGa
8ptaJePAVx941yYIPLYVMhe3NgtVxpjD0PKOHtXo/ZC0p8m1E/bm0B/pVehg8l/y1BNnhtPL
E6MUIz5D4dkOJXfpn12JS1FWYGQS++EcX9tsd9Ov0KT7Y0NWZkO58RR9Ql7jCpQvxJhRHhSb
5qa35ES3Ffh5rfe++7mQC1osDCt7mGIVe5aPBc0RM5TreembcIPA/JYnYsiIHp7twkFwec2k
B16okxGt9C/DnUyWwXjcHMRW1o47pPvmkBFW/BH2Nkn4+QbKqGdr0ZgnkXtZz6gngpHA3MY9
Vmp/8aE+GN0bterNZum5MrrKPKBsVeW5CZs3u48q6rBH+sOfUTcCVizcm5Ms5gGMT4+RhOwq
3QnlSTxEft1k68BzQ9LI55dI5KNyv/aoIciHP6/aB2xZ7fkV7ZzZt2Tir9G1nJuNm+PRm+Dx
0NWPqADc5URrZQvNbSA5m2X5/Rhu7wRiWL3172HVsKOSVbzEABt+qtVS5RQniSl0NLE5Jh4Q
evu0FhRHhPAGLYpjKskz7PsSbXrjkX+8JLbyZLO0DzotqNusW2pqcYmn0cepBrG5O78gDs0v
U8yeXxHs5ufz893bl16KSWI6+47icjSfeL+jOf9Skt9v8fvnYF1G94pKPJGoxBI85dfKibnt
grK+//XmDTjSp77uIXCW2ndSGNp2i/HzGQm+NxzEanJitg1DaaD3A5/eZkRy0dSyPZgE8SEh
9vXp2+e7F7xa+48nEu/aPYSH0fjGr+4bew5C9LCQmI6YgqUejKL2X8EsXLwvc/nX/Wrtvu9j
eXFONgk7PbH9kp6clckaJ18Kl3nykF6iErEwbM9QR4P1sVouWfWTiqzX4wg6nM14Aj9ymkPE
v/ChCWbLd9+HEvczptCHJgxWHCPpcNPq1XrJVDM7YGWmj7n5SoShZyhr3w5iTSxWi2DFNhN4
60XAh9MPQmYivy+T5et5yDk1iMR8zrQbVqP7ub6ylXl1zO/yo0BVByFnkw0SRXpu7PPKgYEo
eOjIVAxPNeVZnMWFrRQYGAdPgP9YOHz2vJ029n0eXpvyGO95eN9R7pwtZvMZW5W2cWriCsSi
ApuuZaYVYiVUOc06tJYH74cP6wKipBIvQ0+7ikJkJRcCOErMrQickZpYgbkDNS4jGjg3cHZb
em4z4deyYl6DZJgyfJFHvG8yZ6MIByGtx4i4YUtQMkkxDoiFoBmkmty+f3ssWTv4mE6Q3V0z
KvIzw3nIMM+irmVZMxy8qjsjyujYCAwwLOuIHV7NjASLaDcKIfZ/yr22OcsEfjCcx31a7I+C
qU8SbRj5ncjT2E6aHN9xrCPMg9227BgJtZwF3HoxSOC+R5BqBk5bCW7uIhlUCB+nUzimVamU
5vscjKNcW3OG6cDfKilW0XQr1si8HiRwI4CLj1EB/OoEueiij6O7Dxbt9IWGjqH03uI6EQKG
03Fq+VgWCLJYNZh/NFmVtMWC65mu9jvNinIRsFt3p6HM29k1OjZkU+i0vVhVh3raMNyh7lfL
2bUsnLWaFdzMu1b4ezUO5vfr+bU6111NpotwDjuzx4Y1Enr7j9KUh7yyZBL4VAj2lMU7yYgG
iBheXMV4rWRfPf94NlKjKzVp6BaPN2FWYNQYtpWYZLht83Ez6X+EMQRtI512xyXVFpu3InEe
zDbTx+q0OfLNcL+FSq2WYbD+Z8JmR/4H/dNLerr5qP/xPl2JLMc7D6xZ4szX7XK2ms8xVHba
duCufbFyncQ5vzWBUMRU3nl3fVjPllg1J/jamlt12Yj6giepZeKz/7R0IjazZTj9uiZCq7kR
mn645H6Kbqlps/miZRYSw3DXKY+UszwTGZnD4MTHafPlgwpXGy50qJ+tYm4iIDhyl4zklpmk
Qu8XGfxfJN7tz/oUrmZtv5b6uxTlVktrzWXY9z52re/vrLjpWedyMYlL1kR+c9AsipCmKXnk
ULaz+ZSik85Lhx4mXTi1Kx8EE0roUuazCWUxacp2SXICtaG7f/rxWYPkyQ/lHXojSEIrqSWT
fO9I6J9XuZ4tQpcI/+2yGkc3rGZUouYtgo4dy0pNSstkxFBrcbaT5ZDUucvbCub99IEughQ5
znNAwowRGuuuH6ljZPJ+ZSNRRe8LGCvYI3JUHgwBVCAp0EFPuRZquVxb+HE9PVswxDQ/BrND
wBSzzdezwE7+4+bGmBjIOLKMb+7L04+nT28IHepmSDd2NsrJakpsgtYxI6tQ5n4vOyex6QVG
2v48pYHcSMaLzxKSO4WX3Wxgv2zoiZhJhdVkdkQyfe8EYiki6OTkA1LPP16eXqfYIwZXwmBs
xOS6MsNYhzSjeSCC9lPVqYa6s8DNGDmC1WAzgtVyORPXE2ioomiU+831Ylu0DTkFxRaadDKp
gQ09bTPSVtS+13ocJLZInhagcXIZoLZUUetYBrzujeHWeO1xng4i7IvStknB/OVdI7agUBVe
tXZygye4blWZr+nJ+eaL6iZcrz1H2kYMERcZ3B+DyPDnt9+wGKDoWakTjRmk464o0P7nfLwj
EWgng4zdkBl0KLfMntXPHH/hg+QwkIEjQVEkLKI1Ld33Y7LSo+R9Op3IR5W7C7vG/9pKFnO1
58dx0Vbcg3Gwkurec/zWCXVbzcdG7N6fQ50gCk2abvFwaPQVlpPZbwtF4pjUaJ4EwTKczd6R
9H3nctuu2tV0peo2VthX2ZpStrd0k6Aw6SvYY2/OHhSCiWP6wJ04deXs6IY2zrR56HDhq71m
lW6L+6BmyWKbpW3HdyscYwyJRhWWOxnDPsGZJ/0nBWvbYzA30AoDpBvZQ9wn4qbOjFN92lcG
l7pIBHtxUgU6WlqJqr7uTxrBMt7TECEtoGGgTHp0inKemLXrjr2lsigfSxIwitBAZqcfozwQ
29d/hZthKzzgHDp/f+ohjskR7AkBAgSLQAKsYxLtJpNM38t85LZBDemMnQvVddMw+g6qtQfV
HvSs4man1aX8KVSXBtd/CqNtUuUSFOoiyYjHA6kag75LMx8tJs1ByJCrL8lYi5iAC+MA3pIL
azXbPhY2BFgAiRGHxLPAi2zYxdTUAx0gpe1LBA0M70ovyRI7EPVdU6Dg+jCZRkHTXTeEYhg9
PoG/yezLGKsKs8/yHkLOHE3fffJrqoiwrQ+/bCsSgeDxlqIFWsJW60b6whOpFtfhgt8eZNXf
CEPZAya/p6ZDQ9MTQVKD3wdDsA6jeZBFfXGe+cJGTAfRGjqiGofLlVUsNT6aGP7s20E0QSpn
z+6oUzFjO48LxEi+xrXHi9gLgUlunKs3pWDVlkXKurtsseJ4Kok7AJkm4ISQ+uIo9dTgHSV1
2V4oXbenmc8fq3BBUu4dnsfFMBEzWDB2JFh28SGWT42wcdTNd1gfVaNvwxxw/s3BN9RlGpdg
w8Njh+kDOURRJAtTGJvrltklCZl7eEpHCljE/DjcHJL/9fr28v31+W+oNtZDw6hylYHNPzJm
NBSZZWmxow5YU6yW4D+6QcC5q3MikTXxYj7j0Ix6iSoWm+UimDSqY/zNMGSBmw7tUWTU6Y5K
67tEB/lJQXnWxlWW2JrEu11Im9fdtICGrad5Kjfb5jAxxOt///nj5e3L15/OcGS7MpINbRES
q3jLEQWBGKIFDy8bvA+Ivj/Ogm4Bv4PKAf3Lnz/f3r3wxLxUBkvQuJwposkrLgRg4LZzd4KL
PLlf+uZDlz/sPiPXHmQ1zVQxF3mHrErKdkGHvdDHp6H7BpN9AfOZB6DQgynVcrnhQcE6/mrO
HkIZ5obCRyD1JPmAzI4HS+LEQM2fPv0nI7e/JMSRj51ijlzifi/XC9a/f749f737Ha9p6BCy
f/kK5b/+++756+/Pnz8/f7770En9BiYyQmf/St8Uw1TvA1fIF6jkrtAXp7jeYYetMt89Vo4g
Z7x7JG33CvI6G8ChGBQm2Jw+OhdWo8AhzSt6jbZePTzX1iGv1CEmvikZi6EBtKeUzJvU2Sa6
MOhupNK/YT/6BnYOsD6YSfD0+en7m2/wE1lijOHR3XySrAidOeFCviKxLqOy2R4fH6+l0Wwt
XiNKBdpzTgtuZHHpwhZ0hcu3L2YZ7WprzS9aU9DfDpOex66SarLUscsa6cjmGLnjdWtyoenm
TXEcRXD1vSHiUyhsvWCo7dxGLcSrPYHSXwdhoxWdLQZnGVNdEHXASbywxRvum7BpWuU1DtlK
wjLzE6dVPC4vkxg+fMo4QIhBj9RW6n9NgpmnErDdRcL2Lv8fZdfW3DaupP+Kn/bM1O7skACv
D+eBIimJJ6TEEJTM5EXldTQzro3tlO3MzuyvXzTACy4NOvuQitVfE9cG0AAa3YJ46mGzVX8y
k0RccGuVnYa8+R1vuaLBbuVGUAtJMNJEQB4zHT5kHKkchvYCRxu6p0EO6JMhUOom9i513Zqp
wwEJfusI6FEOLPOjdshcnnsBhgdZDqfgALPcT/iC5RG9A+QZnl5q4VRd4xrE0zmNaZ6pFNrn
T4ePTXvZfUTkk6/09k0ACJ6if2HnrlCek+1JFz6dHDKPwvtqfsf/4QcLomuOx3YjfNppTkgB
6usyIoNn1sA9pbC2wfpyzxQB4T+0TYC8S2SV4Sp/IX99AC+YSmhLngDsBxQvU61mQ8N/2rOA
VP5aNqWHRvHjH/K9Ozy//SBOGxynNDOXuOBBD89mlmWBwRIw9xlzKX+HwFV3b88vtgLbt7wO
z/f/jdagby9+mCTgcy+3bchH2/nx1QxYZzuDeStG9HdfvoiIR3z9FRm//qfqIMkuz9wK5m5l
ijA2AhcRTVgNe1kd5J7O5odNy/bEP9MvtSAl/heehQSWtUSsUmPeeM+O5coYjYnDV8/I0uQt
ocxLsM4fWRhvRvXgeqYPfuhpJmUz0jdbzNp9wqWNjJ2isE+xyce8rI+9TW9g1646kh/pOQvi
miIJCSBVTvJBbLkEWQSuT7JeuEqsq4bv6kJ/Piw/bg0ddPqk6j6azgpkTzn34EJzZZ/YFlM1
BWgFGxVUYXztLWcGMkLD4923b1zJF7lZKpr4Lg6GwVobBSK1AFcpJn85jxq1uM1azYJRUOHa
05XOtof/PN+zvpql3b0xkHydviQL4r6+LawaiWfqZ1zFl424SSIWY1Iq4fLw2SexkRXLmiws
CBeo4+Zk9AqEF1YvuQVxfgWptTa4jR1dg02HFu4+nLd4gnr96xuf7oy1UaYq31K4a5wVB0yX
kA3LFam6MGor5czDpI8MVouLwx7Uu8YIg2XbYGTRt1VOEt8ztwhGXaWcb4sfagOCH51KBmmx
6irkpoi9kCRGjaWpmyn+2hZMkP6VHT5fej04nQDkDtSVad3SNKBGnnWbxHSwBgqQwwg/whh7
pygdPizm3gOzWDeHnJxdhZ1sLq1+5OQksgssgNTHTlUk/rEZkshqsdEG013KU77xA/Ox7TSY
bEGZAwRbAqR1f58MpoSKcNXweld/jTNhpQQJ9u5RGlQWOSX+oA52pByzCrxaPj6B+1FgFUOY
KKSoT0JlHPvm6M4pTRLPrG7Fjqyzshi6jDc3dlAo05LRRpVBjNRFPqdjG2wQj18hqDmAd7uu
3GVGyFGjPbjKeMKmOhG7VeTn//I/D+MBxLLXmLnG/bV4RHXUXcbOWMFIgLqC0FnUqAoq4t8q
268FMK+4F4TtcK/qSE3UGrKvd3/q8aR5kmLjI/3ioq04szDXJeXMAXX0sMDSOkdiVEqFRJxS
M9IxxupTrcmUNCJn8gR/AqvyJB4+n2rpoOfCOoev9bQCuIpN6SVX3VPqoLPJuNL9bnnj5L3y
xonvyiApPdwCXWfy4zWBHAVP2RzAqfUlO2NLi8QgMJZmHquQkb0MwmQOHxODP3vc9khlrfuc
pCFxpdT0EXXIlcr2Y3mZaqONIRYGXSnC/DbHQj3pkdw6plyB87Gsgs5ysVPb1p/syku681xS
YxLhirQkikxy4BfWENPbgkcQzkggpgEod16kjLJNBmeNny5Z3idpEGqnmBOW3xLPx+aniQGG
QqTtSFQEHUYag7KsanRil5NtVEuKsVZA1PzgygAODA1LMKW0+UjiYRiwUo+Q40bd5NoXH+1y
gr5LPaw1pSaMdqHCgr/kmhi4NuLHXoCmP2LYMNdYpEJltOT0skazSxmxirWQ8Ip08XSTVH2p
MAGgcqsbwYmu70Rn7p5GoW/Ti7IXV1Oi/EEURnZGk2qOlX96pLZSAd6lgR8i7SIA3cWeCpEw
fifVWD1LUYCQNxgi0M2GBkh7jTuH2B4vu+y0K+WkG/iYTHd96FGXD12ZetfzGQBfx+cSy83d
OzxpmqJOTKYZTf15OVeaJwJJHO+ijJN7aZx898Y39Zil/BhEoIipr1nKKEjgY+XSGJSd60Jv
fI8oEqkDoesLTaXSIczJnMZBfdfHfowJm8KRcm0OK1IfD2qIHhWgvoe3WM9bxGGNpvFgT4s1
jojgOQexO+cYW3RmDq7MeGgbsTyOCG4qMfMM1WWbHcCMkm9PsGfdS2pgso80Zz+0iEQULMJi
z0FwOOIjdPkCMCtyrBGq8MMla/AHDJJjG4c0Dhn28fTWlqe92hTbnu+NTn2Gh4CZuHZ16Ces
sSvMAeKxxq7ajqsEGcLP+wZhlgYIBxvZV/vIp6iMVJsmc+ytFJbWEfpgYvlXjq6VE8w1qs4n
BBk3ImTWrkQAMQuHmGxKKHa+wTT5XI/kNT50C61w8CXNx9oPIOLjE77Gg+4ZNI4AmQMFEGEN
JwBkNMC6bhg+qVDkOU7tNCZ/bWoVHFFilwmANEaLRLmuRNARJjDHCZvCFEWopxaNg6ZomaIo
QEaLAEKkZQWQxijAi5oiM1OTtxRd2/o8CgN8DcoH7Jxs7t4moqjsN/GqoDYxRWSlifGB1Kyu
ghxG1vG6SZAWAAc9eBbJO2OjSdbLkKLTFqevjqcmRduBb6Zp4AACpP8kENrAoc/luVXFetVL
yoznPd+zEaxJAEodBxszT5s38aqAiGuMVCly22jBI2e+xnpvsWhBJF7vnE1ZX9qtwzRhWR0u
+Xbbri181YG1J775aVmLLrNVR0OyOr45R+JF6FCqupaFRsBck4XVUcJXcqyDCd+rRY71J04c
Uz5N0L28MdGiCrScPR1WqAoT8WL0rE9nCfEVgM9TCTrkAQsC1Be0wpJECTK9t0PJVwYsKHDL
Ar5ZRqWdYyGN4rX15JQXqebQQAWIh+qnQ9GW/uqS+rnmZUWmd3BKAUqSBbB976NtxoFV2eQ4
/Qvrag7kqx9KO2C74iXXOwMPnVA5RHz0AkThiOCwCalhw/IgbvwUWQ5Z3zNUmljT8HXSsYb5
JCkShwu4hY3FCcEMOzSOGNsa8qokBNVlqkNGvDWpAoZhsOvD6ZTgafZ5vLaz7fdNjoW+7pvW
95AmFXS0EwWy1iKcgc9oaJIBQfVQjoT+mlicqyxKogwrzrlPCOqbfGK4TWgc053dQQAkfoED
qRMgLoDaVRZ0VP4kAoPZNECyGWs+H/bo2iPByBHzUKzxGZb49BxPuTYZKZZ5+gwcjrfZpyPq
tGfmkc8PxXOgS3kAN1wFkgX4HxT2ZTy1f3pIVpY5jzj3ub17u//jy/PvN+3L9e3h8fr8/e1m
9/zn9eXpWbt5nFJpu3LM5LI7npFy6Ay8UTWjAxfb4XhEr0Ud7K0elB1jK0ppea+y6zV2ORBl
x22/dOYjSlZyUk6p5TEe8u14IGFLyOiGyAbE1v0dsnT6ApFu80x1XAwWQl6UIuUYX37b6X6u
KuGAx/5k8stjI6PxlZraYl92u/Y6tTuEfeRrDbWMr9HH1crnsB+DyEdYxsJF18q3WV01se/5
l9tCfRIVUc8r2UZQFeeWYBwz0pZ7ED7OMiISwK8ip94xn0JLcymW/fJfd6/XL4sc5ncvX7R7
8DZfq3wFFtK6XZlRlMmkxJXRnE215KQMpqKXb1smq4h3y8t5VovMwMn6kbFqo3kZUF1QAgtr
O9VNuPgqr8CvN/71hJpEeJRrfrVM8hqLo7Dy4S2kL/xZuNLR2dbT0i0zN3mTIZUCssEkK5JX
Du4Zx8jsmBvkpcQGwLZ1xvY4N8SjuOTNwYEaF9sSQ23Dhf39b9+f7sHUeXJPZN04NNvCeKcM
FOwmVdAZjdFj8gkkih4GDmonSzwj+awnSexZC7XAhKtIeIbBBx465BeufZ07DoaBh7dNmHqO
hxWCoUjD2G9u8RDAIpuhJZ7rDhUYTNPjhWY6glMQ14Go6AswTUY3tzNKQ7PNBDlZ/Ui/91vI
qCUFdJy4/B2M3hwtILXOHFdbzQOcQpcPprWcBYKffExwhJVrBqmVk6+eJAqaNMvUEt5lfQmP
A9hlh75yEF2U+3RQ9y0K0a7jBCCVbFoSoTdkAO6riO8jLBfOfL/KtSdW5dhGAkCej3zlPNLq
ltPyvZoGkJjDxypkXX1kEcFOtgAUlqt5cyzUK20A7LeTQE2StsFD0S5oiH4UOWyX5CgZ/CCM
4zWGOI5Qj/ILHBpzjqQmEUZNKUJNAmr1qbANWC1YkhK3ZAs8fef7FN/OC7yPaOSsNgfFsbn+
SXnYEn/TYPJefh4M75tiXhhJWjLnqi078crJkTtogrrIKGYYswo0ujyVV4UmVTekGA175Rqh
JbxY0qpEYRpgFrvLwz5MsNEk0A+JlxjJSF3ZTIeVufWoVIWrII4GpKisCdVjhJlkKCiC/uFT
wsXemrTg0AgViGwzhGP7OAWG9U3rLPRkcKZ90cODPkrD4dKz3Lh2VdhmW3XtYzCRSbBzlTHl
ujFlZHoAtGxIWhb5XuiI9A6mI57jLl+CsXtekQxJ9A4DehM5w5rhylStyUbfJodRaLBbdvMz
VZrNm9TUt1bukU6cN7AaE/4cdWThs7dqrzptB22NcEKyU6FroByA4IZrw+O29klMkUTrhoa6
nZbIKqdhkrqWqPmhgDo7DUloKUX1Md8fsh36DEnodvIJiKGZjp7MpfKGAIbnmVmRIviFkqh+
E/oebiw3wQ6RlvDqkiFg15DjYOBZ4sOp1He7UFZY1hRVYAm991JJU+xEV8y0x30DZzi+9tRC
RcYXOPqEPn/lMOCSsx4oVq5tiniUaJ+4jJO37j7GtX1ST0B2p9p8hjBh+ZLqQmoccbPqqnOE
G80nL/DYHZ9Awb2ZNo12ueLeHU216iAkL5IgB/bVEO4L1bNEd6kaw9O9JIGLLDyRJi+1uBfw
AfjCrDojGafzVY4t7qjUL7oSXDmi7mogmFdXZs3nrNWz3h27tj7trCLtTtkh00h9z5kq5VKZ
N+b0qNwoiHwWWaEu2CHoKbjWMz4Z/e0J975N1eNuIIDPKMGwOQ6X4qyc3OdlbqgcQDkc+2pb
qU4hRDQ1gekuJhc6GGvjPv8kz4grw1Ql8w6se9034YRviu4s3Cqxsi5z+9isuX55uJsG19vf
3/QXKmMBs0Zsmt8po4xec+nPc2mNBgCHlD20vJOjy+AJlwNkRadARhmn96pYKQ1WYeKOss1P
QK02mUpyropShI80e4L/ABNAzW1icd5M4iEa9fzw5foc1A9P3/+aQsstx0Ay5XNQK4N+oZn7
WwWBPi55HztWCsmZFeeVsIeSZ1sNJd+uVAcR4e+wQy35RJbb28P0pmFsMqxqinwprpWWiptS
NrcgNNxKxyCJidSKh98f3u6+3vRnu3WhK5pG3WgBRcZcVVmygTdV1kK4xX/6kQoVnw4ZHMCI
9mH6Z9I1Gt+igC8BPlMxBq+etfsBznWqS6wPxrohpVcH6HxqKKs6Opb67eHr2/Xl+uXm7pWn
9vV6/wZ/v938YyuAm0f143/YbQ7xNt8fMHAc6x78cszOrfa3Tu/LLIxDbbUXQ5zv1zyFKgpi
0KQjp5G2rKvz9+hl7wJHRvJNl6jWEEAq2KYzS8ZFoBJ/WUXeZ90HlKjtGEUA1hJf2EX01AxU
gsPRKFyWer5dTdF6EabAjdlnWRx70R77chsl6BmexOWOQJlqgnpEKpYpUWe1j6QHKY0El2K9
SezAh+4Hu1CSjivioxh9BrfAzlLvShHo1eyyqju2eaNa147Ns/WjbVMh4iOAzt08XJTBVXVu
pig8VVrET+3+qAXwEOTPxxoi/xnT+ea0JYbSsNCR6V/QGy4yLUO/aLKa77OmJWb78HK9hUd/
P1VlWd74NA1+vsmkYzNjOtxWXInrlYVMIc7BP801UfWEIEl3T/cPX7/evfyN3GxItaDvs1y5
apGLDSh+ZC529v3LwzNfce+f4aXxf9x8e3m+v76+gq8acCnz+PCXlrBMoj/LrbCxXPZFFgdU
G5MzkCYOp7gzh8+3etjGd2QoIRhkmCOJA4IeiEq8YS0NdE+9EsgZpaglzASHNAixz0JaU4L7
FxiLVJ8p8bIqJxQz/pdMJ15lGlg6B984xjGSLdBpupLpuSUxa1p3E7Lj4dNl028vnEnVIH5M
BIS0dAWbGU2h4DNiFCaJmrLGvihiahK2tsT3t2uSIjnwh1ALR+AInrBwRA4z2IUjQd8VSHzT
J35qdxIno15BZ1Q195TED8yTPlaMpJo6iXgpI8xCeW7w2FcfBKnkARkocLbEB+ia4J7b0A9W
RiHgITKWOBB7nru9+luSeAHy3W2aohaFCmw1GVDtep/bgcp3HoqkgQDfafJty5xosJWpJx9I
mASaexZDjJUMr0/O0RGj/SwAh6G6IvHxu2PCYU+9cNDA3dACT6ldvKxIaZJu1pL+kCSo342x
s/YsIR7SenNLKa338Mgnnz+vj9entxvwzor01qktosCj/tr8K3nMSULL3c5pWQ5/lSz3z5yH
T4RwBjYVxprx4pDsmTWbOlOQPk6K7ubt+xPfJRjJwj4bbKv9cQGY/IgY/FIHeHi9v/Ll/+n6
DG50r1+/2enNPRBTj5rjpQlJnCJD2XWqOdYZQmu2VWEe6k7KirtUs3sXo6xGBjvmRxGeuPWx
ogwBZmtb+VCQJPGk88vurJ1x2p/p2lN/Ogj/pbKI31/fnh8f/vcKu0TRF5a2JfjB/22rhnVQ
MVByRLwnF5qQdA1UPUfZ6apGzAaaJol+OarCYqODHhhbXDGeQ8MqT99DaWhPPPQ5ickUeWtJ
oB66DSaiLq8G5lNnCSEiOuqdSWUacuKRxJXEkIee6YkJZQt+hK0Zap5ciJ0C2WyxdTY5onkQ
sMSjzkaFiSZCDWcs2dLu7BR0m/OOd8idwMgKRtek2Seucpc/1ITbnC/a7/VpkyQdi3hyvXN0
nLLUQ9/36IOe+KFjcFR96lPHwO34yujqvaGmnt9tnTLb+IXPWxHVUS3GDa9joM5+2HymTnSv
1xs4Cty+PD+98U/m4y9xM/T6xtWqu5cvNz+93r3x2f7h7frzzW8Kq3b4xvqNl6SYNdCI6m9l
JPHspd5fCFF/5j6SI64F/+VMH2BfTwoGzjCYKXFpKBg1Hrhgtb4Xjlf//YYvGnx1f4OgTXr9
lUSLbvigZz7N1jkpCqsylTkk9RIekiSIsR5fUDotWZz0C3N2kfId128DbR8xEwk12q2n6ogG
0uea9x6NMGJq1S7c+/hOfepfor79msTDw8SDpHbyUhJWkk89S3xgYfVQK5mprzxP9803fUUi
/B0d4OeS+QPqqUR8PU4MhW9VTUKyRyieK7aUyk8zeyTJlKzySzJ+s770vrMpuZSqF9cid8aX
R6t1+XjyUBs5IU2bJMr8yB4dfE3zVSnub376kaHGWq7mmKICtMFqExLbkiDJ+BHpLL3UNfj4
OC/0bOoo0DwjLbULrKnnMPSRa1UbB17oyhkGGw0tYSmqDbQ96n1CxXPkwxgA93cAt3rFODX1
0NEF9cUO2QDOtqmmBgCtzNHlgKrKp+wurtoTr7O7kdMDH71aBrzra5JQIwdJJCgRdmXoPI0b
YYguKXy+eMPl1BGPKToXVFdRZonPx0VmZVmFKSZxDlHZ8AQVP2LJipxQY6soWc94SQ7PL29/
3GSP15eH+7unXz88v1zvnm76ZUT+mosFsejPzrHJBZx4niX3xy70CWpUP6G+fp4M5E3e0NA5
z9e7oqfUzmqkuxfXkSHCHONKnPe5KZkwJ3ipTsxOSUgIRrtYp/4j/RzUSML+PAtWrPjxaTDV
X2mOwzNZnV9gKiYe9oioMLWIf/t/labPwRLeaA2hqQR0Dgkz3cAqCd48P339e9RMf23rWk+V
E7B1k1eTrx3okiqgdD4dZGU+3WZPodFufnt+kUqTpcHRdPj0L2N2P2z2JLSEDKguVZeDrd01
guqa28F5QOBZ2Qiyw0PSgrvUDzhmMCbdeseSXR0iRHOdz/oN15PN+ZNPLFEUGgp7NZDQC8+I
mt1xZcGpFsCiQI3y7Y/didHMKArLjz0pDc6yLg+z3Uf+/Pj4/HRTccl8+e3u/nrzU3kIPUL8
n1djTk3Ts5caQ5u1BNlF2Zsl/ZDJvqgThdu93H374+H+1Y5tl+2U5ZX/gJjlh2PX75UzvF0G
4e+Uyz1JEIYUu/akGVGoQZr4D3GCdyk2FUb9P8aurcltW0n/lXna2n3YKl5EijpbfoBISILF
mwlSovzCcpJJTmodO2Wf1Fn/++0GSQmXhiYP9sz01wBxbTSARrceEBSpRQtCarwH7dMtKxBV
ft4kLw9o20P1KDCdK7mEmTM/iPTDfoWMrx6UZQ2vhjkKPAU2F97NN7CwppmlwliGE+yBC7xV
rTCiDj1V5urlnLL0RrDvrYbDEJpkVYCTpB95NalXckQdsfo+TI9JhX/L/MSLd1qss+X0/AVk
lu88FdPN8RZBYaMtv1cWKcowpe/DVhYMEIRHiTvPzZrDZ/tX1zzb+wo/Kx1dpQVifZyra2S9
ZTpWcNNI8kGdBsm7tidVQWBiVQEzxeywmTaHxTVyXIBcUNaaGsPySU/yI4bBVpOGeCHP8vbl
P+fb2Pxru97C/hfGr/r199/++vYJjZM0KTVnO0Ey3V7g7+WyrLvf//z86ccL//Lb719e3/pO
kROVAup0KnLarHeWDmfe1byc7NeKd+urJ2UwP1c3w4WzwdP+F5hr1myFGWYPjKGgHCqoyujm
JUoeHtkxMvYiOLBy1uGb81NRCQIpL4U0yR/G0iTsm/zkFGuJCm1FbtQYWgZtuD6VXtus/fTl
9fN3s6cUI6wEkCfvJEjPktsfW1jkIKePQdBPfZW0yVTDHjPZ+eXEnGrf8Okk8LFWtN15NjcG
c38Jg/A6QO+V1M34g3lpOiKb+U7ljW/xUhRsOhdx0oceP6kP5gMXo6inMz7PF1W0Z759v57i
xurjdLiBghltChGlLA7eagBRip6f4ccu9sQgInjFLstC35K08NZ1U2JM2GC7+5gzutneF2Iq
eyhuxQP7dsJhPov6WAjZluwGjRjstoV5Xa/1E2cFFrTsz5DtKQ436fWNqmlJoCCnAjaupJL8
6HFWyQFauyx2lpdkLVOA90GcfHiz75DzuEm2pEJ856rRgLzMgk12KsOQ/mbdXBhWRM0VegtK
8e4C45jrztKUouLjVOYF/loPMCYbkq8TEn0nn6amx0enO0ZyyQL/wZjuoyTbTkncS4oP/mey
wcDxl8sYBocg3tS2mJs5OybbPe+6G8aPawaQW3nHeU2z3goBs7yr0m248zSfxoQ2AU+bDyP/
qSq/PwXJtg6Ww1uCr943U7eHcV7EnqGyDieZFmFaPP/ug5fHJxa9lSFP4/fBSJqweNirNwvJ
s4wFsLjKTRLxA3n7RCdjzJc3F+dm2sTXyyGk/GZonKDnt1P5AUZRF8ox8PTkwiaDTdyHJX+r
jKKHbhLjJPvtVvcO5mHJdhfPZ9GEjeXjJtqwM+XGx2VN0oSdK+qTfYt2h0GU9TDOyEIpjvZo
Xo480G4ob8uyuZ2uH8ajRxBfhIQ9TDPiuN9FO9qI78EOUqDl0KNj2wZJkkdb2hrCUgIMFaMT
xZGbO4hlRV4RQ4947I/3337/5bdXZxuhorrC1tBb8vwEvdfDB3Cz8WT5XZcYINXKF7yXE9WB
CV9+0dYoSkHjR4YuxtGDXNGO6IzgyKd9lgSXeDr4FyXcorR9HW/I9+RzY+EGYmpllkaECLiD
pDNDtV8TOKRFlkbOjATyLiC9EKzo7CfUSoQq0NJ93or1J1FjTJs8jaH5wsDzMFOxNvIk9mwx
CiQN3Qm2rTkPLDSzS93DsnFoN96FEnBZpwkMLOuKbUnbFmEkA4+HY6Wzq4dPIDVYPabxhjJm
sNm2xptLAy1aE1Cx3IvLNnHVAQ2anwU/3ROvnP6TBnJHsRAndtpPlsG1DotIPoNznutnVv45
ryfmfc0uwpHCC/mJazrVoF3eHgc7bS66DnYcH3hFR6dXxyVVGA2xJ3gdhg9GptOYxcmWVr1X
HtSio4gaDzpHvDE6Voc2nrfyK08lYOGIP9CPd1amjresJW+iVg5Y7RJz7GvINk58Rxclir6b
KeH74jDajd6FpPfLZXvrShnK5Gjen7rM7MKO1FsbQ2/lda9O8KYPg+jOcj3COnz79Mfry09/
/forBuW+n/YsORz2U14V6J/9UUOgqeedN52k/b4c9KljPyNVUeTG3/kBH1uUZQfrjwPkTXuD
XJgDwJb3yPewRTMQeZN0XgiQeSFA53VoOi6O9cTrQjDDNwWA+6Y/LQjR4sgAP8iU8JkeVo5n
aVUtGj14LzYbP4Dmz4tJd9ZxwPNl9JHDTWZ8HlyK48msEfItp5smOx5KYP1hrB9XXcQYEf/8
9O2Xf3/6pvvs0us0ixK6Mm1lLNgzBTrp0KDysegd5KzFjG+w3bHvJnSG5kB/FX7DJ5RGLfFh
LGzqKoN4YeX5BtPC6qW8T5PEE5HygFcdIJNY7S23qGTvBS9HFlJHL1gdUDTxRZTZPTIsVkdQ
ej71RcAYojPqxIVZ7EjyeA9bUXU+aHxakfXRZNRyS+pbalCqIIU/HBLI6bLktVC9oOe1wjfZ
iw8DrVI92Kg90wO1XghjNdTxs7c3+xstlmfMygsok3/EInqkT+QX9N6aPiZJbV6RrgT8Q6m4
k4gKLwDLc05pBcghpJmVkFNsOuhYqaQLOByAvAHJaboNAzLMJ1r9AiwuyCDcOCuapmia0Pr+
pQeVnd6+oNwC9Zv7ZyHrqLsBJYFiq8w56ypBvlTFRlCek8wE6App8NVlKEzJg37xj2O/SUyL
HKyf6PqB0RHTcUBz3IU3ladgaCYQmYaTD6p6rHwkvSZpTHjiZU/FBfLKihaWdfQ9Oy/45nCx
T4Y1TKIVztZOUW1Dej9NqiRq4dl/+vl/P//+2z//9fIfL2VerP4JHte29w/gSV5eMikXvyRE
ye7T0WDUPF7e8TXwudbaD3B2H/Q0/1aFVyXSzu4Nn6a9h3smkn/Im2q6lpxyh/bgWp1f/kFC
WZYGVJ0VtCUh16ealmx2qkklg4ZK48BYnCyQPo/RmNos8Tjl0krH6qIhw8c/eDQ3Zw5GRYa7
DwTTo+ujYBdo4G3ZUmn2RRoGZG6wOxvzuqagxR8QBZW80HeRb0yJNT2oHhIjU1lvkGnFUG2A
f6yGG1++f/0M+t+yW531QNdSAq0e4FfZmD5zgQy/zY60ZY6+LezYunfWqrjnQO1lhqq6aV+g
yPCzHKpavssCGu+aq3wXJXfZ1LEKFJ/DAS197ZwJcImbCGIQNg7d7Tlv1/SWxQSd46Lc9+zM
0ZBCv0B+o+3XfMvmqI1K/GtSdxiT8rGgdYYGOaooxZSXQx/ZR1dL2RybmfX7shlqPcpbrbv5
rwvlr74zSW1eOYSJl2Yuiih4vksyk15UjNdHPG9z8jldC96aJMk/rJLeoHfsWoFWbRLfowuH
HzZl9gwwWUY4iDZSoqUMMXzXCsy1N8vv8aqCGNoQgYZSyHdxZNRicXrUlAV6vbEaqmvy6WDl
dEHPmZIr8CDtgj9QUfeU7qQKumwSjJSzZcGSnhxQa9XHbqifOOBBtrwvcV8mCjVzPMW4zDHI
zepBtw7omb4jehtFgEvG3p74BbRIGvOlgP51IdDm3DRVO2yCcBpYZ32iacsYptjeoW5IquLF
z9D8LnIZ3XxYvtvOp/i6LqF6cHZ04mntKzrysTOTuM+uKt3fx0zOpkLaE24fpi4V3agYHcgK
t8hFmIUpc4mbzKKV0ozyg7SPfZiaBpsLOYrJTfgdNS8K1LCsRBZ7XP3dcTpOU608M0ZxaJZO
0VKTxmVoRlyaacYpuWrQPLUM/JF6HKRSYwWlui8MfOw7XlmCD+ggZazeqWGCXUEHsb9yB/A9
kOdD79nHj2HqjmLJIpvYi100kl26YvfGM+UsoqTirOad6BpnYNpZ4LD0pJd7duV2BkByJ5qU
OWudRsL2OeAtnHcdEPbYD7Ns5wzVEt/seAcdwPb7SwMVySaxRh1IVTG2zncUVZ0RekKAItOQ
ZeTt0QpG9vwbFuNkM5srGa1rnnpxHFmjYN8bb4buJGVympeNvTrnLAgDa+jB5MQGN0fXeIM9
HSFsFd2dqpk7fVN7Ws60qeZXJe3McvXjQdhtUbCuZJ4bFjUxVXQrL1yym53cyXxjTXXMcWOX
Y86IjHmFk6mpLQlcmTcQSkzlpyYmw4AomVGIY2MLGKQJklq8d6XOzO0JP6ul9IkEWLXD4Gz1
4kJ0p/UCWB3MaxnG24AiOgIK5PYuJmN7LWDqCnqg3X1Oucjsj81Svg5VRoc8RN13XnMNfqRR
z8lUE+Y83JqPve9kz/X1uiKU2egfpyuD77vnpjuGkfvhsimpTbyCxnSTbri0k8BGQPZdQwZA
UwN3dFSxuooSS2C0+Xjq7Kw7AUtOQQZ8QbTisbW4AWmXOrkgkXw/qFYTNAW7iL1bMeK4U1f3
BMusw0CN7Ap2g6frh0Za8/AyRpFVnVt1mKWoOhQ4Ff+t7Jo1hylqdFmSAghz97vkeWf2wyZ3
fCa4yLzn2nMq1QNTlX0X2gwtBipSjxHsfcNJHToU6JaWs9JwrGfCs22CD5XiWDGyojM+39qS
0GJtYM3TFfVesFlsTc1HVvdPMoKl0buAm2z2ULbRZX3zfUj5PHjzQ1LEQbJxP/Q4a7X7sLmi
gwfUPZc4byrk3XIccR+R7tc67mYGNXgyHKoWmrPuXajFQQJqB5T+I3+XbmyduVQZL0PYFCpt
bm3SsToVc3ZjK105LIa9mU+dZ429MWrYdGB7aDtc0TFIna17AUNT33xLJMI9k26mfQNyibt0
ddCDcYW9CBrEOHo3GQgAEXSK/cMi2OY0BhlfeFCuh43vIffAQu8yqXA5Rjf3IzkT7IOHTK3U
CKboPdJNcxIHZp847fMiCuxtKzKjuYWzdAwqoBp10q+hp4JK1sNo9rq3XZkurBPMr2Bhta6C
jnim1kwMr2adOI0tKOjcWnDbQvVdfrB2Uk3uEOYzCzOg9YIsUsI6+3PY+qZtQGrfXGR9rmOP
zgXKP4IGvY3CXTXu0MYJjS0ol6xWmq5P0k2imO2dV6UsYYlKVuLcNepcrm/s4uzzSkU9RMOy
60nIvjRtmOYXtF/zxXMkvps9fHt9/f7zp8+vL3k73L3FLM8vH6yLf2UiyT/MRV2qs0R8pNI5
smrFJPPN6XvqAVY5+xxjTS3ts7YVaAtx8H2Tv/3RSuQHUXozwBo9yUFUoyr2YLjofNrYxnIA
XXYSaRQGixR0sj+6oxKIKqGwD9Y0jJDsK4z2sCADy4mOLquzqrb1fmdG5y9R34GRiPa+zXwe
BJoRzBZqaPdn2K/nF1m4mGwOOD1LfuGl2xCIzvqmU1GETOMfkmU+l4ZZtSd9uGusq1Ir++r3
n799VS7Ev339gncbQIqjF+BbXFfqF83rgPj7qexvL5FZyeGxYPM6h079GQZp8PKtU8VG+0N7
ZJ4BiOaw84K8tsBs5O08wjbE8XqEbGMg1qehFyXxJcRC47WBiYxeJH2C2KENHdyvaaxs6CjV
l8U2DDPYpTwdZ3c+2mDiznbehIFz7LIioe+YYGHYJBnRCOdNYmvPCz013RXpCOmi7MGQxFlK
ZZkkiXt8ikiZJynp3GDl2BcRWvG4me7xNtg+pAX6HPaN+FYu46Qkff6YHMS3ZoBs/xmijJxM
DqJZ8Fiw3JDDR0FJ+MaomLkiT872ocQd2JK9ixDpQVBnsM+u7nTn+OqB/I1KbEM7HpWOjqMz
PSi+OIz9R0grz8anxN8ZdlQN0Uu4cxKtoDEKtpFf6UUepQY+G+NFZe9WkTob/FPXbYhyuQ1j
34nrwhBtCOHHZRbbdysr3T48f9B9onJBnwvKY1+llOzGl69Td44DanZUDPTmwL7NuiOgUTtn
yHcwCZ61jGLRn78YwM507Gx+dEubE5pMu+fDcP687xxFccgq24XpdM2LNdqPW1jYrYSpfauw
AtuMGMYLYMaEM8AdoV8vwNNUy+wlwCz1ZAmAb0yt8PNBBVyx5WbWgt4QPCuXr+wwSzLmR7wN
MqO+XJMw+j9PmRF6u8yKyyMtYS7FpDHynaFMibtQhfQgPmEiF1QUtAdTklKyA+n2/fRK3zgX
6CuSRfbnCDZQsP4OVxj+La7kTS557EvPA/s7ixUW50E/Vsw1XtAQeszc0Y4fK0YmVw8GGfw/
h0QjOLrDoul7Vwyl4D+rlqyiOEiIzAFIA0LNWADfaFzh50MauDZJSspc2CLG5ONKnSEhRYDE
54js2batZzJKElL7UpDtt5zg2W6fDRPgSCx3ozq0Jf3sGxz2hfgCgBJO6O0qYEtIiP3+wHbZ
lgIekU3IQj7gN7pQ5yTl3p0hDh1TFAN2bqA0uMjH0BN35s4pYxZFW98R48wyq5REKRBJSCVf
hXd5qm1dqywJie5COt28Cnkry4zOchsSwhbplAKngs2QMl8hVEwSnYHSIZFOzzuFPNN1VUgc
T6225GRBJHu2bQOGOR4JSfdpGQvqCw2rsdFBTQwGctQgkj4fsIrluaBBlu0b42S3pfsdNGGy
YJLZYT4cno9lnAVvlP6jOl3apbTPQ13f3SaObZKC+jROnu3IFAN5cgBI+kbxanTISb4y0zky
atoqwL7AfgBkd/ctS0GHYvSLFPNgzMh2Xt3RRpc8/nrA1oWAWu6PHWtPBCpvNb4ync+eF/r9
MmS9gxeFa4UPxEcK+GPaq3PDm4pHWx/7k349BjgdN3dwsnncys5HpX++/oyuQbEMznEh8rMN
eowx82B5NxhLxJ04HejzXMXQ+jxOKXTAG1kvvOflWVB2xAjmJ3SoY5YxPwn4yyY2nWR6INyZ
OByZRatYzsrSSt12TSHO/Cat9Ori0qLd2o5LabcR9NKxqdHzkKcmHN03HuxkGOy2oS36FPwR
CuXJ8MirvegKO8fjofPndyybTjSkrQLC8DHluMis8fnGTcKVlX3TmrSL4FdlG2ONyVs3P7Aw
qAKjMVqk3iK8Z/vOavr+KuoTq+0an3ktBcwb0hgdGcpcXdibmc1PdAxC3VwaO3P0deEJ9TiP
pqPIK2hRbo+yEt8G2sTboWTSal4Vovro8Iq8a/BFjkVu8DKH3+xiVkPZC9V3noLWvTBzajrD
kEbNAlajqwoYI8ao0sjPhEDLe1beanrRUwwwbfH1E13AtmS1cmqUS3tuCsP2GWkw1efSGx9Y
nDt5CyBbztFPAvV2QuE9Z5X1oZ7zEgNxc6tU8KG2HCxiZ1oJqQmALsCYJI1tVD4V6/r3zc3M
TKei1DAXhKkXF/oNrwKbVnLyuaFCTzBVrEr2J4wWurzY0J1raHSr57XUAy5QUytju+pXIeyY
8ho6irpqzHJ85F1jtsNKmdtAZ70VsCrZk0aCJGi66TTsSXoOtWmq5S9r3StbIy4ZtXiqVXWQ
e2tVv9d5tiGhPa3M478gFRc7y7vXWlJ7wCvBeek3nMQavHeDKz1XrZTNKReaD4yp4FKzfKI4
qkp/VHnnMNxlmDh/Mwebwy2FE2B9eDxq+WE2fMmVBSZl36ysh8pWTIYd1JxVXVvvRZXhUpef
phOT0ykvDMRkM54IqHR13Qx1zmf7cvV+Ta5PNM1Qb9jlRIBxFet5tpub8LWnIJ1EKy7PezTV
M/3Rbh0goW1Kz0srS4drX6pHrLLHWfSU8yApg9WlL6TqjCPIDSCoPjQaHu3m5ADyuMbHaSW7
vYvMD1TmYv6Yel+//wufXK7OyAtbsVXdmm7HIFh6z8h2xCF3Iteg+4jEZH841K5pVJNMfU+M
4r7HPp/dTruo8bRhbOUsKfJiMQywC6nSHCT1QlEvJJorTs2B+J4CS9ajSYIulFXPjUMUBqf2
SSsI2YZhOjqjfzpAt6OtzNxCZn+xMd5E4ZNcG7JtG7MysBkgpIyGl89xH6h3gIFIe1I3bzXg
8HwIyTILQ6qF7gC0L714P7hySkFXQdkzjBwAe0ynITHjfV4xszZrFa2yIBk90CtLbHKezR4d
XvLPn75/d3ePagrrtnxKHHbK0MgkXguLq6/yVSTWoBz840XVum869I71y+ufGBHgBa3gcile
fvrrXy/78oyydJLFyx+ffqy2cp8+f//68tPry5fX119ef/kfKPyrkdPp9fOfyvrrj6/f/p+x
J2luG2f2r6hymqmaedG+HHKAuEiIuZmgFvvC8mcriWpsy0+2642/X//QAEFiaci5JFZ3YyWW
Rq+H3vH5x0mVhNHRp7ufx+efWuB0fSmHwdyMtMKhtBBGyp7PAgEfR9bVAqB6RcJVVNkbXOLW
ufd0T8VHCsvALikR+YUzXFDIZi9VHm4IBINN2uCWxePdG5+vp97q8f3QS+4+Duc2i51YECnh
c/lw0K8rURO/Pes8S7BXqmhoF4zsUQDs0vAFHp86gWo77yxdcxTycugxnFWTvSCFb69x/BBp
fuj0XKanuHv4eXj7Gr7fPf59hngAMFm98+F/34/ng7zwJYliyHpvYgEfniEb0APSuSGwALRY
Q96GC100PqVTg33wyRJmIKkW3jiIo4OuSnCqTyljEQjj4kuzpuz6ePfzkFo8HYQgpWFE7DNJ
wfl7AjdEMYgurJ6Wxhl8i0lZ6sHQdO/BOD4P6qqc6bFZNKB7f0rEAEZoz3Fbho/LWdoopdwf
Di1C6ex1WIxiCaIH+4axmeleLQ5WPnhzHbZVmawtWmeU0unQ4qpSOpxaXGG4qTbW/LNoy6KV
3ZskWuUVyHS804QLGsQXlQI8/v8smDpnU3AjonX6pz8U0h4vPq4g/kBC8HBmYpQgLG0i+6JE
gqBOY84E8qc3pJLxBLEV80M5H73crjD5gpgHhwfmO5m/UbZ0WRJfRGEx0HxHSr6BsZiaohrO
P9i8J+MLUvAVMd1XmzKyPxtlEB3HE2sYCG54IVyAJBq4FTO8x9U54mrcwPpdDieDvf/xsmb8
4cT/GE1QtZNOMp6aiicxozS7Au8dkef5wk3MP1zOLPFtu2eKXx+vx/u7R3nT4pumWGs+EVle
yBdMENGtOe/wgK23xuO2IuttLl6sujhHAeUps7xRb80L58eoP9CD3VzoutEj9O5uTix/dBGb
CIKFoobhLqH1BG6QMCkgmd99GyLYhless01ay4g/zHiGNmceFu+o+46H8/Hl1+HMp6N7lZqf
MYal1rfuCPWUgqvAWl+r0r4CkQeAeUgWewLpzo0W0i12zwB05H27ZJLLtYQwHMprEg8ipzro
DKaaBOQyDJoumLwZs0Vaiti5sEkaTiajKTJJWVQNnVDvNh7NaC2mOL/aWGfXamimtdbWiXyl
+zlu8fTtX/hoMr6VEkfoWwldPcbxTZfC1ZHRyvosannaUMsZTyw2lDTmPWdM7QIbZ++ouN6Q
YKAiKT85qKED2wY2aE0thkj+aTeloF2vzXNVofkL1H/4KqJ8eeFCaamy36kq+k2imm2WLLpw
MSjaMgvNENKeKlHPcIPE+pJ4PXGdQJzHz+pqvr2vDlgGn1ehLxb84zarxt8QxGr6vCHvmmqW
oL/+Rl6BHuvNU+3lfLg/Pb2cXg8PkAGxS7XlSG1BUeHn+Lwh78XRU639t+HFlSnPp9i/hOJN
FoD29QKJvnIudMNl/81aIOqWK3WwKkFm3JKLBHV72l2oh298/oS7QCC0oRfwPi2NxIbLFZ6g
TaJ30TIg/o8CyjBsJrRj//PVpTFtNwWaBkE0BcEJ2Y7yN4K+ztMUK5BGKauoHoxHQVp5gJT2
HJ5O5w/2drz/B4sn3hbaZIzEUc2fUhs0AG7KijKvl038n648kzBn2+ntfirlb3tR0RjWQnfT
tJjvQoOe1aO5IWBv8SXOuHR4GWrC1PKAYge0G1okR9B1iKBeRhDHFloLjT+6WgTRsoQnUQYP
0vUO3gzZytTdismB8LHIxxA1kGzUH04WxN8G2Q37qHuM7AH4Lw/n1pAEVPdqk0OyXb8ktOz3
If8yHoBGkETJYDLs2+ntTRoRpBdj2Trs0Jlkb2RfhZ2Oh9YgALgY7q0BgyGc7gUngHy4i8nI
rqCBWppDgUJASTFajMfOpAEYjTLTYCeT/b7Tddq44cCdCQD7Z4Jjp8j0FfMJGnZBYeemA0g3
/glmXN2ipyN7fmUYZacDMnSyf1GEnJEYjll/jjnOyebMwM1y9Yac+fdPbjWaLEZW/1QEZmtV
BIPRbD5yul0FZDrpz/z9rpJgshjsvZPEXw2zGa8CXdCTf33FKBsN4mQ0WOydMTeoodmmdXwI
nch/Ho/P//wx+FNcRuVq2WuiU78/Q5pZxPSh90dnOvJndwrLqQZ5SGpNG7uB3BH2XCb70hTl
CTCkgPUNl4HW/qaK3PmnfKI2zf5Ax1udjz9/GpeGrpa2T3ClrbYC3xq4nJ/S67zyYNMqdHvZ
4NYRKatlRDBJi0GIZAYx8EGx8TZCOKu3pRWmiDHokCNKoZTtgfh0YiaPL2+gn3jtvcnp7JZJ
dnj7cXx8g2zEgnfp/QGz/nZ35qyNvUba2S1JxqiM2oMPgnNWUXnhKlN0BckoriYwyLKoCqPt
ZzNSCPvbzPNhrQc1JG1gjC4hAan2tiGDwQ2/zAkk0MBibFP+b0aXJMOEL1EIsYSqHCw6WFBu
NJ20QHV2MG19AEdqKqtAREz80AEOewLAdVDlfJuicwh4jqvyta8NS4UEoGzLeSe1bjigd1Q5
s7Q9CIT8ERBD9bHTJ4GB4MeeVgXeCumsw+sNjWpPcGfR63Ir5dZaanDoqSN+VcRkuZzcRrpu
t8NE+a1hct9h9vM+du63BGw0M/PkKUzIIAfDhaJAMBu7vZHwehdW5jdpcNPZ0C2zvknnkyky
NH41TRe6wFJD8DtrPnUx5dW8P3drKtkk4GO1PxegKEsGwz4ertek8aQCtoiwOLGKZM8JJlgn
iiCe4zyTQdHHZklgRtOROxkCY2qWDNQcd3FuZ3k8qOY4m6xIluGMM02XJ295PRriMfzbnbBL
xn2U4W67S5JUjzbWloT0C4bjsYFZ6A4fGmbe748G2LSUwaSaDvDMEoqGcT5/0cfUXIoiTiFA
AbIK+X4c9LH9xjGTOcb96kWHE/cTRyl/c83QoWw5BnMQ7gjm8z66OFjIN//cYWbAf+riIQUL
ZoHWKDCYZ5Nx4KD7U2DwVJI6yfjS5hEEM/RE4p/Sc/AMpui0LmboM6X7UOOJ7qrfwacDz7eH
s2l86UvJc3CIbvDhYIjs/DQoZouJ2Qs9hM9H90Xvnh8+v35Cxp+kns8DmHq9S1GvB7OnM2Re
YJkuArRuiXPrNrU4ZsedSoI0xyTN2hIYmp67GmYyuPSpgWAy8hSdzid1TFKK2iNpdLMx8l1D
Nhz3xwhcpfdB4NgFwKqrwawic2SBjOfVHF3ggEGD3OgEE5ThSFk6HaJhg7q7YDzHt3lZTIKL
GwvWArp/VIKhC2Vvb7LrtFCr/vT8N3++XF7wjpFNu5xICJkjsCHEFf+rP7h8Y4Lc6tLkBjKF
n3skVdPRAts/M6UZtztqt9T6AbLD8yt/fHv2TZiSxmLcKcxRy02s2Ys3RdhNFggVud4PthNw
TGIs69GJJaRO823UpAtFJ7EhY1ESA/eMvxkaIv7ULSwClUrXHEb7cNrsG2OYbrusw/F4Njdk
I1eMf2LstIZYd4QFlILJj+GCUg2mV+j6LEgpErMUkHa1+7bip0J+61vgMhdTPekakAgpsq1T
/ij0qVDAhAdynS2TOvc4UOkk2IGu4aUL2YfVD38ZQwXm0UNBiOkLOUYATQ3XOAnho87w9MTb
sMBYta2wPKF5lWgeOhJYQnZTCwbV692X0MyjZJJYcJtjyqVEaiBdXQNEA3w9/XjrrT9eDue/
t72f74fXNyx04GekXfOrMrpZbvDNwSqyoh7PtFWehDH16AikgIu/4FGftR3nJLJGwyIPk8fT
/T89dno/3x/cU5bOh5NRbWZk4DUvk1CiDD0JaE/A+LEuaDUdL9EtjTbXalIITZZ6mlFlUV+n
a836ArQsJalTg7Qpqx7rnRSFT8dGiUOcz1oenk5vh5fz6R7lTCLwRrOlC+1YkMKy0pen15/I
jVWkzHCzEQCx57B7RiBFKsAVyEs1zsDCAMCtVm43vN9G/9q7AaI772SY4yYA7fvzw+54Pmj5
oyWCz8cf7OP17fDUy597wa/jy5+9V5AB/zjea5o3QUyeHk8/ORgirOpT3PQFQ8tyvMLDg7eY
i5WZJM+nu4f705OvHIqXrgX74msX9/X6dKbXTiXNTF1vaBDUMkAxOsGf1SXlpP+T7n3ddHAC
ef1+98j77h0citdOFIiHQJ0tsD8+Hp//tepsijRhSLfBRrdDwkq0XpC/tTba/Z2CDC4uo2t1
HDU/e6sTJ3w+6Z1pUPz026oADHkWRinRU9HpREVUihCrmR6i2yAAe2Am8yEhaFAzsIJ4S0Na
pm1k9zx0F0w3TJmZDJPn7qugk6FH/77dn56VS42jy5bENSnprZHGpYHHjCzGc00a18CFGN8m
Blu00WTiEEvJ3cJ4NemoOfqObyhsKZACV9lkYMaoaTBlNV/MRtj93xCwdDIxo7o2CGXOit6F
KT/AS5xDpWaRBppVGpfBf9Q0rEyANJ6o9GC5AOa36qrIdX4EoFWeJxYdX5MWDWg4Gn/HjjFJ
o3qJBl0A3eWH9sMViwPQbzELWIiTHVeYiRhghfZ5ZDYiFLRzTU4BwGqXmFQc0ARJkLLy8rp3
zw8AxCO5vAZGQb/S+bMk0G/zEK54Tmd4LdsVtvUV4Gpi2DMvc4jdUhUBHRrB+KWBLi3ywIjg
WEZgic5/IPkGJG5ZBinj34v/Cjx2TZJQZoxYYRFYJAGEQVPaTikhWd/02Pt/XsWx2c2SioYv
rbrbVpZBWl/xfS/M1gGJfcf1jXoA80VYlpYCTUeHn9fAaFSWhvuNgSXJFttLQAMrjab7eXot
TMutLqR0H0E894Je6kWxJ/VwnqXCxN6uokXCZHgqSElRrPOMv7jCdDrV1RSAzYMoyStYGGHE
TJTgsaRxv7byTYSZPxqQTUyJSz2qOG4wbKSMzeI2F4FWJVxSuCwiDYwp5T/B9gg/CTkuKVAt
GbFtN8cOj0CeH86no+Fyxm/dMveEJ1Dk2lOfYOotpf/TfyJqPpk0uY6AE0+dvq13vbfz3T04
ZzrnDKsMzpj/lAkZ6iXxZFRsKXg3ajMiP0cJs2xPMc4/l0GnyH1CcK1Sv8PKw0IEcLIgpm17
C4VgT/rzRsFZhcVxadF8SWJNVBStDLk+VHwId7ZVrRCTXlN6y0daUdaNI+wFlHQUeNIrqtNV
2RIyM4KhjQ+2BYJsQ+hjJWkQjfseHKT52OdDBLssabhyB8IZu+g2crBNBwowkgjyTZHoZiKi
vjJaGYGO8hiHC2AYJy6kJvEGgVo5FmKGmUVzrjQvzIxP3lx8CU19ggphoMv/zqIAY2z5yDMj
xQFnPPgLioRWRNTUcVFWQkCTCRZ7Pj7yd5U8KTW2uEkxHPHxgkyO6Z7lHERzCOSq87lDy269
AdV7UlXYm5zjR26RkWgvZ3RfkwBnDBQVi4JNiRvccJKxW/f4t+oe++o2iZxd3SC/L0NNtQG/
bGMN8BdYBnxfmOL0iPI5Bst4jFH9LhBavfpITLDqugl18lILUsi+Dua2WJN72aS2qgByvckr
3D5o/+nkAoUnwxKg8gySOkkDHC/RjpS4a+deDRIZyipm9uqEBN/D2mOYv6y8HyKjSVNZtweH
aqZ0AMyt8ckaMrkf9K4oBDp5Fo37cQWGryXOsrutCWsymn2PhBsC1ijY+4M7rpVKvKXjb+LI
mQvtLPQwI/jyjPbwNNO7qSDSKJ0fofoQaBIJaSlIprXHTBaC4+yNBw8OO1lQ3hTNiDEwv2tW
zMBtI2tWFQjZvA1iuaFJRTMIbp0R8LY1apTqHEPZ42p42kNfYISIxPhGxFtEbEOdVgBANC+E
mOIagWxq+KsV/ECaErCfLMm4UaM1fAms+B1tNB6nVb3F1JgSM7QqCCrDqwyiEcVsjG84iTTX
NuS00zdcIOP/2doRtD7IipyQG/s4aKEQD5CWfMPU/D90+jBakuwI53Fj/tzNcfdqrRTNQo9T
nEaURnye8sJVngR3978OhkQsZuI2wVUEklqSh39znv9ruA3Fne9c+ZTlC/6kM6b2e57QSLNq
u6UQfMJ444SxczyoxvEGpYQvZ19jUn2N9vBvVuFdiq1DNGW8nNHBrU0Cv5UhLcSkLcAnbzya
YXiag8KA8QF+Ob6e5vPJ4u/BF4xwU8Vzk5uQzaJSL7VcW2oB8kuRBLrcoVN4cZqkvOP18P5w
6v3Apg+0LcbkCMBV42SsHQgcuk09EXYEFmQsVWJVBFMLocIoP48tVLCmSVhG2gl8FZWZ3hX1
NG1+VmlhTpoAXLwUJYW6T9UKidI4rIOSPww1p1r5X/dhlJjAnbu2Hsqkdh8McaPUPC1K0Dn7
WAQSOpxTA7I+skLG1vkWiXvK5l8VsFF144f22ll7HCIjOGJdXUYW6yIA1pm/dOr0Dv17bDNH
CtJU2tcZ0Aaz49dpJAMAoNtDErJNmpISuwvbihzOqsVc5ktbsotcv6TS+CXOrQAz4Z+HW8MS
XMJK8HDQ+xiUJEXnkvF3HVub60jBJO/jnPoolbyhjJepwsNTOi1qiN6LRrGxCYVf56WaBAGI
5cHSCH37qgK+V2FL0EyeWzK5RWPFd2jNu6Jr7hYB3jLTZ6RFjEXIM4h8BjmML7UWpcuIP75D
pPa4JKs04oyW+EwyG/KovbX21sZLacZXqA7JU3cvF35W/Drbj33bkuOmVnsNyPYjUI0+mRDw
i4lCCFniOJTaBGmF+/Y6FeWojE2S8c21NO0kCvCR1uRB8jfczwkIKdS2NMTHkoQviBaNs8OK
bozSOVTrQG/ORM/H3RFh3LASDSvuNxq5UIM94AsxZNAet3nB3ar1vn9erVPhl8f/jn/df3Gq
DdzwLSaBbcnRgEuPk3eDXia4dT2/rre+PbLxbZCozJ3NpmBeqUJL4Nw7LeYS99ISuW/6FnWr
q/VaaMDv80r4TXH2K6Eprb4NWu4zqnZ5eWVxLgppMRrwW3+cid+GGZKEeEYgkIZnLUDYjuDu
+5K8HniOh7yqfYESoCS8+aQ5GX9Jo3x3QwR8JiSZz6yBhpSRJb8PN2GBOXRxEsw1bFXyV3QT
Sq+rD84m+ydMhdGg7TzMNllpZLgXv+uVfoxwAF8OAKuvyqWZ20SSq2HQTKwbCP4cQJACj+Fb
U8j79giiYo3viYCavAf8FlIthiniBJbA67frWRt/xKxjF5GruthBhGeP0R1QbQrIE+HH+xgI
gXSknR0U92bq8KCWKiATAz6hkvCT/uUh8R1BxH+DLwrPgzLRV3KinbjumxXQ6tFb80evZh2h
Y2YjIx2ZiZthZvAGyXzSN3ukYYZezMTTmflk5isz7fvKTA3rbwuHLVCLZOSteOydmfkUd8ix
iDBXOItk4RnwYjT1DmsxwVzFrOK+2V/oWV/NzszGZhnKclhU9dw7D4Ph513hNAOzRWEkbo9O
NYbJDnX8EO/jCAePzZYVeGKPSCF8X0zhZ3h9Cxw88PRq4OnWYGLSX+V0XpcIbGOWT0kA7LIe
+F+Bg4i/wwIMnlXRpswRTJmTipLMbSK4KWmS6E4hCrMiUYK1Ajk3rlwwDSAuZ2h/BIHKNhTj
NY1hUmyk1aa8oqY9PqBAXofu1TDxhA7KaGAF424wNK9317rQyNCXShvew/37+fj24fqIiJxG
uhsF/12X0fUGonQiUlvF48rkA/B65CXANB+7GCpIDxKFtZk4qVFzKLjZeB2u65zXTnySC8WM
1mEaMWFjVZU00ATALreqIIZwT1XT8KMIpiC6ocYa7FLWpAyjjPccNCEg/BYcRUCkeLF7Bttk
uG6KM3igVZHmIjh3BPrPQFQDkdjXUVJ4ZFBtrxlfdJ6HhyKp8jS/wU0oWxpSFIS3+UljSU7C
guKKuZbohqS4QrbrM4nBVM4TdEtrjXOx+S6rEzSzBOiUVs2XN+wVVrIRpQbDiupx8fmPOo0I
Aw6xCMqahvtvg76O5Y8WsGEx4zdweLZqUbjxBKdhFCfSSJRMv23my/Hp7gtGARxqzdZkYPZe
R3/78vrrbmCUFvJM/vTjZ+ONPYQyImGD8g6Br42S4InM9Lkj7CZNI9idaqNrRPyA2fCnASkT
kLTklUUSbVPjRw3MNOc+NxtqSMQEKgwls40dF2oqumODaBcCX0jfvoCPysPp/57/+rh7uvvr
8XT38HJ8/uv17seB13N8+AvCVPyE0/OLPEyvDufnw2Pv19354fAMplHdoaoFKusdn49vx7vH
439FyDZNiZVRCC0LJqxZnhlraBVAFNXNCpS2/OwMqgReIp74N6IeoSpOIIG9HpnFogCLJZOg
817C+6rQ/qG2HgD2zaIa3+elFJFpX5UIj0QzgqyEpVEaFFrYUAnd61obCSqubSK+FMMpX7dB
vtUUrnDDABch9Yrnj5e3U+8eUj2czr1fh8cXPQivJAadOym0WG4GeOjC/7+yY1tuG9f9SuY8
nYeznThN0vahD7rZUiNLii6xkxdNmnpST5vLxM5s9u8XACmJJECnZ2d2UgMQryAIggAIK0UE
ctLmIqI8/V4E/yRVMXwcyElr07tggomEhnXNabi3JYGv8RdVxakB6M5CH6ApjpOCxgSKOC9X
w61wZI3yLAX7w9ECQbGorPjFfHbyednlDFF0uQzkTac/wux3bQraDYObKWWq1++/t3d//dr8
c3RHbHn/cvv88x/GjXUTsHLilI1tEkUCTCSs48by6h760tVXycnZmZ1eQzkCv+5/bh7327vb
/ebHUfJIDYZVfvT3dv/zKNjtnu62hIpv97esB5H5AMww+NGStSxKQc0MTo5h17nGnBLColpk
mA6Afdkkl2au87GnaQCi72pY/SEFIeJzGzvexpDPVjQPeRtbzqeRwFyJ7aOtobl4raqR5Vz6
pIKW+b9ZC1XDBrqqA776inQcWLYwMQa27fiU4P3hOH7p7e6nb/hA2WQfp8uAD+oaR5oz39XS
zlKlPC+295vdnldWRx9PhOlCMGvEep2qhzTdGsM8uEhOZP89i0Q0OY5VtrPjOJtz/hbltpez
l/GpAJPozvABK9bLZQa8TkEVHFcvY2nNINi0Wk3gk7NzVjGAP55walvlNIBiKwEhlQ3gs5mw
WabBRw5cCjD08grLhTDJ7aKeffEYUhXFqoK6uesSZVvnfB4kfL0BrDffTB3ARRdmAnUdnTJa
0I9WGNntRQwmeiaOgmWS5+bLwyMCj+3sAUQDK9lODTSfpth82VTD5vSXgS/S4CaIhYqbIG9A
wh+oWu8BfJIT8xneEVhXKsbJ5RI+xm3CRwlO/PNMWKcaPg2gYoqnh+eXzW5nafHj4NBtJ6vB
uuTXsM+nXEzlN7zFdB/KoNoXQIWc3z7+eHo4Kl4fvm9ejhabx82Lc8gYmbHJ+qiqzUjFoeV1
uBjyJwgYLcTdiVQ4772IQRTJlx8TBav3W4ZZFhOMyauuhbpR+YOzZ/Zu/SPhoF7/EXHtSb/g
0qGK7+8ZncizYu6ePX5vv7/cwknr5el1v30UttI8C0UxQ3AlPJhaAah39yokUqtrTJ4jKCgj
0aEhICpRW+R0sacrw1YI+i36m8wOkRxu70D2bosd9fJwuz17VboS5OJVn2bzov/05WwtLRUT
73IXJw1aEOmYDIyv1BErKfsTFpt+fCqp+EjDM0RwGrTDraMk9/QmimDDPbjwsS1LfBE96hdr
6UbetglR8nrrhD8gqy7MNU3ThV6ytlpaNFM01tnxlz5K0MCaReiO4kYIVRdR8xkdza8Qi2Vo
irGIoWwXjl9+GtL5iOV+Um9cXdivsKP9McFX0JXXGzrpU9syIYlatHnZYwoFOFztKCPzbnv/
eLt/fdkc3f3c3P3aPt6baZ7Qi8I0ttdWwAHHN1//Y7jBaHyybjG6bhoznzG2LOKgvnbr8/m6
YNHTm8Ei8eCM/QedHvoUZgW2gQIF5oOozb0yVtmIqktzPgZYH8KRHba7Wsqgg5Hm1mCGGWid
mAXJYMghchsU0iKqrvt5TfHCJluYJHlSeLBFgo7cmXmdHpV17AQd19mS3qQK5VxM6urEfMxn
jCyPMjcsDk4ysKxh4zXlSjQ7tyn4YSfqs7brLQ0s+nji/BwTgtkiiTCwupPwWr4Cs0jkNwM0
SVCvZDO6wsNkWU06t05btkIeGXf8+KgSO2xGxllKny4nt8SgiMul2eMRZTncPZhQ5ZJqw9Gp
FNWH3HIOv1E7qqNqmn6DRttvSrNkA34qtMPnLYjUUimWf6ADlujXN31sJs9Qv/u1mSNYwyjy
3XQ/0vAsMKdNA4N6KcHaFJYFQzQgpHm5YfSNwTSzauDUoX5hOboZiBAQJyLGOgJY8FO+NM1r
xEHSRMa5kOKlroJ8iGwat8KmjDJY8FcJdL+2UuQFFANrRtwrEGW2s4QAwmPzBqxI8A1XStnX
g7RamPeghEMEFEH3k0ZzYrp7ivKAvCrTpLYOaTAJKdVFZnuknZcYLY1JDd+jUnntXRLEwqBW
QmWIKspiQPRLq8eIHVEVpm2xUHXCqHUY1YCZruvpPizz+mA2i1xNrlHcpSmb8zK0fwkypMjt
EJKRaygjvCXV8pu+DSyDYlZfoq4saWPLKrMiAODH3MwQXmYxRafDrmWGHpYwaJODogG1LvOJ
7POblJJRo+xMvgQ8f5vJ7peE/fQ2k1zrCVfhXSLW5zQ0gB20EODoz96fvp07YGjAsQOaHb/N
3K+brtDtd6Czk7eTE9YtWLyz87ePkttXs3AYcOTuCvNjWDdSIwowxIkkigOM7gPlUqDr1GME
/TzvmnSI6B4qxivIOKlK03cCdkyL9dG5oliYLDmqa0zbsi9HByWVoM8v28f9L8pp/ONhs7vn
fiikyV30bvCJBqMno3zzo3y3ezhz5KCW5eP91icvxWWH8YKn4xrQijwrYaSIr4sAH15wQhEs
sHOpCSeUEO/Q+6SugcoUkUQN/5tvaesR9Y7SaIba/t78td8+aIV4R6R3Cv7Cx1TVpY0RDIax
oV2UWOY6AzvsV4nslGFQNlWeyUHzBlG8Cuq5rMst4hBj6rPKkzg2Keg2b9mhaRPjyCURUMMo
U6zw18+zL8YjrcjAFeyTmGnG8yQcujxQDUEju16lCeanwrBYWDOiIFUdbVQUO0bmLQP15trQ
CgdDLcV8Atd89GG7ixLtg6xedJFPS3/KDur1ebQRbu+G5Rlvvr/e3+OFfva427+8Pmwe9+br
aQGe4OHwVl9OfTCAozOBmpqvICCnXph0/FVAu6uGpkj+VSS4LoAhzGHB35IpYRRyYRMUcBYo
sja7SXC3Nb8mrDiCfzQmdoOV6767mjAS86v1Ot5UmCHhUMrAITspGifVgSoF8aQpyA53+HW5
KjzGTEJXZdaUbrC8UAtw/Nw7J3UZBxhBP0h7C1mGmKlBdMvLu3AgMkMKEEw++c5M6/GEjQx9
XHhNA+ZAV5QPTefNqtyAsIg1VVLEXtkxqZNU7NWyrxYt8TVr1ZUsINwP/6CSrG47++laC+Gd
HpXjkFx7xBGl7mKU/jwvV7x4Cy1UYqzCoDHdWR0EXtzaWm0UUfcUdrLcDmvYLs2lmtY6IcoO
s0RIw6jwGSVicYujvk0WZbedYx3KOBf4xAJbwWwMU8xMyC6tkf6ofHre/e8of7r79fqs5HF6
+3hv6jn4LhU6ZZVWKhELjKmNOrSNT6xczlv0peoqaEMLS9DjmKmQfYoJ6dqgkVfP6hK2H9iE
4lIWFDQ+qjZxgA73VPkbw4b045Ve5uSCUK1LFgFDYBIVYq1SkfbSQN3xIkkqZa9TFkH0/JgE
+393z9tH9AaBlj+87jdvG/jHZn/34cMH80WycnjydEG6Lw/FqmpMiK8zu4hjSGVgZw7ICzyG
d22y9kRGaWbTCbwPkLxfyGqliEAclyt0az7UqlWTeBQlRUBdYxuVRTK8VJbDbHAZpMdN3dAd
fDKAqgJeR69dYkuhxqlv0hnl/5j/ocCWAupgic/zwEzCQ+KFkBOM1DgYC3zsNkliYGtlCRT2
M7V1esTGL6WC/Ljd3x6h7nGHVm+myaMFXdAbEHyIgw6pA5S/J5MNyWov70kdgONN3VVjjiZL
Enga71YVwXkjKVrQB/kLFnXUWZJi0s2jjpLostm3KHwsYhPVvnRDiE0uxQQoQw51q31seV1q
pb0W1HX73EccDUogmr3kpqKNt4iu21JKAVqUlepH7ezMw0Pe72AXdVClMs1wnJ07LK4KUIti
Sen9yNe2jh0SzL+CK4EoQRMtmMoX6Q9VKRNSNQfzTPdO3arWyA60J4OEysYxASnRNtFbtzXw
p8XRVmmcWceNonRoKMYGG7tynSRL4Ho4yYjdYvUNhjm3Ik0oWM2GHo/zj87wuJMN38jWMHu6
fbEjKD0ZgUZDp0CrmE9NdfRm74fpClhU+EzziOYDORyIJropgoreSXU5YEAM515nNkKQrTCJ
+qEV5jw/wIMChFqAN5PqA8/OOJIDz0qEQ6U5pdrAICuHOYcFQ6zHmcI2sTfXRZsy0hSvRI0H
ZycVjIZSMbXKjucbTmLJ6QpT5u0J/cDrCHIy5eNgyLym57UNQMhWB2SsUaGPmK+rOMF0Yu4l
oTFcuKb8lVojeCCKvAnwBQExGdJ0MKOExJmOErdSplCImaaYwFnJMMra+fT35uX5Tt7RKiNE
fpXUdSmtMSRSSFMY4UyrVR0nVZt+PT816fFZU2L74bg9XZaWMToqgAQ0bblCtd8wsjwPwiTv
5wnFSqlDs1Waj+jA6M8xdidbA0NIlU+WoybrlQH6MB32FnkHT0XAu82hqtdLT97IMM70tiCt
ehDC+LjM2lb7cZQpYulAwn2gqVoM0feeXps0iGGrAeGLed2O3zbH6j/DEMwYyLStt5vdHrVZ
PHNF+HDG7f3G5LCLrvDYYwdtryfWmvJuypNm5+Y8tHQuMPbGtQRAVwGsxYx5r6upp/YimTby
0n1GjWYsaa0SJVph644SFwVmwIZCAlsEdRKobEbHb6d6YAcZBYoH7a3AWiSjfc9TwWrm7GcH
RcnTwCKn1D3Iv5dkl1J3EQIA

--fUYQa+Pmc3FrFX/N--
