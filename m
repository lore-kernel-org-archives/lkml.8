Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E673AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9056206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgFAGD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:03:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:38467 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgFAGD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:03:58 -0400
IronPort-SDR: Bl1+ppwplIu8WuY1NjRq56DJbbXBCSlQTojMwzgCCoa/NnWmoFgEuHQbbd671b86XG1/a1rZoP
 h+95TOeVdznQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 23:03:57 -0700
IronPort-SDR: wsSICHzBQ5LDy5N+oVj9qRNOjjytQlziDaATEim2C6cEF5HkIncf/ExLEnTTBRkEIXAVBMfY85
 2iFls75YMO5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="415694870"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga004.jf.intel.com with ESMTP; 31 May 2020 23:03:53 -0700
Date:   Mon, 1 Jun 2020 14:02:59 +0800
From:   Philip Li <philip.li@intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     "Amit, Daniel, Kachhap," <amit.kachhap@arm.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [kbuild-all] sh: 1: scripts/ld-version.sh: Permission denied
Message-ID: <20200601060259.GA10102@intel.com>
References: <202006011327.VZKhJeiu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006011327.VZKhJeiu%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 01:54:29PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
> commit: 9553d16fa671b9621c5e2847d08bd90d3be3349c init/kconfig: Add LD_VERSION Kconfig
> date:   9 weeks ago
> config: x86_64-allyesconfig
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 2388a096e7865c043e83ece4e26654bd3d1a20d5)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         git checkout 9553d16fa671b9621c5e2847d08bd90d3be3349c
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64  allyesconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
kindly ignore this report, which looks like an environment problem,
we will look into to solve the issue.

> 
> sh: 1: scripts/gcc-version.sh: Permission denied
> sh: 1: scripts/gcc-version.sh: Permission denied
> init/Kconfig:18: syntax error
> init/Kconfig:17: invalid statement
> init/Kconfig:18: invalid statement
> >> sh: 1: scripts/ld-version.sh: Permission denied
> init/Kconfig:23: syntax error
> init/Kconfig:22: invalid statement
> sh: 1: scripts/clang-version.sh: Permission denied
> init/Kconfig:30: syntax error
> init/Kconfig:29: invalid statement
> sh: 1: scripts/gcc-plugin.sh: Permission denied
> make[2]: *** [scripts/kconfig/Makefile:75: allyesconfig] Error 1
> make[1]: *** [Makefile:567: allyesconfig] Error 2
> make: *** [Makefile:179: sub-make] Error 2
> --
> sh: 1: scripts/gcc-version.sh: Permission denied
> sh: 1: scripts/gcc-version.sh: Permission denied
> init/Kconfig:18: syntax error
> init/Kconfig:17: invalid statement
> init/Kconfig:18: invalid statement
> >> sh: 1: scripts/ld-version.sh: Permission denied
> init/Kconfig:23: syntax error
> init/Kconfig:22: invalid statement
> sh: 1: scripts/clang-version.sh: Permission denied
> init/Kconfig:30: syntax error
> init/Kconfig:29: invalid statement
> sh: 1: scripts/gcc-plugin.sh: Permission denied
> make[2]: *** [scripts/kconfig/Makefile:75: oldconfig] Error 1
> make[1]: *** [Makefile:567: oldconfig] Error 2
> make: *** [Makefile:179: sub-make] Error 2
> --
> sh: 1: scripts/gcc-version.sh: Permission denied
> sh: 1: scripts/gcc-version.sh: Permission denied
> init/Kconfig:18: syntax error
> init/Kconfig:17: invalid statement
> init/Kconfig:18: invalid statement
> >> sh: 1: scripts/ld-version.sh: Permission denied
> init/Kconfig:23: syntax error
> init/Kconfig:22: invalid statement
> sh: 1: scripts/clang-version.sh: Permission denied
> init/Kconfig:30: syntax error
> init/Kconfig:29: invalid statement
> sh: 1: scripts/gcc-plugin.sh: Permission denied
> make[2]: *** [scripts/kconfig/Makefile:75: olddefconfig] Error 1
> make[1]: *** [Makefile:567: olddefconfig] Error 2
> make: *** [Makefile:179: sub-make] Error 2
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
