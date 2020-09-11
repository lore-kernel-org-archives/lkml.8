Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF04C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3B0221EE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKLVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:21:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:4971 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgIKLUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:20:47 -0400
IronPort-SDR: feI+MZqMVEHrusCxlGWlGZMHJpoiNLuttnyUj2ImnouqkXmBobZCiCTANt+Wp0NWymEfkYuXpN
 /R1gzm33IDvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="159675567"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="159675567"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 04:20:39 -0700
IronPort-SDR: Uou/V7LU45LApjEceNw6X8jRoOJFdCjwLUz3KjHM9jKsO3SD7krRwT43jlD8hlALI/LUa3DcJx
 mJxyEeRLHTWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="286869869"
Received: from lkp-server01.sh.intel.com (HELO a75722977aa5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2020 04:20:38 -0700
Received: from kbuild by a75722977aa5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kGh6b-0000Bp-DD; Fri, 11 Sep 2020 11:20:37 +0000
Date:   Fri, 11 Sep 2020 19:19:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.09.07a] BUILD REGRESSION
 cccf684a1da846c3ff830d553bc4cf97bf779f48
Message-ID: <5f5b5d52.r9y/QJhXkHreAKCo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.09.07a
branch HEAD: cccf684a1da846c3ff830d553bc4cf97bf779f48  rcu-tasks: Mass of debug and fixes

Error/Warning in current branch:

