Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973E8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D84B206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgGHVeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:34:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:32336 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgGHVeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 17:34:03 -0400
IronPort-SDR: A6NZn+j2EdtLPSAXQ3rUbQEnN+Mr2P0AHxCsrOnEYTs67W0SH7sXK0DBxy+yrAtLAFH4aJXqTP
 zJEkHjp9Quug==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="146977638"
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; 
   d="gz'50?scan'50,208,50";a="146977638"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 14:33:53 -0700
IronPort-SDR: osKU6mRZSomXXtFLIBhCYi6jaCyDnnUwiD5z8LW5wWXTJkLC5rhPn5/4PANRuCmFhKZoJSDNXj
 /uVhelphJ0Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; 
   d="gz'50?scan'50,208,50";a="324008341"
Received: from lkp-server01.sh.intel.com (HELO 6136dd46483e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Jul 2020 14:33:51 -0700
Received: from kbuild by 6136dd46483e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtHhO-0000IM-HR; Wed, 08 Jul 2020 21:33:50 +0000
Date:   Thu, 9 Jul 2020 05:33:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: kernel/bpf/syscall.c:1384:13: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202007090533.9aGXcIll%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcde237b9b0eb1d19306e6f48c0a4e058907619f
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: openrisc-randconfig-s032-20200709 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-37-gc9676a3b-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> kernel/bpf/syscall.c:1384:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/syscall.c:1384:13: sparse:     expected unsigned int *__pu_addr
>> kernel/bpf/syscall.c:1384:13: sparse:     got unsigned int [noderef] __user *
>> kernel/bpf/syscall.c:2648:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__pu_addr @@     got char [noderef] __user * @@
   kernel/bpf/syscall.c:2648:21: sparse:     expected char *__pu_addr
>> kernel/bpf/syscall.c:2648:21: sparse:     got char [noderef] __user *
   kernel/bpf/syscall.c:3014:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/syscall.c:3014:23: sparse:     expected unsigned int *__pu_addr
   kernel/bpf/syscall.c:3014:23: sparse:     got unsigned int [noderef] __user *
>> kernel/bpf/syscall.c:3263:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   kernel/bpf/syscall.c:3263:29: sparse:     expected unsigned int *__pu_addr
>> kernel/bpf/syscall.c:3263:29: sparse:     got unsigned int [noderef] [usertype] __user *
>> kernel/bpf/syscall.c:3380:45: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__pu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   kernel/bpf/syscall.c:3380:45: sparse:     expected unsigned long long *__pu_addr
>> kernel/bpf/syscall.c:3380:45: sparse:     got unsigned long long [noderef] [usertype] __user *
   kernel/bpf/syscall.c:3386:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__pu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   kernel/bpf/syscall.c:3386:37: sparse:     expected unsigned long long *__pu_addr
   kernel/bpf/syscall.c:3386:37: sparse:     got unsigned long long [noderef] [usertype] __user *
   kernel/bpf/syscall.c:3408:45: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   kernel/bpf/syscall.c:3408:45: sparse:     expected unsigned int *__pu_addr
   kernel/bpf/syscall.c:3408:45: sparse:     got unsigned int [noderef] [usertype] __user *
   kernel/bpf/syscall.c:3413:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   kernel/bpf/syscall.c:3413:37: sparse:     expected unsigned int *__pu_addr
   kernel/bpf/syscall.c:3413:37: sparse:     got unsigned int [noderef] [usertype] __user *
   kernel/bpf/syscall.c:3461:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__pu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   kernel/bpf/syscall.c:3461:37: sparse:     expected unsigned long long *__pu_addr
   kernel/bpf/syscall.c:3461:37: sparse:     got unsigned long long [noderef] [usertype] __user *
   kernel/bpf/syscall.c:3494:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/syscall.c:3494:13: sparse:     expected unsigned int *__pu_addr
   kernel/bpf/syscall.c:3494:13: sparse:     got unsigned int [noderef] __user *
   kernel/bpf/syscall.c:3537:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/syscall.c:3537:13: sparse:     expected unsigned int *__pu_addr
   kernel/bpf/syscall.c:3537:13: sparse:     got unsigned int [noderef] __user *
   kernel/bpf/syscall.c:3587:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/syscall.c:3587:13: sparse:     expected unsigned int *__pu_addr
   kernel/bpf/syscall.c:3587:13: sparse:     got unsigned int [noderef] __user *
   kernel/bpf/syscall.c:3664:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/syscall.c:3664:13: sparse:     expected unsigned int *__pu_addr
   kernel/bpf/syscall.c:3664:13: sparse:     got unsigned int [noderef] __user *
>> kernel/bpf/syscall.c:3672:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__pu_addr @@     got char [noderef] __user *ubuf @@
   kernel/bpf/syscall.c:3672:29: sparse:     expected char *__pu_addr
>> kernel/bpf/syscall.c:3672:29: sparse:     got char [noderef] __user *ubuf
   kernel/bpf/syscall.c:3687:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__pu_addr @@     got char [noderef] __user * @@
   kernel/bpf/syscall.c:3687:29: sparse:     expected char *__pu_addr
   kernel/bpf/syscall.c:3687:29: sparse:     got char [noderef] __user *
   kernel/bpf/syscall.c:3692:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/syscall.c:3692:13: sparse:     expected unsigned int *__pu_addr
   kernel/bpf/syscall.c:3692:13: sparse:     got unsigned int [noderef] __user *
   kernel/bpf/syscall.c:3693:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/syscall.c:3693:13: sparse:     expected unsigned int *__pu_addr
   kernel/bpf/syscall.c:3693:13: sparse:     got unsigned int [noderef] __user *
>> kernel/bpf/syscall.c:3694:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__pu_addr @@     got unsigned long long [noderef] __user * @@
   kernel/bpf/syscall.c:3694:13: sparse:     expected unsigned long long *__pu_addr
>> kernel/bpf/syscall.c:3694:13: sparse:     got unsigned long long [noderef] __user *
   kernel/bpf/syscall.c:3695:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__pu_addr @@     got unsigned long long [noderef] __user * @@
   kernel/bpf/syscall.c:3695:13: sparse:     expected unsigned long long *__pu_addr
   kernel/bpf/syscall.c:3695:13: sparse:     got unsigned long long [noderef] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
--
>> kernel/bpf/verifier.c:299:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__pu_addr @@     got char [noderef] __user * @@
   kernel/bpf/verifier.c:299:13: sparse:     expected char *__pu_addr
>> kernel/bpf/verifier.c:299:13: sparse:     got char [noderef] __user *
>> kernel/bpf/verifier.c:7595:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/verifier.c:7595:37: sparse:     expected unsigned int *__pu_addr
>> kernel/bpf/verifier.c:7595:37: sparse:     got unsigned int [noderef] __user *
   kernel/bpf/verifier.c:7712:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/verifier.c:7712:37: sparse:     expected unsigned int *__pu_addr
   kernel/bpf/verifier.c:7712:37: sparse:     got unsigned int [noderef] __user *
   kernel/bpf/verifier.c:9897:76: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c:10272:81: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c:10276:81: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c:10280:81: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c:10284:79: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c:10288:78: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c:10292:79: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c:10335:38: sparse: sparse: subtraction of functions? Share your drugs
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
   kernel/bpf/hashtab.c:622:19: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/hashtab.c:663:19: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/hashtab.c:1347:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *ubatch @@     got void [noderef] __user * @@
   kernel/bpf/hashtab.c:1347:24: sparse:     expected void *ubatch
   kernel/bpf/hashtab.c:1347:24: sparse:     got void [noderef] __user *
>> kernel/bpf/hashtab.c:1372:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/hashtab.c:1372:13: sparse:     expected unsigned int *__pu_addr
>> kernel/bpf/hashtab.c:1372:13: sparse:     got unsigned int [noderef] __user *
   kernel/bpf/hashtab.c:1376:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void *ubatch @@
   kernel/bpf/hashtab.c:1376:46: sparse:     expected void const [noderef] __user *from
   kernel/bpf/hashtab.c:1376:46: sparse:     got void *ubatch
   kernel/bpf/hashtab.c:1537:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *ubatch @@     got void [noderef] __user * @@
   kernel/bpf/hashtab.c:1537:16: sparse:     expected void *ubatch
   kernel/bpf/hashtab.c:1537:16: sparse:     got void [noderef] __user *
   kernel/bpf/hashtab.c:1538:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void *ubatch @@
   kernel/bpf/hashtab.c:1538:26: sparse:     expected void [noderef] __user *to
   kernel/bpf/hashtab.c:1538:26: sparse:     got void *ubatch
   kernel/bpf/hashtab.c:1539:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/hashtab.c:1539:13: sparse:     expected unsigned int *__pu_addr
   kernel/bpf/hashtab.c:1539:13: sparse:     got unsigned int [noderef] __user *
   kernel/bpf/hashtab.c:1874:19: sparse: sparse: subtraction of functions? Share your drugs
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   kernel/bpf/hashtab.c:1409:9: sparse: sparse: context imbalance in '__htab_map_lookup_and_delete_batch' - different lock contexts for basic block
--
>> kernel/bpf/btf.c:4671:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   kernel/bpf/btf.c:4671:13: sparse:     expected unsigned int *__pu_addr
>> kernel/bpf/btf.c:4671:13: sparse:     got unsigned int [noderef] __user *
   include/linux/bpf_types.h:35:1: sparse: sparse: Initializer entry defined twice
   kernel/bpf/btf.c:3509:9: sparse:   also defined here
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   arch/openrisc/include/asm/cmpxchg.h:69:29: sparse: sparse: shift too big (32) for type int
--
   kernel/bpf/cgroup.c:1402:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   kernel/bpf/cgroup.c:1402:21: sparse:     expected int const *__gu_addr
   kernel/bpf/cgroup.c:1402:21: sparse:     got int [noderef] __user *optlen
>> kernel/bpf/cgroup.c:1440:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *optlen @@
   kernel/bpf/cgroup.c:1440:13: sparse:     expected int *__pu_addr
   kernel/bpf/cgroup.c:1440:13: sparse:     got int [noderef] __user *optlen
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> drivers/spi/spidev.c:374:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__pu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:374:26: sparse:     expected unsigned char *__pu_addr
   drivers/spi/spidev.c:374:26: sparse:     got unsigned char [noderef] [usertype] __user *
>> drivers/spi/spidev.c:378:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:378:26: sparse:     expected unsigned int *__pu_addr
   drivers/spi/spidev.c:378:26: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/spi/spidev.c:382:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__pu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:382:26: sparse:     expected unsigned char *__pu_addr
   drivers/spi/spidev.c:382:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:386:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__pu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:386:26: sparse:     expected unsigned char *__pu_addr
   drivers/spi/spidev.c:386:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:389:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:389:26: sparse:     expected unsigned int *__pu_addr
   drivers/spi/spidev.c:389:26: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/spi/spidev.c:396:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:396:34: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:396:34: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:398:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:398:34: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:398:34: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/spi/spidev.c:422:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:422:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:422:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:439:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:439:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:439:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:452:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:452:26: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:452:26: sparse:     got unsigned int [noderef] [usertype] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> drivers/rtc/rtc-m41t80.c:731:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/rtc/rtc-m41t80.c:731:24: sparse:     expected int *__pu_addr
>> drivers/rtc/rtc-m41t80.c:731:24: sparse:     got int [noderef] __user *
>> drivers/rtc/rtc-m41t80.c:736:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     expected int const *__gu_addr
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     got int [noderef] __user *
   drivers/rtc/rtc-m41t80.c:745:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/rtc/rtc-m41t80.c:745:24: sparse:     expected int *__pu_addr
   drivers/rtc/rtc-m41t80.c:745:24: sparse:     got int [noderef] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
   drivers/usb/gadget/udc/mv_u3d_core.c:47:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/usb/gadget/udc/mv_u3d_core.c:47:33: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/mv_u3d_core.c:47:33: sparse:     got int
   drivers/usb/gadget/udc/mv_u3d_core.c:241:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] rsvd0 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_u3d_core.c:241:35: sparse:     expected unsigned int [usertype] rsvd0
   drivers/usb/gadget/udc/mv_u3d_core.c:241:35: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:247:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] trb_addr_lo @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_u3d_core.c:247:41: sparse:     expected unsigned int [usertype] trb_addr_lo
   drivers/usb/gadget/udc/mv_u3d_core.c:247:41: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:305:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buf_addr_lo @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_u3d_core.c:305:29: sparse:     expected unsigned int [usertype] buf_addr_lo
   drivers/usb/gadget/udc/mv_u3d_core.c:305:29: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:307:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] trb_len @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_u3d_core.c:307:25: sparse:     expected unsigned int [usertype] trb_len
   drivers/usb/gadget/udc/mv_u3d_core.c:307:25: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:351:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buf_addr_lo @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_u3d_core.c:351:34: sparse:     expected unsigned int [usertype] buf_addr_lo
   drivers/usb/gadget/udc/mv_u3d_core.c:351:34: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:353:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] trb_len @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_u3d_core.c:353:30: sparse:     expected unsigned int [usertype] trb_len
   drivers/usb/gadget/udc/mv_u3d_core.c:353:30: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:889:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/usb/gadget/udc/mv_u3d_core.c:889:42: sparse:     expected void [noderef] __iomem *
   drivers/usb/gadget/udc/mv_u3d_core.c:889:42: sparse:     got unsigned int *
   drivers/usb/gadget/udc/mv_u3d_core.c:1478:26: sparse: sparse: cast from restricted __le16
