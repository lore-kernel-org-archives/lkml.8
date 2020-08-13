Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D7FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 04:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E5C206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 04:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgHMEko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 00:40:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:26628 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgHMEkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 00:40:43 -0400
IronPort-SDR: RiUCOsB4rV1vtp8Jyhpnfu2H5Y5X4P8tfUqtpO0wE+6droBZGCzoAPxWOVyWFM4WjXvuNoiJWT
 MgU2DIl4RVhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="153380295"
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="gz'50?scan'50,208,50";a="153380295"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 21:40:38 -0700
IronPort-SDR: weyeUMcfVJWRqeZIXscmVt89QcDdpaUfY62Qr19mujQjww65Inz+yTbFOGb5TBtnsCrARpIzeF
 xZegNy+TyuEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="gz'50?scan'50,208,50";a="327443278"
Received: from lkp-server01.sh.intel.com (HELO 7f1ebb311643) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 Aug 2020 21:40:37 -0700
Received: from kbuild by 7f1ebb311643 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k652a-0000Re-CX; Thu, 13 Aug 2020 04:40:36 +0000
Date:   Thu, 13 Aug 2020 12:40:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: drivers/char/agp/i460-agp.c:254:19: sparse: expected void gatt
Message-ID: <202008131227.OhBzl5qP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc06fe51d26efc100ac74121607c01a454867c91
commit: df41017eafd267c08acbfff99d34e4f96bbfbc92 ia64: remove support for machvecs
date:   12 months ago
config: ia64-randconfig-s031-20200813 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-168-g9554805c-dirty
        git checkout df41017eafd267c08acbfff99d34e4f96bbfbc92
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/char/agp/i460-agp.c:254:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *static [assigned] [toplevel] gatt @@     got void [noderef] <asn:2> * @@
>> drivers/char/agp/i460-agp.c:254:19: sparse:     expected void *static [assigned] [toplevel] gatt
   drivers/char/agp/i460-agp.c:254:19: sparse:     got void [noderef] <asn:2> *
   drivers/char/agp/i460-agp.c:266:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned int [usertype] * @@
   drivers/char/agp/i460-agp.c:266:17: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/char/agp/i460-agp.c:266:17: sparse:     got unsigned int [usertype] *
   drivers/char/agp/i460-agp.c:267:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned int [usertype] * @@
   drivers/char/agp/i460-agp.c:267:9: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/char/agp/i460-agp.c:267:9: sparse:     got unsigned int [usertype] *
   drivers/char/agp/i460-agp.c:281:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned int [usertype] * @@
   drivers/char/agp/i460-agp.c:281:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/char/agp/i460-agp.c:281:17: sparse:     got unsigned int [usertype] *
   drivers/char/agp/i460-agp.c:282:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned int [usertype] * @@
   drivers/char/agp/i460-agp.c:282:9: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/char/agp/i460-agp.c:282:9: sparse:     got unsigned int [usertype] *
   drivers/char/agp/i460-agp.c:284:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got void *static [assigned] [toplevel] gatt @@
   drivers/char/agp/i460-agp.c:284:21: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/char/agp/i460-agp.c:284:21: sparse:     got void *static [assigned] [toplevel] gatt
   drivers/char/agp/i460-agp.c:318:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned int [usertype] * @@
   drivers/char/agp/i460-agp.c:318:22: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/char/agp/i460-agp.c:318:22: sparse:     got unsigned int [usertype] *
   drivers/char/agp/i460-agp.c:318:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned int [usertype] * @@
   drivers/char/agp/i460-agp.c:318:22: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/char/agp/i460-agp.c:318:22: sparse:     got unsigned int [usertype] *
   drivers/char/agp/i460-agp.c:319:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned int [usertype] * @@
   drivers/char/agp/i460-agp.c:319:25: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/char/agp/i460-agp.c:319:25: sparse:     got unsigned int [usertype] *
   drivers/char/agp/i460-agp.c:330:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned int [usertype] * @@
   drivers/char/agp/i460-agp.c:330:25: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/char/agp/i460-agp.c:330:25: sparse:     got unsigned int [usertype] *
   drivers/char/agp/i460-agp.c:332:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned int [usertype] * @@
   drivers/char/agp/i460-agp.c:332:9: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/char/agp/i460-agp.c:332:9: sparse:     got unsigned int [usertype] *
   drivers/char/agp/i460-agp.c:347:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned int [usertype] * @@
   drivers/char/agp/i460-agp.c:347:17: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/char/agp/i460-agp.c:347:17: sparse:     got unsigned int [usertype] *
   drivers/char/agp/i460-agp.c:348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned int [usertype] * @@
   drivers/char/agp/i460-agp.c:348:9: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/char/agp/i460-agp.c:348:9: sparse:     got unsigned int [usertype] *
