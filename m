Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE34BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 12:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C25D20720
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 12:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgHWMxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 08:53:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:14625 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgHWMxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 08:53:05 -0400
IronPort-SDR: auW/81xm/B94cH0aBH70Jl49B4YGbnrHqmgAIoGNi3igpKJODb1xK34GAn9taiJH2xxbVpiWFV
 iiYhXnPthw8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9721"; a="155049964"
X-IronPort-AV: E=Sophos;i="5.76,344,1592895600"; 
   d="gz'50?scan'50,208,50";a="155049964"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2020 05:52:46 -0700
IronPort-SDR: CJuSmS9ep8SvZqfhubV5TvyzpagDf21NTQwmAHXSo5Yqa8SVZIYWxOU1ISZu9515D6V2YH9Lod
 D+8nuB68hFkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,344,1592895600"; 
   d="gz'50?scan'50,208,50";a="294285148"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2020 05:52:43 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k9pUI-00026h-QD; Sun, 23 Aug 2020 12:52:42 +0000
Date:   Sun, 23 Aug 2020 20:52:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: micron: add support for MT29F2G01AAAED
Message-ID: <202008232018.skaumq3A%lkp@intel.com>
References: <20200823111410.13049-1-nthirumalesha7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20200823111410.13049-1-nthirumalesha7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thirumalesha,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.9-rc1 next-20200821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Thirumalesha-Narasimhappa/mtd-spinand-micron-add-support-for-MT29F2G01AAAED/20200823-191310
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c3d8f220d01220a5b253e422be407d068dc65511
config: openrisc-randconfig-m031-20200823 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mtd/nand/spi/micron.c:323: error: unterminated argument list invoking macro "SPINAND_INFO"
     323 | };
         | 
