Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C8EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1150E2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgFOG5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:57:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20425 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgFOG5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:57:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49lhvY0lbZzB09ZN;
        Mon, 15 Jun 2020 08:56:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id cQs_S25EY5ey; Mon, 15 Jun 2020 08:56:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49lhvX6sWZzB09ZM;
        Mon, 15 Jun 2020 08:56:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2862E8B77C;
        Mon, 15 Jun 2020 08:56:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Mz-jSYSEVN6f; Mon, 15 Jun 2020 08:56:47 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D9E6E8B75F;
        Mon, 15 Jun 2020 08:56:46 +0200 (CEST)
Subject: Re: arch/powerpc/mm/pgtable_32.c:38:34: error: array is too large
 (34359672832 elements)
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20200615062259.GH12456@shao2-debian>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <118352b5-bf96-37ea-214e-b8a825ea89ac@csgroup.eu>
Date:   Mon, 15 Jun 2020 06:56:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200615062259.GH12456@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/15/2020 06:22 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   08bf1a27c4c354b853fd81a79e953525bbcc8506
> commit: 925ac141d106b55acbe112a9272f970631a3c082 powerpc/mm: Allocate static page tables for fixmap

Guilty commit is b8e8efaa8639 ("powerpc: reserve fixmap entries for 
early debug")


> date:   3 weeks ago
> :::::: branch date: 49 minutes ago
> :::::: commit date: 3 weeks ago
> config: powerpc64-randconfig-r011-20200614 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project c669a1ed6386d57a75a602b53266466dae1e1d84)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install powerpc64 cross compiling tool for clang build
>          # apt-get install binutils-powerpc64-linux-gnu
>          git checkout 925ac141d106b55acbe112a9272f970631a3c082
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> In file included from arch/powerpc/mm/pgtable_32.c:20:

gcc fails long before that, at:

CC      arch/powerpc/kernel/asm-offsets.s

Christophe

