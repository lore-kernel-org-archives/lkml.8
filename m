Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B45C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCD621473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDTLmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:42:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:61604 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgDTLmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:42:37 -0400
IronPort-SDR: /uCBdtW8mHDjUfT5qrvv4FsCF97JZTYzGeK5In4sF0vsNG0r4kVlEw3PgMx+/qMIJwOJqsK83K
 YfQ9jJnUCI5Q==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 04:42:05 -0700
IronPort-SDR: px5jjQCrn3e+b33r+e8c53P7Q35Dn38s3CMoWmRIq2I1MpIkIhsQjhV1AaTedNYVtLNDIhADJG
 68y6arq/I75Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="gz'50?scan'50,208,50";a="254914082"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2020 04:42:02 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jQUoM-0004BS-0B; Mon, 20 Apr 2020 19:42:01 +0800
Date:   Mon, 20 Apr 2020 19:41:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bernard Zhao <bernard@vivo.com>,
        Christoph Lameter <cl@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel@vivo.com
Subject: Re: [PATCH] kmalloc_index optimization(code size & runtime stable)
Message-ID: <202004201954.JM38mLQy%lkp@intel.com>
References: <1587089010-110083-1-git-send-email-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1587089010-110083-1-git-send-email-bernard@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bernard,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.7-rc2 next-20200420]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Bernard-Zhao/kmalloc_index-optimization-code-size-runtime-stable/20200417-100445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2fcd80144b93ff90836a44f2054b4d82133d3a85
config: s390-zfcpdump_defconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kvm_host.h:18,
                    from arch/s390/kernel/asm-offsets.c:11:
   include/linux/slab.h: In function 'kmalloc_index':
>> include/linux/slab.h:390:3: error: 'high_bit' undeclared (first use in this function); did you mean 'assign_bit'?
     390 |   high_bit = fls((int)size);
         |   ^~~~~~~~
         |   assign_bit
   include/linux/slab.h:390:3: note: each undeclared identifier is reported only once for each function it appears in
   make[2]: *** [scripts/Makefile.build:100: arch/s390/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1141: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:180: sub-make] Error 2
   40 real  5 user  12 sys  44.33% cpu 	make prepare

vim +390 include/linux/slab.h

   356	
   357	/*
   358	 * Figure out which kmalloc slab an allocation of a certain size
   359	 * belongs to.
   360	 * 0 = zero alloc
   361	 * 1 =  65 .. 96 bytes
   362	 * 2 = 129 .. 192 bytes
   363	 * n = 2^(n-1)+1 .. 2^n
   364	 */
   365	static __always_inline unsigned int kmalloc_index(size_t size)
   366	{
   367		if (!size)
   368			return 0;
   369	
   370		if (size <= KMALLOC_MIN_SIZE)
   371			return KMALLOC_SHIFT_LOW;
   372	
   373		if (KMALLOC_MIN_SIZE <= 32 && size > 64 && size <= 96)
   374			return 1;
   375		if (KMALLOC_MIN_SIZE <= 64 && size > 128 && size <= 192)
   376			return 2;
   377	
   378		if (size <= 8)
   379			return 3;
   380	
   381		/* size over KMALLOC_MAX_SIZE should trigger BUG */
   382		if (size <= KMALLOC_MAX_SIZE) {
   383			/*
   384			 * kmalloc_info[index]
   385			 * size  8----16----32----64----128---256---512---1024---2048.
   386			 *       |  |  |  |  |  |  |  |  |  |  |  |  |  |   |  |   |
   387			 * index 3  4  4  5  5  6  6  7  7  8  8  9  9  10  10 11  11
   388			 */
   389	
 > 390			high_bit = fls((int)size);
   391	
   392			if (size == (2 << (high_bit - KMALLOC_SIZE_POW_2_SHIFT_BIT)))
   393				return (high_bit - KMALLOC_SIZE_POW_2_INDEX_BIT);
   394	
   395			return high_bit;
   396		}
   397	
   398		BUG();
   399	
   400		/* Will never be reached. Needed because the compiler may complain */
   401		return -1;
   402	}
   403	#endif /* !CONFIG_SLOB */
   404	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LZvS9be/3tNcYl/X
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
DZzixvPxHzi7ZPWVeQAA

--LZvS9be/3tNcYl/X--
