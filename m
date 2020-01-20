Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC99C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2596E2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgATDQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 22:16:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:33839 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgATDQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:16:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 19:16:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,340,1574150400"; 
   d="gz'50?scan'50,208,50";a="426607543"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jan 2020 19:16:31 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1itNYE-000Bqm-QW; Mon, 20 Jan 2020 11:16:30 +0800
Date:   Mon, 20 Jan 2020 11:15:45 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>
Subject: include/asm-generic/hugetlb.h:7:9: error: incompatible types when
 returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
Message-ID: <202001201117.36MambYV%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vimlsrkax2jrrfx5"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vimlsrkax2jrrfx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christoph,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7008ee121089b8193aea918b98850fe87d996508
commit: 6bd33e1ece528f67646db33bf97406b747dafda0 riscv: add nommu support
date:   9 weeks ago
config: riscv-randconfig-a001-20200120 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6bd33e1ece528f67646db33bf97406b747dafda0
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/drm_gem.c: In function 'drm_gem_mmap_obj':
>> drivers/gpu/drm/drm_gem.c:1116:22: error: implicit declaration of function 'pgprot_writecombine' [-Werror=implicit-function-declaration]
     vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
                         ^~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/drm_gem.c:1116:20: error: incompatible types when assigning to type 'pgprot_t {aka struct <anonymous>}' from type 'int'
     vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
                       ^
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/vgem/vgem_drv.c: In function 'vgem_prime_vmap':
>> drivers/gpu/drm/vgem/vgem_drv.c:392:33: error: implicit declaration of function 'pgprot_writecombine' [-Werror=implicit-function-declaration]
     return vmap(pages, n_pages, 0, pgprot_writecombine(PAGE_KERNEL));
                                    ^~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/vgem/vgem_drv.c:392:33: error: incompatible type for argument 4 of 'vmap'
   In file included from include/asm-generic/io.h:887:0,
                    from arch/riscv/include/asm/io.h:148,
                    from include/linux/scatterlist.h:9,
                    from include/linux/dma-buf.h:18,
                    from drivers/gpu/drm/vgem/vgem_drv.c:33:
   include/linux/vmalloc.h:119:14: note: expected 'pgprot_t {aka struct <anonymous>}' but argument is of type 'int'
    extern void *vmap(struct page **pages, unsigned int count,
                 ^~~~
   drivers/gpu/drm/vgem/vgem_drv.c: In function 'vgem_prime_mmap':
>> drivers/gpu/drm/vgem/vgem_drv.c:421:20: error: incompatible types when assigning to type 'pgprot_t {aka struct <anonymous>}' from type 'int'
     vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
                       ^
   drivers/gpu/drm/vgem/vgem_drv.c: In function 'vgem_prime_vmap':
   drivers/gpu/drm/vgem/vgem_drv.c:393:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors
--
   In file included from arch/riscv/include/asm/hugetlb.h:5:0,
                    from include/linux/hugetlb.h:444,
                    from arch/riscv//mm/hugetlbpage.c:2:
   include/asm-generic/hugetlb.h: In function 'mk_huge_pte':
>> include/asm-generic/hugetlb.h:7:9: error: implicit declaration of function 'mk_pte'; did you mean '__pte'? [-Werror=implicit-function-declaration]
     return mk_pte(page, pgprot);
            ^~~~~~
            __pte
>> include/asm-generic/hugetlb.h:7:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return mk_pte(page, pgprot);
            ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_write':
>> include/asm-generic/hugetlb.h:12:9: error: implicit declaration of function 'pte_write'; did you mean 'pgd_write'? [-Werror=implicit-function-declaration]
     return pte_write(pte);
            ^~~~~~~~~
            pgd_write
   include/asm-generic/hugetlb.h: In function 'huge_pte_dirty':
>> include/asm-generic/hugetlb.h:17:9: error: implicit declaration of function 'pte_dirty'; did you mean 'info_dirty'? [-Werror=implicit-function-declaration]
     return pte_dirty(pte);
            ^~~~~~~~~
            info_dirty
   include/asm-generic/hugetlb.h: In function 'huge_pte_mkwrite':
>> include/asm-generic/hugetlb.h:22:9: error: implicit declaration of function 'pte_mkwrite'; did you mean 'pgd_write'? [-Werror=implicit-function-declaration]
     return pte_mkwrite(pte);
            ^~~~~~~~~~~
            pgd_write
   include/asm-generic/hugetlb.h:22:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_mkwrite(pte);
            ^~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_mkdirty':
>> include/asm-generic/hugetlb.h:27:9: error: implicit declaration of function 'pte_mkdirty'; did you mean 'huge_pte_mkdirty'? [-Werror=implicit-function-declaration]
     return pte_mkdirty(pte);
            ^~~~~~~~~~~
            huge_pte_mkdirty
   include/asm-generic/hugetlb.h:27:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_mkdirty(pte);
            ^~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_modify':
>> include/asm-generic/hugetlb.h:32:9: error: implicit declaration of function 'pte_modify'; did you mean 'lease_modify'? [-Werror=implicit-function-declaration]
     return pte_modify(pte, newprot);
            ^~~~~~~~~~
            lease_modify
   include/asm-generic/hugetlb.h:32:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_modify(pte, newprot);
            ^~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_clear':
>> include/asm-generic/hugetlb.h:39:2: error: implicit declaration of function 'pte_clear'; did you mean 'pud_clear'? [-Werror=implicit-function-declaration]
     pte_clear(mm, addr, ptep);
     ^~~~~~~~~
     pud_clear
   include/asm-generic/hugetlb.h: In function 'set_huge_pte_at':
>> include/asm-generic/hugetlb.h:56:2: error: implicit declaration of function 'set_pte_at'; did you mean 'set_huge_pte_at'? [-Werror=implicit-function-declaration]
     set_pte_at(mm, addr, ptep, pte);
     ^~~~~~~~~~
     set_huge_pte_at
   include/asm-generic/hugetlb.h: In function 'huge_ptep_get_and_clear':
>> include/asm-generic/hugetlb.h:64:9: error: implicit declaration of function 'ptep_get_and_clear'; did you mean 'huge_ptep_get_and_clear'? [-Werror=implicit-function-declaration]
     return ptep_get_and_clear(mm, addr, ptep);
            ^~~~~~~~~~~~~~~~~~
            huge_ptep_get_and_clear
   include/asm-generic/hugetlb.h:64:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return ptep_get_and_clear(mm, addr, ptep);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_ptep_clear_flush':
>> include/asm-generic/hugetlb.h:72:2: error: implicit declaration of function 'ptep_clear_flush'; did you mean 'huge_ptep_clear_flush'? [-Werror=implicit-function-declaration]
     ptep_clear_flush(vma, addr, ptep);
     ^~~~~~~~~~~~~~~~
     huge_ptep_clear_flush
   include/asm-generic/hugetlb.h: In function 'huge_pte_none':
>> include/asm-generic/hugetlb.h:79:9: error: implicit declaration of function 'pte_none'; did you mean 'pud_none'? [-Werror=implicit-function-declaration]
     return pte_none(pte);
            ^~~~~~~~
            pud_none
   include/asm-generic/hugetlb.h: In function 'huge_pte_wrprotect':
>> include/asm-generic/hugetlb.h:86:9: error: implicit declaration of function 'pte_wrprotect'; did you mean 'huge_pte_wrprotect'? [-Werror=implicit-function-declaration]
     return pte_wrprotect(pte);
            ^~~~~~~~~~~~~
            huge_pte_wrprotect
   include/asm-generic/hugetlb.h:86:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_wrprotect(pte);
            ^~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_ptep_set_wrprotect':
>> include/asm-generic/hugetlb.h:109:2: error: implicit declaration of function 'ptep_set_wrprotect'; did you mean 'huge_ptep_set_wrprotect'? [-Werror=implicit-function-declaration]
     ptep_set_wrprotect(mm, addr, ptep);
     ^~~~~~~~~~~~~~~~~~
     huge_ptep_set_wrprotect
   include/asm-generic/hugetlb.h: In function 'huge_ptep_set_access_flags':
>> include/asm-generic/hugetlb.h:118:9: error: implicit declaration of function 'ptep_set_access_flags'; did you mean 'huge_ptep_set_access_flags'? [-Werror=implicit-function-declaration]
     return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
            ^~~~~~~~~~~~~~~~~~~~~
            huge_ptep_set_access_flags
   arch/riscv//mm/hugetlbpage.c: In function 'pmd_huge':
>> arch/riscv//mm/hugetlbpage.c:13:9: error: implicit declaration of function 'pmd_present'; did you mean 'pud_present'? [-Werror=implicit-function-declaration]
     return pmd_present(pmd) &&
            ^~~~~~~~~~~
            pud_present
   cc1: some warnings being treated as errors
--
   In file included from arch/riscv/include/asm/hugetlb.h:5:0,
                    from include/linux/hugetlb.h:444,
                    from include/linux/migrate.h:8,
                    from fs//btrfs/disk-io.c:14:
   include/asm-generic/hugetlb.h: In function 'mk_huge_pte':
>> include/asm-generic/hugetlb.h:7:9: error: implicit declaration of function 'mk_pte'; did you mean '__pte'? [-Werror=implicit-function-declaration]
     return mk_pte(page, pgprot);
            ^~~~~~
            __pte
>> include/asm-generic/hugetlb.h:7:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return mk_pte(page, pgprot);
            ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_write':
>> include/asm-generic/hugetlb.h:12:9: error: implicit declaration of function 'pte_write'; did you mean 'pgd_write'? [-Werror=implicit-function-declaration]
     return pte_write(pte);
            ^~~~~~~~~
            pgd_write
   include/asm-generic/hugetlb.h: In function 'huge_pte_dirty':
>> include/asm-generic/hugetlb.h:17:9: error: implicit declaration of function 'pte_dirty'; did you mean 'info_dirty'? [-Werror=implicit-function-declaration]
     return pte_dirty(pte);
            ^~~~~~~~~
            info_dirty
   include/asm-generic/hugetlb.h: In function 'huge_pte_mkwrite':
>> include/asm-generic/hugetlb.h:22:9: error: implicit declaration of function 'pte_mkwrite'; did you mean 'pgd_write'? [-Werror=implicit-function-declaration]
     return pte_mkwrite(pte);
            ^~~~~~~~~~~
            pgd_write
   include/asm-generic/hugetlb.h:22:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_mkwrite(pte);
            ^~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_mkdirty':
>> include/asm-generic/hugetlb.h:27:9: error: implicit declaration of function 'pte_mkdirty'; did you mean 'huge_pte_mkdirty'? [-Werror=implicit-function-declaration]
     return pte_mkdirty(pte);
            ^~~~~~~~~~~
            huge_pte_mkdirty
   include/asm-generic/hugetlb.h:27:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_mkdirty(pte);
            ^~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_modify':
>> include/asm-generic/hugetlb.h:32:9: error: implicit declaration of function 'pte_modify'; did you mean 'lease_modify'? [-Werror=implicit-function-declaration]
     return pte_modify(pte, newprot);
            ^~~~~~~~~~
            lease_modify
   include/asm-generic/hugetlb.h:32:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_modify(pte, newprot);
            ^~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_pte_clear':
>> include/asm-generic/hugetlb.h:39:2: error: implicit declaration of function 'pte_clear'; did you mean 'pud_clear'? [-Werror=implicit-function-declaration]
     pte_clear(mm, addr, ptep);
     ^~~~~~~~~
     pud_clear
   include/asm-generic/hugetlb.h: In function 'set_huge_pte_at':
>> include/asm-generic/hugetlb.h:56:2: error: implicit declaration of function 'set_pte_at'; did you mean 'set_huge_pte_at'? [-Werror=implicit-function-declaration]
     set_pte_at(mm, addr, ptep, pte);
     ^~~~~~~~~~
     set_huge_pte_at
   include/asm-generic/hugetlb.h: In function 'huge_ptep_get_and_clear':
>> include/asm-generic/hugetlb.h:64:9: error: implicit declaration of function 'ptep_get_and_clear'; did you mean 'huge_ptep_get_and_clear'? [-Werror=implicit-function-declaration]
     return ptep_get_and_clear(mm, addr, ptep);
            ^~~~~~~~~~~~~~~~~~
            huge_ptep_get_and_clear
   include/asm-generic/hugetlb.h:64:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return ptep_get_and_clear(mm, addr, ptep);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_ptep_clear_flush':
>> include/asm-generic/hugetlb.h:72:2: error: implicit declaration of function 'ptep_clear_flush'; did you mean 'huge_ptep_clear_flush'? [-Werror=implicit-function-declaration]
     ptep_clear_flush(vma, addr, ptep);
     ^~~~~~~~~~~~~~~~
     huge_ptep_clear_flush
   include/asm-generic/hugetlb.h: In function 'huge_pte_none':
>> include/asm-generic/hugetlb.h:79:9: error: implicit declaration of function 'pte_none'; did you mean 'pud_none'? [-Werror=implicit-function-declaration]
     return pte_none(pte);
            ^~~~~~~~
            pud_none
   include/asm-generic/hugetlb.h: In function 'huge_pte_wrprotect':
>> include/asm-generic/hugetlb.h:86:9: error: implicit declaration of function 'pte_wrprotect'; did you mean 'huge_pte_wrprotect'? [-Werror=implicit-function-declaration]
     return pte_wrprotect(pte);
            ^~~~~~~~~~~~~
            huge_pte_wrprotect
   include/asm-generic/hugetlb.h:86:9: error: incompatible types when returning type 'int' but 'pte_t {aka struct <anonymous>}' was expected
     return pte_wrprotect(pte);
            ^~~~~~~~~~~~~~~~~~
   include/asm-generic/hugetlb.h: In function 'huge_ptep_set_wrprotect':
>> include/asm-generic/hugetlb.h:109:2: error: implicit declaration of function 'ptep_set_wrprotect'; did you mean 'huge_ptep_set_wrprotect'? [-Werror=implicit-function-declaration]
     ptep_set_wrprotect(mm, addr, ptep);
     ^~~~~~~~~~~~~~~~~~
     huge_ptep_set_wrprotect
   include/asm-generic/hugetlb.h: In function 'huge_ptep_set_access_flags':
>> include/asm-generic/hugetlb.h:118:9: error: implicit declaration of function 'ptep_set_access_flags'; did you mean 'huge_ptep_set_access_flags'? [-Werror=implicit-function-declaration]
     return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
            ^~~~~~~~~~~~~~~~~~~~~
            huge_ptep_set_access_flags
   cc1: some warnings being treated as errors
--
   fs//pstore/ram_core.c: In function 'persistent_ram_vmap':
>> fs//pstore/ram_core.c:417:10: error: implicit declaration of function 'pgprot_writecombine' [-Werror=implicit-function-declaration]
      prot = pgprot_writecombine(PAGE_KERNEL);
             ^~~~~~~~~~~~~~~~~~~
>> fs//pstore/ram_core.c:417:8: error: incompatible types when assigning to type 'pgprot_t {aka struct <anonymous>}' from type 'int'
      prot = pgprot_writecombine(PAGE_KERNEL);
           ^
   cc1: some warnings being treated as errors

vim +7 include/asm-generic/hugetlb.h

106c992a5ebef2 Gerald Schaefer 2013-04-29    4  
106c992a5ebef2 Gerald Schaefer 2013-04-29    5  static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
106c992a5ebef2 Gerald Schaefer 2013-04-29    6  {
106c992a5ebef2 Gerald Schaefer 2013-04-29   @7  	return mk_pte(page, pgprot);
106c992a5ebef2 Gerald Schaefer 2013-04-29    8  }
106c992a5ebef2 Gerald Schaefer 2013-04-29    9  
26794942461f43 David Miller    2013-10-02   10  static inline unsigned long huge_pte_write(pte_t pte)
106c992a5ebef2 Gerald Schaefer 2013-04-29   11  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @12  	return pte_write(pte);
106c992a5ebef2 Gerald Schaefer 2013-04-29   13  }
106c992a5ebef2 Gerald Schaefer 2013-04-29   14  
26794942461f43 David Miller    2013-10-02   15  static inline unsigned long huge_pte_dirty(pte_t pte)
106c992a5ebef2 Gerald Schaefer 2013-04-29   16  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @17  	return pte_dirty(pte);
106c992a5ebef2 Gerald Schaefer 2013-04-29   18  }
106c992a5ebef2 Gerald Schaefer 2013-04-29   19  
106c992a5ebef2 Gerald Schaefer 2013-04-29   20  static inline pte_t huge_pte_mkwrite(pte_t pte)
106c992a5ebef2 Gerald Schaefer 2013-04-29   21  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @22  	return pte_mkwrite(pte);
106c992a5ebef2 Gerald Schaefer 2013-04-29   23  }
106c992a5ebef2 Gerald Schaefer 2013-04-29   24  
106c992a5ebef2 Gerald Schaefer 2013-04-29   25  static inline pte_t huge_pte_mkdirty(pte_t pte)
106c992a5ebef2 Gerald Schaefer 2013-04-29   26  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @27  	return pte_mkdirty(pte);
106c992a5ebef2 Gerald Schaefer 2013-04-29   28  }
106c992a5ebef2 Gerald Schaefer 2013-04-29   29  
106c992a5ebef2 Gerald Schaefer 2013-04-29   30  static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
106c992a5ebef2 Gerald Schaefer 2013-04-29   31  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @32  	return pte_modify(pte, newprot);
106c992a5ebef2 Gerald Schaefer 2013-04-29   33  }
106c992a5ebef2 Gerald Schaefer 2013-04-29   34  
d018498ccc9277 Alexandre Ghiti 2018-10-26   35  #ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
106c992a5ebef2 Gerald Schaefer 2013-04-29   36  static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
9386fac34c7cbe Punit Agrawal   2017-07-06   37  		    pte_t *ptep, unsigned long sz)
106c992a5ebef2 Gerald Schaefer 2013-04-29   38  {
106c992a5ebef2 Gerald Schaefer 2013-04-29  @39  	pte_clear(mm, addr, ptep);
106c992a5ebef2 Gerald Schaefer 2013-04-29   40  }
9386fac34c7cbe Punit Agrawal   2017-07-06   41  #endif
106c992a5ebef2 Gerald Schaefer 2013-04-29   42  
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   43  #ifndef __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   44  static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   45  		unsigned long addr, unsigned long end,
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   46  		unsigned long floor, unsigned long ceiling)
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   47  {
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   48  	free_pgd_range(tlb, addr, end, floor, ceiling);
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   49  }
cea685d556330b Alexandre Ghiti 2018-10-26   50  #endif
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   51  
cea685d556330b Alexandre Ghiti 2018-10-26   52  #ifndef __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
cea685d556330b Alexandre Ghiti 2018-10-26   53  static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
cea685d556330b Alexandre Ghiti 2018-10-26   54  		pte_t *ptep, pte_t pte)
cea685d556330b Alexandre Ghiti 2018-10-26   55  {
cea685d556330b Alexandre Ghiti 2018-10-26  @56  	set_pte_at(mm, addr, ptep, pte);
cea685d556330b Alexandre Ghiti 2018-10-26   57  }
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   58  #endif
1e5f50fc9d0a65 Alexandre Ghiti 2018-10-26   59  
a4d838536c6e5c Alexandre Ghiti 2018-10-26   60  #ifndef __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
a4d838536c6e5c Alexandre Ghiti 2018-10-26   61  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
a4d838536c6e5c Alexandre Ghiti 2018-10-26   62  		unsigned long addr, pte_t *ptep)
a4d838536c6e5c Alexandre Ghiti 2018-10-26   63  {
a4d838536c6e5c Alexandre Ghiti 2018-10-26  @64  	return ptep_get_and_clear(mm, addr, ptep);
a4d838536c6e5c Alexandre Ghiti 2018-10-26   65  }
a4d838536c6e5c Alexandre Ghiti 2018-10-26   66  #endif
a4d838536c6e5c Alexandre Ghiti 2018-10-26   67  
fe632225bdbd49 Alexandre Ghiti 2018-10-26   68  #ifndef __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
fe632225bdbd49 Alexandre Ghiti 2018-10-26   69  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
fe632225bdbd49 Alexandre Ghiti 2018-10-26   70  		unsigned long addr, pte_t *ptep)
fe632225bdbd49 Alexandre Ghiti 2018-10-26   71  {
fe632225bdbd49 Alexandre Ghiti 2018-10-26  @72  	ptep_clear_flush(vma, addr, ptep);
fe632225bdbd49 Alexandre Ghiti 2018-10-26   73  }
fe632225bdbd49 Alexandre Ghiti 2018-10-26   74  #endif
fe632225bdbd49 Alexandre Ghiti 2018-10-26   75  
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   76  #ifndef __HAVE_ARCH_HUGE_PTE_NONE
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   77  static inline int huge_pte_none(pte_t pte)
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   78  {
cae72abc1af0c1 Alexandre Ghiti 2018-10-26  @79  	return pte_none(pte);
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   80  }
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   81  #endif
cae72abc1af0c1 Alexandre Ghiti 2018-10-26   82  
c4916a008665a6 Alexandre Ghiti 2018-10-26   83  #ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
c4916a008665a6 Alexandre Ghiti 2018-10-26   84  static inline pte_t huge_pte_wrprotect(pte_t pte)
c4916a008665a6 Alexandre Ghiti 2018-10-26   85  {
c4916a008665a6 Alexandre Ghiti 2018-10-26  @86  	return pte_wrprotect(pte);
c4916a008665a6 Alexandre Ghiti 2018-10-26   87  }
c4916a008665a6 Alexandre Ghiti 2018-10-26   88  #endif
c4916a008665a6 Alexandre Ghiti 2018-10-26   89  
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   90  #ifndef __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   91  static inline int prepare_hugepage_range(struct file *file,
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   92  		unsigned long addr, unsigned long len)
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   93  {
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   94  	struct hstate *h = hstate_file(file);
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   95  
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   96  	if (len & ~huge_page_mask(h))
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   97  		return -EINVAL;
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   98  	if (addr & ~huge_page_mask(h))
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26   99  		return -EINVAL;
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  100  
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  101  	return 0;
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  102  }
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  103  #endif
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  104  
8e581d433bf796 Alexandre Ghiti 2018-10-26  105  #ifndef __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
8e581d433bf796 Alexandre Ghiti 2018-10-26  106  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
8e581d433bf796 Alexandre Ghiti 2018-10-26  107  		unsigned long addr, pte_t *ptep)
8e581d433bf796 Alexandre Ghiti 2018-10-26  108  {
8e581d433bf796 Alexandre Ghiti 2018-10-26 @109  	ptep_set_wrprotect(mm, addr, ptep);
8e581d433bf796 Alexandre Ghiti 2018-10-26  110  }
8e581d433bf796 Alexandre Ghiti 2018-10-26  111  #endif
8e581d433bf796 Alexandre Ghiti 2018-10-26  112  
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  113  #ifndef __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  114  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  115  		unsigned long addr, pte_t *ptep,
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  116  		pte_t pte, int dirty)
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  117  {
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26 @118  	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  119  }
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  120  #endif
facf6d5b8b6c42 Alexandre Ghiti 2018-10-26  121  

:::::: The code at line 7 was first introduced by commit
:::::: 106c992a5ebef28193cf5958e49ceff5e4aebb04 mm/hugetlb: add more arch-defined huge_pte functions

:::::: TO: Gerald Schaefer <gerald.schaefer@de.ibm.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--vimlsrkax2jrrfx5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
wuiwEKGP6QReTGmVDv0HDg/MqZzhAQA=

--vimlsrkax2jrrfx5--
