Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC475C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 05:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2E120781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 05:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHLF3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 01:29:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:58755 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgHLF3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 01:29:01 -0400
IronPort-SDR: qb4zIU4ZIQCHL5rdfA+cNx6AMyTD7CQfx00udfO1eN9GhTG1kQ9P9qe4ui3Lc2k2RNhGCgY+QV
 2qtJsmqAMQOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="155016709"
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="gz'50?scan'50,208,50";a="155016709"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 22:25:44 -0700
IronPort-SDR: vMPEIl56OYxRIEhPXn1ssMxKXOYRMIhwr+dOZ8inV/v+tnN0/smtRjjd59yHr9XhMYF71mkzJf
 gUD8b/lDxsaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,303,1592895600"; 
   d="gz'50?scan'50,208,50";a="334801802"
Received: from lkp-server01.sh.intel.com (HELO e03a785590b8) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2020 22:25:42 -0700
Received: from kbuild by e03a785590b8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5jGg-00008R-8W; Wed, 12 Aug 2020 05:25:42 +0000
Date:   Wed, 12 Aug 2020 13:25:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/soc/qcom/smd-rpm.c:177:47: sparse: sparse: incorrect type in
 argument 2 (different address spaces)
Message-ID: <202008121310.hqDvutzs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb893de323e2d39f7a1f6df425703a2edbdf56ea
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   8 weeks ago
config: powerpc64-randconfig-s032-20200812 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-168-g9554805c-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/soc/qcom/smd-rpm.c:177:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got unsigned char const * @@
>> drivers/soc/qcom/smd-rpm.c:177:47: sparse:     expected void const volatile [noderef] __iomem *s
   drivers/soc/qcom/smd-rpm.c:177:47: sparse:     got unsigned char const *
--
>> drivers/spi/spi-fsl-cpm.c:58:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/spi/spi-fsl-cpm.c:58:39: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
>> drivers/spi/spi-fsl-cpm.c:58:39: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/spi/spi-fsl-cpm.c:59:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> drivers/spi/spi-fsl-cpm.c:59:39: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
>> drivers/spi/spi-fsl-cpm.c:59:39: sparse:     got restricted __be16 [noderef] __iomem *
>> drivers/spi/spi-fsl-cpm.c:60:47: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> drivers/spi/spi-fsl-cpm.c:60:47: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:60:47: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:61:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:61:39: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:61:39: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:62:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:62:39: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:62:39: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:63:47: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:63:47: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:63:47: sparse:     got restricted __be16 [noderef] __iomem *
>> drivers/spi/spi-fsl-cpm.c:77:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-cpm.c:77:44: sparse:     expected struct fsl_spi_reg *reg_base
>> drivers/spi/spi-fsl-cpm.c:77:44: sparse:     got void [noderef] __iomem *reg_base
>> drivers/spi/spi-fsl-cpm.c:97:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
>> drivers/spi/spi-fsl-cpm.c:97:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-cpm.c:97:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-cpm.c:104:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-cpm.c:104:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-cpm.c:104:44: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-cpm.c:149:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-cpm.c:149:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-cpm.c:149:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-cpm.c:182:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] __iomem *reg_base @@
   drivers/spi/spi-fsl-cpm.c:182:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-cpm.c:182:44: sparse:     got void [noderef] __iomem *reg_base
   drivers/spi/spi-fsl-cpm.c:194:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] __iomem *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-cpm.c:194:32: sparse:     expected restricted __be32 [noderef] [usertype] __iomem *reg
   drivers/spi/spi-fsl-cpm.c:194:32: sparse:     got restricted __be32 *
