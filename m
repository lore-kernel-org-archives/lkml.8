Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438DBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD99A221E2
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgHHAbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 20:31:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:49056 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgHHAbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 20:31:19 -0400
IronPort-SDR: cOLw2BcI97LY3oV+d9qK6Z2ZXyZU1lyPMKiZGDrdYZ50sra8sGV76cYhNjAdU95oVwm6uIDZvK
 uEpYsLHig73Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="238061859"
X-IronPort-AV: E=Sophos;i="5.75,447,1589266800"; 
   d="gz'50?scan'50,208,50";a="238061859"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 17:03:49 -0700
IronPort-SDR: 3Cdf9Nfb/W64xZl/V26Fb5oPtC3Tm/Chm/iGXgJAFfb+zPAIPUnUA19sBPZrKqCu/JhnxexEy7
 7iUuFoW6Nw5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,447,1589266800"; 
   d="gz'50?scan'50,208,50";a="333699414"
Received: from lkp-server02.sh.intel.com (HELO 090e49ab5480) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2020 17:03:46 -0700
Received: from kbuild by 090e49ab5480 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k4CKv-0000ZF-ER; Sat, 08 Aug 2020 00:03:45 +0000
Date:   Sat, 8 Aug 2020 08:03:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>
Subject: include/linux/bits.h:25:21: error: first argument to
 '__builtin_choose_expr' not a constant
Message-ID: <202008080833.zZnw48Gr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   30185b69a2d533c4ba6ca926b8390ce7de495e29
commit: 295bcca84916cb5079140a89fccb472bb8d1f6e2 linux/bits.h: add compile time sanity check of GENMASK inputs
date:   4 months ago
config: s390-randconfig-r001-20200808 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 295bcca84916cb5079140a89fccb472bb8d1f6e2
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/mux/mmio.c: In function 'mux_mmio_probe':
   drivers/mux/mmio.c:76:20: error: storage size of 'field' isn't known
      76 |   struct reg_field field;
         |                    ^~~~~
   In file included from include/linux/bits.h:23,
                    from include/linux/bitops.h:5,
                    from drivers/mux/mmio.c:8:
>> include/linux/bits.h:25:21: error: first argument to '__builtin_choose_expr' not a constant
      25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/mux/mmio.c:96:15: note: in expansion of macro 'GENMASK'
      96 |   if (mask != GENMASK(field.msb, field.lsb)) {
         |               ^~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/mux/mmio.c:96:15: note: in expansion of macro 'GENMASK'
      96 |   if (mask != GENMASK(field.msb, field.lsb)) {
         |               ^~~~~~~
   drivers/mux/mmio.c:102:15: error: implicit declaration of function 'devm_regmap_field_alloc' [-Werror=implicit-function-declaration]
     102 |   fields[i] = devm_regmap_field_alloc(dev, regmap, field);
         |               ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mux/mmio.c:76:20: warning: unused variable 'field' [-Wunused-variable]
      76 |   struct reg_field field;
         |                    ^~~~~
   cc1: some warnings being treated as errors

vim +/__builtin_choose_expr +25 include/linux/bits.h

    15	
    16	/*
    17	 * Create a contiguous bitmask starting at bit position @l and ending at
    18	 * position @h. For example
    19	 * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
    20	 */
    21	#if !defined(__ASSEMBLY__) && \
    22		(!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
  > 23	#include <linux/build_bug.h>
    24	#define GENMASK_INPUT_CHECK(h, l) \
  > 25		(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
    26			__builtin_constant_p((l) > (h)), (l) > (h), 0)))
    27	#else
    28	/*
    29	 * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
    30	 * disable the input check if that is the case.
    31	 */
    32	#define GENMASK_INPUT_CHECK(h, l) 0
    33	#endif
    34	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
tC9FsEBJ2IZr7LXovzvjhutRu+Am6y/H52d8eIy2+8Pu+GL6MVKMBTR2K+408dEDu9dPOQm3
p3+OOCoZ05YvQUVTFnc1paF+987qfMlsdvW4DFJQSuFchNI9MHOvEpazUaCvemGvDeLfGhaz
YWgSKJjQjmgl55yM2mfgrlzzpAJyRNxXGBsj49rdhowEMmu/sRBqKfQPoGYd2TLl0/ggMs8i
jA5i2uyamCbN5JhzJhQWKUYm4BraGCchCS+ySVAFTbdTGMhs/EmEnqXfLrE4YCMXoP1GO1WU
jyRY2BX/Co62ldCnLG7khc3V6empXXtH6zl0WFSducDUGYaOBk1wQeTpRh9tT8l2oS6tMFgl
iL1JixTpxJWCVpM/8xp7y77kQEQ2DpyFusSSQXUEsgh2Lso5/ckwfG+nW8oqVGptsxpayIug
NOLDmAh86DK5PQxp7Uuscz9mlWZT9fZDhMjqKrayMhr4KI0Nz3oJlerbyC6M7nwuGqkH5I4n
q0Hb96q3A8YQpYQdsiDpRYfD/3P0jrIlDtGfZK9v+/cn8evT9+Ob3Bbmq+2zrkDBeg7RmCUz
jPwNMPoW1Np9pUSizgXDeGusiArN0ec1CIAKVF6WzZZ3bNBEczjwzqTO2fEY7pi0H4Nt8OuR
okpoAtdYLVbsBQk0lSCCqZvv3h6HKdueERyahRC5xQjyzgrf2Pv95Z/7t80W392hNy/Hw/rP
NfxnfXj67bff/tW3mbwwqOwZ6dWdO3Gn76JPP+N0IREYa4aKSGFsee4kNHbWEc5441uJeyOG
heS73vfalCA8+XIpMSCvsyXZndk1LUuROJ9RwyxJgDA4cbibRYvwimE4uaNCXsZC5FxFOLj0
hqKCIOhVUEvg6F+hHZxH2ved5I4+/8fUqwJlrgFY4NM4mOkOCCiKCKk3kVRIGCyMwyLEBFha
3osNyPuF3GA98uO71Ie+rg6rE1SEnvB21jk8xBG3c+cIHtq3OT6UKLW/GONP2kDakK4QZkVR
M55EhozwNN5uRwhHHIFpS2M37ncR1pwMaZdVqL0p6oxhXEyGNe6EUx/HIN76VsPg/knnik7c
no3MsokH+IMLYMVd6R4/e2d3o3fWcr1rzx1FYQaIxybNsyqPpUJSCeVdq61PgKbhgxGCDsMl
UVsNw1kYxWmdyoPQMHZWBPmcp1Hn7KlaD35ks4yqOV5u2BpJi07IZw8I8FbfIkGHIpoJpARN
N62cQvB598ECYsdlsRqzUDfwRqqx2iybEZpylS5TxvV0qncdtA1oKdIbjng4GXCYaKNCOQOm
FUVSdQmE+gVUXgiRwMKCkxnbT6c+dTNqV9QSunuVPUtoQozMrRXde5SZvMGyudR7Bwi0LtGY
cY+WgCxBJXd6IfWCDtpbdS+Bx4cqbfmp5RmuypYHyhTU43nmModCdHq0OVFjkOwwvyCJyOHS
NmhW8CAFWRqQqTZ9wD7ZqjUih8edQ+OKcg5SHTDRbGbJZ9ljyZbyRMDrdx1bNWOQEvMkKLgr
G51ROzp7nQjQTOnSvI2KpHgyzD53IzB1dkk1N1UAYjd3BHMvQLUm/JJY47KJQJdJL2X5kIIM
kuMEq2eAMEjymJ2w7iJEJphpolIuZvOeTrpAtDTO1rbHZ3ZmbzM1Di4un3zjriZ1wmlaIihi
lZ9I136s+vRr32q9P6BGhGp8+Pqf9W71vO4btKjTyKifAFykGwNvbqYSJu5pSC0ce5o1QqJm
U9oS/NR682SKVZ6Ou5uk+wCmUkzFincbBusCTN6jkErMFgcUU9RBze+MSrq7tSHeWsAqck7f
cErFxSWZJDdP1oDgFjLsfCTe5dnDiWoVLyaeCAjyJIjipsw86cWIJIlSiirmp/B+P1ZaNCns
A6JgjEaXA3h63cviDNN1eKkoTACKrOHC8LkL5L0XL08xVxfsW7fZ8bm4t5epNTLypUa+WfG3
bIquDHPeh15eYABFxUbFkilYlOGGDhxHVWIGAVFgWDieUP1EUdd20A8dK19k/Xh0ap+CtPRT
FGheQPlcB4bWFx2OsNGEDy4oeXoxwPDtDdFA59FUD53D/CTj3JPJgpAxMP08o4tiPiMxmbrA
LAxu0FTWNCoSOHQKa2I733tt00OIJpq5Owhc6obwtjpOG+sQj5KLm+0haAkLkYSgug0uCTId
8rxrqUK8BIBz16Tp7sXvd45PmHwL/R8Hqf+50PkAAA==

--X1bOJ3K7DJ5YkBrT--
