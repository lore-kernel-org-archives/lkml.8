Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EC2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1A52065C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgFDPk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:40:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:16825 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729402AbgFDPk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:40:56 -0400
IronPort-SDR: P177AHBIa/jPgwW/n5H1oB6hYtZMaBvRtO17KTDKe9Q1EugzfoEmmjdb9jIuanI+dlFyXSLYUg
 Lw7TadCo4oMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 08:40:25 -0700
IronPort-SDR: KX0U+/L9mj+R+zn+bO9mOmwaZ25v2nQ4H1+Mu00BL43sGBsmbM9O4Xx0i91LMx16zOokqwKb1q
 d31cd69rhMCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,472,1583222400"; 
   d="scan'208";a="304746987"
Received: from lkp-server02.sh.intel.com (HELO 6de3076d9aaa) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jun 2020 08:40:24 -0700
Received: from kbuild by 6de3076d9aaa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgryh-00001Q-IM; Thu, 04 Jun 2020 15:40:23 +0000
Date:   Thu, 04 Jun 2020 23:39:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 b8797e281f77cdac3988e9a97b1c76eabbabaefa
Message-ID: <5ed915c8.sV/jYWaIzMLhjNGN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/entry
branch HEAD: b8797e281f77cdac3988e9a97b1c76eabbabaefa  Merge branch 'linus' into x86/entry, to resolve conflicts

i386-tinyconfig vmlinux size:

+-------+------------------------------------+------------------------------------------------------------------------+
| DELTA |               SYMBOL               |                                 COMMIT                                 |
+-------+------------------------------------+------------------------------------------------------------------------+
| +3696 | TOTAL                              | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
| +3221 | TEXT                               | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +395 | DATA                               | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -76 | RODATA                             | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
| +3904 | sha1_transform()                   | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
| +1238 | generic_file_buffered_read()       | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +859 | zhaoxin_pmu_init()                 | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +827 | free_area_init_node()              | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +643 | init.text                          | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +581 | internal_get_user_pages_fast()     | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +463 | do_tee()                           | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +405 | __ia32_sys_setns()                 | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +405 | zhaoxin_pmu_handle_irq()           | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +336 | zxd_hw_cache_event_ids()           | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +336 | zxe_hw_cache_event_ids()           | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +333 | cp_statx()                         | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +324 | page_cache_readahead_unbounded()   | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +313 | memblock_add_range.isra()          | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +296 | zhaoxin_pmu_enable_event()         | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +288 | map_kernel_range_noflush()         | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +259 | arch_sync_kernel_mappings()        | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +256 | lru_pvecs                          | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +210 | try_enable_new_console()           | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +204 | unmap_kernel_range_noflush()       | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +160 | zxd_event_constraints              | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +157 | free_area_init()                   | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +140 | zhaoxin_pmu_disable_event()        | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +136 | arch/x86/events/zhaoxin/built-in.* | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +132 | bdi_alloc()                        | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +128 | time64_str()                       | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +124 | cpu_vuln_whitelist()               | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +121 | memmap_init                        | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +121 | __dump_page()                      | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +116 | copy_xstate_to_kernel()            | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +104 | altinstructions                    | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +104 | fillonedir()                       | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  +102 | shrink_page_list()                 | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +99 | page_cache_pipe_buf_try_steal()    | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +96 | copy_part()                        | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +95 | lru_note_cost()                    | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +91 | check_free_page()                  | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +90 | delay_halt()                       | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +87 | do_statx()                         | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +85 | sanitize_restored_user_xstate()    | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +84 | arch/x86/built-in.*                | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +80 | zx_pmon_event_map                  | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +80 | zxc_event_constraints              | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +76 | arch/x86/events/built-in.*         | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +76 | __vmalloc_node()                   | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +75 | vfs_statx()                        | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +71 | do_splice_from()                   | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +70 | zhaoxin_arch_events_quirk()        | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +69 | fpu__init_system_xstate()          | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +68 | put_nsset()                        | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +66 | zhaoxin_get_event_constraints()    | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   +64 | lru_rotate                         | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -64 | lru_add_pvec                       | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -64 | lru_deactivate_file_pvecs          | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -64 | lru_deactivate_pvecs               | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -64 | lru_lazyfree_pvecs                 | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -64 | lru_rotate_pvecs                   | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -65 | bdi_register_owner()               | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -65 | validate_xstate_header()           | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -67 | __vmalloc_node()                   | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -79 | memblock_set_node()                | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -80 | forbidden_sb_flag                  | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -84 | init.data                          | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -84 | memblock_dump()                    | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -84 | vmalloc_user_node_flags()          | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -85 | sanitize_restored_xstate()         | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -87 | __do_sys_statx()                   | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -89 | get_cpu_cap()                      | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -91 | free_pages_check()                 | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -92 | find_min_pfn_for_node()            | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|   -98 | fpu__clear()                       | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -102 | page_cache_pipe_buf_steal()        | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -103 | free_bootmem_with_active_regions() | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -119 | vmalloc_sync()                     | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -121 | vmalloc_sync_one()                 | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -122 | delay_mwaitx()                     | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -128 | register_console()                 | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -132 | bdi_alloc_node()                   | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -140 | vmalloc_fault()                    | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -157 | vunmap_page_range()                | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -176 | free_area_init_nodes()             | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -196 | __do_page_cache_readahead()        | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -241 | vmap_page_range_noflush()          | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -313 | cp_statx()                         | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -337 | memblock_add_range()               | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -466 | __ia32_sys_tee()                   | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -512 | memblock_memory_init_regions()     | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -512 | memblock_reserved_init_regions()   | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -581 | gup_pgd_range()                    | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
|  -826 | free_area_init_node()              | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
| -1238 | generic_file_buffered_read()       | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
| -3904 | sha_transform()                    | b8797e281f77 Merge branch 'linus' into x86/entry, to resolve conflicts |
+-------+------------------------------------+------------------------------------------------------------------------+

elapsed time: 485m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                       aspeed_g4_defconfig
arc                          axs101_defconfig
arc                        vdk_hs38_defconfig
parisc                           allyesconfig
arc                        nsimosci_defconfig
arm                         hackkit_defconfig
sh                         apsh4a3a_defconfig
arm                            mmp2_defconfig
arm                        neponset_defconfig
arm                         orion5x_defconfig
sh                          r7780mp_defconfig
riscv                            allyesconfig
mips                        bcm47xx_defconfig
arm                           tegra_defconfig
mips                           ci20_defconfig
arm                         ebsa110_defconfig
arm                          moxart_defconfig
arm                     eseries_pxa_defconfig
arm                           stm32_defconfig
arm                     am200epdkit_defconfig
powerpc                    gamecube_defconfig
nios2                            alldefconfig
arm                              zx_defconfig
microblaze                    nommu_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
