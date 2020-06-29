Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09F32082F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbgF2TpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:45:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:58001 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387708AbgF2Toy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:44:54 -0400
IronPort-SDR: uCPzXLWpoDZgMap/BNkkhiWviFhpBHHM27TqD3So7pq1VuP7bcCBliOhJHqu8isUPLLPw6PFaN
 /7mI6mwFp92w==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="211042101"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="gz'50?scan'50,208,50";a="211042101"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 06:45:15 -0700
IronPort-SDR: 1HDgH2DeDktovkwseoAqEKsXIkCZXgzi8NDVfW6NBBbNEJRmbCbsrTJwteLfHPHmzcNZ/vFM7z
 Pp6CKmKLh2YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="gz'50?scan'50,208,50";a="424823143"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2020 06:45:13 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpu5w-0000zl-OI; Mon, 29 Jun 2020 13:45:12 +0000
Date:   Mon, 29 Jun 2020 21:44:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/8xx/cpm1.c:209:24: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202006292126.gvFU8Yag%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   11 days ago
config: powerpc64-randconfig-s032-20200629 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C= CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/powerpc/platforms/8xx/cpm1.c:209:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct comm_proc [usertype] *cp @@     got struct comm_proc [noderef] [usertype] __iomem *[addressable] [assigned] [toplevel] cpmp @@
   arch/powerpc/platforms/8xx/cpm1.c:209:24: sparse:     expected struct comm_proc [usertype] *cp
>> arch/powerpc/platforms/8xx/cpm1.c:209:24: sparse:     got struct comm_proc [noderef] [usertype] __iomem *[addressable] [assigned] [toplevel] cpmp
>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse:     got restricted __be16 [noderef] __iomem *
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse:     got restricted __be16 [noderef] __iomem *
--
>> arch/powerpc/platforms/8xx/micropatch.c:328:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned char * @@
>> arch/powerpc/platforms/8xx/micropatch.c:328:34: sparse:     expected void volatile [noderef] __iomem *d
   arch/powerpc/platforms/8xx/micropatch.c:328:34: sparse:     got unsigned char *
>> arch/powerpc/platforms/8xx/micropatch.c:333:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
>> arch/powerpc/platforms/8xx/micropatch.c:333:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:333:19: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:346:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:346:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:346:27: sparse:     got unsigned short *
>> arch/powerpc/platforms/8xx/micropatch.c:350:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 * @@
   arch/powerpc/platforms/8xx/micropatch.c:350:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:350:27: sparse:     got restricted __be16 *
   arch/powerpc/platforms/8xx/micropatch.c:356:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:356:35: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:356:35: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:364:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:364:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:364:27: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:366:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:366:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:366:27: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:369:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:369:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:369:19: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:370:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:370:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:370:19: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:371:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:371:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:371:19: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:372:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:372:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:372:19: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:374:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:374:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:374:19: sparse:     got unsigned short *
--
>> drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:78:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *dp_mem @@     got void [noderef] __iomem * @@
   drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:78:16: sparse:     expected unsigned char [usertype] *dp_mem
>> drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:78:16: sparse:     got void [noderef] __iomem *
>> drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:85:29: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:86:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned char [usertype] *[assigned] mem_addr @@
>> drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:86:48: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:86:48: sparse:     got unsigned char [usertype] *[assigned] mem_addr
--
>> drivers/mtd/nand/raw/fsl_elbc_nand.c:168:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/mtd/nand/raw/fsl_elbc_nand.c:168:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
>> drivers/mtd/nand/raw/fsl_elbc_nand.c:168:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:169:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:169:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:169:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:178:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:178:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:178:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:179:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:179:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:179:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:212:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:212:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:212:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:214:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:214:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:214:27: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/mtd/nand/raw/fsl_elbc_nand.c:216:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/mtd/nand/raw/fsl_elbc_nand.c:216:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:216:9: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/mtd/nand/raw/fsl_elbc_nand.c:216:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/mtd/nand/raw/fsl_elbc_nand.c:216:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:216:9: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/mtd/nand/raw/fsl_elbc_nand.c:216:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/mtd/nand/raw/fsl_elbc_nand.c:216:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:216:9: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:219:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:219:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:219:9: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:219:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:219:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:219:9: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:219:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:219:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:219:9: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:227:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:227:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:227:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:235:47: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:235:47: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:235:47: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:240:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:240:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:240:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:240:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:240:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:240:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:253:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:253:44: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:253:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:266:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:266:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:266:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:283:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:283:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:283:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:290:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:290:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:290:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:293:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:293:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:293:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:300:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:300:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:300:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:302:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:302:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:302:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:334:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:334:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:334:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:359:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:359:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:359:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:372:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:372:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:372:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:375:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:375:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:375:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:380:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:380:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:380:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:400:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:400:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:400:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:407:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:407:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:407:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:412:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:412:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:412:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:439:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] fcr @@     got int @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:439:21: sparse:     expected restricted __be32 [usertype] fcr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:439:21: sparse:     got int
   drivers/mtd/nand/raw/fsl_elbc_nand.c:444:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:444:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:444:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:453:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:453:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:453:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:465:37: sparse: sparse: invalid assignment: |=
   drivers/mtd/nand/raw/fsl_elbc_nand.c:465:37: sparse:    left side has type restricted __be32
   drivers/mtd/nand/raw/fsl_elbc_nand.c:465:37: sparse:    right side has type int
   drivers/mtd/nand/raw/fsl_elbc_nand.c:468:37: sparse: sparse: invalid assignment: |=
   drivers/mtd/nand/raw/fsl_elbc_nand.c:468:37: sparse:    left side has type restricted __be32
   drivers/mtd/nand/raw/fsl_elbc_nand.c:468:37: sparse:    right side has type int
   drivers/mtd/nand/raw/fsl_elbc_nand.c:471:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:471:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:471:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:471:37: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] fcr @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:471:37: sparse:     expected unsigned int [usertype] val
   drivers/mtd/nand/raw/fsl_elbc_nand.c:471:37: sparse:     got restricted __be32 [usertype] fcr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:488:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:488:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:488:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:491:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:491:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:491:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:500:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:500:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:500:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/mtd/nand/raw/fsl_elbc_nand.c:503:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/mtd/nand/raw/fsl_elbc_nand.c:503:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/mtd/nand/raw/fsl_elbc_nand.c:503:27: sparse:     got restricted __be32 [noderef] __iomem *
--
>> drivers/watchdog/mpc8xxx_wdt.c:76:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> drivers/watchdog/mpc8xxx_wdt.c:76:24: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
>> drivers/watchdog/mpc8xxx_wdt.c:76:24: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/watchdog/mpc8xxx_wdt.c:77:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/watchdog/mpc8xxx_wdt.c:77:24: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/watchdog/mpc8xxx_wdt.c:77:24: sparse:     got restricted __be16 [noderef] __iomem *
>> drivers/watchdog/mpc8xxx_wdt.c:85:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/watchdog/mpc8xxx_wdt.c:85:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> drivers/watchdog/mpc8xxx_wdt.c:85:33: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/watchdog/mpc8xxx_wdt.c:94:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/watchdog/mpc8xxx_wdt.c:94:24: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/watchdog/mpc8xxx_wdt.c:94:24: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/watchdog/mpc8xxx_wdt.c:96:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/watchdog/mpc8xxx_wdt.c:96:29: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/watchdog/mpc8xxx_wdt.c:96:29: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/watchdog/mpc8xxx_wdt.c:152:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/watchdog/mpc8xxx_wdt.c:152:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/watchdog/mpc8xxx_wdt.c:152:33: sparse:     got restricted __be32 [noderef] __iomem *

vim +209 arch/powerpc/platforms/8xx/cpm1.c