>> drivers/usb/gadget/udc/mv_u3d_core.c:1770:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got struct mv_u3d_cap_regs [noderef] __iomem *cap_regs @@
   drivers/usb/gadget/udc/mv_u3d_core.c:1770:28: sparse:     expected void *addr
>> drivers/usb/gadget/udc/mv_u3d_core.c:1770:28: sparse:     got struct mv_u3d_cap_regs [noderef] __iomem *cap_regs
   drivers/usb/gadget/udc/mv_u3d_core.c:1981:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got struct mv_u3d_cap_regs [noderef] __iomem *cap_regs @@
   drivers/usb/gadget/udc/mv_u3d_core.c:1981:20: sparse:     expected void *addr
   drivers/usb/gadget/udc/mv_u3d_core.c:1981:20: sparse:     got struct mv_u3d_cap_regs [noderef] __iomem *cap_regs

vim +1384 kernel/bpf/syscall.c

cb4d03ab499d4c Brian Vazquez 2020-01-15  1358  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1359  int generic_map_lookup_batch(struct bpf_map *map,
cb4d03ab499d4c Brian Vazquez 2020-01-15  1360  				    const union bpf_attr *attr,
cb4d03ab499d4c Brian Vazquez 2020-01-15  1361  				    union bpf_attr __user *uattr)
cb4d03ab499d4c Brian Vazquez 2020-01-15  1362  {
cb4d03ab499d4c Brian Vazquez 2020-01-15  1363  	void __user *uobatch = u64_to_user_ptr(attr->batch.out_batch);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1364  	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1365  	void __user *values = u64_to_user_ptr(attr->batch.values);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1366  	void __user *keys = u64_to_user_ptr(attr->batch.keys);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1367  	void *buf, *buf_prevkey, *prev_key, *key, *value;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1368  	int err, retry = MAP_LOOKUP_RETRIES;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1369  	u32 value_size, cp, max_count;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1370  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1371  	if (attr->batch.elem_flags & ~BPF_F_LOCK)
cb4d03ab499d4c Brian Vazquez 2020-01-15  1372  		return -EINVAL;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1373  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1374  	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
cb4d03ab499d4c Brian Vazquez 2020-01-15  1375  	    !map_value_has_spin_lock(map))
cb4d03ab499d4c Brian Vazquez 2020-01-15  1376  		return -EINVAL;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1377  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1378  	value_size = bpf_map_value_size(map);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1379  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1380  	max_count = attr->batch.count;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1381  	if (!max_count)
cb4d03ab499d4c Brian Vazquez 2020-01-15  1382  		return 0;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1383  
cb4d03ab499d4c Brian Vazquez 2020-01-15 @1384  	if (put_user(0, &uattr->batch.count))
cb4d03ab499d4c Brian Vazquez 2020-01-15  1385  		return -EFAULT;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1386  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1387  	buf_prevkey = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1388  	if (!buf_prevkey)
cb4d03ab499d4c Brian Vazquez 2020-01-15  1389  		return -ENOMEM;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1390  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1391  	buf = kmalloc(map->key_size + value_size, GFP_USER | __GFP_NOWARN);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1392  	if (!buf) {
bb2359f4dbe98e Denis Efremov 2020-06-01  1393  		kfree(buf_prevkey);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1394  		return -ENOMEM;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1395  	}
cb4d03ab499d4c Brian Vazquez 2020-01-15  1396  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1397  	err = -EFAULT;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1398  	prev_key = NULL;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1399  	if (ubatch && copy_from_user(buf_prevkey, ubatch, map->key_size))
cb4d03ab499d4c Brian Vazquez 2020-01-15  1400  		goto free_buf;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1401  	key = buf;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1402  	value = key + map->key_size;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1403  	if (ubatch)
cb4d03ab499d4c Brian Vazquez 2020-01-15  1404  		prev_key = buf_prevkey;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1405  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1406  	for (cp = 0; cp < max_count;) {
cb4d03ab499d4c Brian Vazquez 2020-01-15  1407  		rcu_read_lock();
cb4d03ab499d4c Brian Vazquez 2020-01-15  1408  		err = map->ops->map_get_next_key(map, prev_key, key);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1409  		rcu_read_unlock();
cb4d03ab499d4c Brian Vazquez 2020-01-15  1410  		if (err)
cb4d03ab499d4c Brian Vazquez 2020-01-15  1411  			break;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1412  		err = bpf_map_copy_value(map, key, value,
cb4d03ab499d4c Brian Vazquez 2020-01-15  1413  					 attr->batch.elem_flags);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1414  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1415  		if (err == -ENOENT) {
cb4d03ab499d4c Brian Vazquez 2020-01-15  1416  			if (retry) {
cb4d03ab499d4c Brian Vazquez 2020-01-15  1417  				retry--;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1418  				continue;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1419  			}
cb4d03ab499d4c Brian Vazquez 2020-01-15  1420  			err = -EINTR;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1421  			break;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1422  		}
cb4d03ab499d4c Brian Vazquez 2020-01-15  1423  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1424  		if (err)
cb4d03ab499d4c Brian Vazquez 2020-01-15  1425  			goto free_buf;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1426  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1427  		if (copy_to_user(keys + cp * map->key_size, key,
cb4d03ab499d4c Brian Vazquez 2020-01-15  1428  				 map->key_size)) {
cb4d03ab499d4c Brian Vazquez 2020-01-15  1429  			err = -EFAULT;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1430  			goto free_buf;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1431  		}
cb4d03ab499d4c Brian Vazquez 2020-01-15  1432  		if (copy_to_user(values + cp * value_size, value, value_size)) {
cb4d03ab499d4c Brian Vazquez 2020-01-15  1433  			err = -EFAULT;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1434  			goto free_buf;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1435  		}
cb4d03ab499d4c Brian Vazquez 2020-01-15  1436  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1437  		if (!prev_key)
cb4d03ab499d4c Brian Vazquez 2020-01-15  1438  			prev_key = buf_prevkey;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1439  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1440  		swap(prev_key, key);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1441  		retry = MAP_LOOKUP_RETRIES;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1442  		cp++;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1443  	}
cb4d03ab499d4c Brian Vazquez 2020-01-15  1444  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1445  	if (err == -EFAULT)
cb4d03ab499d4c Brian Vazquez 2020-01-15  1446  		goto free_buf;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1447  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1448  	if ((copy_to_user(&uattr->batch.count, &cp, sizeof(cp)) ||
cb4d03ab499d4c Brian Vazquez 2020-01-15  1449  		    (cp && copy_to_user(uobatch, prev_key, map->key_size))))
cb4d03ab499d4c Brian Vazquez 2020-01-15  1450  		err = -EFAULT;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1451  
cb4d03ab499d4c Brian Vazquez 2020-01-15  1452  free_buf:
cb4d03ab499d4c Brian Vazquez 2020-01-15  1453  	kfree(buf_prevkey);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1454  	kfree(buf);
cb4d03ab499d4c Brian Vazquez 2020-01-15  1455  	return err;
cb4d03ab499d4c Brian Vazquez 2020-01-15  1456  }
cb4d03ab499d4c Brian Vazquez 2020-01-15  1457  

:::::: The code at line 1384 was first introduced by commit
:::::: cb4d03ab499d4c040f4ab6fd4389d2b49f42b5a5 bpf: Add generic support for lookup batch op

:::::: TO: Brian Vazquez <brianvv@google.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mYCpIKhGyMATD0i+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
EYIO6t0DDnKGE/CnPD7/A6CSyCjwSwEA

--mYCpIKhGyMATD0i+--
