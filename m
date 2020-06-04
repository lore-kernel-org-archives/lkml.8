Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3655BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04123207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgFDQHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:07:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:43565 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgFDQHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:07:47 -0400
IronPort-SDR: mlKH+omNX5LrNMWlA2Fr55rWDK03/qkfQiil7nqTI7ss90ZYCokPNTT1g8ZDFQdBhF62ZXq6yN
 n22s9BoD82fA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 09:07:46 -0700
IronPort-SDR: 1EN9NwfgtLqzYUyJv5VYYmg+kJgoSEK2Z71XFDHu3Jw1PiJVssbC1HQJKDR7asl+KJhB9bq0Ju
 leRxn0dRbw5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,472,1583222400"; 
   d="scan'208";a="471468504"
Received: from lkp-server02.sh.intel.com (HELO 6de3076d9aaa) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2020 09:07:45 -0700
Received: from kbuild by 6de3076d9aaa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgsPA-000029-OC; Thu, 04 Jun 2020 16:07:44 +0000
Date:   Fri, 05 Jun 2020 00:07:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:WIP.x86/mm] BUILD SUCCESS
 c30a3e465817f0c5a3c94678edf0fd15585cadd9
Message-ID: <5ed91c25.hJwl4gY2kFnzQUh5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  WIP.x86/mm
branch HEAD: c30a3e465817f0c5a3c94678edf0fd15585cadd9  Merge branch 'linus' into WIP.x86/mm, to resolve conflict

i386-tinyconfig vmlinux size:

+-------+------------------------------------+------------------------------------------------------------------------+
| DELTA |               SYMBOL               |                                 COMMIT                                 |
+-------+------------------------------------+------------------------------------------------------------------------+
| +8899 | TOTAL                              | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
| +4241 | TEXT                               | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
| +4563 | DATA                               | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -65 | RODATA                             | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
| +4096 | doublefault_stack                  | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
| +3904 | sha1_transform()                   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
| +1238 | generic_file_buffered_read()       | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +859 | zhaoxin_pmu_init()                 | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +827 | free_area_init_node()              | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +683 | init.text                          | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +538 | internal_get_user_pages_fast()     | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +463 | do_tee()                           | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +405 | __ia32_sys_setns()                 | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +405 | zhaoxin_pmu_handle_irq()           | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +336 | zxd_hw_cache_event_ids()           | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +336 | zxe_hw_cache_event_ids()           | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +333 | cp_statx()                         | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +324 | page_cache_readahead_unbounded()   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +313 | memblock_add_range.isra()          | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +296 | zhaoxin_pmu_enable_event()         | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +288 | map_kernel_range_noflush()         | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +275 | doublefault_shim()                 | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +259 | arch_sync_kernel_mappings()        | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +256 | lru_pvecs                          | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +210 | try_enable_new_console()           | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +204 | unmap_kernel_range_noflush()       | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +168 | arch/x86/built-in.*                | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +160 | zxd_event_constraints              | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +157 | free_area_init()                   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +140 | zhaoxin_pmu_disable_event()        | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +132 | bdi_alloc()                        | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +128 | time64_str()                       | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +124 | cpu_vuln_whitelist()               | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +121 | memmap_init                        | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +121 | __dump_page()                      | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +116 | copy_xstate_to_kernel()            | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +104 | altinstructions                    | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +104 | fillonedir()                       | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +104 | do_double_fault()                  | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  +102 | shrink_page_list()                 | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +99 | page_cache_pipe_buf_try_steal()    | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +96 | copy_part()                        | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +95 | lru_note_cost()                    | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +91 | check_free_page()                  | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +90 | delay_halt()                       | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +87 | do_statx()                         | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +85 | sanitize_restored_user_xstate()    | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +80 | zx_pmon_event_map                  | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +80 | zxc_event_constraints              | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +78 | arch/x86/kernel/built-in.*         | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +76 | arch/x86/events/built-in.*         | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +76 | __vmalloc_node()                   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +76 | try_invoke_on_locked_down_task()   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +75 | vfs_statx()                        | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +71 | do_splice_from()                   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +71 | set_df_gdt_entry()                 | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +70 | zhaoxin_arch_events_quirk()        | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +69 | fpu__init_system_xstate()          | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +68 | put_nsset()                        | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +66 | zhaoxin_get_event_constraints()    | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   +64 | lru_rotate                         | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -64 | lru_add_pvec                       | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -64 | lru_deactivate_file_pvecs          | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -64 | lru_deactivate_pvecs               | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -64 | lru_lazyfree_pvecs                 | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -64 | lru_rotate_pvecs                   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -65 | bdi_register_owner()               | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -65 | validate_xstate_header()           | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -67 | __vmalloc_node()                   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -79 | memblock_set_node()                | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -80 | forbidden_sb_flag                  | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -84 | init.data                          | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -84 | memblock_dump()                    | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -84 | vmalloc_user_node_flags()          | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -85 | sanitize_restored_xstate()         | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -87 | __do_sys_statx()                   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -89 | get_cpu_cap()                      | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -91 | free_pages_check()                 | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -92 | find_min_pfn_for_node()            | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|   -98 | fpu__clear()                       | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -102 | page_cache_pipe_buf_steal()        | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -103 | free_bootmem_with_active_regions() | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -119 | vmalloc_sync()                     | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -121 | vmalloc_sync_one()                 | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -122 | delay_mwaitx()                     | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -128 | register_console()                 | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -132 | bdi_alloc_node()                   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -140 | vmalloc_fault()                    | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -157 | vunmap_page_range()                | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -176 | free_area_init_nodes()             | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -188 | __do_page_cache_readahead()        | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -241 | vmap_page_range_noflush()          | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -313 | cp_statx()                         | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -337 | memblock_add_range()               | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -458 | __ia32_sys_tee()                   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -512 | memblock_memory_init_regions()     | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -512 | memblock_reserved_init_regions()   | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -538 | gup_pgd_range()                    | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
|  -826 | free_area_init_node()              | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
| -1238 | generic_file_buffered_read()       | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
| -3904 | sha_transform()                    | c30a3e465817 Merge branch 'linus' into WIP.x86/mm, to resolve conflict |
+-------+------------------------------------+------------------------------------------------------------------------+

elapsed time: 514m

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