f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   85  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  @86  int cpm_get_irq(void)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   87  {
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   88  	int cpm_vec;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   89  
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14   90  	/*
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14   91  	 * Get the vector by setting the ACK bit and then reading
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   92  	 * the register.
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   93  	 */
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   94  	out_be16(&cpic_reg->cpic_civr, 1);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   95  	cpm_vec = in_be16(&cpic_reg->cpic_civr);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   96  	cpm_vec >>= 11;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   97  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   98  	return irq_linear_revmap(cpm_pic_host, cpm_vec);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24   99  }
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  100  
bae1d8f19983fb arch/powerpc/sysdev/cpm1.c        Grant Likely     2012-02-14  101  static int cpm_pic_host_map(struct irq_domain *h, unsigned int virq,
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  102  			  irq_hw_number_t hw)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  103  {
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  104  	pr_debug("cpm_pic_host_map(%d, 0x%lx)\n", virq, hw);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  105  
98488db9ff0184 arch/powerpc/sysdev/cpm1.c        Thomas Gleixner  2011-03-25  106  	irq_set_status_flags(virq, IRQ_LEVEL);
ec775d0e70eb6b arch/powerpc/sysdev/cpm1.c        Thomas Gleixner  2011-03-25  107  	irq_set_chip_and_handler(virq, &cpm_pic, handle_fasteoi_irq);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  108  	return 0;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  109  }
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  110  
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  111  /*
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  112   * The CPM can generate the error interrupt when there is a race condition
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  113   * between generating and masking interrupts.  All we have to do is ACK it
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  114   * and return.  This is a no-op function so we don't need any special
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  115   * tests in the interrupt handler.
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  116   */
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  117  static irqreturn_t cpm_error_interrupt(int irq, void *dev)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  118  {
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  119  	return IRQ_HANDLED;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  120  }
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  121  
9f70b8eb3cd37c arch/powerpc/sysdev/cpm1.c        Grant Likely     2012-01-26  122  static const struct irq_domain_ops cpm_pic_host_ops = {
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  123  	.map = cpm_pic_host_map,
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  124  };
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  125  
132f92fdc42782 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-09-12  126  unsigned int __init cpm_pic_init(void)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  127  {
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  128  	struct device_node *np = NULL;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  129  	struct resource res;
ef24ba7091517d arch/powerpc/sysdev/cpm1.c        Michael Ellerman 2016-09-06  130  	unsigned int sirq = 0, hwirq, eirq;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  131  	int ret;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  132  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  133  	pr_debug("cpm_pic_init\n");
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  134  
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  135  	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1-pic");
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  136  	if (np == NULL)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  137  		np = of_find_compatible_node(NULL, "cpm-pic", "CPM");
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  138  	if (np == NULL) {
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  139  		printk(KERN_ERR "CPM PIC init: can not find cpm-pic node\n");
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  140  		return sirq;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  141  	}
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  142  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  143  	ret = of_address_to_resource(np, 0, &res);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  144  	if (ret)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  145  		goto end;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  146  
28f65c11f2ffb3 arch/powerpc/sysdev/cpm1.c        Joe Perches      2011-06-09  147  	cpic_reg = ioremap(res.start, resource_size(&res));
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  148  	if (cpic_reg == NULL)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  149  		goto end;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  150  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  151  	sirq = irq_of_parse_and_map(np, 0);
ef24ba7091517d arch/powerpc/sysdev/cpm1.c        Michael Ellerman 2016-09-06  152  	if (!sirq)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  153  		goto end;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  154  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  155  	/* Initialize the CPM interrupt controller. */
476eb4912601a8 arch/powerpc/sysdev/cpm1.c        Grant Likely     2011-05-04  156  	hwirq = (unsigned int)virq_to_hw(sirq);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  157  	out_be32(&cpic_reg->cpic_cicr,
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  158  	    (CICR_SCD_SCC4 | CICR_SCC_SCC3 | CICR_SCB_SCC2 | CICR_SCA_SCC1) |
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  159  		((hwirq/2) << 13) | CICR_HP_MASK);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  160  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  161  	out_be32(&cpic_reg->cpic_cimr, 0);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  162  
a8db8cf0d894df arch/powerpc/sysdev/cpm1.c        Grant Likely     2012-02-14  163  	cpm_pic_host = irq_domain_add_linear(np, 64, &cpm_pic_host_ops, NULL);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  164  	if (cpm_pic_host == NULL) {
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  165  		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
ef24ba7091517d arch/powerpc/sysdev/cpm1.c        Michael Ellerman 2016-09-06  166  		sirq = 0;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  167  		goto end;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  168  	}
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  169  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  170  	/* Install our own error handler. */
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  171  	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1");
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  172  	if (np == NULL)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  173  		np = of_find_node_by_type(NULL, "cpm");
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  174  	if (np == NULL) {
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  175  		printk(KERN_ERR "CPM PIC init: can not find cpm node\n");
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  176  		goto end;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  177  	}
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  178  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  179  	eirq = irq_of_parse_and_map(np, 0);
ef24ba7091517d arch/powerpc/sysdev/cpm1.c        Michael Ellerman 2016-09-06  180  	if (!eirq)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  181  		goto end;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  182  
b4f00d5b209832 arch/powerpc/platforms/8xx/cpm1.c afzal mohammed   2020-03-12  183  	if (request_irq(eirq, cpm_error_interrupt, IRQF_NO_THREAD, "error",
b4f00d5b209832 arch/powerpc/platforms/8xx/cpm1.c afzal mohammed   2020-03-12  184  			NULL))
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  185  		printk(KERN_ERR "Could not allocate CPM error IRQ!");
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  186  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  187  	setbits32(&cpic_reg->cpic_cicr, CICR_IEN);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  188  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  189  end:
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  190  	of_node_put(np);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  191  	return sirq;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  192  }
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  193  
15f8c604a79c48 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-28  194  void __init cpm_reset(void)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  195  {
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  196  	sysconf8xx_t __iomem *siu_conf;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  197  
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  198  	cpmp = &mpc8xx_immr->im_cpm;
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  199  
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  200  #ifndef CONFIG_PPC_EARLY_DEBUG_CPM
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  201  	/* Perform a reset. */
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  202  	out_be16(&cpmp->cp_cpcr, CPM_CR_RST | CPM_CR_FLG);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  203  
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  204  	/* Wait for it. */
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  205  	while (in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG);
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  206  #endif
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  207  
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  208  #ifdef CONFIG_UCODE_PATCH
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14 @209  	cpm_load_patch(cpmp);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  210  #endif
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  211  
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  212  	/*
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  213  	 * Set SDMA Bus Request priority 5.
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  214  	 * On 860T, this also enables FEC priority 6.  I am not sure
25985edcedea63 arch/powerpc/sysdev/cpm1.c        Lucas De Marchi  2011-03-30  215  	 * this is what we really want for some applications, but the
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  216  	 * manual recommends it.
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  217  	 * Bit 25, FAM can also be set to use FEC aggressive mode (860T).
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  218  	 */
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  219  	siu_conf = immr_map(im_siu_conf);
501ea76687ef16 arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2016-02-04  220  	if ((mfspr(SPRN_IMMR) & 0xffff) == 0x0900) /* MPC885 */
501ea76687ef16 arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2016-02-04  221  		out_be32(&siu_conf->sc_sdcr, 0x40);
501ea76687ef16 arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2016-02-04  222  	else
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  223  		out_be32(&siu_conf->sc_sdcr, 1);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  224  	immr_unmap(siu_conf);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  225  }
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  226  
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  227  static DEFINE_SPINLOCK(cmd_lock);
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  228  
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  229  #define MAX_CR_CMD_LOOPS        10000
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  230  
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  231  int cpm_command(u32 command, u8 opcode)
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  232  {
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  233  	int i, ret;
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  234  	unsigned long flags;
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  235  
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  236  	if (command & 0xffffff0f)
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  237  		return -EINVAL;
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  238  
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  239  	spin_lock_irqsave(&cmd_lock, flags);
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  240  
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  241  	ret = 0;
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  242  	out_be16(&cpmp->cp_cpcr, command | CPM_CR_FLG | (opcode << 8));
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  243  	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  244  		if ((in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0)
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  245  			goto out;
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  246  
e48b1b452ff630 arch/powerpc/sysdev/cpm1.c        Harvey Harrison  2008-03-29  247  	printk(KERN_ERR "%s(): Not able to issue CPM command\n", __func__);
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  248  	ret = -EIO;
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  249  out:
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  250  	spin_unlock_irqrestore(&cmd_lock, flags);
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  251  	return ret;
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  252  }
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  253  EXPORT_SYMBOL(cpm_command);
362f9b6fa8c967 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-26  254  
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  255  /*
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  256   * Set a baud rate generator.  This needs lots of work.  There are
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  257   * four BRGs, any of which can be wired to any channel.
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  258   * The internal baud rate clock is the system clock divided by 16.
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  259   * This assumes the baudrate is 16x oversampled by the uart.
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  260   */
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  261  #define BRG_INT_CLK		(get_brgfreq())
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  262  #define BRG_UART_CLK		(BRG_INT_CLK/16)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  263  #define BRG_UART_CLK_DIV16	(BRG_UART_CLK/16)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  264  
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  265  void
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  266  cpm_setbrg(uint brg, uint rate)
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  267  {
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  268  	u32 __iomem *bp;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  269  
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  270  	/* This is good enough to get SMCs running..... */
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  271  	bp = &cpmp->cp_brgc1;
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  272  	bp += brg;
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  273  	/*
4128a89ac80d37 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-06-14  274  	 * The BRG has a 12-bit counter.  For really slow baud rates (or
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  275  	 * really fast processors), we may have to further divide by 16.
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  276  	 */
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  277  	if (((BRG_UART_CLK / rate) - 1) < 4096)
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  278  		out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  279  	else
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  280  		out_be32(bp, (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
fb533d0c5a9783 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-09-14  281  			      CPM_BRG_EN | CPM_BRG_DIV16);
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  282  }
f2a0bd3753dad7 arch/powerpc/sysdev/commproc.c    Vitaly Bordug    2007-01-24  283  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  284  struct cpm_ioport16 {
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  285  	__be16 dir, par, odr_sor, dat, intr;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  286  	__be16 res[3];
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  287  };
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  288  
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  289  struct cpm_ioport32b {
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  290  	__be32 dir, par, odr, dat;
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  291  };
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  292  
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  293  struct cpm_ioport32e {
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  294  	__be32 dir, par, sor, odr, dat;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  295  };
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  296  
132f92fdc42782 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-09-12  297  static void __init cpm1_set_pin32(int port, int pin, int flags)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  298  {
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  299  	struct cpm_ioport32e __iomem *iop;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  300  	pin = 1 << (31 - pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  301  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  302  	if (port == CPM_PORTB)
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  303  		iop = (struct cpm_ioport32e __iomem *)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  304  		      &mpc8xx_immr->im_cpm.cp_pbdir;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  305  	else
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  306  		iop = (struct cpm_ioport32e __iomem *)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  307  		      &mpc8xx_immr->im_cpm.cp_pedir;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  308  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  309  	if (flags & CPM_PIN_OUTPUT)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16 @310  		setbits32(&iop->dir, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  311  	else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  312  		clrbits32(&iop->dir, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  313  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  314  	if (!(flags & CPM_PIN_GPIO))
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  315  		setbits32(&iop->par, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  316  	else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  317  		clrbits32(&iop->par, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  318  
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  319  	if (port == CPM_PORTB) {
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  320  		if (flags & CPM_PIN_OPENDRAIN)
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  321  			setbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  322  		else
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  323  			clrbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  324  	}
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  325  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  326  	if (port == CPM_PORTE) {
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  327  		if (flags & CPM_PIN_SECONDARY)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16 @328  			setbits32(&iop->sor, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  329  		else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16 @330  			clrbits32(&iop->sor, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  331  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  332  		if (flags & CPM_PIN_OPENDRAIN)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  333  			setbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  334  		else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  335  			clrbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  336  	}
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  337  }
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  338  
132f92fdc42782 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-09-12  339  static void __init cpm1_set_pin16(int port, int pin, int flags)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  340  {
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  341  	struct cpm_ioport16 __iomem *iop =
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  342  		(struct cpm_ioport16 __iomem *)&mpc8xx_immr->im_ioport;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  343  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  344  	pin = 1 << (15 - pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  345  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  346  	if (port != 0)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  347  		iop += port - 1;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  348  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  349  	if (flags & CPM_PIN_OUTPUT)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16 @350  		setbits16(&iop->dir, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  351  	else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  352  		clrbits16(&iop->dir, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  353  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  354  	if (!(flags & CPM_PIN_GPIO))
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  355  		setbits16(&iop->par, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  356  	else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  357  		clrbits16(&iop->par, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  358  
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  359  	if (port == CPM_PORTA) {
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  360  		if (flags & CPM_PIN_OPENDRAIN)
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  361  			setbits16(&iop->odr_sor, pin);
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  362  		else
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  363  			clrbits16(&iop->odr_sor, pin);
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  364  	}
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  365  	if (port == CPM_PORTC) {
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  366  		if (flags & CPM_PIN_SECONDARY)
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  367  			setbits16(&iop->odr_sor, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  368  		else
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  369  			clrbits16(&iop->odr_sor, pin);
726bd223105c04 arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  370  		if (flags & CPM_PIN_FALLEDGE)
726bd223105c04 arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  371  			setbits16(&iop->intr, pin);
726bd223105c04 arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  372  		else
726bd223105c04 arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  373  			clrbits16(&iop->intr, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  374  	}
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  375  }
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  376  

:::::: The code at line 209 was first introduced by commit
:::::: fb533d0c5a9783ecafa9a177bace6384c47282a9 [POWERPC] 8xx: Infrastructure code cleanup.

:::::: TO: Scott Wood <scottwood@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--7JfCtLOvnd9MIVvH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
CwOnaWNo8T/s01+7O6MBAA==

--7JfCtLOvnd9MIVvH--