>> drivers/char/agp/i460-agp.c:556:32: sparse: sparse: symbol 'intel_i460_driver' was not declared. Should it be static?
   drivers/char/agp/i460-agp.c: note: in included file (through arch/ia64/include/asm/io.h, arch/ia64/include/asm/smp.h, include/linux/smp.h, ...):
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32

vim +254 drivers/char/agp/i460-agp.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  241  
^1da177e4c3f41 Linus Torvalds 2005-04-16  242  static int i460_create_gatt_table (struct agp_bridge_data *bridge)
^1da177e4c3f41 Linus Torvalds 2005-04-16  243  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  244  	int page_order, num_entries, i;
^1da177e4c3f41 Linus Torvalds 2005-04-16  245  	void *temp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  246  
^1da177e4c3f41 Linus Torvalds 2005-04-16  247  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  248  	 * Load up the fixed address of the GART SRAMS which hold our GATT table.
^1da177e4c3f41 Linus Torvalds 2005-04-16  249  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  250  	temp = agp_bridge->current_size;
^1da177e4c3f41 Linus Torvalds 2005-04-16  251  	page_order = A_SIZE_8(temp)->page_order;
^1da177e4c3f41 Linus Torvalds 2005-04-16  252  	num_entries = A_SIZE_8(temp)->num_entries;
^1da177e4c3f41 Linus Torvalds 2005-04-16  253  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @254  	i460.gatt = ioremap(INTEL_I460_ATTBASE, PAGE_SIZE << page_order);
5bdbc7dc2c07d5 Scott Thompson 2007-08-25  255  	if (!i460.gatt) {
5bdbc7dc2c07d5 Scott Thompson 2007-08-25  256  		printk(KERN_ERR PFX "ioremap failed\n");
5bdbc7dc2c07d5 Scott Thompson 2007-08-25  257  		return -ENOMEM;
5bdbc7dc2c07d5 Scott Thompson 2007-08-25  258  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  259  
^1da177e4c3f41 Linus Torvalds 2005-04-16  260  	/* These are no good, the should be removed from the agp_bridge strucure... */
^1da177e4c3f41 Linus Torvalds 2005-04-16  261  	agp_bridge->gatt_table_real = NULL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  262  	agp_bridge->gatt_table = NULL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  263  	agp_bridge->gatt_bus_addr = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  264  
^1da177e4c3f41 Linus Torvalds 2005-04-16  265  	for (i = 0; i < num_entries; ++i)
^1da177e4c3f41 Linus Torvalds 2005-04-16 @266  		WR_GATT(i, 0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  267  	WR_FLUSH_GATT(i - 1);
^1da177e4c3f41 Linus Torvalds 2005-04-16  268  	return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  269  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  270  
^1da177e4c3f41 Linus Torvalds 2005-04-16  271  static int i460_free_gatt_table (struct agp_bridge_data *bridge)
^1da177e4c3f41 Linus Torvalds 2005-04-16  272  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  273  	int num_entries, i;
^1da177e4c3f41 Linus Torvalds 2005-04-16  274  	void *temp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  275  
^1da177e4c3f41 Linus Torvalds 2005-04-16  276  	temp = agp_bridge->current_size;
^1da177e4c3f41 Linus Torvalds 2005-04-16  277  
^1da177e4c3f41 Linus Torvalds 2005-04-16  278  	num_entries = A_SIZE_8(temp)->num_entries;
^1da177e4c3f41 Linus Torvalds 2005-04-16  279  
^1da177e4c3f41 Linus Torvalds 2005-04-16  280  	for (i = 0; i < num_entries; ++i)
^1da177e4c3f41 Linus Torvalds 2005-04-16  281  		WR_GATT(i, 0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  282  	WR_FLUSH_GATT(num_entries - 1);
^1da177e4c3f41 Linus Torvalds 2005-04-16  283  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @284  	iounmap(i460.gatt);
^1da177e4c3f41 Linus Torvalds 2005-04-16  285  	return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  286  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  287  

:::::: The code at line 254 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--huq684BweRXVnRxX
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--huq684BweRXVnRxX--
