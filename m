Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D915EC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B8A222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgBNGRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:17:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:61297 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbgBNGRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:17:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 22:17:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,439,1574150400"; 
   d="gz'50?scan'50,208,50";a="222909868"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Feb 2020 22:17:03 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j2UHe-0001qB-Hl; Fri, 14 Feb 2020 14:17:02 +0800
Date:   Fri, 14 Feb 2020 14:16:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>
Subject: mm/hugetlb.c:3454:14: error: implicit declaration of function
 'pte_page'; did you mean 'put_page'?
Message-ID: <202002141441.B8hFHHms%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Christoph,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b19e8c68470385dd2c5440876591fddb02c8c402
commit: 6bd33e1ece528f67646db33bf97406b747dafda0 riscv: add nommu support
date:   3 months ago
config: riscv-randconfig-a001-20200214 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6bd33e1ece528f67646db33bf97406b747dafda0
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/hugetlb.h:5:0,
                    from include/linux/hugetlb.h:444,
                    from mm/hugetlb.c:36:
   include/asm-generic/hugetlb.h: In function 'mk_huge_pte':
   include/asm-generic/hugetlb.h:7:9: error: implicit declaration of function 'mk_pte'; did you mean '__pte'? [-Werror=implicit-function-declaration]
     return mk_pte(page, pgprot);
            ^~~~~~
            __pte
   include/asm-generic/hugetlb.h:7:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return mk_pte(page, pgprot);
            ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_write':
   include/asm-generic/hugetlb.h:12:9: error: implicit declaration of function 'pte_write'; did you mean 'pgd_write'? [-Werror=implicit-function-declaration]
     return pte_write(pte);
            ^~~~~~~~~
            pgd_write
   include/asm-generic/hugetlb.h: In function 'huge_pte_dirty':
   include/asm-generic/hugetlb.h:17:9: error: implicit declaration of function 'pte_dirty'; did you mean 'info_dirty'? [-Werror=implicit-function-declaration]
     return pte_dirty(pte);
            ^~~~~~~~~
            info_dirty
   include/asm-generic/hugetlb.h: In function 'huge_pte_mkwrite':
   include/asm-generic/hugetlb.h:22:9: error: implicit declaration of function 'pte_mkwrite'; did you mean 'pgd_write'? [-Werror=implicit-function-declaration]
     return pte_mkwrite(pte);
            ^~~~~~~~~~~
            pgd_write
   include/asm-generic/hugetlb.h:22:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_mkwrite(pte);
            ^~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_mkdirty':
   include/asm-generic/hugetlb.h:27:9: error: implicit declaration of function 'pte_mkdirty'; did you mean 'huge_pte_mkdirty'? [-Werror=implicit-function-declaration]
     return pte_mkdirty(pte);
            ^~~~~~~~~~~
            huge_pte_mkdirty
   include/asm-generic/hugetlb.h:27:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_mkdirty(pte);
            ^~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_modify':
   include/asm-generic/hugetlb.h:32:9: error: implicit declaration of function 'pte_modify'; did you mean 'lease_modify'? [-Werror=implicit-function-declaration]
     return pte_modify(pte, newprot);
            ^~~~~~~~~~
            lease_modify
   include/asm-generic/hugetlb.h:32:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_modify(pte, newprot);
            ^~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_clear':
   include/asm-generic/hugetlb.h:39:2: error: implicit declaration of function 'pte_clear'; did you mean 'pud_clear'? [-Werror=implicit-function-declaration]
     pte_clear(mm, addr, ptep);
     ^~~~~~~~~
     pud_clear
   include/asm-generic/hugetlb.h: In function 'set_huge_pte_at':
   include/asm-generic/hugetlb.h:56:2: error: implicit declaration of function 'set_pte_at'; did you mean 'set_huge_pte_at'? [-Werror=implicit-function-declaration]
     set_pte_at(mm, addr, ptep, pte);
     ^~~~~~~~~~
     set_huge_pte_at
   include/asm-generic/hugetlb.h: In function 'huge_ptep_get_and_clear':
   include/asm-generic/hugetlb.h:64:9: error: implicit declaration of function 'ptep_get_and_clear'; did you mean 'huge_ptep_get_and_clear'? [-Werror=implicit-function-declaration]
     return ptep_get_and_clear(mm, addr, ptep);
            ^~~~~~~~~~~~~~~~~~
            huge_ptep_get_and_clear
   include/asm-generic/hugetlb.h:64:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return ptep_get_and_clear(mm, addr, ptep);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_ptep_clear_flush':
   include/asm-generic/hugetlb.h:72:2: error: implicit declaration of function 'ptep_clear_flush'; did you mean 'huge_ptep_clear_flush'? [-Werror=implicit-function-declaration]
     ptep_clear_flush(vma, addr, ptep);
     ^~~~~~~~~~~~~~~~
     huge_ptep_clear_flush
   include/asm-generic/hugetlb.h: In function 'huge_pte_none':
   include/asm-generic/hugetlb.h:79:9: error: implicit declaration of function 'pte_none'; did you mean 'pud_none'? [-Werror=implicit-function-declaration]
     return pte_none(pte);
            ^~~~~~~~
            pud_none
   include/asm-generic/hugetlb.h: In function 'huge_pte_wrprotect':
   include/asm-generic/hugetlb.h:86:9: error: implicit declaration of function 'pte_wrprotect'; did you mean 'huge_pte_wrprotect'? [-Werror=implicit-function-declaration]
     return pte_wrprotect(pte);
            ^~~~~~~~~~~~~
            huge_pte_wrprotect
   include/asm-generic/hugetlb.h:86:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_wrprotect(pte);
            ^~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_ptep_set_wrprotect':
   include/asm-generic/hugetlb.h:109:2: error: implicit declaration of function 'ptep_set_wrprotect'; did you mean 'huge_ptep_set_wrprotect'? [-Werror=implicit-function-declaration]
     ptep_set_wrprotect(mm, addr, ptep);
     ^~~~~~~~~~~~~~~~~~
     huge_ptep_set_wrprotect
   include/asm-generic/hugetlb.h: In function 'huge_ptep_set_access_flags':
   include/asm-generic/hugetlb.h:118:9: error: implicit declaration of function 'ptep_set_access_flags'; did you mean 'huge_ptep_set_access_flags'? [-Werror=implicit-function-declaration]
     return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
            ^~~~~~~~~~~~~~~~~~~~~
            huge_ptep_set_access_flags
   mm/hugetlb.c: In function 'make_huge_pte':
