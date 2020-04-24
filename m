Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F07EC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2DE2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgDXRFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:05:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:19171 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgDXRFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:05:46 -0400
IronPort-SDR: RPA+PIvnhcpcBPJqfOiDCzuk/GLQMxSSq3C+eBI5Tcn6ZCMccfTEmjZvDGSk9VsVeplheeDN33
 L1bhx9rYgG6w==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 10:05:37 -0700
IronPort-SDR: EfnHXv7FxY3nPmIUi2++6TXc8HpSKbq8SPU4ibMYom/ELepvfnVoxTSg050LMjO4KDqmo9KtXn
 qWzbnR6bLBdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="gz'50?scan'50,208,50";a="292702120"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 Apr 2020 10:05:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jS1ld-0007fj-PT; Sat, 25 Apr 2020 01:05:33 +0800
Date:   Sat, 25 Apr 2020 01:04:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 6/7] kernel.h: Split out panic and oops helpers
Message-ID: <202004250022.Ix9vGhzp%lkp@intel.com>
References: <20200422125201.37618-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20200422125201.37618-6-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20200423]
[cannot apply to tip/locking/core rcu/dev linus/master tip/x86/core v5.7-rc2 v5.7-rc1 v5.6 v5.7-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/drm-shmobile-Reduce-include-dependencies/20200424-044529
base:    aefe184e814492e36b2ca350c1522bd71b09b520
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   arch/powerpc/kernel/setup-common.c: In function 'setup_panic':
>> arch/powerpc/kernel/setup-common.c:737:35: error: 'panic_notifier_list' undeclared (first use in this function); did you mean 'reboot_notifier_list'?
     737 |   atomic_notifier_chain_register(&panic_notifier_list,
         |                                   ^~~~~~~~~~~~~~~~~~~
         |                                   reboot_notifier_list
   arch/powerpc/kernel/setup-common.c:737:35: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:249,
                    from arch/powerpc/lib/feature-fixups.c:12:
   arch/powerpc/include/asm/cmpxchg.h: In function '__xchg_u8_local':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
>> arch/powerpc/include/asm/cmpxchg.h:23:11: note: in expansion of macro 'BITOFF_CAL'
      23 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
>> arch/powerpc/include/asm/cmpxchg.h:83:1: note: in expansion of macro 'XCHG_GEN'
      83 | XCHG_GEN(u8, _local, "memory");
         | ^~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:12:61: note: each undeclared identifier is reported only once for each function it appears in
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
>> arch/powerpc/include/asm/cmpxchg.h:23:11: note: in expansion of macro 'BITOFF_CAL'
      23 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
>> arch/powerpc/include/asm/cmpxchg.h:83:1: note: in expansion of macro 'XCHG_GEN'
      83 | XCHG_GEN(u8, _local, "memory");
         | ^~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__xchg_u8_relaxed':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
>> arch/powerpc/include/asm/cmpxchg.h:23:11: note: in expansion of macro 'BITOFF_CAL'
      23 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:84:1: note: in expansion of macro 'XCHG_GEN'
      84 | XCHG_GEN(u8, _relaxed, "cc");
         | ^~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__xchg_u16_local':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
>> arch/powerpc/include/asm/cmpxchg.h:23:11: note: in expansion of macro 'BITOFF_CAL'
      23 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:85:1: note: in expansion of macro 'XCHG_GEN'
      85 | XCHG_GEN(u16, _local, "memory");
         | ^~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__xchg_u16_relaxed':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
>> arch/powerpc/include/asm/cmpxchg.h:23:11: note: in expansion of macro 'BITOFF_CAL'
      23 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:86:1: note: in expansion of macro 'XCHG_GEN'
      86 | XCHG_GEN(u16, _relaxed, "cc");
         | ^~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u8':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:49:11: note: in expansion of macro 'BITOFF_CAL'
      49 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
>> arch/powerpc/include/asm/cmpxchg.h:213:1: note: in expansion of macro 'CMPXCHG_GEN'
     213 | CMPXCHG_GEN(u8, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u8_local':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:49:11: note: in expansion of macro 'BITOFF_CAL'
      49 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:214:1: note: in expansion of macro 'CMPXCHG_GEN'
     214 | CMPXCHG_GEN(u8, _local, , , "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u8_acquire':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:49:11: note: in expansion of macro 'BITOFF_CAL'
      49 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:215:1: note: in expansion of macro 'CMPXCHG_GEN'
     215 | CMPXCHG_GEN(u8, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u8_relaxed':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:49:11: note: in expansion of macro 'BITOFF_CAL'
      49 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:216:1: note: in expansion of macro 'CMPXCHG_GEN'
     216 | CMPXCHG_GEN(u8, _relaxed, , , "cc");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u16':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:49:11: note: in expansion of macro 'BITOFF_CAL'
      49 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:217:1: note: in expansion of macro 'CMPXCHG_GEN'
     217 | CMPXCHG_GEN(u16, , PPC_ATOMIC_ENTRY_BARRIER, PPC_ATOMIC_EXIT_BARRIER, "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u16_local':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:49:11: note: in expansion of macro 'BITOFF_CAL'
      49 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:218:1: note: in expansion of macro 'CMPXCHG_GEN'
     218 | CMPXCHG_GEN(u16, _local, , , "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u16_acquire':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:49:11: note: in expansion of macro 'BITOFF_CAL'
      49 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:219:1: note: in expansion of macro 'CMPXCHG_GEN'
     219 | CMPXCHG_GEN(u16, _acquire, , PPC_ACQUIRE_BARRIER, "memory");
         | ^~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h: In function '__cmpxchg_u16_relaxed':
>> arch/powerpc/include/asm/cmpxchg.h:12:61: error: 'BITS_PER_BYTE' undeclared (first use in this function); did you mean 'BITS_PER_LONG'?
      12 | #define BITOFF_CAL(size, off) ((sizeof(u32) - size - off) * BITS_PER_BYTE)
         |                                                             ^~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:49:11: note: in expansion of macro 'BITOFF_CAL'
      49 |  bitoff = BITOFF_CAL(sizeof(type), off);   \
         |           ^~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:220:1: note: in expansion of macro 'CMPXCHG_GEN'
     220 | CMPXCHG_GEN(u16, _relaxed, , , "cc");
         | ^~~~~~~~~~~

vim +737 arch/powerpc/kernel/setup-common.c

921a79b7802078 Jason Yan       2019-09-20  733  
ab9dbf771ff9b6 David Gibson    2017-12-04  734  void __init setup_panic(void)
ab9dbf771ff9b6 David Gibson    2017-12-04  735  {
921a79b7802078 Jason Yan       2019-09-20  736  	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_offset() > 0)
921a79b7802078 Jason Yan       2019-09-20 @737  		atomic_notifier_chain_register(&panic_notifier_list,
921a79b7802078 Jason Yan       2019-09-20  738  					       &kernel_offset_notifier);
921a79b7802078 Jason Yan       2019-09-20  739  
855b6232dda2b6 Nicholas Piggin 2018-05-19  740  	/* PPC64 always does a hard irq disable in its panic handler */
855b6232dda2b6 Nicholas Piggin 2018-05-19  741  	if (!IS_ENABLED(CONFIG_PPC64) && !ppc_md.panic)
ab9dbf771ff9b6 David Gibson    2017-12-04  742  		return;
ab9dbf771ff9b6 David Gibson    2017-12-04  743  	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
ab9dbf771ff9b6 David Gibson    2017-12-04  744  }
ab9dbf771ff9b6 David Gibson    2017-12-04  745  

:::::: The code at line 737 was first introduced by commit
:::::: 921a79b7802078fab3787c7eae561536906cb8f3 powerpc/fsl_booke/kaslr: dump out kernel offset information on panic

:::::: TO: Jason Yan <yanaijie@huawei.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--huq684BweRXVnRxX
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--huq684BweRXVnRxX--