(.text+0x4070): undefined reference to `n_rtt_sched'
(.text+0x41cc): undefined reference to `n_rtt_sched_running'
aarch64-linux-ld: core.c:(.text+0x438c): undefined reference to `n_rtt_sched'
aarch64-linux-ld: core.c:(.text+0x43e8): undefined reference to `n_rtt_sched_offrq'
aarch64-linux-ld: core.c:(.text+0x4414): undefined reference to `n_rtt_sched_fail'
aarch64-linux-ld: core.c:(.text+0x44b0): undefined reference to `n_rtt_sched_waking'
aarch64-linux-ld: core.c:(.text+0x44d8): undefined reference to `n_rtt_sched_running'
aarch64-linux-ld: core.c:(.text+0x4554): undefined reference to `n_rtt_sched_onrq'
arch/s390/include/asm/atomic_ops.h:57: undefined reference to `n_rtt_sched'
arch/x86/include/asm/atomic.h:95: undefined reference to `n_rtt_sched'
arm-linux-gnueabi-ld: core.c:(.text+0x19cc): undefined reference to `n_rtt_sched_fail'
arm-linux-gnueabi-ld: core.c:(.text+0x19d0): undefined reference to `n_rtt_sched_waking'
arm-linux-gnueabi-ld: core.c:(.text+0x19d4): undefined reference to `n_rtt_sched_running'
arm-linux-gnueabi-ld: core.c:(.text+0x19d8): undefined reference to `n_rtt_sched_onrq'
arm-linux-gnueabi-ld: core.c:(.text+0x26e0): undefined reference to `n_rtt_sched_waking'
arm-linux-gnueabi-ld: core.c:(.text+0x26e4): undefined reference to `n_rtt_sched_fail'
arm-linux-gnueabi-ld: core.c:(.text+0x26e8): undefined reference to `n_rtt_sched_running'
arm-linux-gnueabi-ld: core.c:(.text+0x26f0): undefined reference to `n_rtt_sched_offrq'
arm-linux-gnueabi-ld: core.c:(.text+0x26f4): undefined reference to `n_rtt_sched_onrq'
arm-linux-gnueabi-ld: core.c:(.text+0x6078): undefined reference to `n_rtt_sched'
arm-linux-gnueabi-ld: core.c:(.text+0x60d4): undefined reference to `n_rtt_sched_waking'
arm-linux-gnueabi-ld: core.c:(.text+0x60fc): undefined reference to `n_rtt_sched_fail'
arm-linux-gnueabi-ld: core.c:(.text+0x6160): undefined reference to `n_rtt_sched_running'
arm-linux-gnueabi-ld: core.c:(.text+0x61c4): undefined reference to `n_rtt_sched_offrq'
arm-linux-gnueabi-ld: core.c:(.text+0x6228): undefined reference to `n_rtt_sched_onrq'
arm-linux-gnueabi-ld: core.c:(.text+0x798): undefined reference to `n_rtt_sched_fail'
arm-linux-gnueabi-ld: core.c:(.text+0x79c): undefined reference to `n_rtt_sched_offrq'
arm-linux-gnueabi-ld: core.c:(.text+0x7a0): undefined reference to `n_rtt_sched_running'
arm-linux-gnueabi-ld: core.c:(.text+0x7a4): undefined reference to `n_rtt_sched_waking'
arm-linux-gnueabi-ld: core.c:(.text+0x7a8): undefined reference to `n_rtt_sched_onrq'
arm-linux-gnueabi-ld: core.c:(.text+0xbc0): undefined reference to `n_rtt_sched_fail'
arm-linux-gnueabi-ld: core.c:(.text+0xbc4): undefined reference to `n_rtt_sched_offrq'
arm-linux-gnueabi-ld: core.c:(.text+0xbc8): undefined reference to `n_rtt_sched_running'
arm-linux-gnueabi-ld: core.c:(.text+0xbcc): undefined reference to `n_rtt_sched_waking'
arm-linux-gnueabi-ld: core.c:(.text+0xbd0): undefined reference to `n_rtt_sched_onrq'
core.c:(.text+0x1074): undefined reference to `n_rtt_sched_running'
core.c:(.text+0x16f2): undefined reference to `n_rtt_sched'
core.c:(.text+0x19c8): undefined reference to `n_rtt_sched'
core.c:(.text+0x1a72): undefined reference to `n_rtt_sched'
core.c:(.text+0x1ae8): undefined reference to `n_rtt_sched'
core.c:(.text+0x1c44): undefined reference to `n_rtt_sched'
core.c:(.text+0x1e8c): undefined reference to `n_rtt_sched'
core.c:(.text+0x1f34): undefined reference to `n_rtt_sched'
core.c:(.text+0x2194): undefined reference to `n_rtt_sched_running'
core.c:(.text+0x26dc): undefined reference to `n_rtt_sched'
core.c:(.text+0x35b6): undefined reference to `n_rtt_sched'
core.c:(.text+0x3670): undefined reference to `n_rtt_sched_offrq'
core.c:(.text+0x36b0): undefined reference to `n_rtt_sched_onrq'
core.c:(.text+0x39f4): undefined reference to `n_rtt_sched'
core.c:(.text+0x3b88): undefined reference to `n_rtt_sched'
core.c:(.text+0x3c54): undefined reference to `n_rtt_sched_running'
core.c:(.text+0x43d4): undefined reference to `n_rtt_sched'
core.c:(.text+0x790): undefined reference to `n_rtt_sched'
core.c:(.text+0xbb8): undefined reference to `n_rtt_sched'
core.c:(.text+0xc78): undefined reference to `n_rtt_sched'
core.c:(.text+0xca2): undefined reference to `n_rtt_sched'
csky-linux-ld: core.c:(.text+0x1744): undefined reference to `n_rtt_sched_running'
csky-linux-ld: core.c:(.text+0x1748): undefined reference to `n_rtt_sched_fail'
csky-linux-ld: core.c:(.text+0x174c): undefined reference to `n_rtt_sched_waking'
csky-linux-ld: core.c:(.text+0x1750): undefined reference to `n_rtt_sched_onrq'
h8300-linux-ld: include/linux/atomic-fallback.h:302: undefined reference to `n_rtt_sched_fail'
h8300-linux-ld: include/linux/atomic-fallback.h:302: undefined reference to `n_rtt_sched_offrq'
h8300-linux-ld: include/linux/atomic-fallback.h:302: undefined reference to `n_rtt_sched_onrq'
h8300-linux-ld: include/linux/atomic-fallback.h:302: undefined reference to `n_rtt_sched_running'
h8300-linux-ld: include/linux/atomic-fallback.h:302: undefined reference to `n_rtt_sched_waking'
hppa-linux-ld: (.text+0x4074): undefined reference to `n_rtt_sched'
hppa-linux-ld: (.text+0x4118): undefined reference to `n_rtt_sched_onrq'
hppa-linux-ld: (.text+0x4170): undefined reference to `n_rtt_sched_waking'
hppa-linux-ld: (.text+0x41d0): undefined reference to `n_rtt_sched_running'
hppa-linux-ld: (.text+0x4218): undefined reference to `n_rtt_sched_fail'
hppa-linux-ld: (.text+0x4300): undefined reference to `n_rtt_sched_offrq'
ia64-linux-ld: core.c:(.text+0x86c1): undefined reference to `n_rtt_sched'
ia64-linux-ld: core.c:(.text+0x8810): undefined reference to `n_rtt_sched_waking'
ia64-linux-ld: core.c:(.text+0x8850): undefined reference to `n_rtt_sched_fail'
ia64-linux-ld: core.c:(.text+0x88a0): undefined reference to `n_rtt_sched_running'
ia64-linux-ld: core.c:(.text+0x8990): undefined reference to `n_rtt_sched_offrq'
ia64-linux-ld: core.c:(.text+0x8a90): undefined reference to `n_rtt_sched_onrq'
include/linux/atomic-fallback.h:302: undefined reference to `n_rtt_sched'
kernel/rcu/rcuscale.c:514: undefined reference to `show_rcu_tasks_gp_kthreads'
ld: arch/x86/include/asm/atomic.h:95: undefined reference to `n_rtt_sched_fail'
ld: arch/x86/include/asm/atomic.h:95: undefined reference to `n_rtt_sched_offrq'
ld: arch/x86/include/asm/atomic.h:95: undefined reference to `n_rtt_sched_onrq'
ld: arch/x86/include/asm/atomic.h:95: undefined reference to `n_rtt_sched_running'
ld: arch/x86/include/asm/atomic.h:95: undefined reference to `n_rtt_sched_waking'
ld: core.c:(.text+0x1e72): undefined reference to `n_rtt_sched_running'
ld: core.c:(.text+0x1e80): undefined reference to `n_rtt_sched_fail'
ld: core.c:(.text+0x1e92): undefined reference to `n_rtt_sched_waking'
ld: core.c:(.text+0x1ea2): undefined reference to `n_rtt_sched_onrq'
m68k-linux-ld: core.c:(.text+0x175e): undefined reference to `n_rtt_sched_running'
m68k-linux-ld: core.c:(.text+0x1766): undefined reference to `n_rtt_sched_fail'
m68k-linux-ld: core.c:(.text+0x1776): undefined reference to `n_rtt_sched_waking'
m68k-linux-ld: core.c:(.text+0x179e): undefined reference to `n_rtt_sched_onrq'
m68k-linux-ld: core.c:(.text+0xcb6): undefined reference to `n_rtt_sched_fail'
m68k-linux-ld: core.c:(.text+0xcc6): undefined reference to `n_rtt_sched_offrq'
m68k-linux-ld: core.c:(.text+0xce0): undefined reference to `n_rtt_sched_fail'
m68k-linux-ld: core.c:(.text+0xcec): undefined reference to `n_rtt_sched_running'
m68k-linux-ld: core.c:(.text+0xcf0): undefined reference to `n_rtt_sched_offrq'
m68k-linux-ld: core.c:(.text+0xcf6): undefined reference to `n_rtt_sched_waking'
m68k-linux-ld: core.c:(.text+0xcfe): undefined reference to `n_rtt_sched_onrq'
m68k-linux-ld: core.c:(.text+0xd16): undefined reference to `n_rtt_sched_running'
m68k-linux-ld: core.c:(.text+0xd20): undefined reference to `n_rtt_sched_waking'
m68k-linux-ld: core.c:(.text+0xd28): undefined reference to `n_rtt_sched_onrq'
nds32le-linux-ld: core.c:(.text+0x1d0e): undefined reference to `n_rtt_sched'
nds32le-linux-ld: core.c:(.text+0x1d84): undefined reference to `n_rtt_sched_offrq'
nds32le-linux-ld: core.c:(.text+0x1de8): undefined reference to `n_rtt_sched_running'
nds32le-linux-ld: core.c:(.text+0x1e0c): undefined reference to `n_rtt_sched_waking'
nds32le-linux-ld: core.c:(.text+0x1e40): undefined reference to `n_rtt_sched_onrq'
nds32le-linux-ld: core.c:(.text+0x1eb2): undefined reference to `n_rtt_sched_fail'
nios2-linux-ld: core.c:(.text+0x1bbc): undefined reference to `n_rtt_sched'
nios2-linux-ld: core.c:(.text+0x1c5c): undefined reference to `n_rtt_sched_running'
nios2-linux-ld: core.c:(.text+0x1c88): undefined reference to `n_rtt_sched_fail'
nios2-linux-ld: core.c:(.text+0x1cb4): undefined reference to `n_rtt_sched_waking'
nios2-linux-ld: core.c:(.text+0x1cfc): undefined reference to `n_rtt_sched_onrq'
riscv64-linux-ld: core.c:(.text+0x1084): undefined reference to `n_rtt_sched_fail'
riscv64-linux-ld: core.c:(.text+0x10ac): undefined reference to `n_rtt_sched_waking'
riscv64-linux-ld: core.c:(.text+0x10f4): undefined reference to `n_rtt_sched_onrq'
riscv64-linux-ld: core.c:(.text+0x3628): undefined reference to `n_rtt_sched_running'
s390x-linux-gnu-ld: arch/s390/include/asm/atomic_ops.h:57: undefined reference to `n_rtt_sched_fail'
s390x-linux-gnu-ld: arch/s390/include/asm/atomic_ops.h:57: undefined reference to `n_rtt_sched_offrq'
s390x-linux-gnu-ld: arch/s390/include/asm/atomic_ops.h:57: undefined reference to `n_rtt_sched_onrq'
s390x-linux-gnu-ld: arch/s390/include/asm/atomic_ops.h:57: undefined reference to `n_rtt_sched_running'
s390x-linux-gnu-ld: arch/s390/include/asm/atomic_ops.h:57: undefined reference to `n_rtt_sched_waking'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-nsimosci_hs_smp_defconfig
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched
|-- arc-vdk_hs38_smp_defconfig
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched
|-- arm-cm_x300_defconfig
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched
|-- arm-defconfig
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_offrq
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   `-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|-- arm-efm32_defconfig
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_offrq
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched
|-- arm-integrator_defconfig
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_offrq
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched
|-- arm-mps2_defconfig
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_offrq
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   |-- arm-linux-gnueabi-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched
|-- arm64-defconfig
|   |-- aarch64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched
|   |-- aarch64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- aarch64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_offrq
|   |-- aarch64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- aarch64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   `-- aarch64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|-- csky-defconfig
|   |-- csky-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- csky-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- csky-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   `-- csky-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|-- h8300-randconfig-c003-20200911
|   |-- h8300-linux-ld:include-linux-atomic-fallback.h:undefined-reference-to-n_rtt_sched_fail
|   |-- h8300-linux-ld:include-linux-atomic-fallback.h:undefined-reference-to-n_rtt_sched_offrq
|   |-- h8300-linux-ld:include-linux-atomic-fallback.h:undefined-reference-to-n_rtt_sched_onrq
|   |-- h8300-linux-ld:include-linux-atomic-fallback.h:undefined-reference-to-n_rtt_sched_running
|   |-- h8300-linux-ld:include-linux-atomic-fallback.h:undefined-reference-to-n_rtt_sched_waking
|   `-- include-linux-atomic-fallback.h:undefined-reference-to-n_rtt_sched
|-- h8300-randconfig-r023-20200911
|   `-- kernel-rcu-rcuscale.c:undefined-reference-to-show_rcu_tasks_gp_kthreads
|-- i386-randconfig-a002-20200911
|   |-- ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   `-- ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|-- i386-randconfig-c001-20200911
|   `-- kernel-rcu-rcuscale.c:undefined-reference-to-show_rcu_tasks_gp_kthreads
|-- i386-randconfig-s001-20200911
|   |-- arch-x86-include-asm-atomic.h:undefined-reference-to-n_rtt_sched
|   |-- ld:arch-x86-include-asm-atomic.h:undefined-reference-to-n_rtt_sched_fail
|   |-- ld:arch-x86-include-asm-atomic.h:undefined-reference-to-n_rtt_sched_offrq
|   |-- ld:arch-x86-include-asm-atomic.h:undefined-reference-to-n_rtt_sched_onrq
|   |-- ld:arch-x86-include-asm-atomic.h:undefined-reference-to-n_rtt_sched_running
|   `-- ld:arch-x86-include-asm-atomic.h:undefined-reference-to-n_rtt_sched_waking
|-- ia64-defconfig
|   |-- ia64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched
|   |-- ia64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- ia64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_offrq
|   |-- ia64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- ia64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   `-- ia64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|-- m68k-defconfig
|   |-- core.c:(.text):undefined-reference-to-n_rtt_sched
|   |-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_offrq
|   |-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   `-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|-- m68k-m5407c3_defconfig
|   |-- core.c:(.text):undefined-reference-to-n_rtt_sched
|   |-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   `-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|-- m68k-sun3_defconfig
|   |-- core.c:(.text):undefined-reference-to-n_rtt_sched
|   |-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_offrq
|   |-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   `-- m68k-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|-- mips-ath79_defconfig
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched
|-- mips-ip22_defconfig
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched
|-- mips-maltaup_defconfig
|   |-- core.c:(.text):undefined-reference-to-n_rtt_sched
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched_running
|-- mips-mtx1_defconfig
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched
|-- mips-sb1250_swarm_defconfig
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched
|-- mips-tb0226_defconfig
|   |-- core.c:(.text):undefined-reference-to-n_rtt_sched
|   `-- core.c:(.text):undefined-reference-to-n_rtt_sched_running
|-- nds32-defconfig
|   |-- nds32le-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched
|   |-- nds32le-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- nds32le-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_offrq
|   |-- nds32le-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- nds32le-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   `-- nds32le-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|-- nios2-defconfig
|   |-- nios2-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched
|   |-- nios2-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- nios2-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- nios2-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   `-- nios2-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|-- parisc-defconfig
|   |-- (.text):undefined-reference-to-n_rtt_sched
|   |-- (.text):undefined-reference-to-n_rtt_sched_running
|   |-- hppa-linux-ld:(.text):undefined-reference-to-n_rtt_sched
|   |-- hppa-linux-ld:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- hppa-linux-ld:(.text):undefined-reference-to-n_rtt_sched_offrq
|   |-- hppa-linux-ld:(.text):undefined-reference-to-n_rtt_sched_onrq
|   |-- hppa-linux-ld:(.text):undefined-reference-to-n_rtt_sched_running
|   `-- hppa-linux-ld:(.text):undefined-reference-to-n_rtt_sched_waking
|-- riscv-allnoconfig
|   |-- core.c:(.text):undefined-reference-to-n_rtt_sched_running
|   |-- riscv64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_fail
|   |-- riscv64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   `-- riscv64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_waking
|-- riscv-defconfig
|   |-- core.c:(.text):undefined-reference-to-n_rtt_sched_offrq
|   |-- core.c:(.text):undefined-reference-to-n_rtt_sched_onrq
|   `-- riscv64-linux-ld:core.c:(.text):undefined-reference-to-n_rtt_sched_running
`-- sh-polaris_defconfig
    `-- core.c:(.text):undefined-reference-to-n_rtt_sched

