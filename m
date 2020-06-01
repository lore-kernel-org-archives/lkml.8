Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C13C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D14E20678
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgFAFz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:55:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:10974 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgFAFz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:55:26 -0400
IronPort-SDR: ll8YEk3pPFYYK1jMlvxl7VNd9kCuqMU+V9EGoEB3UYbr80Wl+MughsK0wKNz2eFtA32toIu6y1
 0Tore4ifA5gQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:55:26 -0700
IronPort-SDR: ktsIJ3CXy/ZmktK/veSWdbbFOjLfvvzLQoYCqmXEG5RkSFT0KTmV30Tjw0RjRNhQTYsL4ONGM5
 DCty+5ESuwTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="303769823"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2020 22:55:24 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfdPw-0000ZH-0s; Mon, 01 Jun 2020 05:55:24 +0000
Date:   Mon, 1 Jun 2020 13:54:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Amit, Daniel, Kachhap," <amit.kachhap@arm.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: sh: 1: scripts/ld-version.sh: Permission denied
Message-ID: <202006011327.VZKhJeiu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
commit: 9553d16fa671b9621c5e2847d08bd90d3be3349c init/kconfig: Add LD_VERSION Kconfig
date:   9 weeks ago
config: x86_64-allyesconfig
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 2388a096e7865c043e83ece4e26654bd3d1a20d5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        git checkout 9553d16fa671b9621c5e2847d08bd90d3be3349c
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64  allyesconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

sh: 1: scripts/gcc-version.sh: Permission denied
sh: 1: scripts/gcc-version.sh: Permission denied
init/Kconfig:18: syntax error
init/Kconfig:17: invalid statement
init/Kconfig:18: invalid statement
>> sh: 1: scripts/ld-version.sh: Permission denied
init/Kconfig:23: syntax error
init/Kconfig:22: invalid statement
sh: 1: scripts/clang-version.sh: Permission denied
init/Kconfig:30: syntax error
init/Kconfig:29: invalid statement
sh: 1: scripts/gcc-plugin.sh: Permission denied
make[2]: *** [scripts/kconfig/Makefile:75: allyesconfig] Error 1
make[1]: *** [Makefile:567: allyesconfig] Error 2
make: *** [Makefile:179: sub-make] Error 2
--
sh: 1: scripts/gcc-version.sh: Permission denied
sh: 1: scripts/gcc-version.sh: Permission denied
init/Kconfig:18: syntax error
init/Kconfig:17: invalid statement
init/Kconfig:18: invalid statement
>> sh: 1: scripts/ld-version.sh: Permission denied
init/Kconfig:23: syntax error
init/Kconfig:22: invalid statement
sh: 1: scripts/clang-version.sh: Permission denied
init/Kconfig:30: syntax error
init/Kconfig:29: invalid statement
sh: 1: scripts/gcc-plugin.sh: Permission denied
make[2]: *** [scripts/kconfig/Makefile:75: oldconfig] Error 1
make[1]: *** [Makefile:567: oldconfig] Error 2
make: *** [Makefile:179: sub-make] Error 2
--
sh: 1: scripts/gcc-version.sh: Permission denied
sh: 1: scripts/gcc-version.sh: Permission denied
init/Kconfig:18: syntax error
init/Kconfig:17: invalid statement
init/Kconfig:18: invalid statement
>> sh: 1: scripts/ld-version.sh: Permission denied
init/Kconfig:23: syntax error
init/Kconfig:22: invalid statement
sh: 1: scripts/clang-version.sh: Permission denied
init/Kconfig:30: syntax error
init/Kconfig:29: invalid statement
sh: 1: scripts/gcc-plugin.sh: Permission denied
make[2]: *** [scripts/kconfig/Makefile:75: olddefconfig] Error 1
make[1]: *** [Makefile:567: olddefconfig] Error 2
make: *** [Makefile:179: sub-make] Error 2

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
