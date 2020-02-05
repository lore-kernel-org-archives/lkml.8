Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41E4C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 01:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FF02082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 01:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgBEB5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 20:57:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:53991 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbgBEB5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:57:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 17:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,404,1574150400"; 
   d="gz'50?scan'50,208,50";a="254612683"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Feb 2020 17:57:26 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iz9wT-000Db8-OE; Wed, 05 Feb 2020 09:57:25 +0800
Date:   Wed, 5 Feb 2020 09:57:07 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Trond@black.fi.intel.com,
        Myklebust@black.fi.intel.com, trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] kernel.h: Split out mathematical helpers
Message-ID: <202002050944.Bw319kgR%lkp@intel.com>
References: <20200204170412.30106-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oajsmj2c2x3ckznp"
Content-Disposition: inline
In-Reply-To: <20200204170412.30106-2-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oajsmj2c2x3ckznp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20200203]
[cannot apply to nfs/linux-next rcu/dev linux/master linus/master v5.5 v5.5-rc7 v5.5-rc6 v5.5]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/kernel-h-Split-out-min-max-et-al-helpers/20200205-040141
base:    cee5a42837d4a6c4189f06f7bf355b97a24c3c93
config: m68k-multi_defconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   lib/math/div64.c: In function 'div64_u64_rem':
>> lib/math/div64.c:112:11: error: implicit declaration of function 'fls' [-Werror=implicit-function-declaration]
      int n = fls(high);
              ^~~
   cc1: some warnings being treated as errors

vim +/fls +112 lib/math/div64.c

2418f4f28f8467 lib/div64.c Roman Zippel      2008-05-01   89  
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20   90  /**
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20   91   * div64_u64_rem - unsigned 64bit divide with 64bit divisor and remainder
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20   92   * @dividend:	64bit dividend
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20   93   * @divisor:	64bit divisor
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20   94   * @remainder:  64bit remainder
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20   95   *
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20   96   * This implementation is a comparable to algorithm used by div64_u64.
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20   97   * But this operation, which includes math for calculating the remainder,
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20   98   * is kept distinct to avoid slowing down the div64_u64 operation on 32bit
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20   99   * systems.
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  100   */
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  101  #ifndef div64_u64_rem
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  102  u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  103  {
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  104  	u32 high = divisor >> 32;
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  105  	u64 quot;
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  106  
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  107  	if (high == 0) {
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  108  		u32 rem32;
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  109  		quot = div_u64_rem(dividend, divisor, &rem32);
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  110  		*remainder = rem32;
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  111  	} else {
cdc94a37493135 lib/div64.c Stanislaw Gruszka 2019-03-07 @112  		int n = fls(high);
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  113  		quot = div_u64(dividend >> n, divisor >> n);
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  114  
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  115  		if (quot != 0)
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  116  			quot--;
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  117  
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  118  		*remainder = dividend - quot * divisor;
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  119  		if (*remainder >= divisor) {
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  120  			quot++;
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  121  			*remainder -= divisor;
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  122  		}
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  123  	}
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  124  
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  125  	return quot;
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  126  }
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  127  EXPORT_SYMBOL(div64_u64_rem);
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  128  #endif
eb18cba78c2b92 lib/div64.c Mike Snitzer      2013-08-20  129  

:::::: The code at line 112 was first introduced by commit
:::::: cdc94a37493135e355dfc0b0e086d84e3eadb50d lib/div64.c: off by one in shift

:::::: TO: Stanislaw Gruszka <sgruszka@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--oajsmj2c2x3ckznp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AQA=

--oajsmj2c2x3ckznp--