clang_recent_errors
`-- s390-randconfig-r004-20200911
    |-- arch-s390-include-asm-atomic_ops.h:undefined-reference-to-n_rtt_sched
    |-- s39-linux-gnu-ld:arch-s390-include-asm-atomic_ops.h:undefined-reference-to-n_rtt_sched_fail
    |-- s39-linux-gnu-ld:arch-s390-include-asm-atomic_ops.h:undefined-reference-to-n_rtt_sched_offrq
    |-- s39-linux-gnu-ld:arch-s390-include-asm-atomic_ops.h:undefined-reference-to-n_rtt_sched_onrq
    |-- s39-linux-gnu-ld:arch-s390-include-asm-atomic_ops.h:undefined-reference-to-n_rtt_sched_running
    `-- s39-linux-gnu-ld:arch-s390-include-asm-atomic_ops.h:undefined-reference-to-n_rtt_sched_waking

elapsed time: 721m

configs tested: 108
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           efm32_defconfig
arm                       aspeed_g4_defconfig
mips                         tb0226_defconfig
mips                          ath79_defconfig
arm                      integrator_defconfig
mips                           ip22_defconfig
mips                        workpad_defconfig
mips                           gcw0_defconfig
sh                          sdk7780_defconfig
powerpc                      ppc64e_defconfig
openrisc                    or1ksim_defconfig
arm                          imote2_defconfig
powerpc                      pasemi_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                           mtx1_defconfig
m68k                           sun3_defconfig
arm                            mps2_defconfig
mips                   sb1250_swarm_defconfig
arc                          axs101_defconfig
nios2                         3c120_defconfig
powerpc                     powernv_defconfig
sh                ecovec24-romimage_defconfig
arm                       cns3420vb_defconfig
ia64                            zx1_defconfig
s390                       zfcpdump_defconfig
powerpc                     akebono_defconfig
arm                         at91_dt_defconfig
mips                       capcella_defconfig
powerpc                     ep8248e_defconfig
powerpc                     taishan_defconfig
mips                      loongson3_defconfig
microblaze                    nommu_defconfig
arc                          axs103_defconfig
arm                         cm_x300_defconfig
sh                          polaris_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        maltaup_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200911
i386                 randconfig-a006-20200911
i386                 randconfig-a001-20200911
i386                 randconfig-a003-20200911
i386                 randconfig-a002-20200911
i386                 randconfig-a005-20200911
x86_64               randconfig-a014-20200911
x86_64               randconfig-a011-20200911
x86_64               randconfig-a012-20200911
x86_64               randconfig-a016-20200911
x86_64               randconfig-a015-20200911
x86_64               randconfig-a013-20200911
i386                 randconfig-a015-20200911
i386                 randconfig-a014-20200911
i386                 randconfig-a011-20200911
i386                 randconfig-a013-20200911
i386                 randconfig-a016-20200911
i386                 randconfig-a012-20200911
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20200911
x86_64               randconfig-a006-20200911
x86_64               randconfig-a003-20200911
x86_64               randconfig-a002-20200911
x86_64               randconfig-a005-20200911
x86_64               randconfig-a001-20200911

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
