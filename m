Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E3EC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443D520774
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgDXRqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:46:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:23773 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgDXRqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:46:09 -0400
IronPort-SDR: VXbvlX3GvlCpYqzo1Z6FSI5kzk9AKOVkRTgV2yeBZQcO/e5Qv8juNPal//fQMouqNEipkI3wDg
 o0Oh+AMhb7eQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 10:46:08 -0700
IronPort-SDR: tl4YNUDDqzQcSJ46Fv8xEQYB3YqVvNVxswkVfXcbC2ydqL6m63mJXgLfl15qXjxTf9nuYXP1Wi
 yW5p/Su4bSJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="gz'50?scan'50,208,50";a="335431639"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2020 10:46:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jS2Or-000923-F6; Sat, 25 Apr 2020 01:46:05 +0800
Date:   Sat, 25 Apr 2020 01:45:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 7/7] kernel.h: Split out might_sleep() and friends
Message-ID: <202004250159.fzdnZfm6%lkp@intel.com>
References: <20200422125201.37618-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20200422125201.37618-7-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
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
config: parisc-allnoconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/might_sleep.h:6,
                    from include/linux/kernel.h:14,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/thread_info.h: In function 'copy_overflow':
>> include/linux/thread_info.h:135:2: error: implicit declaration of function 'WARN' [-Werror=implicit-function-declaration]
     135 |  WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
         |  ^~~~
   include/linux/thread_info.h: In function 'check_copy_size':
>> include/linux/thread_info.h:151:6: error: implicit declaration of function 'WARN_ON_ONCE' [-Werror=implicit-function-declaration]
     151 |  if (WARN_ON_ONCE(bytes > INT_MAX))
         |      ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:100: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1142: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:180: sub-make] Error 2

vim +/WARN +135 include/linux/thread_info.h

b0377fedb65280 Al Viro   2017-06-29  132  
b0377fedb65280 Al Viro   2017-06-29  133  static inline void copy_overflow(int size, unsigned long count)
b0377fedb65280 Al Viro   2017-06-29  134  {
b0377fedb65280 Al Viro   2017-06-29 @135  	WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
b0377fedb65280 Al Viro   2017-06-29  136  }
b0377fedb65280 Al Viro   2017-06-29  137  
9dd819a15162f8 Kees Cook 2019-09-25  138  static __always_inline __must_check bool
b0377fedb65280 Al Viro   2017-06-29  139  check_copy_size(const void *addr, size_t bytes, bool is_source)
b0377fedb65280 Al Viro   2017-06-29  140  {
b0377fedb65280 Al Viro   2017-06-29  141  	int sz = __compiletime_object_size(addr);
b0377fedb65280 Al Viro   2017-06-29  142  	if (unlikely(sz >= 0 && sz < bytes)) {
b0377fedb65280 Al Viro   2017-06-29  143  		if (!__builtin_constant_p(bytes))
b0377fedb65280 Al Viro   2017-06-29  144  			copy_overflow(sz, bytes);
b0377fedb65280 Al Viro   2017-06-29  145  		else if (is_source)
b0377fedb65280 Al Viro   2017-06-29  146  			__bad_copy_from();
b0377fedb65280 Al Viro   2017-06-29  147  		else
b0377fedb65280 Al Viro   2017-06-29  148  			__bad_copy_to();
b0377fedb65280 Al Viro   2017-06-29  149  		return false;
b0377fedb65280 Al Viro   2017-06-29  150  	}
6d13de1489b6bf Kees Cook 2019-12-04 @151  	if (WARN_ON_ONCE(bytes > INT_MAX))
6d13de1489b6bf Kees Cook 2019-12-04  152  		return false;
b0377fedb65280 Al Viro   2017-06-29  153  	check_object_size(addr, bytes, is_source);
b0377fedb65280 Al Viro   2017-06-29  154  	return true;
b0377fedb65280 Al Viro   2017-06-29  155  }
b0377fedb65280 Al Viro   2017-06-29  156  

:::::: The code at line 135 was first introduced by commit
:::::: b0377fedb6528087ed319b0d054d6ed82240372c copy_{to,from}_user(): consolidate object size checks

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--zYM0uCDKw75PZbzx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--zYM0uCDKw75PZbzx--