>> mm/hugetlb.c:3327:10: error: implicit declaration of function 'pte_mkyoung'; did you mean 'page_mapping'? [-Werror=implicit-function-declaration]
     entry = pte_mkyoung(entry);
             ^~~~~~~~~~~
             page_mapping
>> mm/hugetlb.c:3327:8: error: incompatible types when assigning to type 'pte_t {aka struct <anonymous>}' from type 'int'
     entry = pte_mkyoung(entry);
           ^
>> mm/hugetlb.c:3328:10: error: implicit declaration of function 'pte_mkhuge'; did you mean 'pud_huge'? [-Werror=implicit-function-declaration]
     entry = pte_mkhuge(entry);
             ^~~~~~~~~~
             pud_huge
   mm/hugetlb.c:3328:8: error: incompatible types when assigning to type 'pte_t {aka struct <anonymous>}' from type 'int'
     entry = pte_mkhuge(entry);
           ^
   mm/hugetlb.c: In function 'set_huge_ptep_writable':
>> mm/hugetlb.c:3341:3: error: implicit declaration of function 'update_mmu_cache'; did you mean 'node_add_cache'? [-Werror=implicit-function-declaration]
      update_mmu_cache(vma, address, ptep);
      ^~~~~~~~~~~~~~~~
      node_add_cache
   mm/hugetlb.c: In function 'is_hugetlb_entry_migration':
>> mm/hugetlb.c:3348:28: error: implicit declaration of function 'pte_present'; did you mean 'pud_present'? [-Werror=implicit-function-declaration]
     if (huge_pte_none(pte) || pte_present(pte))
                               ^~~~~~~~~~~
                               pud_present
   mm/hugetlb.c:3350:8: error: implicit declaration of function 'pte_to_swp_entry'; did you mean 'pte_lockptr'? [-Werror=implicit-function-declaration]
     swp = pte_to_swp_entry(pte);
           ^~~~~~~~~~~~~~~~
           pte_lockptr
>> mm/hugetlb.c:3350:6: error: incompatible types when assigning to type 'swp_entry_t {aka struct <anonymous>}' from type 'int'
     swp = pte_to_swp_entry(pte);
         ^
>> mm/hugetlb.c:3351:6: error: implicit declaration of function 'non_swap_entry'; did you mean 'init_wait_entry'? [-Werror=implicit-function-declaration]
     if (non_swap_entry(swp) && is_migration_entry(swp))
         ^~~~~~~~~~~~~~
         init_wait_entry
>> mm/hugetlb.c:3351:29: error: implicit declaration of function 'is_migration_entry'; did you mean 'list_first_entry'? [-Werror=implicit-function-declaration]
     if (non_swap_entry(swp) && is_migration_entry(swp))
                                ^~~~~~~~~~~~~~~~~~
                                list_first_entry
   mm/hugetlb.c: In function 'is_hugetlb_entry_hwpoisoned':
   mm/hugetlb.c:3363:6: error: incompatible types when assigning to type 'swp_entry_t {aka struct <anonymous>}' from type 'int'
     swp = pte_to_swp_entry(pte);
         ^
>> mm/hugetlb.c:3364:29: error: implicit declaration of function 'is_hwpoison_entry'; did you mean 'hwpoison_filter'? [-Werror=implicit-function-declaration]
     if (non_swap_entry(swp) && is_hwpoison_entry(swp))
                                ^~~~~~~~~~~~~~~~~
                                hwpoison_filter
   mm/hugetlb.c: In function 'copy_hugetlb_page_range':
>> mm/hugetlb.c:3429:28: error: invalid initializer
       swp_entry_t swp_entry = pte_to_swp_entry(entry);
                               ^~~~~~~~~~~~~~~~