> In file included from include/linux/mm.h:95:
> In file included from arch/powerpc/include/asm/pgtable.h:20:
> In file included from arch/powerpc/include/asm/nohash/pgtable.h:8:
> In file included from arch/powerpc/include/asm/nohash/32/pgtable.h:77:
> arch/powerpc/include/asm/fixmap.h:57:2: warning: overflow in enumeration value
> FIX_KMAP_BEGIN, /* reserved pte's for temporary kernel mappings */
> ^
> In file included from arch/powerpc/mm/pgtable_32.c:20:
> In file included from include/linux/mm.h:95:
> In file included from arch/powerpc/include/asm/pgtable.h:20:
> In file included from arch/powerpc/include/asm/nohash/pgtable.h:8:
> In file included from arch/powerpc/include/asm/nohash/32/pgtable.h:77:
> In file included from arch/powerpc/include/asm/fixmap.h:96:
> include/asm-generic/fixmap.h:32:19: warning: result of comparison of constant '__end_of_fixed_addresses' (4294967376) with expression of type 'const unsigned int' is always false [-Wtautological-constant-out-of-range-compare]
> BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
> ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:50:19: note: expanded from macro 'BUILD_BUG_ON'
> BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> ^~~~~~~~~
> include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
> #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> ^~~~
> include/linux/compiler.h:350:22: note: expanded from macro 'compiletime_assert'
> _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> ^~~~~~~~~
> include/linux/compiler.h:338:23: note: expanded from macro '_compiletime_assert'
> __compiletime_assert(condition, msg, prefix, suffix)
> ^~~~~~~~~
> include/linux/compiler.h:330:9: note: expanded from macro '__compiletime_assert'
> if (!(condition))                                                                ^~~~~~~~~
> In file included from arch/powerpc/mm/pgtable_32.c:20:
> In file included from include/linux/mm.h:95:
> In file included from arch/powerpc/include/asm/pgtable.h:20:
> In file included from arch/powerpc/include/asm/nohash/pgtable.h:8:
> In file included from arch/powerpc/include/asm/nohash/32/pgtable.h:77:
> In file included from arch/powerpc/include/asm/fixmap.h:96:
> include/asm-generic/fixmap.h:38:39: warning: result of comparison of constant 18445618177942224896 with expression of type 'const unsigned long' is always true [-Wtautological-constant-out-of-range-compare]
> BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
> arch/powerpc/include/asm/bug.h:73:27: note: expanded from macro 'BUG_ON'
> if (__builtin_constant_p(x)) {                                                              ^
> In file included from arch/powerpc/mm/pgtable_32.c:20:
> In file included from include/linux/mm.h:95:
> In file included from arch/powerpc/include/asm/pgtable.h:20:
> In file included from arch/powerpc/include/asm/nohash/pgtable.h:8:
> In file included from arch/powerpc/include/asm/nohash/32/pgtable.h:77:
> In file included from arch/powerpc/include/asm/fixmap.h:96:
> include/asm-generic/fixmap.h:38:39: warning: result of comparison of constant 18445618177942224896 with expression of type 'const unsigned long' is always true [-Wtautological-constant-out-of-range-compare]
> BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
> arch/powerpc/include/asm/bug.h:74:7: note: expanded from macro 'BUG_ON'
> if (x)                                                                 ^
>>> arch/powerpc/mm/pgtable_32.c:38:34: error: array is too large (34359672832 elements)
> static u8 early_fixmap_pagetable[FIXMAP_PTE_SIZE] __page_aligned_data;
> ^~~~~~~~~~~~~~~
> arch/powerpc/include/asm/fixmap.h:91:25: note: expanded from macro 'FIXMAP_PTE_SIZE'
> #define FIXMAP_PTE_SIZE (FIXMAP_ALIGNED_SIZE / PGDIR_SIZE * PTE_TABLE_SIZE)
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> arch/powerpc/mm/pgtable_32.c:42:23: warning: implicit conversion from 'unsigned long long' to 'unsigned long' changes value from 18445618175950192640 to 2147483648 [-Wconstant-conversion]
> unsigned long addr = ALIGN_DOWN(FIXADDR_START, PGDIR_SIZE);
> ~~~~   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/kernel.h:34:26: note: expanded from macro 'ALIGN_DOWN'
> #define ALIGN_DOWN(x, a)        __ALIGN_KERNEL((x) - ((a) - 1), (a))
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/uapi/linux/kernel.h:10:31: note: expanded from macro '__ALIGN_KERNEL'
> #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/uapi/linux/kernel.h:11:54: note: expanded from macro '__ALIGN_KERNEL_MASK'
> #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
> ~~~~~~~~~~~~~~~^~~~~~~~~
> 5 warnings and 1 error generated.
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=925ac141d106b55acbe112a9272f970631a3c082
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout 925ac141d106b55acbe112a9272f970631a3c082
> vim +38 arch/powerpc/mm/pgtable_32.c
> 
> 14cf11af6cf608 arch/powerpc/mm/pgtable.c    Paul Mackerras   2005-09-26  37
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19 @38  static u8 early_fixmap_pagetable[FIXMAP_PTE_SIZE] __page_aligned_data;
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  39
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  40  notrace void __init early_ioremap_init(void)
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  41  {
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19 @42  	unsigned long addr = ALIGN_DOWN(FIXADDR_START, PGDIR_SIZE);
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  43  	pte_t *ptep = (pte_t *)early_fixmap_pagetable;
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  44  	pmd_t *pmdp = pmd_ptr_k(addr);
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  45
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  46  	for (; (s32)(FIXADDR_TOP - addr) > 0;
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  47  	     addr += PGDIR_SIZE, ptep += PTRS_PER_PTE, pmdp++)
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  48  		pmd_populate_kernel(&init_mm, pmdp, ptep);
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  49
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  50  	early_ioremap_setup();
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  51  }
> 925ac141d106b5 arch/powerpc/mm/pgtable_32.c Christophe Leroy 2020-05-19  52
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> 
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
> 