>> drivers/mtd/nand/spi/micron.c:288:2: error: 'SPINAND_INFO' undeclared here (not in a function)
     288 |  SPINAND_INFO("MT29F2G01AAAED",
         |  ^~~~~~~~~~~~
>> drivers/mtd/nand/spi/micron.c:323: error: expected '}' at end of input
     323 | };
         | 
   drivers/mtd/nand/spi/micron.c:184:59: note: to match this '{'
     184 | static const struct spinand_info micron_spinand_table[] = {
         |                                                           ^
   drivers/mtd/nand/spi/micron.c:184:34: warning: 'micron_spinand_table' defined but not used [-Wunused-const-variable=]
     184 | static const struct spinand_info micron_spinand_table[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/micron.c:163:12: warning: 'mt29f2g01aaaed_ecc_get_status' defined but not used [-Wunused-function]
     163 | static int mt29f2g01aaaed_ecc_get_status(struct spinand_device *spinand,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/spi/micron.c:118:39: warning: 'mt29f2g01aaaed_ooblayout' defined but not used [-Wunused-const-variable=]
     118 | static const struct mtd_ooblayout_ops mt29f2g01aaaed_ooblayout = {
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mtd/nand/spi/micron.c:11:
   drivers/mtd/nand/spi/micron.c:60:28: warning: 'update_cache_variants_mt29f2g01aaaed' defined but not used [-Wunused-const-variable=]
      60 | static SPINAND_OP_VARIANTS(update_cache_variants_mt29f2g01aaaed,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mtd/spinand.h:265:35: note: in definition of macro 'SPINAND_OP_VARIANTS'
     265 |  const struct spinand_op_variants name = {   \
         |                                   ^~~~
   drivers/mtd/nand/spi/micron.c:57:28: warning: 'write_cache_variants_mt29f2g01aaaed' defined but not used [-Wunused-const-variable=]
      57 | static SPINAND_OP_VARIANTS(write_cache_variants_mt29f2g01aaaed,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mtd/spinand.h:265:35: note: in definition of macro 'SPINAND_OP_VARIANTS'
     265 |  const struct spinand_op_variants name = {   \
         |                                   ^~~~
   drivers/mtd/nand/spi/micron.c:51:28: warning: 'read_cache_variants_mt29f2g01aaaed' defined but not used [-Wunused-const-variable=]
      51 | static SPINAND_OP_VARIANTS(read_cache_variants_mt29f2g01aaaed,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mtd/spinand.h:265:35: note: in definition of macro 'SPINAND_OP_VARIANTS'
     265 |  const struct spinand_op_variants name = {   \
         |                                   ^~~~

# https://github.com/0day-ci/linux/commit/8dc175bd1853ebc961fea42976cffc290b5fbf22
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Thirumalesha-Narasimhappa/mtd-spinand-micron-add-support-for-MT29F2G01AAAED/20200823-191310
git checkout 8dc175bd1853ebc961fea42976cffc290b5fbf22
vim +/SPINAND_INFO +323 drivers/mtd/nand/spi/micron.c

8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23  183  
a508e8875e135d Peter Pan                 2018-06-22  184  static const struct spinand_info micron_spinand_table[] = {
8511a3a9937e30 Shivamurthy Shastri       2020-03-11  185  	/* M79A 2Gb 3.3V */
f1541773af49ec Chuanhong Guo             2020-02-08  186  	SPINAND_INFO("MT29F2G01ABAGD",
f1541773af49ec Chuanhong Guo             2020-02-08  187  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24),
377e517b5fa535 Boris Brezillon           2018-11-04  188  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
a508e8875e135d Peter Pan                 2018-06-22  189  		     NAND_ECCREQ(8, 512),
a508e8875e135d Peter Pan                 2018-06-22  190  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
a508e8875e135d Peter Pan                 2018-06-22  191  					      &write_cache_variants,
a508e8875e135d Peter Pan                 2018-06-22  192  					      &update_cache_variants),
a508e8875e135d Peter Pan                 2018-06-22  193  		     0,
d3137043440fb1 Shivamurthy Shastri       2020-03-11  194  		     SPINAND_ECCINFO(&micron_8_ooblayout,
d3137043440fb1 Shivamurthy Shastri       2020-03-11  195  				     micron_8_ecc_get_status)),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  196  	/* M79A 2Gb 1.8V */
a15335a17f4abf Shivamurthy Shastri       2020-03-11  197  	SPINAND_INFO("MT29F2G01ABBGD",
a15335a17f4abf Shivamurthy Shastri       2020-03-11  198  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  199  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  200  		     NAND_ECCREQ(8, 512),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  201  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  202  					      &write_cache_variants,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  203  					      &update_cache_variants),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  204  		     0,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  205  		     SPINAND_ECCINFO(&micron_8_ooblayout,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  206  				     micron_8_ecc_get_status)),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  207  	/* M78A 1Gb 3.3V */
a15335a17f4abf Shivamurthy Shastri       2020-03-11  208  	SPINAND_INFO("MT29F1G01ABAFD",
a15335a17f4abf Shivamurthy Shastri       2020-03-11  209  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  210  		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  211  		     NAND_ECCREQ(8, 512),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  212  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  213  					      &write_cache_variants,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  214  					      &update_cache_variants),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  215  		     0,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  216  		     SPINAND_ECCINFO(&micron_8_ooblayout,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  217  				     micron_8_ecc_get_status)),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  218  	/* M78A 1Gb 1.8V */
a15335a17f4abf Shivamurthy Shastri       2020-03-11  219  	SPINAND_INFO("MT29F1G01ABAFD",
a15335a17f4abf Shivamurthy Shastri       2020-03-11  220  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  221  		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  222  		     NAND_ECCREQ(8, 512),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  223  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  224  					      &write_cache_variants,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  225  					      &update_cache_variants),
a15335a17f4abf Shivamurthy Shastri       2020-03-11  226  		     0,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  227  		     SPINAND_ECCINFO(&micron_8_ooblayout,
a15335a17f4abf Shivamurthy Shastri       2020-03-11  228  				     micron_8_ecc_get_status)),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  229  	/* M79A 4Gb 3.3V */
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  230  	SPINAND_INFO("MT29F4G01ADAGD",
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  231  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x36),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  232  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 80, 2, 1, 2),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  233  		     NAND_ECCREQ(8, 512),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  234  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  235  					      &write_cache_variants,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  236  					      &update_cache_variants),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  237  		     0,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  238  		     SPINAND_ECCINFO(&micron_8_ooblayout,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  239  				     micron_8_ecc_get_status),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  240  		     SPINAND_SELECT_TARGET(micron_select_target)),
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  241  	/* M70A 4Gb 3.3V */
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  242  	SPINAND_INFO("MT29F4G01ABAFD",
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  243  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x34),
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  244  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  245  		     NAND_ECCREQ(8, 512),
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  246  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  247  					      &write_cache_variants,
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  248  					      &update_cache_variants),
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  249  		     SPINAND_HAS_CR_FEAT_BIT,
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  250  		     SPINAND_ECCINFO(&micron_8_ooblayout,
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  251  				     micron_8_ecc_get_status)),
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  252  	/* M70A 4Gb 1.8V */
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  253  	SPINAND_INFO("MT29F4G01ABBFD",
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  254  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  255  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  256  		     NAND_ECCREQ(8, 512),
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  257  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  258  					      &write_cache_variants,
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  259  					      &update_cache_variants),
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  260  		     SPINAND_HAS_CR_FEAT_BIT,
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  261  		     SPINAND_ECCINFO(&micron_8_ooblayout,
a7e5daccc310c3 Shivamurthy Shastri       2020-03-11  262  				     micron_8_ecc_get_status)),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  263  	/* M70A 8Gb 3.3V */
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  264  	SPINAND_INFO("MT29F8G01ADAFD",
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  265  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x46),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  266  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  267  		     NAND_ECCREQ(8, 512),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  268  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  269  					      &write_cache_variants,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  270  					      &update_cache_variants),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  271  		     SPINAND_HAS_CR_FEAT_BIT,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  272  		     SPINAND_ECCINFO(&micron_8_ooblayout,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  273  				     micron_8_ecc_get_status),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  274  		     SPINAND_SELECT_TARGET(micron_select_target)),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  275  	/* M70A 8Gb 1.8V */
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  276  	SPINAND_INFO("MT29F8G01ADBFD",
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  277  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x47),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  278  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  279  		     NAND_ECCREQ(8, 512),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  280  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  281  					      &write_cache_variants,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  282  					      &update_cache_variants),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  283  		     SPINAND_HAS_CR_FEAT_BIT,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  284  		     SPINAND_ECCINFO(&micron_8_ooblayout,
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  285  				     micron_8_ecc_get_status),
9f9ae0c253c1e0 Shivamurthy Shastri       2020-03-11  286  		     SPINAND_SELECT_TARGET(micron_select_target)),
8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23  287  	/* M69A 2Gb 3.3V */
8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23 @288  	SPINAND_INFO("MT29F2G01AAAED",
8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23  289  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x9F),
8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23  290  		     NAND_MEMORG(1, 2048, 64, 64, 2048, 80, 2, 1, 1),
8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23  291  		     NAND_ECCREQ(4, 512),
8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23  292  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_mt29f2g01aaaed,
8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23  293  					      &write_cache_variants_mt29f2g01aaaed,
8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23  294  					      &update_cache_variants_mt29f2g01aaaed),
8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23  295  		     0,
8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23  296  		     SPINAND_ECCINFO(&mt29f2g01aaaed_ooblayout,
8dc175bd1853eb Thirumalesha Narasimhappa 2020-08-23  297  				     mt29f2g01aaaed_ecc_get_status),
a508e8875e135d Peter Pan                 2018-06-22  298  };
a508e8875e135d Peter Pan                 2018-06-22  299  
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  300  static int micron_spinand_init(struct spinand_device *spinand)
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  301  {
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  302  	/*
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  303  	 * M70A device series enable Continuous Read feature at Power-up,
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  304  	 * which is not supported. Disable this bit to avoid any possible
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  305  	 * failure.
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  306  	 */
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  307  	if (spinand->flags & SPINAND_HAS_CR_FEAT_BIT)
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  308  		return spinand_upd_cfg(spinand, MICRON_CFG_CR, 0);
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  309  
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  310  	return 0;
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  311  }
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  312  
a508e8875e135d Peter Pan                 2018-06-22  313  static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
0bc68af9137dc3 Shivamurthy Shastri       2020-03-11  314  	.init = micron_spinand_init,
a508e8875e135d Peter Pan                 2018-06-22  315  };
a508e8875e135d Peter Pan                 2018-06-22  316  
a508e8875e135d Peter Pan                 2018-06-22  317  const struct spinand_manufacturer micron_spinand_manufacturer = {
a508e8875e135d Peter Pan                 2018-06-22  318  	.id = SPINAND_MFR_MICRON,
a508e8875e135d Peter Pan                 2018-06-22  319  	.name = "Micron",
f1541773af49ec Chuanhong Guo             2020-02-08  320  	.chips = micron_spinand_table,
f1541773af49ec Chuanhong Guo             2020-02-08  321  	.nchips = ARRAY_SIZE(micron_spinand_table),
a508e8875e135d Peter Pan                 2018-06-22  322  	.ops = &micron_spinand_manuf_ops,
a508e8875e135d Peter Pan                 2018-06-22 @323  };

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--d6Gm4EdcadzBjdND
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
W5O9nRxAy2JR3Tr8H+55wFTMyAEA

--d6Gm4EdcadzBjdND--
