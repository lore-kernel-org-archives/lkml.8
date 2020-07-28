Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D704C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1326420838
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgG1AaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:30:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:4530 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgG1AaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 20:30:07 -0400
IronPort-SDR: YIG9V55rUXMx7G/KEJyI9ZIjlTqBZ0/q4xJydCB3OgfMLwHlZcf7AiwIX5OVJCXF+WpSHd03QX
 2DRtL5dE8Y8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="152386411"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="152386411"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 17:30:06 -0700
IronPort-SDR: qRUL7CB2qBB/1naGzWuzDstQZOqpXuUw3A085F79HgSfWGN9v9gdCEZtr7tPsX4wO8Dyjr9ZoP
 jsrIp8fakGeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="289985325"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2020 17:30:04 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0DVK-000279-Tt; Tue, 28 Jul 2020 00:30:02 +0000
Date:   Tue, 28 Jul 2020 08:29:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 c84d53051fcb4f3d14d5a245e1d7ee8512bcb199
Message-ID: <5f1f7185.4j6ZjL0+y5N5EmOq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/core
branch HEAD: c84d53051fcb4f3d14d5a245e1d7ee8512bcb199  Merge tag 'v5.8-rc6' into locking/core, to pick up fixes

i386-tinyconfig vmlinux size:

+-------+---------------------------------------+-----------------------------------------------------------------------+
| DELTA |                SYMBOL                 |                                COMMIT                                 |
+-------+---------------------------------------+-----------------------------------------------------------------------+
|  +473 | TOTAL                                 | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|  +465 | TEXT                                  | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|  +129 | new_sync_write()                      | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|  +125 | fw_devlink_resume()                   | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|  +122 | __kernel_read()                       | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|  +122 | new_sync_read()                       | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|  +110 | driver_deferred_probe_trigger()       | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|  +104 | dma_coherent_ok()                     | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|   +76 | __schedule()                          | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|  -108 | dma_direct_alloc_pages()              | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|  -112 | driver_deferred_probe_force_trigger() | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|  -156 | __vfs_read()                          | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
|  -163 | __vfs_write()                         | c84d53051fcb Merge tag 'v5.8-rc6' into locking/core, to pick up fixes |
+-------+---------------------------------------+-----------------------------------------------------------------------+

elapsed time: 2980m

configs tested: 52
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
xtensa                              defconfig
arc                                 defconfig
sh                               allmodconfig
arc                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
sparc64                             defconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                              defconfig

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