>> drivers/spi/spi-fsl-cpm.c:310:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *pram @@     got void [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:310:22: sparse:     expected void *pram
>> drivers/spi/spi-fsl-cpm.c:310:22: sparse:     got void [noderef] __iomem *
>> drivers/spi/spi-fsl-cpm.c:315:36: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct spi_pram [noderef] __iomem *pram @@     got void *pram @@
>> drivers/spi/spi-fsl-cpm.c:315:36: sparse:     expected struct spi_pram [noderef] __iomem *pram
   drivers/spi/spi-fsl-cpm.c:315:36: sparse:     got void *pram
   drivers/spi/spi-fsl-cpm.c:354:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:354:23: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:354:23: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:355:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:355:23: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:355:23: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:358:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:358:23: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:358:23: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:359:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:359:23: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:359:23: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:360:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:360:23: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:360:23: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:361:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:361:23: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:361:23: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:362:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:362:23: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:362:23: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:363:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:363:23: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:363:23: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:364:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:364:23: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:364:23: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:365:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:365:23: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:365:23: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:366:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:366:23: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:366:23: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:367:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:367:23: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:367:23: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/spi/spi-fsl-cpm.c:368:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/spi/spi-fsl-cpm.c:368:23: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/spi/spi-fsl-cpm.c:368:23: sparse:     got restricted __be32 [noderef] __iomem *
--
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:28: sparse:     expected void const *q
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:133:28: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:16: sparse:     expected void *p
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:136:16: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:29: sparse:     expected void const *q
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:155:29: sparse:     got void [noderef] __iomem *irq_0x500
>> arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:16: sparse:     expected void *p
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:156:16: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *irq_0x500 @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:16: sparse:     expected void *p
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:163:16: sparse:     got void [noderef] __iomem *irq_0x500
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *static [assigned] [toplevel] sram @@
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:16: sparse:     expected void *p
   arch/powerpc/platforms/52xx/mpc52xx_pm.c:176:16: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] sram
--
>> arch/powerpc/platforms/86xx/mpc86xx_smp.c:48:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
>> arch/powerpc/platforms/86xx/mpc86xx_smp.c:48:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/86xx/mpc86xx_smp.c:48:33: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
>> arch/powerpc/platforms/86xx/mpc86xx_smp.c:50:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
>> arch/powerpc/platforms/86xx/mpc86xx_smp.c:50:28: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/86xx/mpc86xx_smp.c:50:28: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/86xx/mpc86xx_smp.c:103:18: sparse: sparse: symbol 'smp_86xx_ops' was not declared. Should it be static?
--
>> drivers/hwspinlock/u8500_hsem.c:52:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *lock_addr @@     got void *priv @@
>> drivers/hwspinlock/u8500_hsem.c:52:39: sparse:     expected void [noderef] __iomem *lock_addr
   drivers/hwspinlock/u8500_hsem.c:52:39: sparse:     got void *priv
   drivers/hwspinlock/u8500_hsem.c:65:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *lock_addr @@     got void *priv @@
   drivers/hwspinlock/u8500_hsem.c:65:39: sparse:     expected void [noderef] __iomem *lock_addr
   drivers/hwspinlock/u8500_hsem.c:65:39: sparse:     got void *priv
>> drivers/hwspinlock/u8500_hsem.c:116:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/hwspinlock/u8500_hsem.c:116:30: sparse:     expected void *priv
>> drivers/hwspinlock/u8500_hsem.c:116:30: sparse:     got void [noderef] __iomem *
>> drivers/hwspinlock/u8500_hsem.c:126:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *io_base @@     got void * @@
>> drivers/hwspinlock/u8500_hsem.c:126:52: sparse:     expected void [noderef] __iomem *io_base
   drivers/hwspinlock/u8500_hsem.c:126:52: sparse:     got void *

vim +177 drivers/soc/qcom/smd-rpm.c