>> mm/hugetlb.c:3431:8: error: implicit declaration of function 'is_write_migration_entry'; did you mean 'init_wait_entry'? [-Werror=implicit-function-declaration]
       if (is_write_migration_entry(swp_entry) && cow) {
           ^~~~~~~~~~~~~~~~~~~~~~~~
           init_wait_entry
>> mm/hugetlb.c:3436:5: error: implicit declaration of function 'make_migration_entry_read'; did you mean 'thp_migration_supported'? [-Werror=implicit-function-declaration]
        make_migration_entry_read(&swp_entry);
        ^~~~~~~~~~~~~~~~~~~~~~~~~
        thp_migration_supported
>> mm/hugetlb.c:3437:13: error: implicit declaration of function 'swp_entry_to_pte'; did you mean '__d_entry_type'? [-Werror=implicit-function-declaration]
        entry = swp_entry_to_pte(swp_entry);
                ^~~~~~~~~~~~~~~~
                __d_entry_type
   mm/hugetlb.c:3437:11: error: incompatible types when assigning to type 'pte_t {aka struct <anonymous>}' from type 'int'
        entry = swp_entry_to_pte(swp_entry);
              ^
>> mm/hugetlb.c:3454:14: error: implicit declaration of function 'pte_page'; did you mean 'put_page'? [-Werror=implicit-function-declaration]
       ptepage = pte_page(entry);
                 ^~~~~~~~
                 put_page
   mm/hugetlb.c:3454:12: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
       ptepage = pte_page(entry);
               ^
>> mm/hugetlb.c:3456:4: error: implicit declaration of function 'page_dup_rmap'; did you mean 'page_is_ram'? [-Werror=implicit-function-declaration]
       page_dup_rmap(ptepage, true);
       ^~~~~~~~~~~~~
       page_is_ram
   mm/hugetlb.c: In function '__unmap_hugepage_range':
>> mm/hugetlb.c:3492:2: error: implicit declaration of function 'tlb_change_page_size'; did you mean 'huge_page_size'? [-Werror=implicit-function-declaration]
     tlb_change_page_size(tlb, sz);
     ^~~~~~~~~~~~~~~~~~~~
     huge_page_size
>> mm/hugetlb.c:3493:2: error: implicit declaration of function 'tlb_start_vma'; did you mean 'hstate_vma'? [-Werror=implicit-function-declaration]
     tlb_start_vma(tlb, vma);
     ^~~~~~~~~~~~~
     hstate_vma
   mm/hugetlb.c:3534:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      page = pte_page(pte);
           ^
>> mm/hugetlb.c:3554:3: error: implicit declaration of function 'tlb_remove_huge_tlb_entry'; did you mean 'move_hugetlb_state'? [-Werror=implicit-function-declaration]
      tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
      ^~~~~~~~~~~~~~~~~~~~~~~~~
      move_hugetlb_state
>> mm/hugetlb.c:3559:3: error: implicit declaration of function 'page_remove_rmap'; did you mean 'page_anon_vma'? [-Werror=implicit-function-declaration]
      page_remove_rmap(page, true);
      ^~~~~~~~~~~~~~~~
      page_anon_vma
>> mm/hugetlb.c:3562:3: error: implicit declaration of function 'tlb_remove_page_size'; did you mean 'vma_mmu_pagesize'? [-Werror=implicit-function-declaration]
      tlb_remove_page_size(tlb, page, huge_page_size(h));
      ^~~~~~~~~~~~~~~~~~~~
      vma_mmu_pagesize
   mm/hugetlb.c:3570:2: error: implicit declaration of function 'tlb_end_vma'; did you mean 'find_vma'? [-Werror=implicit-function-declaration]
     tlb_end_vma(tlb, vma);
     ^~~~~~~~~~~
     find_vma
   mm/hugetlb.c: In function 'unmap_hugepage_range':
   mm/hugetlb.c:3596:20: error: storage size of 'tlb' isn't known
     struct mmu_gather tlb;
                       ^~~
   mm/hugetlb.c:3596:20: warning: unused variable 'tlb' [-Wunused-variable]
   mm/hugetlb.c: In function 'hugetlb_cow':
   mm/hugetlb.c:3691:11: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     old_page = pte_page(pte);
              ^
   mm/hugetlb.c:3697:3: error: implicit declaration of function 'page_move_anon_rmap'; did you mean 'page_anon_vma'? [-Werror=implicit-function-declaration]
      page_move_anon_rmap(old_page, vma);
      ^~~~~~~~~~~~~~~~~~~
      page_anon_vma
   In file included from include/linux/kernel.h:11:0,
                    from include/linux/list.h:9,
                    from mm/hugetlb.c:6:
   mm/hugetlb.c:3740:8: error: implicit declaration of function 'pte_same'; did you mean 'pte_val'? [-Werror=implicit-function-declaration]
           pte_same(huge_ptep_get(ptep), pte)))
           ^
   include/linux/compiler.h:33:34: note: in definition of macro '__branch_check__'
       ______r = __builtin_expect(!!(x), expect); \
                                     ^
   mm/hugetlb.c:3739:8: note: in expansion of macro 'likely'
       if (likely(ptep &&
           ^~~~~~
   mm/hugetlb.c:3785:3: error: implicit declaration of function 'hugepage_add_new_anon_rmap'; did you mean 'hugepage_new_subpool'? [-Werror=implicit-function-declaration]
      hugepage_add_new_anon_rmap(new_page, vma, haddr);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
      hugepage_new_subpool
   mm/hugetlb.c: In function 'hugetlb_fault':
   mm/hugetlb.c:4089:4: error: implicit declaration of function 'migration_entry_wait_huge' [-Werror=implicit-function-declaration]
       migration_entry_wait_huge(vma, mm, ptep);
       ^~~~~~~~~~~~~~~~~~~~~~~~~
   mm/hugetlb.c:4161:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     page = pte_page(entry);
          ^
   mm/hugetlb.c:4178:8: error: incompatible types when assigning to type 'pte_t {aka struct <anonymous>}' from type 'int'
     entry = pte_mkyoung(entry);
           ^
   mm/hugetlb.c: In function 'hugetlb_mcopy_atomic_pte':
   mm/hugetlb.c:4311:11: error: incompatible types when assigning to type 'pte_t {aka struct <anonymous>}' from type 'int'
     _dst_pte = pte_mkyoung(_dst_pte);
              ^
   mm/hugetlb.c: In function 'follow_hugetlb_page':
   mm/hugetlb.c:4402:17: error: implicit declaration of function 'is_swap_pte'; did you mean 'is_swap_pmd'? [-Werror=implicit-function-declaration]
      if (absent || is_swap_pte(huge_ptep_get(pte)) ||
                    ^~~~~~~~~~~
                    is_swap_pmd
   mm/hugetlb.c:4448:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      page = pte_page(huge_ptep_get(pte));
           ^
   mm/hugetlb.c: In function 'hugetlb_change_protection':
   mm/hugetlb.c:4548:24: error: invalid initializer
       swp_entry_t entry = pte_to_swp_entry(pte);
                           ^~~~~~~~~~~~~~~~
   mm/hugetlb.c:4554:12: error: incompatible types when assigning to type 'pte_t {aka struct <anonymous>}' from type 'int'
        newpte = swp_entry_to_pte(entry);
               ^
   mm/hugetlb.c:4566:8: error: incompatible types when assigning to type 'pte_t {aka struct <anonymous>}' from type 'int'
       pte = pte_mkhuge(huge_pte_modify(old_pte, newprot));
           ^
   mm/hugetlb.c: In function 'huge_pmd_share':
   mm/hugetlb.c:4843:19: error: implicit declaration of function 'pmd_alloc'; did you mean '__pmd_alloc'? [-Werror=implicit-function-declaration]
      return (pte_t *)pmd_alloc(mm, pud, addr);
                      ^~~~~~~~~
                      __pmd_alloc
   mm/hugetlb.c:4843:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      return (pte_t *)pmd_alloc(mm, pud, addr);
             ^
   mm/hugetlb.c:4866:3: error: implicit declaration of function 'pud_populate'; did you mean 'pgd_populate'? [-Werror=implicit-function-declaration]
      pud_populate(mm, pud,
      ^~~~~~~~~~~~
      pgd_populate
   mm/hugetlb.c:4874:8: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     pte = (pte_t *)pmd_alloc(mm, pud, addr);
           ^
   mm/hugetlb.c: In function 'huge_pmd_unshare':
   mm/hugetlb.c:4893:15: error: implicit declaration of function 'pgd_offset'; did you mean 'pmd_offset'? [-Werror=implicit-function-declaration]
     pgd_t *pgd = pgd_offset(mm, *addr);
                  ^~~~~~~~~~
                  pmd_offset
   mm/hugetlb.c:4893:15: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/cache.h:5:0,
                    from include/linux/printk.h:9,
                    from include/linux/kernel.h:15,
                    from include/linux/list.h:9,
                    from mm/hugetlb.c:6:
   mm/hugetlb.c:4904:36: error: 'PTRS_PER_PTE' undeclared (first use in this function); did you mean 'PTRS_PER_P4D'?
     *addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
                                       ^
   include/uapi/linux/kernel.h:11:47: note: in definition of macro '__ALIGN_KERNEL_MASK'
    #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                                  ^~~~

vim +3454 mm/hugetlb.c

^1da177e4c3f415 Linus Torvalds     2005-04-16  3314  
1e8f889b10d8d22 David Gibson       2006-01-06  3315  static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
1e8f889b10d8d22 David Gibson       2006-01-06  3316  				int writable)
63551ae0feaaa23 David Gibson       2005-06-21  3317  {
63551ae0feaaa23 David Gibson       2005-06-21  3318  	pte_t entry;
63551ae0feaaa23 David Gibson       2005-06-21  3319  
1e8f889b10d8d22 David Gibson       2006-01-06  3320  	if (writable) {
106c992a5ebef28 Gerald Schaefer    2013-04-29  3321  		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
106c992a5ebef28 Gerald Schaefer    2013-04-29  3322  					 vma->vm_page_prot)));
63551ae0feaaa23 David Gibson       2005-06-21  3323  	} else {
106c992a5ebef28 Gerald Schaefer    2013-04-29  3324  		entry = huge_pte_wrprotect(mk_huge_pte(page,
106c992a5ebef28 Gerald Schaefer    2013-04-29  3325  					   vma->vm_page_prot));
63551ae0feaaa23 David Gibson       2005-06-21  3326  	}
63551ae0feaaa23 David Gibson       2005-06-21 @3327  	entry = pte_mkyoung(entry);
63551ae0feaaa23 David Gibson       2005-06-21 @3328  	entry = pte_mkhuge(entry);
d9ed9faac283a3b Chris Metcalf      2012-04-01  3329  	entry = arch_make_huge_pte(entry, vma, page, writable);
63551ae0feaaa23 David Gibson       2005-06-21  3330  
63551ae0feaaa23 David Gibson       2005-06-21  3331  	return entry;
63551ae0feaaa23 David Gibson       2005-06-21  3332  }
63551ae0feaaa23 David Gibson       2005-06-21  3333  
1e8f889b10d8d22 David Gibson       2006-01-06  3334  static void set_huge_ptep_writable(struct vm_area_struct *vma,
1e8f889b10d8d22 David Gibson       2006-01-06  3335  				   unsigned long address, pte_t *ptep)
1e8f889b10d8d22 David Gibson       2006-01-06  3336  {
1e8f889b10d8d22 David Gibson       2006-01-06  3337  	pte_t entry;
1e8f889b10d8d22 David Gibson       2006-01-06  3338  
106c992a5ebef28 Gerald Schaefer    2013-04-29  3339  	entry = huge_pte_mkwrite(huge_pte_mkdirty(huge_ptep_get(ptep)));
32f84528fbb5177 Chris Forbes       2011-07-25  3340  	if (huge_ptep_set_access_flags(vma, address, ptep, entry, 1))
4b3073e1c53a256 Russell King       2009-12-18 @3341  		update_mmu_cache(vma, address, ptep);
1e8f889b10d8d22 David Gibson       2006-01-06  3342  }
1e8f889b10d8d22 David Gibson       2006-01-06  3343  
d5ed7444dafb94b Aneesh Kumar K.V   2017-07-06  3344  bool is_hugetlb_entry_migration(pte_t pte)
4a705fef986231a Naoya Horiguchi    2014-06-23  3345  {
4a705fef986231a Naoya Horiguchi    2014-06-23  3346  	swp_entry_t swp;
4a705fef986231a Naoya Horiguchi    2014-06-23  3347  
4a705fef986231a Naoya Horiguchi    2014-06-23 @3348  	if (huge_pte_none(pte) || pte_present(pte))
d5ed7444dafb94b Aneesh Kumar K.V   2017-07-06  3349  		return false;
4a705fef986231a Naoya Horiguchi    2014-06-23 @3350  	swp = pte_to_swp_entry(pte);
4a705fef986231a Naoya Horiguchi    2014-06-23 @3351  	if (non_swap_entry(swp) && is_migration_entry(swp))
d5ed7444dafb94b Aneesh Kumar K.V   2017-07-06  3352  		return true;
4a705fef986231a Naoya Horiguchi    2014-06-23  3353  	else
d5ed7444dafb94b Aneesh Kumar K.V   2017-07-06  3354  		return false;
4a705fef986231a Naoya Horiguchi    2014-06-23  3355  }
4a705fef986231a Naoya Horiguchi    2014-06-23  3356  
4a705fef986231a Naoya Horiguchi    2014-06-23  3357  static int is_hugetlb_entry_hwpoisoned(pte_t pte)
4a705fef986231a Naoya Horiguchi    2014-06-23  3358  {
4a705fef986231a Naoya Horiguchi    2014-06-23  3359  	swp_entry_t swp;
4a705fef986231a Naoya Horiguchi    2014-06-23  3360  
4a705fef986231a Naoya Horiguchi    2014-06-23  3361  	if (huge_pte_none(pte) || pte_present(pte))
4a705fef986231a Naoya Horiguchi    2014-06-23  3362  		return 0;
4a705fef986231a Naoya Horiguchi    2014-06-23  3363  	swp = pte_to_swp_entry(pte);
4a705fef986231a Naoya Horiguchi    2014-06-23 @3364  	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
4a705fef986231a Naoya Horiguchi    2014-06-23  3365  		return 1;
4a705fef986231a Naoya Horiguchi    2014-06-23  3366  	else
4a705fef986231a Naoya Horiguchi    2014-06-23  3367  		return 0;
4a705fef986231a Naoya Horiguchi    2014-06-23  3368  }
1e8f889b10d8d22 David Gibson       2006-01-06  3369  
63551ae0feaaa23 David Gibson       2005-06-21  3370  int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
63551ae0feaaa23 David Gibson       2005-06-21  3371  			    struct vm_area_struct *vma)
63551ae0feaaa23 David Gibson       2005-06-21  3372  {
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3373  	pte_t *src_pte, *dst_pte, entry, dst_entry;
63551ae0feaaa23 David Gibson       2005-06-21  3374  	struct page *ptepage;
1c59827d1da9bcd Hugh Dickins       2005-10-19  3375  	unsigned long addr;
1e8f889b10d8d22 David Gibson       2006-01-06  3376  	int cow;
a5516438959d90b Andi Kleen         2008-07-23  3377  	struct hstate *h = hstate_vma(vma);
a5516438959d90b Andi Kleen         2008-07-23  3378  	unsigned long sz = huge_page_size(h);
ac46d4f3c43241f Jérôme Glisse      2018-12-28  3379  	struct mmu_notifier_range range;
e8569dd299dbc7b Andreas Sandberg   2014-01-21  3380  	int ret = 0;
1e8f889b10d8d22 David Gibson       2006-01-06  3381  
1e8f889b10d8d22 David Gibson       2006-01-06  3382  	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
63551ae0feaaa23 David Gibson       2005-06-21  3383  
ac46d4f3c43241f Jérôme Glisse      2018-12-28  3384  	if (cow) {
7269f999934b289 Jérôme Glisse      2019-05-13  3385  		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, src,
6f4f13e8d9e27ce Jérôme Glisse      2019-05-13  3386  					vma->vm_start,
ac46d4f3c43241f Jérôme Glisse      2018-12-28  3387  					vma->vm_end);
ac46d4f3c43241f Jérôme Glisse      2018-12-28  3388  		mmu_notifier_invalidate_range_start(&range);
ac46d4f3c43241f Jérôme Glisse      2018-12-28  3389  	}
e8569dd299dbc7b Andreas Sandberg   2014-01-21  3390  
a5516438959d90b Andi Kleen         2008-07-23  3391  	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
cb900f412154474 Kirill A. Shutemov 2013-11-14  3392  		spinlock_t *src_ptl, *dst_ptl;
7868a2087ec13ec Punit Agrawal      2017-07-06  3393  		src_pte = huge_pte_offset(src, addr, sz);
c74df32c724a165 Hugh Dickins       2005-10-29  3394  		if (!src_pte)
c74df32c724a165 Hugh Dickins       2005-10-29  3395  			continue;
a5516438959d90b Andi Kleen         2008-07-23  3396  		dst_pte = huge_pte_alloc(dst, addr, sz);
e8569dd299dbc7b Andreas Sandberg   2014-01-21  3397  		if (!dst_pte) {
e8569dd299dbc7b Andreas Sandberg   2014-01-21  3398  			ret = -ENOMEM;
e8569dd299dbc7b Andreas Sandberg   2014-01-21  3399  			break;
e8569dd299dbc7b Andreas Sandberg   2014-01-21  3400  		}
c5c99429fa57dcf Larry Woodman      2008-01-24  3401  
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3402  		/*
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3403  		 * If the pagetables are shared don't copy or take references.
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3404  		 * dst_pte == src_pte is the common case of src/dest sharing.
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3405  		 *
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3406  		 * However, src could have 'unshared' and dst shares with
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3407  		 * another vma.  If dst_pte !none, this implies sharing.
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3408  		 * Check here before taking page table lock, and once again
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3409  		 * after taking the lock below.
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3410  		 */
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3411  		dst_entry = huge_ptep_get(dst_pte);
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3412  		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
c5c99429fa57dcf Larry Woodman      2008-01-24  3413  			continue;
c5c99429fa57dcf Larry Woodman      2008-01-24  3414  
cb900f412154474 Kirill A. Shutemov 2013-11-14  3415  		dst_ptl = huge_pte_lock(h, dst, dst_pte);
cb900f412154474 Kirill A. Shutemov 2013-11-14  3416  		src_ptl = huge_pte_lockptr(h, src, src_pte);
cb900f412154474 Kirill A. Shutemov 2013-11-14  3417  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
4a705fef986231a Naoya Horiguchi    2014-06-23  3418  		entry = huge_ptep_get(src_pte);
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3419  		dst_entry = huge_ptep_get(dst_pte);
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3420  		if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3421  			/*
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3422  			 * Skip if src entry none.  Also, skip in the
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3423  			 * unlikely case dst entry !none as this implies
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3424  			 * sharing with another vma.
5e41540c8a0f0e9 Mike Kravetz       2018-11-16  3425  			 */
4a705fef986231a Naoya Horiguchi    2014-06-23  3426  			;
4a705fef986231a Naoya Horiguchi    2014-06-23  3427  		} else if (unlikely(is_hugetlb_entry_migration(entry) ||
4a705fef986231a Naoya Horiguchi    2014-06-23  3428  				    is_hugetlb_entry_hwpoisoned(entry))) {
4a705fef986231a Naoya Horiguchi    2014-06-23 @3429  			swp_entry_t swp_entry = pte_to_swp_entry(entry);
4a705fef986231a Naoya Horiguchi    2014-06-23  3430  
4a705fef986231a Naoya Horiguchi    2014-06-23 @3431  			if (is_write_migration_entry(swp_entry) && cow) {
4a705fef986231a Naoya Horiguchi    2014-06-23  3432  				/*
4a705fef986231a Naoya Horiguchi    2014-06-23  3433  				 * COW mappings require pages in both
4a705fef986231a Naoya Horiguchi    2014-06-23  3434  				 * parent and child to be set to read.
4a705fef986231a Naoya Horiguchi    2014-06-23  3435  				 */
4a705fef986231a Naoya Horiguchi    2014-06-23 @3436  				make_migration_entry_read(&swp_entry);
4a705fef986231a Naoya Horiguchi    2014-06-23 @3437  				entry = swp_entry_to_pte(swp_entry);
e5251fd43007f9e Punit Agrawal      2017-07-06  3438  				set_huge_swap_pte_at(src, addr, src_pte,
e5251fd43007f9e Punit Agrawal      2017-07-06  3439  						     entry, sz);
4a705fef986231a Naoya Horiguchi    2014-06-23  3440  			}
e5251fd43007f9e Punit Agrawal      2017-07-06  3441  			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
4a705fef986231a Naoya Horiguchi    2014-06-23  3442  		} else {
34ee645e83b60ae Joerg Roedel       2014-11-13  3443  			if (cow) {
0f10851ea475e08 Jérôme Glisse      2017-11-15  3444  				/*
0f10851ea475e08 Jérôme Glisse      2017-11-15  3445  				 * No need to notify as we are downgrading page
0f10851ea475e08 Jérôme Glisse      2017-11-15  3446  				 * table protection not changing it to point
0f10851ea475e08 Jérôme Glisse      2017-11-15  3447  				 * to a new page.
0f10851ea475e08 Jérôme Glisse      2017-11-15  3448  				 *
ad56b738c5dd223 Mike Rapoport      2018-03-21  3449  				 * See Documentation/vm/mmu_notifier.rst
0f10851ea475e08 Jérôme Glisse      2017-11-15  3450  				 */
7f2e9525ba55b1c Gerald Schaefer    2008-04-28  3451  				huge_ptep_set_wrprotect(src, addr, src_pte);
34ee645e83b60ae Joerg Roedel       2014-11-13  3452  			}
0253d634e0803a8 Naoya Horiguchi    2014-07-23  3453  			entry = huge_ptep_get(src_pte);
63551ae0feaaa23 David Gibson       2005-06-21 @3454  			ptepage = pte_page(entry);
63551ae0feaaa23 David Gibson       2005-06-21  3455  			get_page(ptepage);
53f9263baba69fc Kirill A. Shutemov 2016-01-15 @3456  			page_dup_rmap(ptepage, true);
63551ae0feaaa23 David Gibson       2005-06-21  3457  			set_huge_pte_at(dst, addr, dst_pte, entry);
5d317b2b6536592 Naoya Horiguchi    2015-11-05  3458  			hugetlb_count_add(pages_per_huge_page(h), dst);
1c59827d1da9bcd Hugh Dickins       2005-10-19  3459  		}
cb900f412154474 Kirill A. Shutemov 2013-11-14  3460  		spin_unlock(src_ptl);
cb900f412154474 Kirill A. Shutemov 2013-11-14  3461  		spin_unlock(dst_ptl);
63551ae0feaaa23 David Gibson       2005-06-21  3462  	}
63551ae0feaaa23 David Gibson       2005-06-21  3463  
e8569dd299dbc7b Andreas Sandberg   2014-01-21  3464  	if (cow)
ac46d4f3c43241f Jérôme Glisse      2018-12-28  3465  		mmu_notifier_invalidate_range_end(&range);
e8569dd299dbc7b Andreas Sandberg   2014-01-21  3466  
e8569dd299dbc7b Andreas Sandberg   2014-01-21  3467  	return ret;
63551ae0feaaa23 David Gibson       2005-06-21  3468  }
63551ae0feaaa23 David Gibson       2005-06-21  3469  
24669e58477e275 Aneesh Kumar K.V   2012-07-31  3470  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
24669e58477e275 Aneesh Kumar K.V   2012-07-31  3471  			    unsigned long start, unsigned long end,
24669e58477e275 Aneesh Kumar K.V   2012-07-31  3472  			    struct page *ref_page)
63551ae0feaaa23 David Gibson       2005-06-21  3473  {
63551ae0feaaa23 David Gibson       2005-06-21  3474  	struct mm_struct *mm = vma->vm_mm;
63551ae0feaaa23 David Gibson       2005-06-21  3475  	unsigned long address;
c7546f8f03f5a4f David Gibson       2005-08-05  3476  	pte_t *ptep;
63551ae0feaaa23 David Gibson       2005-06-21  3477  	pte_t pte;
cb900f412154474 Kirill A. Shutemov 2013-11-14  3478  	spinlock_t *ptl;
63551ae0feaaa23 David Gibson       2005-06-21  3479  	struct page *page;
a5516438959d90b Andi Kleen         2008-07-23  3480  	struct hstate *h = hstate_vma(vma);
a5516438959d90b Andi Kleen         2008-07-23  3481  	unsigned long sz = huge_page_size(h);
ac46d4f3c43241f Jérôme Glisse      2018-12-28  3482  	struct mmu_notifier_range range;
a5516438959d90b Andi Kleen         2008-07-23  3483  
63551ae0feaaa23 David Gibson       2005-06-21  3484  	WARN_ON(!is_vm_hugetlb_page(vma));
a5516438959d90b Andi Kleen         2008-07-23  3485  	BUG_ON(start & ~huge_page_mask(h));
a5516438959d90b Andi Kleen         2008-07-23  3486  	BUG_ON(end & ~huge_page_mask(h));
63551ae0feaaa23 David Gibson       2005-06-21  3487  
07e326610e5634e Aneesh Kumar K.V   2016-12-12  3488  	/*
07e326610e5634e Aneesh Kumar K.V   2016-12-12  3489  	 * This is a hugetlb vma, all the pte entries should point
07e326610e5634e Aneesh Kumar K.V   2016-12-12  3490  	 * to huge page.
07e326610e5634e Aneesh Kumar K.V   2016-12-12  3491  	 */
ed6a79352cad00e Peter Zijlstra     2018-08-31 @3492  	tlb_change_page_size(tlb, sz);
24669e58477e275 Aneesh Kumar K.V   2012-07-31 @3493  	tlb_start_vma(tlb, vma);
dff11abe280b47c Mike Kravetz       2018-10-05  3494  
dff11abe280b47c Mike Kravetz       2018-10-05  3495  	/*
dff11abe280b47c Mike Kravetz       2018-10-05  3496  	 * If sharing possible, alert mmu notifiers of worst case.
dff11abe280b47c Mike Kravetz       2018-10-05  3497  	 */
6f4f13e8d9e27ce Jérôme Glisse      2019-05-13  3498  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, mm, start,
6f4f13e8d9e27ce Jérôme Glisse      2019-05-13  3499  				end);
ac46d4f3c43241f Jérôme Glisse      2018-12-28  3500  	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
ac46d4f3c43241f Jérôme Glisse      2018-12-28  3501  	mmu_notifier_invalidate_range_start(&range);
569f48b85813f05 Hillf Danton       2014-12-10  3502  	address = start;
569f48b85813f05 Hillf Danton       2014-12-10  3503  	for (; address < end; address += sz) {
7868a2087ec13ec Punit Agrawal      2017-07-06  3504  		ptep = huge_pte_offset(mm, address, sz);
c7546f8f03f5a4f David Gibson       2005-08-05  3505  		if (!ptep)
c7546f8f03f5a4f David Gibson       2005-08-05  3506  			continue;
c7546f8f03f5a4f David Gibson       2005-08-05  3507  
cb900f412154474 Kirill A. Shutemov 2013-11-14  3508  		ptl = huge_pte_lock(h, mm, ptep);
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3509  		if (huge_pmd_unshare(mm, &address, ptep)) {
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3510  			spin_unlock(ptl);
dff11abe280b47c Mike Kravetz       2018-10-05  3511  			/*
dff11abe280b47c Mike Kravetz       2018-10-05  3512  			 * We just unmapped a page of PMDs by clearing a PUD.
dff11abe280b47c Mike Kravetz       2018-10-05  3513  			 * The caller's TLB flush range should cover this area.
dff11abe280b47c Mike Kravetz       2018-10-05  3514  			 */
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3515  			continue;
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3516  		}
39dde65c9940c97 Kenneth W Chen     2006-12-06  3517  
6629326b89b6e69 Hillf Danton       2012-03-23  3518  		pte = huge_ptep_get(ptep);
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3519  		if (huge_pte_none(pte)) {
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3520  			spin_unlock(ptl);
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3521  			continue;
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3522  		}
6629326b89b6e69 Hillf Danton       2012-03-23  3523  
6629326b89b6e69 Hillf Danton       2012-03-23  3524  		/*
9fbc1f635fd0bd2 Naoya Horiguchi    2015-02-11  3525  		 * Migrating hugepage or HWPoisoned hugepage is already
9fbc1f635fd0bd2 Naoya Horiguchi    2015-02-11  3526  		 * unmapped and its refcount is dropped, so just clear pte here.
6629326b89b6e69 Hillf Danton       2012-03-23  3527  		 */
9fbc1f635fd0bd2 Naoya Horiguchi    2015-02-11  3528  		if (unlikely(!pte_present(pte))) {
9386fac34c7cbe3 Punit Agrawal      2017-07-06  3529  			huge_pte_clear(mm, address, ptep, sz);
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3530  			spin_unlock(ptl);
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3531  			continue;
8c4894c6bc790d0 Naoya Horiguchi    2012-12-12  3532  		}
6629326b89b6e69 Hillf Danton       2012-03-23  3533  
6629326b89b6e69 Hillf Danton       2012-03-23  3534  		page = pte_page(pte);
04f2cbe35699d22 Mel Gorman         2008-07-23  3535  		/*
04f2cbe35699d22 Mel Gorman         2008-07-23  3536  		 * If a reference page is supplied, it is because a specific
04f2cbe35699d22 Mel Gorman         2008-07-23  3537  		 * page is being unmapped, not a range. Ensure the page we
04f2cbe35699d22 Mel Gorman         2008-07-23  3538  		 * are about to unmap is the actual page of interest.
04f2cbe35699d22 Mel Gorman         2008-07-23  3539  		 */
04f2cbe35699d22 Mel Gorman         2008-07-23  3540  		if (ref_page) {
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3541  			if (page != ref_page) {
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3542  				spin_unlock(ptl);
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3543  				continue;
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3544  			}
04f2cbe35699d22 Mel Gorman         2008-07-23  3545  			/*
04f2cbe35699d22 Mel Gorman         2008-07-23  3546  			 * Mark the VMA as having unmapped its page so that
04f2cbe35699d22 Mel Gorman         2008-07-23  3547  			 * future faults in this VMA will fail rather than
04f2cbe35699d22 Mel Gorman         2008-07-23  3548  			 * looking like data was lost
04f2cbe35699d22 Mel Gorman         2008-07-23  3549  			 */
04f2cbe35699d22 Mel Gorman         2008-07-23  3550  			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
04f2cbe35699d22 Mel Gorman         2008-07-23  3551  		}
04f2cbe35699d22 Mel Gorman         2008-07-23  3552  
c7546f8f03f5a4f David Gibson       2005-08-05  3553  		pte = huge_ptep_get_and_clear(mm, address, ptep);
b528e4b6405b9fd Aneesh Kumar K.V   2016-12-12 @3554  		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
106c992a5ebef28 Gerald Schaefer    2013-04-29  3555  		if (huge_pte_dirty(pte))
6649a3863232eb2 Ken Chen           2007-02-08  3556  			set_page_dirty(page);
9e81130b7ce2305 Hillf Danton       2012-03-21  3557  
5d317b2b6536592 Naoya Horiguchi    2015-11-05  3558  		hugetlb_count_sub(pages_per_huge_page(h), mm);
d281ee614518359 Kirill A. Shutemov 2016-01-15 @3559  		page_remove_rmap(page, true);
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3560  
cb900f412154474 Kirill A. Shutemov 2013-11-14  3561  		spin_unlock(ptl);
e77b0852b551ffd Aneesh Kumar K.V   2016-07-26 @3562  		tlb_remove_page_size(tlb, page, huge_page_size(h));
24669e58477e275 Aneesh Kumar K.V   2012-07-31  3563  		/*
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3564  		 * Bail out after unmapping reference page if supplied
24669e58477e275 Aneesh Kumar K.V   2012-07-31  3565  		 */
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3566  		if (ref_page)
31d49da5ad01728 Aneesh Kumar K.V   2016-07-26  3567  			break;
fe1668ae5bf0145 Kenneth W Chen     2006-10-04  3568  	}
ac46d4f3c43241f Jérôme Glisse      2018-12-28  3569  	mmu_notifier_invalidate_range_end(&range);
24669e58477e275 Aneesh Kumar K.V   2012-07-31 @3570  	tlb_end_vma(tlb, vma);
^1da177e4c3f415 Linus Torvalds     2005-04-16  3571  }
63551ae0feaaa23 David Gibson       2005-06-21  3572  
d833352a4338dc3 Mel Gorman         2012-07-31  3573  void __unmap_hugepage_range_final(struct mmu_gather *tlb,
d833352a4338dc3 Mel Gorman         2012-07-31  3574  			  struct vm_area_struct *vma, unsigned long start,
d833352a4338dc3 Mel Gorman         2012-07-31  3575  			  unsigned long end, struct page *ref_page)
d833352a4338dc3 Mel Gorman         2012-07-31  3576  {
d833352a4338dc3 Mel Gorman         2012-07-31  3577  	__unmap_hugepage_range(tlb, vma, start, end, ref_page);
d833352a4338dc3 Mel Gorman         2012-07-31  3578  
d833352a4338dc3 Mel Gorman         2012-07-31  3579  	/*
d833352a4338dc3 Mel Gorman         2012-07-31  3580  	 * Clear this flag so that x86's huge_pmd_share page_table_shareable
d833352a4338dc3 Mel Gorman         2012-07-31  3581  	 * test will fail on a vma being torn down, and not grab a page table
d833352a4338dc3 Mel Gorman         2012-07-31  3582  	 * on its way out.  We're lucky that the flag has such an appropriate
d833352a4338dc3 Mel Gorman         2012-07-31  3583  	 * name, and can in fact be safely cleared here. We could clear it
d833352a4338dc3 Mel Gorman         2012-07-31  3584  	 * before the __unmap_hugepage_range above, but all that's necessary
c8c06efa8b55260 Davidlohr Bueso    2014-12-12  3585  	 * is to clear it before releasing the i_mmap_rwsem. This works
d833352a4338dc3 Mel Gorman         2012-07-31  3586  	 * because in the context this is called, the VMA is about to be
c8c06efa8b55260 Davidlohr Bueso    2014-12-12  3587  	 * destroyed and the i_mmap_rwsem is held.
d833352a4338dc3 Mel Gorman         2012-07-31  3588  	 */
d833352a4338dc3 Mel Gorman         2012-07-31  3589  	vma->vm_flags &= ~VM_MAYSHARE;
d833352a4338dc3 Mel Gorman         2012-07-31  3590  }
d833352a4338dc3 Mel Gorman         2012-07-31  3591  
502717f4e112b18 Kenneth W Chen     2006-10-11  3592  void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
04f2cbe35699d22 Mel Gorman         2008-07-23  3593  			  unsigned long end, struct page *ref_page)
502717f4e112b18 Kenneth W Chen     2006-10-11  3594  {
24669e58477e275 Aneesh Kumar K.V   2012-07-31  3595  	struct mm_struct *mm;
24669e58477e275 Aneesh Kumar K.V   2012-07-31 @3596  	struct mmu_gather tlb;
dff11abe280b47c Mike Kravetz       2018-10-05  3597  	unsigned long tlb_start = start;
dff11abe280b47c Mike Kravetz       2018-10-05  3598  	unsigned long tlb_end = end;
dff11abe280b47c Mike Kravetz       2018-10-05  3599  
dff11abe280b47c Mike Kravetz       2018-10-05  3600  	/*
dff11abe280b47c Mike Kravetz       2018-10-05  3601  	 * If shared PMDs were possibly used within this vma range, adjust
dff11abe280b47c Mike Kravetz       2018-10-05  3602  	 * start/end for worst case tlb flushing.
dff11abe280b47c Mike Kravetz       2018-10-05  3603  	 * Note that we can not be sure if PMDs are shared until we try to
dff11abe280b47c Mike Kravetz       2018-10-05  3604  	 * unmap pages.  However, we want to make sure TLB flushing covers
dff11abe280b47c Mike Kravetz       2018-10-05  3605  	 * the largest possible range.
dff11abe280b47c Mike Kravetz       2018-10-05  3606  	 */
dff11abe280b47c Mike Kravetz       2018-10-05  3607  	adjust_range_if_pmd_sharing_possible(vma, &tlb_start, &tlb_end);
24669e58477e275 Aneesh Kumar K.V   2012-07-31  3608  
24669e58477e275 Aneesh Kumar K.V   2012-07-31  3609  	mm = vma->vm_mm;
24669e58477e275 Aneesh Kumar K.V   2012-07-31  3610  
dff11abe280b47c Mike Kravetz       2018-10-05  3611  	tlb_gather_mmu(&tlb, mm, tlb_start, tlb_end);
24669e58477e275 Aneesh Kumar K.V   2012-07-31  3612  	__unmap_hugepage_range(&tlb, vma, start, end, ref_page);
dff11abe280b47c Mike Kravetz       2018-10-05  3613  	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
502717f4e112b18 Kenneth W Chen     2006-10-11  3614  }
502717f4e112b18 Kenneth W Chen     2006-10-11  3615  

:::::: The code at line 3454 was first introduced by commit
:::::: 63551ae0feaaa23807ebea60de1901564bbef32e [PATCH] Hugepage consolidation

:::::: TO: David Gibson <david@gibson.dropbear.id.au>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
GJr/AwyXQxqwogEA

--HcAYCG3uE/tztfnV--
