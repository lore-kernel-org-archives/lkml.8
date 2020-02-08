Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882D4C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D59421741
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgBHVs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 16:48:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:2906 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbgBHVs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:48:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 13:48:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,419,1574150400"; 
   d="gz'50?scan'50,208,50";a="379749046"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Feb 2020 13:48:54 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j0Xy9-0002uv-GW; Sun, 09 Feb 2020 05:48:53 +0800
Date:   Sun, 9 Feb 2020 05:47:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/4] kernel.h: Split out might_sleep() and friends
Message-ID: <202002090527.ewT5fDhg%lkp@intel.com>
References: <20200206163940.1940-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6vz5ksn2gidj7nvn"
Content-Disposition: inline
In-Reply-To: <20200206163940.1940-3-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6vz5ksn2gidj7nvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20200207]
[cannot apply to nfs/linux-next rcu/dev cryptodev/master crypto/master dennis-percpu/for-next tip/sched/core linux/master v5.5]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/kernel-h-Split-out-min-max-et-al-helpers/20200209-041358
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f757165705e92db62f85a1ad287e9251d1f2cd82
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/current.h:5,
                    from ./arch/openrisc/include/generated/asm/current.h:1,
                    from include/linux/might_sleep.h:6,
                    from include/linux/kernel.h:14,
                    from include/asm-generic/bug.h:19,
                    from ./arch/openrisc/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/thread_info.h: In function 'copy_overflow':
   include/linux/thread_info.h:134:2: error: implicit declaration of function 'WARN' [-Werror=implicit-function-declaration]
     134 |  WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
         |  ^~~~
   include/linux/thread_info.h: In function 'check_copy_size':
>> include/linux/thread_info.h:150:6: error: implicit declaration of function 'WARN_ON_ONCE' [-Werror=implicit-function-declaration]
     150 |  if (WARN_ON_ONCE(bytes > INT_MAX))
         |      ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2
   16 real  6 user  7 sys  83.27% cpu 	make prepare

vim +/WARN_ON_ONCE +150 include/linux/thread_info.h

b0377fedb652808 Al Viro   2017-06-29  136  
9dd819a15162f8f Kees Cook 2019-09-25  137  static __always_inline __must_check bool
b0377fedb652808 Al Viro   2017-06-29  138  check_copy_size(const void *addr, size_t bytes, bool is_source)
b0377fedb652808 Al Viro   2017-06-29  139  {
b0377fedb652808 Al Viro   2017-06-29  140  	int sz = __compiletime_object_size(addr);
b0377fedb652808 Al Viro   2017-06-29  141  	if (unlikely(sz >= 0 && sz < bytes)) {
b0377fedb652808 Al Viro   2017-06-29  142  		if (!__builtin_constant_p(bytes))
b0377fedb652808 Al Viro   2017-06-29  143  			copy_overflow(sz, bytes);
b0377fedb652808 Al Viro   2017-06-29  144  		else if (is_source)
b0377fedb652808 Al Viro   2017-06-29  145  			__bad_copy_from();
b0377fedb652808 Al Viro   2017-06-29  146  		else
b0377fedb652808 Al Viro   2017-06-29  147  			__bad_copy_to();
b0377fedb652808 Al Viro   2017-06-29  148  		return false;
b0377fedb652808 Al Viro   2017-06-29  149  	}
6d13de1489b6bf5 Kees Cook 2019-12-04 @150  	if (WARN_ON_ONCE(bytes > INT_MAX))
6d13de1489b6bf5 Kees Cook 2019-12-04  151  		return false;
b0377fedb652808 Al Viro   2017-06-29  152  	check_object_size(addr, bytes, is_source);
b0377fedb652808 Al Viro   2017-06-29  153  	return true;
b0377fedb652808 Al Viro   2017-06-29  154  }
b0377fedb652808 Al Viro   2017-06-29  155  

:::::: The code at line 150 was first introduced by commit
:::::: 6d13de1489b6bf539695f96d945de3860e6d5e17 uaccess: disallow > INT_MAX copy sizes

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6vz5ksn2gidj7nvn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qAxAU5XAWVHqXdiwy+9fQIOaclZ3AAA=

--6vz5ksn2gidj7nvn--