936f14cf4e6716 Bjorn Andersson 2015-07-27  146  
5052de8deff561 Bjorn Andersson 2017-03-27  147  static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
5052de8deff561 Bjorn Andersson 2017-03-27  148  				 void *data,
5052de8deff561 Bjorn Andersson 2017-03-27  149  				 int count,
5052de8deff561 Bjorn Andersson 2017-03-27  150  				 void *priv,
5052de8deff561 Bjorn Andersson 2017-03-27  151  				 u32 addr)
936f14cf4e6716 Bjorn Andersson 2015-07-27  152  {
936f14cf4e6716 Bjorn Andersson 2015-07-27  153  	const struct qcom_rpm_header *hdr = data;
30b7ea5eda0afb Stephen Boyd    2015-09-02  154  	size_t hdr_length = le32_to_cpu(hdr->length);
936f14cf4e6716 Bjorn Andersson 2015-07-27  155  	const struct qcom_rpm_message *msg;
5052de8deff561 Bjorn Andersson 2017-03-27  156  	struct qcom_smd_rpm *rpm = dev_get_drvdata(&rpdev->dev);
936f14cf4e6716 Bjorn Andersson 2015-07-27  157  	const u8 *buf = data + sizeof(struct qcom_rpm_header);
30b7ea5eda0afb Stephen Boyd    2015-09-02  158  	const u8 *end = buf + hdr_length;
936f14cf4e6716 Bjorn Andersson 2015-07-27  159  	char msgbuf[32];
936f14cf4e6716 Bjorn Andersson 2015-07-27  160  	int status = 0;
30b7ea5eda0afb Stephen Boyd    2015-09-02  161  	u32 len, msg_length;
936f14cf4e6716 Bjorn Andersson 2015-07-27  162  
30b7ea5eda0afb Stephen Boyd    2015-09-02  163  	if (le32_to_cpu(hdr->service_type) != RPM_SERVICE_TYPE_REQUEST ||
30b7ea5eda0afb Stephen Boyd    2015-09-02  164  	    hdr_length < sizeof(struct qcom_rpm_message)) {
b853cb9628bfbc Bjorn Andersson 2016-03-28  165  		dev_err(rpm->dev, "invalid request\n");
936f14cf4e6716 Bjorn Andersson 2015-07-27  166  		return 0;
936f14cf4e6716 Bjorn Andersson 2015-07-27  167  	}
936f14cf4e6716 Bjorn Andersson 2015-07-27  168  
936f14cf4e6716 Bjorn Andersson 2015-07-27  169  	while (buf < end) {
936f14cf4e6716 Bjorn Andersson 2015-07-27  170  		msg = (struct qcom_rpm_message *)buf;
30b7ea5eda0afb Stephen Boyd    2015-09-02  171  		msg_length = le32_to_cpu(msg->length);
30b7ea5eda0afb Stephen Boyd    2015-09-02  172  		switch (le32_to_cpu(msg->msg_type)) {
936f14cf4e6716 Bjorn Andersson 2015-07-27  173  		case RPM_MSG_TYPE_MSG_ID:
936f14cf4e6716 Bjorn Andersson 2015-07-27  174  			break;
936f14cf4e6716 Bjorn Andersson 2015-07-27  175  		case RPM_MSG_TYPE_ERR:
30b7ea5eda0afb Stephen Boyd    2015-09-02  176  			len = min_t(u32, ALIGN(msg_length, 4), sizeof(msgbuf));
936f14cf4e6716 Bjorn Andersson 2015-07-27 @177  			memcpy_fromio(msgbuf, msg->message, len);
936f14cf4e6716 Bjorn Andersson 2015-07-27  178  			msgbuf[len - 1] = 0;
936f14cf4e6716 Bjorn Andersson 2015-07-27  179  
936f14cf4e6716 Bjorn Andersson 2015-07-27  180  			if (!strcmp(msgbuf, "resource does not exist"))
936f14cf4e6716 Bjorn Andersson 2015-07-27  181  				status = -ENXIO;
936f14cf4e6716 Bjorn Andersson 2015-07-27  182  			else
936f14cf4e6716 Bjorn Andersson 2015-07-27  183  				status = -EINVAL;
936f14cf4e6716 Bjorn Andersson 2015-07-27  184  			break;
936f14cf4e6716 Bjorn Andersson 2015-07-27  185  		}
936f14cf4e6716 Bjorn Andersson 2015-07-27  186  
30b7ea5eda0afb Stephen Boyd    2015-09-02  187  		buf = PTR_ALIGN(buf + 2 * sizeof(u32) + msg_length, 4);
936f14cf4e6716 Bjorn Andersson 2015-07-27  188  	}
936f14cf4e6716 Bjorn Andersson 2015-07-27  189  
936f14cf4e6716 Bjorn Andersson 2015-07-27  190  	rpm->ack_status = status;
936f14cf4e6716 Bjorn Andersson 2015-07-27  191  	complete(&rpm->ack);
936f14cf4e6716 Bjorn Andersson 2015-07-27  192  	return 0;
936f14cf4e6716 Bjorn Andersson 2015-07-27  193  }
936f14cf4e6716 Bjorn Andersson 2015-07-27  194  

:::::: The code at line 177 was first introduced by commit
:::::: 936f14cf4e67168fcd37f10cebf5a475f490fb6e soc: qcom: Driver for the Qualcomm RPM over SMD

:::::: TO: Bjorn Andersson <bjorn.andersson@sonymobile.com>
:::::: CC: Andy Gross <agross@codeaurora.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--9amGYk9869ThD9tj--
