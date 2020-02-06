Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16F5C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8C220720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 21:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgBFVEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 16:04:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:62294 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbgBFVEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:04:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 13:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,411,1574150400"; 
   d="gz'50?scan'50,208,50";a="250187326"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2020 13:04:30 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izoK6-000F8x-BN; Fri, 07 Feb 2020 05:04:30 +0800
Date:   Fri, 7 Feb 2020 05:04:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>
Subject: drivers//staging/comedi/comedi_fops.c:2380:8: error: 'PAGE_SHARED'
 undeclared; did you mean 'PAGE_SIZE'?
Message-ID: <202002070502.6Rg3orkS%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zmxy6vhjo7u3bajm"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zmxy6vhjo7u3bajm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90568ecf561540fa330511e21fcd823b0c3829c6
commit: 6bd33e1ece528f67646db33bf97406b747dafda0 riscv: add nommu support
date:   3 months ago
config: riscv-randconfig-a001-20200207 (attached as .config)
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

   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:112:30: note: in expansion of macro 'pfn_to_page'
    #define virt_to_page(vaddr) (pfn_to_page(virt_to_pfn(vaddr)))
                                 ^~~~~~~~~~~
   include/linux/scatterlist.h:145:18: note: in expansion of macro 'virt_to_page'
     sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
                     ^~~~~~~~~~~~
   In file included from arch/riscv/include/asm/page.h:12:0,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/pagemap.h:8,
                    from fs//cifs/smb2ops.c:8:
   include/linux/scatterlist.h: In function 'sg_phys':
   include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
                                                         ^
   include/linux/pfn.h:21:36: note: in definition of macro 'PFN_PHYS'
    #define PFN_PHYS(x) ((phys_addr_t)(x) << PAGE_SHIFT)
                                       ^
   arch/riscv/include/asm/page.h:115:29: note: in expansion of macro 'pfn_to_phys'
    #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
                                ^~~~~~~~~~~
   include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
    #define page_to_pfn __page_to_pfn
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:115:41: note: in expansion of macro 'page_to_pfn'
    #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
                                            ^~~~~~~~~~~
   include/linux/scatterlist.h:224:9: note: in expansion of macro 'page_to_phys'
     return page_to_phys(sg_page(sg)) + sg->offset;
            ^~~~~~~~~~~~
   In file included from arch/riscv/include/asm/page.h:131:0,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/pagemap.h:8,
                    from fs//cifs/smb2ops.c:8:
   include/linux/scatterlist.h: In function 'sg_page_iter_page':
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                ^
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   include/linux/mm.h:213:26: note: in expansion of macro 'pfn_to_page'
    #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
                             ^~~~~~~~~~~
   include/linux/scatterlist.h:384:9: note: in expansion of macro 'nth_page'
     return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
            ^~~~~~~~
   include/linux/dma-mapping.h: In function 'dma_map_single_attrs':
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                ^
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:112:30: note: in expansion of macro 'pfn_to_page'
    #define virt_to_page(vaddr) (pfn_to_page(virt_to_pfn(vaddr)))
                                 ^~~~~~~~~~~
   include/linux/dma-mapping.h:587:33: note: in expansion of macro 'virt_to_page'
     return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
                                    ^~~~~~~~~~~~
   In file included from arch/riscv/include/asm/page.h:131:0,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/pagemap.h:8,
                    from fs//cifs/smb2ops.c:8:
   fs//cifs/smb2ops.c: In function 'smb2_sg_set_buf':
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                ^
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:112:30: note: in expansion of macro 'pfn_to_page'
    #define virt_to_page(vaddr) (pfn_to_page(virt_to_pfn(vaddr)))
                                 ^~~~~~~~~~~
>> fs//cifs/smb2ops.c:3542:10: note: in expansion of macro 'virt_to_page'
      addr = virt_to_page(buf);
             ^~~~~~~~~~~~
   In file included from include/linux/pagemap.h:8:0,
                    from fs//cifs/smb2ops.c:8:
   include/linux/mm.h: In function 'lowmem_page_address':
   include/linux/mm.h:1322:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
--
                    from include/linux/module.h:10,
                    from drivers//staging/comedi/comedi_fops.c:14:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                ^
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:112:30: note: in expansion of macro 'pfn_to_page'
    #define virt_to_page(vaddr) (pfn_to_page(virt_to_pfn(vaddr)))
                                 ^~~~~~~~~~~
   include/linux/scatterlist.h:145:18: note: in expansion of macro 'virt_to_page'
     sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
                     ^~~~~~~~~~~~
   In file included from arch/riscv/include/asm/page.h:12:0,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from drivers//staging/comedi/comedi_fops.c:14:
   include/linux/scatterlist.h: In function 'sg_phys':
   include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
                                                         ^
   include/linux/pfn.h:21:36: note: in definition of macro 'PFN_PHYS'
    #define PFN_PHYS(x) ((phys_addr_t)(x) << PAGE_SHIFT)
                                       ^
   arch/riscv/include/asm/page.h:115:29: note: in expansion of macro 'pfn_to_phys'
    #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
                                ^~~~~~~~~~~
   include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
    #define page_to_pfn __page_to_pfn
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:115:41: note: in expansion of macro 'page_to_pfn'
    #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
                                            ^~~~~~~~~~~
   include/linux/scatterlist.h:224:9: note: in expansion of macro 'page_to_phys'
     return page_to_phys(sg_page(sg)) + sg->offset;
            ^~~~~~~~~~~~
   In file included from arch/riscv/include/asm/page.h:131:0,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from drivers//staging/comedi/comedi_fops.c:14:
   include/linux/scatterlist.h: In function 'sg_page_iter_page':
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                ^
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   include/linux/mm.h:213:26: note: in expansion of macro 'pfn_to_page'
    #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
                             ^~~~~~~~~~~
   include/linux/scatterlist.h:384:9: note: in expansion of macro 'nth_page'
     return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
            ^~~~~~~~
   include/linux/dma-mapping.h: In function 'dma_map_single_attrs':
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                ^
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:112:30: note: in expansion of macro 'pfn_to_page'
    #define virt_to_page(vaddr) (pfn_to_page(virt_to_pfn(vaddr)))
                                 ^~~~~~~~~~~
   include/linux/dma-mapping.h:587:33: note: in expansion of macro 'virt_to_page'
     return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
                                    ^~~~~~~~~~~~
   drivers//staging/comedi/comedi_fops.c: In function 'comedi_mmap':
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                ^
   include/asm-generic/memory_model.h:55:46: note: in definition of macro '__page_to_pfn'
    #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
                                                 ^~~~
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:112:30: note: in expansion of macro 'pfn_to_page'
    #define virt_to_page(vaddr) (pfn_to_page(virt_to_pfn(vaddr)))
                                 ^~~~~~~~~~~
   drivers//staging/comedi/comedi_fops.c:2378:22: note: in expansion of macro 'virt_to_page'
       pfn = page_to_pfn(virt_to_page(buf->virt_addr));
                         ^~~~~~~~~~~~
>> drivers//staging/comedi/comedi_fops.c:2380:8: error: 'PAGE_SHARED' undeclared (first use in this function); did you mean 'PAGE_SIZE'?
           PAGE_SHARED);
           ^~~~~~~~~~~
           PAGE_SIZE
--
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                ^
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:112:30: note: in expansion of macro 'pfn_to_page'
    #define virt_to_page(vaddr) (pfn_to_page(virt_to_pfn(vaddr)))
                                 ^~~~~~~~~~~
   include/linux/scatterlist.h:145:18: note: in expansion of macro 'virt_to_page'
     sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
                     ^~~~~~~~~~~~
   In file included from arch/riscv/include/asm/page.h:12:0,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from net//sunrpc/xprtsock.c:24:
   include/linux/scatterlist.h: In function 'sg_phys':
   include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
                                                         ^
   include/linux/pfn.h:21:36: note: in definition of macro 'PFN_PHYS'
    #define PFN_PHYS(x) ((phys_addr_t)(x) << PAGE_SHIFT)
                                       ^
   arch/riscv/include/asm/page.h:115:29: note: in expansion of macro 'pfn_to_phys'
    #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
                                ^~~~~~~~~~~
   include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
    #define page_to_pfn __page_to_pfn
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:115:41: note: in expansion of macro 'page_to_pfn'
    #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
                                            ^~~~~~~~~~~
   include/linux/scatterlist.h:224:9: note: in expansion of macro 'page_to_phys'
     return page_to_phys(sg_page(sg)) + sg->offset;
            ^~~~~~~~~~~~
   In file included from arch/riscv/include/asm/page.h:131:0,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from net//sunrpc/xprtsock.c:24:
   include/linux/scatterlist.h: In function 'sg_page_iter_page':
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                ^
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   include/linux/mm.h:213:26: note: in expansion of macro 'pfn_to_page'
    #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
                             ^~~~~~~~~~~
   include/linux/scatterlist.h:384:9: note: in expansion of macro 'nth_page'
     return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
            ^~~~~~~~
   include/linux/dma-mapping.h: In function 'dma_map_single_attrs':
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                ^
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:112:30: note: in expansion of macro 'pfn_to_page'
    #define virt_to_page(vaddr) (pfn_to_page(virt_to_pfn(vaddr)))
                                 ^~~~~~~~~~~
   include/linux/dma-mapping.h:587:33: note: in expansion of macro 'virt_to_page'
     return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
                                    ^~~~~~~~~~~~
   In file included from arch/riscv/include/asm/page.h:131:0,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from net//sunrpc/xprtsock.c:24:
   net//sunrpc/xprtsock.c: In function 'bc_sendto':
   include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                ^
   include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
    #define pfn_to_page __pfn_to_page
                        ^~~~~~~~~~~~~
   arch/riscv/include/asm/page.h:112:30: note: in expansion of macro 'pfn_to_page'
    #define virt_to_page(vaddr) (pfn_to_page(virt_to_pfn(vaddr)))
                                 ^~~~~~~~~~~
>> net//sunrpc/xprtsock.c:2668:14: note: in expansion of macro 'virt_to_page'
      tailpage = virt_to_page(xbufp->tail[0].iov_base);
                 ^~~~~~~~~~~~
   In file included from include/linux/pagemap.h:8:0,
                    from net//sunrpc/xprtsock.c:27:
   include/linux/mm.h: In function 'lowmem_page_address':
   include/linux/mm.h:1322:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
..

vim +2380 drivers//staging/comedi/comedi_fops.c

ed9eccbe8970f6 David Schleef      2008-11-04  2296  
ed9eccbe8970f6 David Schleef      2008-11-04  2297  static int comedi_mmap(struct file *file, struct vm_area_struct *vma)
ed9eccbe8970f6 David Schleef      2008-11-04  2298  {
20f083c07565cb Ian Abbott         2014-11-04  2299  	struct comedi_file *cfp = file->private_data;
20f083c07565cb Ian Abbott         2014-11-04  2300  	struct comedi_device *dev = cfp->dev;
a52840a98bbb50 H Hartley Sweeten  2012-12-19  2301  	struct comedi_subdevice *s;
a52840a98bbb50 H Hartley Sweeten  2012-12-19  2302  	struct comedi_async *async;
b34aa86f12e884 Ian Abbott         2014-04-10  2303  	struct comedi_buf_map *bm = NULL;
e36472145aa706 Ian Abbott         2019-06-25  2304  	struct comedi_buf_page *buf;
ed9eccbe8970f6 David Schleef      2008-11-04  2305  	unsigned long start = vma->vm_start;
ed9eccbe8970f6 David Schleef      2008-11-04  2306  	unsigned long size;
ed9eccbe8970f6 David Schleef      2008-11-04  2307  	int n_pages;
ed9eccbe8970f6 David Schleef      2008-11-04  2308  	int i;
e36472145aa706 Ian Abbott         2019-06-25  2309  	int retval = 0;
3ffab428f40849 Bernd Porr         2011-11-08  2310  
b34aa86f12e884 Ian Abbott         2014-04-10  2311  	/*
b34aa86f12e884 Ian Abbott         2014-04-10  2312  	 * 'trylock' avoids circular dependency with current->mm->mmap_sem
b34aa86f12e884 Ian Abbott         2014-04-10  2313  	 * and down-reading &dev->attach_lock should normally succeed without
b34aa86f12e884 Ian Abbott         2014-04-10  2314  	 * contention unless the device is in the process of being attached
b34aa86f12e884 Ian Abbott         2014-04-10  2315  	 * or detached.
b34aa86f12e884 Ian Abbott         2014-04-10  2316  	 */
b34aa86f12e884 Ian Abbott         2014-04-10  2317  	if (!down_read_trylock(&dev->attach_lock))
b34aa86f12e884 Ian Abbott         2014-04-10  2318  		return -EAGAIN;
a52840a98bbb50 H Hartley Sweeten  2012-12-19  2319  
ed9eccbe8970f6 David Schleef      2008-11-04  2320  	if (!dev->attached) {
272850f07c47ab H Hartley Sweeten  2013-11-26  2321  		dev_dbg(dev->class_dev, "no driver attached\n");
ed9eccbe8970f6 David Schleef      2008-11-04  2322  		retval = -ENODEV;
ed9eccbe8970f6 David Schleef      2008-11-04  2323  		goto done;
ed9eccbe8970f6 David Schleef      2008-11-04  2324  	}
a52840a98bbb50 H Hartley Sweeten  2012-12-19  2325  
476b847733636c Greg Kroah-Hartman 2008-11-13  2326  	if (vma->vm_flags & VM_WRITE)
20f083c07565cb Ian Abbott         2014-11-04  2327  		s = comedi_file_write_subdevice(file);
476b847733636c Greg Kroah-Hartman 2008-11-13  2328  	else
20f083c07565cb Ian Abbott         2014-11-04  2329  		s = comedi_file_read_subdevice(file);
a52840a98bbb50 H Hartley Sweeten  2012-12-19  2330  	if (!s) {
ed9eccbe8970f6 David Schleef      2008-11-04  2331  		retval = -EINVAL;
ed9eccbe8970f6 David Schleef      2008-11-04  2332  		goto done;
ed9eccbe8970f6 David Schleef      2008-11-04  2333  	}
a52840a98bbb50 H Hartley Sweeten  2012-12-19  2334  
ed9eccbe8970f6 David Schleef      2008-11-04  2335  	async = s->async;
a52840a98bbb50 H Hartley Sweeten  2012-12-19  2336  	if (!async) {
ed9eccbe8970f6 David Schleef      2008-11-04  2337  		retval = -EINVAL;
ed9eccbe8970f6 David Schleef      2008-11-04  2338  		goto done;
ed9eccbe8970f6 David Schleef      2008-11-04  2339  	}
ed9eccbe8970f6 David Schleef      2008-11-04  2340  
ed9eccbe8970f6 David Schleef      2008-11-04  2341  	if (vma->vm_pgoff != 0) {
272850f07c47ab H Hartley Sweeten  2013-11-26  2342  		dev_dbg(dev->class_dev, "mmap() offset must be 0.\n");
ed9eccbe8970f6 David Schleef      2008-11-04  2343  		retval = -EINVAL;
ed9eccbe8970f6 David Schleef      2008-11-04  2344  		goto done;
ed9eccbe8970f6 David Schleef      2008-11-04  2345  	}
ed9eccbe8970f6 David Schleef      2008-11-04  2346  
ed9eccbe8970f6 David Schleef      2008-11-04  2347  	size = vma->vm_end - vma->vm_start;
ed9eccbe8970f6 David Schleef      2008-11-04  2348  	if (size > async->prealloc_bufsz) {
ed9eccbe8970f6 David Schleef      2008-11-04  2349  		retval = -EFAULT;
ed9eccbe8970f6 David Schleef      2008-11-04  2350  		goto done;
ed9eccbe8970f6 David Schleef      2008-11-04  2351  	}
44b8c793fc0d63 Sandhya Bankar     2016-03-06  2352  	if (offset_in_page(size)) {
ed9eccbe8970f6 David Schleef      2008-11-04  2353  		retval = -EFAULT;
ed9eccbe8970f6 David Schleef      2008-11-04  2354  		goto done;
ed9eccbe8970f6 David Schleef      2008-11-04  2355  	}
ed9eccbe8970f6 David Schleef      2008-11-04  2356  
ec9d0754e0c640 sayli karnik       2016-09-20  2357  	n_pages = vma_pages(vma);
b34aa86f12e884 Ian Abbott         2014-04-10  2358  
b34aa86f12e884 Ian Abbott         2014-04-10  2359  	/* get reference to current buf map (if any) */
b34aa86f12e884 Ian Abbott         2014-04-10  2360  	bm = comedi_buf_map_from_subdev_get(s);
af93da31634d6d Ian Abbott         2013-11-08  2361  	if (!bm || n_pages > bm->n_pages) {
af93da31634d6d Ian Abbott         2013-11-08  2362  		retval = -EINVAL;
af93da31634d6d Ian Abbott         2013-11-08  2363  		goto done;
af93da31634d6d Ian Abbott         2013-11-08  2364  	}
e36472145aa706 Ian Abbott         2019-06-25  2365  	if (bm->dma_dir != DMA_NONE) {
e36472145aa706 Ian Abbott         2019-06-25  2366  		/*
e36472145aa706 Ian Abbott         2019-06-25  2367  		 * DMA buffer was allocated as a single block.
e36472145aa706 Ian Abbott         2019-06-25  2368  		 * Address is in page_list[0].
e36472145aa706 Ian Abbott         2019-06-25  2369  		 */
e36472145aa706 Ian Abbott         2019-06-25  2370  		buf = &bm->page_list[0];
e36472145aa706 Ian Abbott         2019-06-25  2371  		retval = dma_mmap_coherent(bm->dma_hw_dev, vma, buf->virt_addr,
e36472145aa706 Ian Abbott         2019-06-25  2372  					   buf->dma_addr, n_pages * PAGE_SIZE);
e36472145aa706 Ian Abbott         2019-06-25  2373  	} else {
ed9eccbe8970f6 David Schleef      2008-11-04  2374  		for (i = 0; i < n_pages; ++i) {
e36472145aa706 Ian Abbott         2019-06-25  2375  			unsigned long pfn;
e36472145aa706 Ian Abbott         2019-06-25  2376  
e36472145aa706 Ian Abbott         2019-06-25  2377  			buf = &bm->page_list[i];
e36472145aa706 Ian Abbott         2019-06-25  2378  			pfn = page_to_pfn(virt_to_page(buf->virt_addr));
e36472145aa706 Ian Abbott         2019-06-25  2379  			retval = remap_pfn_range(vma, start, pfn, PAGE_SIZE,
e36472145aa706 Ian Abbott         2019-06-25 @2380  						 PAGE_SHARED);
e36472145aa706 Ian Abbott         2019-06-25  2381  			if (retval)
e36472145aa706 Ian Abbott         2019-06-25  2382  				break;
a52840a98bbb50 H Hartley Sweeten  2012-12-19  2383  
ed9eccbe8970f6 David Schleef      2008-11-04  2384  			start += PAGE_SIZE;
ed9eccbe8970f6 David Schleef      2008-11-04  2385  		}
e36472145aa706 Ian Abbott         2019-06-25  2386  	}
ed9eccbe8970f6 David Schleef      2008-11-04  2387  
e36472145aa706 Ian Abbott         2019-06-25  2388  	if (retval == 0) {
ed9eccbe8970f6 David Schleef      2008-11-04  2389  		vma->vm_ops = &comedi_vm_ops;
af93da31634d6d Ian Abbott         2013-11-08  2390  		vma->vm_private_data = bm;
ed9eccbe8970f6 David Schleef      2008-11-04  2391  
af93da31634d6d Ian Abbott         2013-11-08  2392  		vma->vm_ops->open(vma);
e36472145aa706 Ian Abbott         2019-06-25  2393  	}
ed9eccbe8970f6 David Schleef      2008-11-04  2394  
ed9eccbe8970f6 David Schleef      2008-11-04  2395  done:
b34aa86f12e884 Ian Abbott         2014-04-10  2396  	up_read(&dev->attach_lock);
b34aa86f12e884 Ian Abbott         2014-04-10  2397  	comedi_buf_map_put(bm);	/* put reference to buf map - okay if NULL */
ed9eccbe8970f6 David Schleef      2008-11-04  2398  	return retval;
ed9eccbe8970f6 David Schleef      2008-11-04  2399  }
ed9eccbe8970f6 David Schleef      2008-11-04  2400  

:::::: The code at line 2380 was first introduced by commit
:::::: e36472145aa706c186a6bb4f6419c613b0b1305c staging: comedi: use dma_mmap_coherent for DMA-able buffer mmap

:::::: TO: Ian Abbott <abbotti@mev.co.uk>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--zmxy6vhjo7u3bajm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICM94PF4AAy5jb25maWcAnDxrc9u2st/Pr+CkM3faOZNWkh+x7x1/AEFQQsVXAFKS/YWj
2EqqqS35SnLb/Pu7C5IiQC6dMzfTJtbu4rXvXUD+6V8/eezttH9Zn7aP6+fn7963zW5zWJ82
T97X7fPmf7wg9ZI090Qg81+BONru3v757bA9Pv7lXf16+evo4+Hx2ptvDrvNs8f3u6/bb28w
fLvf/eunf8F/PwHw5RVmOvy3Z0ZdX358xjk+fnt89H6ecv6L9+nXq19HQMvTJJTTkvNS6hIw
d98bEHwoF0JpmSZ3n0ZXo9GZNmLJ9IwaWVPMmC6ZjstpmqftRBZCJpFMRA+1ZCopY3bvi7JI
ZCJzySL5IAKLME10rgqep0q3UKk+l8tUzVtIPlOCBbBOmMJfZc40Ig1PpobJz95xc3p7bU+O
y5UiWZRMTctIxjK/u5ggC5uF40xGosyFzr3t0dvtTzhDSzCD9YTq4WtslHIWNaz68IECl6yw
ueUXMgpKzaLcog9EyIooL2epzhMWi7sPP+/2u80vH9p96Hu9kBkn95ilWq7K+HMhCkESFFpE
0idRrAAtJE42YwsBPOOzigKWhyNFDbNBMt7x7cvx+/G0eWmZPRWJUJIbwelZurS0zcLwmcxc
IQdpzGTiwrSMKaJyJoXCfd33J4+1RMpBRG8dnTGlBT3G0Au/mIaokT95m92Tt//aOTk1KAZJ
SuBfEkRC9efloBxzsRBJrhtu5tuXzeFIMTSXfF6miQBm5u1Us4cyg7nSQHKztRqcpIiRsCwp
aYOmJC2ns1IJDYvFQjmH7W2sGZMpIeIshzmNubeaWMMXaVQkOVP3tL5WVMRemvE8heENe3hW
/Javj396J9iOt4atHU/r09FbPz7u33an7e5bh2EwoGTczCGTqb0/XwewRsqF1khBmzx6FZ2z
XNOb19KF17z6D3Z59nawP6nTiOXoNupTKl54mtAA4EgJOPsU8LEUK1ABioW6IraHd0B4vNIB
4YRw4ihCfxiniYtJhACPJabcj6TObf1w93w21nn1g2W+87N8U0dl5bzyr5r0regtQ3AkMszv
JiMbjhyM2crCjyetDskkn4OLDUVnjvFF1xg1n8HZjEk2ctCPf2ye3iC4el8369PbYXM04PrE
BLaZ0zhLXWRZqnINcScfT26sCDdVaZFp+/CxiPmU1DE/mtcDCL5UiGrr7fwhk6p0MW2QC3Xp
gz9ayiCfETOqfHBkBc9kQEmoxqogZt2DliEo3oPxf+1kGcShAauqRwViIbkYXgqmQLPtreZn
YQ9mnLfl61M+P6NYzhzPCTEXYgG4BWrpmeDzLAWBopeEDMVKcCr9wQhvJrbnhIgJbA8EuDTO
chFQfBcRs8IYSh0YYFIWZYnWfGYxzKbTQnFhJQ4qKKcPdjQFgA+AiQOJHmwBAWD10MGnnc+X
Tg6XZhAaIGErw1Rh5IF/YpZwx/N3yTT8QHknyCPyyGKg+QzejIsMvSE4LMYtBjuCrXxe+9lE
WtApR8v0VOQxuLiyTlnoTSAzzymNLTPczfDIsArr7Raq1OscOR0XZCd9bhRikHSEBb1CkYuV
Zdb4EezPCv6YmFVgHmcrPrN0XGRpZDNXThMWhZYqmY3aAJOI2AAmU8dBp2UBh6HdFAsWEk5S
s4uyHXBxPlNK2onQHGnvY92HlMze/Rlq2IW2ksuFqxqWDJvzxL4IAtsxGn6h0pbnpKuN5Xw8
urS3bVx9XXllm8PX/eFlvXvceOKvzQ5iOYMgwDGaQ1ZUpSb1PO30ZG7wH87YTriIq+mqRIiO
j1i6sLz07fpIR8x3FDoq6LRfR+kQgvkgNjUVTVVCGRASoYfHhKBUYBNp7Cw7K8IQqqqMwTQg
HyiHwG9S+hGzzBAshypDyBhCGTVpXM1Pt9ZrSK8vfWl5ByU1X1iKjeHZrKcScJJQ0pQx1ALj
m/cI2OpuculMWMZlnAaO64vjgjjaA6TGJUTGC8sXL5iZ9+7i9ny8GnJ13UKAZ2kYQqi8G/1z
M6r+OJsMwRTAsqCsZb7tjKoMxNQ0w2gRCZ6jYabq3hwl6lAsGeidSZBYVM4KcKeR7zjsNsmp
saFly5BG8rlx4g2ZnYwiGGokOMBU9/FNVubEbQt4dgKlCceOyz2XV6BAvoKAC+rrRNczgS7i
PnS2FFAGWXvJpjlyr4zADiOQWJ0c7jnI+HnzWHdj2twCnG1Yuac2V3SIzfjseX1CF+Cdvr9u
bA9iOK8WFxNJqFKNvL60wgA3ogM5BpGps9tAfEaw5J4yuTQo4FwatADircVBUPZsdq9RcyZT
W+KxlV8kyqRxd2eryQtQ85qLHduDGoeVTrofZgXpH1222E7YycEbj/5QjkcjqpJ9KCdXI3tB
gFy4pJ1Z6GnuYBo3xZsprCxt6XY3aHbo72Gq/SsK/Gh13+LA9MU+fGiHO5SVbuz/hrICosP6
2+YFgoM1TxtoYpp/Q0Odztj68PjH9gTqCPv9+LR5hcHuMnbENDpnDHaWpvO+wYBWmFZD3ZLr
xFtsBoKi1S0w3cHyaH5HxGclpl1KA8cMr/IrZVDYyli3Fw0K4kQusH/Y9CTsaRYSShy3K4AH
oRwfujRgMxS8M6a688CRGicrONi7pfGVWWncbCmi0Lgqa6cRRgMf9rlkKrBOaWKWScucAl+E
Zp+9JPFMgRWrnSLoXhYz5eni45f1cfPk/Vmp6uth/3X77LRLkKicC5XYUcAATY6fl5flJyfw
vjPp2XNGxRT7dKnOOb/78O3f//7Qj9w/0EWrMo0x1RUWy0w6qGNM+8Yd7nfFgafg2AVgTlVb
I4sEESR7Ld0dwhsnqvi5yzsgqIZS0il0jcZcDorLdxer0qRYao3qey5ZSxmbYEw3fhPQR9Dl
+9hPyQQ9VzJuqOZuVu7XXRGrOtVcS1DOz4XQuYvButXXbpXTgoeaz23Fm4upkjndLmyoMKOi
xWX6JZWTLU36owbJlj6V0FZLYIoR6u4ZkDVpxqKehWXrw2mL+urlELZcP80gXph6FmokLJWp
8j/WQapbUquICaUDbv18Z0V7+/FnKGekKxWAoeszJV3Vt0/bDpbl8YFOplWgC8CZu5c4FnJ+
77vFdoPww89kYHLXa1PcugHTeF+djNtPWAgYSeoM3Agaqa2Gxv2i149jmS6tNKX7uW1AmZOL
fzaPb6f1l+eNuYTzTCF2snjgyySMc1BxJbOcWK/GY+7taEgLpvSqwoLR8rsX+9ZJCQxlJM+G
dmqOEW9e9ofvXkxlCU3CQmb4bQ5WFw8xSwpGdkfOBURFYmWCDaYbFqul0IOJJCfoS7HKlYgF
hVrAX1h0dauVHkV/UeOhIN4H8MnG6yyCoJrlBm3S1Vvzx+pK4H599Ki23WH6CwYbqDLvFpNJ
ClVeWVeoldfEnpXWbQzikQBLZ2AP7bCHLE0jkHzz0S+cQPRwEaYR7dKg+BZKoe8296JVWYjr
05cSQmF6M3xrMcUmqUj4LGZqPlRioJpnuaiyGxbZnmdY784cErbk5z7KXCRN+meUN9mc/t4f
/oRkgcxtITsSlBGBQ1g57mEFVur0GwwskIyOsTkZ+VahcubAzybVJOcwWFNzhozT92uGRBc+
FKeR5HQoMzSxnGKB+s4kIEapoeCgZQmchpxtYIEgM53uTp+9cdeVkFr3nVU9VM7I221AN+Gr
VCnkYaozOJQ+2oLoK15ngQwLBbRv3ZnBTFvTMPdyok8GuZafaqqtDCRZYl8qm89lMONZZ0EE
+2maZ0NLIYFiisYj62Um30NOFbYe4mJFbLOiwJo5EZ3GcwJBIZ1LMSxymS1yqjuAuCKwZrXg
YVr0AO0OXGEgmg1IAHGQbg4jZYYp7IDK9bZmgGivHVDOswbsTo/nG7RvQ6HY8gcUiAXJgD9N
advB1eHH6Xs525mGF75d/jUvOBr83YfHty/bxw/u7HFw1SkEznq3uHYVdXFdmxyG1XBAWYGo
unRBZ1EGA8UMnv76PdFevyvba0K47h5imV0PiP6aUHYzhtZlg9Iy75EDrLxWlEQMOgkgwzKZ
QH6fCdsPLK772odAxzIaCE36rgfDvRU+XrPTllvNYEQ5eF4xvS6j5QCjDBbCNn93eHVPZvsL
fDiFXb5uwO/RQNZjGhDgw+Ns6KoHiEMZ5UOFVfYOEtxNwPmgv9V8wBergOZoPvQMCvJaulcy
GVjBVzKYUmIxCabxGZp12IogcrJFxJLyZjQZfybRgeCJoJO3KOKTgQOxiJbdanJFT8UyutLO
ZunQ8tdRusxYQstHCIFnuroc0oqqP0ofmfsEb4NE4z16iu/j7JrIB/ExUy+Tk6WZSBZ6KXNO
+7EFkfXY+4SKcj4cIOIsGg68iaaXnGla4Q1XzE4DsSA4gPjoAkoWje4daLoqlnBNOUeVWd0Z
FZoXTLazWrnPS+q3DjhhpqAQf+fZBdLwiGktKQ9rwiu+tdH3pXvB7H92/BXeyP5OviY0d7Xg
JFlc92c6WQl2tqrHmW6p4J02x/qBl8OhbJ5PRUdl60qlN7KDsKsPS5YsViwY4tKAdfi0QbEQ
2KWGnFRYznlMsGiAPZhiK7e3uZQKSnztCjucop2Oe02qM2K32TwdvdPe+7IBjmB74QlbCx5E
FkNgdYNqCGb1WBPOzFMrfNBxN2pXXEqA0o47nEvybQNK7jZzRX+btS0qR8S39QueAYlIOifi
IpuVQ+3GJBx4P6sh8g29msTkNqSChBWxOxD31UqgwbjctgBYHew0irTLC/NEKXa7qCGTUboQ
1OW5iVKiNrrGcILNX9vHjRcctn85Lb7qOsVuEHY/1K9jNQm0rvhatnEpsPUMjoHYHQ6OdWeJ
oYe4iPtcSDXvPM+Q7+gAYnU+8L4BkTKlQwniwCMO41jHD7ZeAurGqDBU/W4wwB73u9Nh/4zP
A5/OAqjMcP20wWcfQLWxyPBt7evr/nByGiHAV9CYQEANYq5RSD/3wxndQ4U5/D0euAtFAlyo
kfIQkShX+BZj1Tt8sDluv+2W64PZj8f38IMeOFmwLLOI5cTJbEWBDIH27+8udW6U08I4C0rs
nl732113c6VIAvO0gL5ltQeepzr+vT09/kGL3tXVZZ0V5IIPzj88W2sqnKnANZOYS0aYIBKC
cTauIeMfH9eHJ+/LYfv0zb2vuBdJTqe1imWyExfbS+XtY+1ovLTfzyuq68mZiDLSfUHik8eZ
e9/SwMoYLzXJKMmSgEXOFS8UyGalUKp4yZSovmPRnDrcHl7+Rm153oPFHFqPGC7NxaATbBuQ
abcG+HTYupVZ5YqdF7EeYbajzE11dWDHh1ME4NmjCG+ESba3Q+irwVpluoc7pwh4lY13Zs1N
g3WhYa4RaVwHaokFr8YCJelAVKPFQgndH4ZfnanHQuIfQzCj+ipIxPR9whvSTKW+aFvn5+c7
WVG/EraTYTF1LgCqz6Wc8HaCGqYhzUSb6MGzWPaAy3EPhNdM/YXsL5AEMaseDxj9CV1VQGRo
HLt5W0Fwojlo9QAjhYQ7nd47d/C05VXvT96O3pPJAJxX6zbYypVSSFY4/TBvmmj7Nj1378/z
wAis/+igvaB8XR+O7h1jjm8nPpmLTd2dzbq8JfvISJOG9dgXGwpsxnbue6gA8mU85n19pf1x
PDhBWST1c0X7DWKfDJ+8pEnkyKV/dsOSAn704j1egVbPPfPDend8Nt/n86L1906kwLXMNuk6
tcGWii5Vwpx+hpAMIeQgRoXB4HRahwGdJeh4cJARYpoNyfd84w2GU9XGjQtXLP5NpfFv4fP6
CLHxj+2rFWNtLQqlK7TfRSB45UgcONhY2YBdPQwldiBMV7Xz9sOiQpP3WTIvzRcqyrE7eQc7
eRd76WJxfTkmYBMCluRQBq5yV+nNCWKoOXoWixgIn1Si0KCLXEYdtWex3aQxoJRusxkD9/EG
mAxV7wixutlev75ibV4DTW1qqNaP4LZ6NoJhEU6P/MSm5aBS4YtGlnV5UYPrN9SDx2nIUrrY
RBIjhXKBz87IB844C2S7DR+b69QfHLZ6bLp5/voRM8H1dgfFOkxVO3EqwzQLxfzqajywCx3h
Hr67zOmB4P8uDD5DHMpZVLUALke31x2sUOZJFmLHkxvCW01w772aYXv882O6+8jx3ENlK04R
pHx60Wq5D3GR4/eFy/hufNmH5neXLaN/zMOOf0pEAhnmoLjxmqlLYE4TZUGgvP+q/p1Arh17
L9Wd+YCwqgGUpfx4Kps7hd9xegAol5F5l6lnKSTCHYkZAl/4dcNtMnL3hdgQ3C/o/YAmIcU0
KoRZuDf2/eA1u4fUl24YBLl1n5Y61xkQ+otE5gNfwgYsPmrBOxh7glIwFd3TqHnq/+4AgvuE
xdLZgHkJIuw0CGBOpgefnVcPKT77hAx/gRHMfiVTIbDl7cCwr+O8UYcQaF7EWx63BpVsdXPz
6faaZGxDA8Z3SfCnQSeYvlhHrN/VOR3c+qldUkQRfqDbnjURVvNao8+Q2cVkRTcDG+ICGPIu
QQSpwbsEgfKHX/+ZTf8Ar+c/wK9u3sWDq6N7jgHENWxJ82BBr8ByZoRdioEnDlUL9Icc/xEH
lF71ezPJIhZUM+bMNsSTOSMgyoGWqcHlTE27l0pNs91etIrv2+OjVZs06aJIdKo0+CJ9ES1G
k6D18yy4mlytyiBLcxJYl3dtaVXE8T0a6MAFGJTEA5lLLsPY1L10hsz17cVEX47GJBqKuSjV
hcKvVChTl9KtQ6gSIzpnZ1mgb29GE0a+U5I6mtyORhf2USvYhPryQsPQHEiurkYt5xqEPxt/
+kTAzS5uR6sWM4v59cXVxOGxHl/fTKhlq6yBbKYN/3KNqptY6iAU1PU2PpssodxaOQ5xkbFE
UuR8UjvP6sGnyDBTbfurjbwMHExyctketQZGYsr4fQ8cs9X1zacrexc15vaCr6inDzUaUvzy
5naWCb3qTSrEeDS6tJPCzo4tB+N/Go96Clr96ojNP+ujJ3fH0+HtxXyj8PjH+gCZzgmrTJzH
e4bMx3sC69u+4o+2C8ixIiDt9/8xL2XStY2aNdnzaXNYe2E2Zd7Xpm/1tP97h70r78VUyN7P
h83/vm0PUCrDyF9aqTF8XsCwfsmiZkK5O22ePYjakCsdNs/mF+y04u6QYAukyi4bnOYyJMAL
CEMOtHXSaVZ2UpfOIrP98dSZrkVy7L0SWxik378e9lgNQG2gT3A6+/XlzzzV8S9Wvnzeu7Xv
5hH2O3xqTwc18fIz1ZASfOZczhmrZBHH74Jz+hblbLhdih6+0L5tVjMGtTErGf0rNpwQUjNQ
yyah71m6+bZCnDqFsGISqlRICGkvrfnAb/egFnLiO80HOlxXcXM44oQFPpvt65kQwhtf3F56
P4dgIkv4/5f+qUOpBN4QOw3oGlYOvQFpCVJ9TzLg3cWtS8xebzapT+qkmWkSDL00MmGcjrSf
C/Pt4OFXF7kYSNFixvF9Dh3fs0HUYjWEwS7tgpbeNCcLJ8a1cH9dz/9R9iztbts6/pUs7110
rh6WLS+6kCXZZo5eR6Rs+Wz0nTa5N/kmafK1pzPtvx+A1IOkQDuzSHsMgG8KBEAAzAUqrHVB
2sO7Sv8u4OdwkTPZ1hxYK93y5YF46Vr9qijN7aZN6aU1NLGktd2YFIfE+/jlaLAuP0HTf/v9
8y9/IuPh6oIr0eK/DA15uuX7wSIzkxJnjGIT5r67gAgCbCpMzfD0C4gJOa2uiFtzrt2ToepL
sqQR5mKOIDygWvyYHlRwys0PIhd+6Ls8hqdCRZK2DBo5G57DBYOjgBIcjaIiHyOJpv6muSVE
LSh11ArS0VqvtExezEpzYN3TQjwqa3Bl+Bn7vu9UjxrcdCEld+p1AnuoBEvILQD7loZjd2vj
PiIRhcsdr6BVAETQXyRiXLP8aLm7tm4N70MFATU3jsm4Za3woa2TzNr1hw3txHdIS+RmNGs4
VD09Galr+wh2qqvQWRn92fEbF7mMY3QVfLChYMDoMWGMt6JM3VqZ0cXCkG0S0mfRKHRhnTGv
4txVeFELEzI0tKFYJ7k8JjmcHMxJo2kdNKp/Q+NweS3Yc2ff56+QVh+JSTjnBTddtkbQIOhP
ZEbTO2NG01t0QT/sGUiWtcmTSF1RLwK7jlXGl3bKS1YxkpctcspDJpetzns4xwtGSQd6KfRU
Na6Mi4C2CnHYDRincL++vOwKmVFo+TDy4GHf85cxS+MykRIyVA2mRangBCvR58JmHOuaTnV9
KoyP7ER6AGhFzkbD54bO9qAX6JJrzkgGz+Ig6nsahVc3xhDphhDs2XSew1h0ov3RAO748Fnv
KgIIRyOIcVW3cfUMEK4yjoi2Y+l79NZjJ5r5vy8fLG2ZtJfcTLpVXkoXQ+JPJ7pn/On2QBoo
oZWkqo2NXxb9ZrDdhhdc5NbIAMuvd9HH64P+sLQ1d9sTj+PIh7L0bfkTf4njjUuDtmqu7a8V
xr7bhA9EDFmSA68jP4/y1poXPPDb9xwLcsyTonrQXJWIsbGFJyoQrZXwOIxJG6deZy4wE6oh
hvLAsZ0uPRntYVbX1lVtZuOojg9YdmWOiQ3Qzv+PScbh3jPPiuDp8cpXFzitjYNL5rvIcjLL
o1awfjJ6DPT1g0NSBefCSE6sMp28zqAHwO4jJ/yWo7PZkT3Qp5q84phDTK8W1vTRwf1c1CfT
I/m5SMLecRH1XDhFVqizz6vBhX4mIwH1jnRoDisNqfA5RRuvFba1mKHKh1uizYyhtVtv8+Bb
aHNU3QzZIfbDvSP0ClGipj+UNva3+0eNwT5IOMk5WgzFaUkUT0oQWwwPd46nma36ESXz/Jmu
si5A54Z/xkfLHRdXAEfPy/SRjs8ZsFCjwnQfeCHlXWGUMr4N+Ll3uFwDyt8/WFBecmMP5A1L
XS7cSLv3fYd6hcjNI17K6xS9r3raiMKFPC6M4YkSNvgPLF1XmRyjaW5lnjhcy2B7OK6KU4xQ
qhynBaOS8OmduFV1A3qmIVpf06EvTnRwpVZW5OdOGCxTQR6UMkuwIW1AiMBwS57TYxeWuXFd
58Xk9/BzaM/Akh1mvwTKFbCsgsoEp1V7ZS+VmRpAQYZr5NpwM4Erwdoxy+ilAlGlcdwboPK5
zgG82IHON1dsT1M4ovKbhoZzWhPr+EGFeUovZGO3ICpNBM1XEPkEWojDgoXoJj8lvHMkagJ8
K4rYj+jJXPC0OQbxKPPFjtMP8fDPpcwimjVn+ku+Wpxwij8brmRWaCRfLKWlOpEonDAMmfDz
TrAPYCOXRGRWWuoRWTpKs4kR2MlwQKAmPdGBajkz5HqMa0kce7FlvIwoHx290kVHopA5iHzO
OW2T0XpA4WbxgELqkVo6Qk/0pcOFg/7llulSgY6S9tm8kqYWdUUvwxDfXT9jJOE/1vGZ/8Rw
xT8+fnz39mmiIpzprq7Lm7JHq7FL4gM2wxl9zsiQVCLubhFOeUby6YshAsLPobFcesY73u9/
vjmvLVnVdNqky59DkWead7uCHY/oZVYYLmoKg1G6lmeXQqikSk+0b58iKRPRsv5JOc3OHuxf
8EGDz5im+N+vhgPPWKjGDHLQ4le7xQmDQZZkThSLjIOaDLJ4/7PvLZl3aZrbz7ttbLf3vr7R
UdcKnV/IXuYXi/Fo6+RyTVUln/LboU70dO0TBJhfSkKbKIpjvQ8WjpK8FxLxdKAaexa+J919
1rUiakcfKxpN4G8p+XCmyMYI+nYbR8tOnNHFE/ZrDT81rCZ7hQi5UUntaiYTabLd+FuiZsDE
G5+eSLWJ7w+5KOMwCO+1jRRh6Gig34XR3ZUqU070umxaP/AJRJVfRV0RCMx8gJYnTnZkVKju
dYSL+ppckxtRNxSll62G739DNijKYBB1l56tFFQ2Xe/YqGnSgJrSk3UfyMj4Ze4EiADopUtz
GedHDzyBj+l7R/gEGZIqKeoThQgzCpoxAprWhzYh4KdjYGjjC6IlZU8DP+iBeQumY/DFlLpL
5IyTwkiSCrJJzrL8yvD66F7DosxSqmZpV9Kn3UKhAHmv3pEqCAOi9iu+EFC3ZPVlcpKG3HuV
yzSodXsgpkuiMM8f0SzHNMAyB8lqFq4sgx8E5uWcV+cuITDZYU8O4JSUeUoaG5bmuvZQn9rk
2BP1JjzyfJ+sGo+6jky6NZP0TUJtYwSD+EBgrknxBJsIzguf6EzT69foM/jIWbI92EKIzJZk
bEYFkcoGLEvqSFelU7EGJFZigBrNSaT10lUNcU4qEA1Pjg48HeDHo/YJjc0k4nmL+SCvCegV
mjvpOAHIJZWsssyNBsQQNHzQhOnuUjo+yXbxbm8MYIVFD0t6GAYpZeAwKFqQt3zbpdqgQM1q
KMmLeIOug2Od9SlrXTUdusD3fOrkXVEFe21pNSRed2BGbZZWcShlAIroFqeiPPm+58ILwZvJ
Oc1NcGdSFMVmdTNEkGKECSw43ZVzUjb8jF57JDrPBXN1AbZokVCC9Zpo3K6uDZX3aUhnxNep
jt17JnhHd/RU1xnrHWOEEyhvaBwrGKy2oyDf8ttu67sm4NRVL7S5yBjckzgGfrB7TOhy+TOJ
aMO5TiOZwnCNPUfgwJrW+pQJOhA7fT/WebOBTeGw8By7vSy5729ckwjf9hGTKrOGsk4YlPKH
aw+xst92xSD4Y6bEqrx3XNQZ7T3tfOqu12CkeVWOLwbSy5WBtiyi3qN89XVC+XdrvgSywl+Z
g5936cHfeJ5rjhVXfNCDaybiXd/fYzrXcr/rH33x0lhZl/g+lchd81KmfriLaROJXdkP8Rl5
aCbVe+aYP8SHpas70grpSOK36o6Umn6I9McYBFJmZYpb16eV5VVXWwn5gSkBzmfZ3lZ9HN/b
uftxScJa1JTIZ9O9xwj69F5NFg9zUQXM3euXG16Xs/vNCMyKuoksDcFJ/2NcQdac8NuPrID8
m4nADx0fNU/lyVi7hgEEgec9YoyKauf6akf0wH5gdG05ODIZGuciK/KETFJrEHEzD4qBFL5S
yej6RXn8kW708daRH9IYf8O3kbd7xEFecrENgpDu78ukh1JzVp/LUWgMXSNizzwiOedoRWA8
tbWYOG7K2OuHunrKb2vDAwjh/oY2NI0ELXupK8yj1zgTeo+UUsBOgc7e0xbhoUxc10SjNTPs
PZgKIUi9cxwrL4eLfCmrbm3FBY1bO1isedAmVh0aQ3NtVRuEOaZM4k1ESZIKf2qCxK5W2gMP
ICHqngMaKgM1OstXfZU4ORBicQSTGYdETl+azRZcDmfWSHmPsBfv93fwTX3N8dEctyHqlqv7
mVVP09L3KGOiwrb5qStwocZdtC7fwnG4LMidPsqvMPBjmtgg7ciLiCY9Rt42hOUvO3stABdH
u5UeLJeorfE5aIyWpVYxS/ZQKb3fkqwvwk1vd2QEm8xNoVjJoS8dNc2JQ8MZu9Fegi187OPH
uuolorfRffRujW5LtrHUTAky81MhhJcHC3L0QqsUQObjSocH2Rh6adP7/goS2JDQcD8bYTRT
V8jISEAsr0vOr79/kEGd7F/1O7zTMuK8jQ7Ln/jfMWLXADdJq4zSy129gqes4WTwsUQX7ABo
u402udr1jwEuSLxugwel481LVbZNB6KVpKHaVlccOryz5gGtg9YbiCNkqHgUaYaNGV5sDF/q
CZyXne890ZrmTHSEo8wiGeOtqLVb4keJ60p1A/vp9ffXX98wS6Ed2C/EzXBUcT3ssQdWJEyv
HBWFLcG054YyulWY7QWzAba0HbGqX2qXa+lw4g41Q71cCUyaLoh5MQTpTVPIFPT4FLT93FiW
X1zJLwD1ZOHG1D+/f379ss5yNQ5dZjZJ9adrRkRsvX+ogbWnqKn0VmSRI14pUPZXnShVQYxk
X8wkszoi75OWxpRSMT2YX+2ErNqhk5neNhS2xbf9yvweiXyVJjNfOTdaTyrMcu16UE0nTXiT
w2ResLWHxDIjoJ2dglwlfMbQzDNjDNHMSG8UvT7sRSuCOKYE4JEIc+yBpIGP/023/9W3337C
skAt96QM8FzHWqvyOBUFGhzsxZsQywL6FoV5PmpAbYPZY3rPyUzaCjk/yEqB71TK07TqHT5j
E4W/ZZy2wYwk4xnzXiQnHO6qFxbe+RE56IbDrUnMDOBmgUd7csy80fCHlHDi3UO3jetEBuSR
F0PRyAmwN4REsepY5D05QRbeOUEpeqzKbKfsxFLgva19qCeFZCkvfhiRR5/Fa636y1S0hfJi
WE+2fN6Qvh8St9Ur8AtMvSr889bwDKtcD2g0jeXRspyqKq47dYaRs6Zkg3qz3pgXCW8wj4p6
RNRVVPliLg9freogHypQGPjQNAkZQdcE30SoTxZY6k318WhVfli1TjR1vk7Pj39dgdRr96zG
VFwEdkw7rzWaNA1GU9NHtXxgyJUBV6TwrzFSJWrdaCguJYswrvjeVwu6AqCuMDo36rYNDQnf
Cqtyh/KnE1bdpab1PqSa2tBAFxgA3lX2t3W3uAjDl0ZPpWNjTC0HlnSUd+e+ASsqbgfbL3bK
cr6SMGe9ZZzctuNCvug1J3NWvltBSrjWGboizIX0K4GZ00RyBKu0kBYMDnDlO6YBy66fstGU
f355+/z9y8e/oK/YuExrSPUAOOpBqQZQZVHk1cn8rFS1koJW5GcC+pGxCV+IdBN621WHQSZL
9tHGdyH+onrTsAoZ4d0Otbnj9S3AyxfRqFqsOsqiT5si09Mi3Z1Ys5UxszYK4Y42+Jj8ed4j
yZf/fPv989unr39Yi1ScanwB8qsNbNIjBUz0LlsVz43NWhYmGLJSFTXpO+gcwD9hEqH76eRV
s8yP7CPNxm/pu50Z39/Bl9kuovMNjmhM2eDEs5WmqSO5y8AJyIaxnrY8SO4lTcAOex7iZUwc
fBydk4QzUK337pkD/DZ02FcVer91mHwBfWF0LqAR17TrXPqSV/39x9vHr+9+wUzdY1LYf3yF
nfDl73cfv/7y8cOHjx/e/Wuk+glEcswW+09zy6awtSd/S+PT4+xUycT45lljIWfB/6v96c4k
vEgcSW/sukhHfSTKy/wS2E3YvE5DPeWl4gcarJ7cIfVdkyb6CDRM+xT2JoSzEu/GDJgSiCfO
kP8FR85vIBUC6l/qs3z98Pr9zfgc9aGzGh3dO/t8WRJ6roEg3uI9s9nX+lCLY/fyMtSm+AQ4
kdQcpLXV+ggGGivtf6f2HGZclS7K4+Dqt0+KlY4j0/aczWSOjnRYTmZmTLPoDtbE4/4xj1UJ
GnPirXcevh/gTsw4kyALfkDiEjB0OWHuV6gtY4oPlgFkykm+iDJXE7woBw21+eUDA/PQz9z8
YUgiyprK9SdM5lxKEvzlM6bk0x73gQpQPtF70TREen7RQOFvv/43+eyMaAY/iuMhtTP46sEa
YwgWhgM4HxDUojZeP3yQOfHhU5IN//FfepandX+mEY2SgmYXHZ9FGBGDfLhMf6uIVSiMUfQo
Vxw7KDa+Raw1AX/RTSiEZqfDPeQWX6ZeYV4jfQ1GcJk2Qci9+E5JDhOnq7czXJS6X+gErtO8
qMWavEQZOFnTp3yzK/xoXUAiZPD5NAvAi2GFVwCZFBrf6B3zRkd+MFHUx0lBtoqw9tlOTKBm
0sHwpVTMb/zIzbq016d0qHTC9xYJXCXJ/vr6/TsclrIJgq3JkrtN38unPGh7eTPfErg6ueQO
0qHZNWmMfIYSiqZOVz1Hgf/zfI8eMHGkKXS7nvDhXFwze4YO8Zbv+lWXyrx6cTnDqUVIyiTK
Atgm9YEKrJ1WKjWvfyV4/UaUMa9lNhzTsyHhuxdulo8k9ONf34HxUAs6RtU4G82qZtXPEz5E
RflPaJvLW08dwgPn8KQOFa5nXN2NOouJhqVB7Hu2FmENW+3zY/ZwOpTXgau1Uagy90rRhPtN
aG00m5/MU4D+AatBKh+PmNYaForAdy6UxO/9wGpRPJd9vF21NzrcuSq7lvF+b6TYJaZufsjr
wZQehCu2dlxfNsjcWf6d0cv3zyRVQGs46qo8S8PAjuTX3gijBoDy32oAeqWGGDhXRxQzVxok
gU6LQ5EPIskG/Z/+9/Mo+5WvoJRYMZn+9LwpRmLV9LwtRBkPNmQyBJMkNhQHHedfKRPbQmFq
RQucn5g+HcSg9MHyL6//o99xQj1KfMU8YaXVN4Xhrpu/mQIH5kV07zWKmKxeoeRzRPZTYhSp
HxqToNWxdSACR4nYixwlQt+FCJ1DCMMhbSnfZ5PKOQeRRzFWnWIXe3S3drHvqjXOSZ8/k8Tf
ERto3CiaIIgm7iG50JeKCotPR1CGeIXlXdMUxpW6Dl9Hzk9EWaIINYY6PTCWpfjoMnwGRrXy
JTZZhOwrqhknHAscuN6WNvGMtQ5JKuL9JqKOoYkEV2CrLY0Oj40DxsBQaVgMgoAqWuQnkMYu
VOTJRMIPml1hGqsBVHmdJuCqjcNzsOvJm8GptizZ+xE15Am+qhO9/nd0+h+LJFhXKzFwnKyH
NblyrTGMN1jbGgGVxXvpkbTaEEUT7xwS5UTikPqXyuXMLqfNXLUIt5FP9sbfRLvdGqNu0euR
ZBttycIrIWbCwSJu/MiRYFOn2dNmQp0miHZ3xowUuzBadw8QEUw1sRnLQ7ghhjxKVrv1Djgl
3SnH64BgvyFmsRXwjRI96FLue57xIZ2vpeuCCU/AhFKN50u/v22IdeU/g6v6mtxq3fVwRqmr
THndg9mGD4X+TN9MhRHT0iKBlXgr9KRgyqP9+vr266cP3/7zrvn949vnrx+//fn27vQNdI/f
vuky1Fy4afOx5uFUX4jGTQJM9WOcLw6yqia9+l3k8upWO9AIsiw/Jl2hk9sjXiU2WCxY9VHM
ldKOS8phk6LRKQLizleJ5iswqKTHwD+UKY178bZ7AjP6Maw32QtjLR7S6yLTy8rrMtmVAOLj
H2FPNSGdbrX6l3vkgpU73/MxmIc2S25Bs8z5wSYY0Uo9Q6TOaNGJIQlWlU76y0+/vP4B2vO8
uvjchP0GcZPeXVSomXrZGpQEV+VjQaBYqtZcNDAaqOacHSxHG9JYfUjLhCRHxKpT8lbw33/+
9qt8R3P1Lt40Z8fM4jIImeQSbYMhVPrfo8OJkSRoQZ2LVM/ogQjoWrT3zGwGEp7to51fXmm3
DVll3wRe7wj5QwJb815g5jW2HOJs3TPakGDHFeGMjyndY8aaaSkXMOX0g1j11Zu9U7xiBbOE
HQktKlfFGHXQ9701HwpoB8sh6sy2G/hYMF0E5TYiUvnMe2qIMkWTDsxxM4k4160ltvc+qV6G
tKwzUsRBCtvogjAVXeKZo1LAyF56W9YZoZMQs4Ka9pIFvqfk3xENEofdgtiGexs2sWoTbJgY
NDjySROyljznsIJET0AxQ039fTT7TNeZxhhJ44mOF5EX0rfeEv0Um2Z6E1tFYuu78Zxtdtv+
Tp5gpCkjj3yjE3FPtxhW2ZC5kkMfeevXn/RSygxrfacC34ENw6jHyDM6AQCS2Va/sWihR3eg
aOl7kcHllKnPJ6PFx0gvq9LRNkhAA39nLyN2ARSK0L2QI0W0dfGvydRINGgYGHUoxUmuhR/s
wvuLWpRhFLq+q7XxUn4tfRy5uj6ab61DaIwkI7ooebLDpCiHUEa+R/tMTGhHzKtCx/s9pcTM
yNjs6Wx31TfpeI9luvW4DvBFxBojn3SpawqGkjYPCnFkPfpl14VITpq/w0KArn+dch7lXakb
RxYaDNWQ6WPuUgGvPsXb3oEaefviQzgjUQSJya1r0phiiobLonAfO+quEjpGWCMZ91KR/R9j
V/PcNo7s7++vcO3h1cxha0VSpKh9lQP4IQkxQTIEKUu5qDyJk3GtHU85SdXmv3/dACkBYEOe
w0ys/jVAfDSABtDobgJPJiMHrJ94xESbRJ65Jz3oDTatHVwt2VlZoJOH5IzjsARUi21YHUdx
HNNZe63tLixcVutoQWtTFlcSrgLqzOvCBNNFEpFCg9Pxiiy/QkIaSVehJzeYID01rvo8on3N
2TzJKqGyNvQRInNEY889kMWltJerZUCtJFmuPWVIE/P00IYsXcaB7DXWLdLfK3m6uC7Kk3Zq
W13Z+CqNfFC69pUxbwNoNXo+N9hAcwsoTcNmCekCTGofkfGklb3x/XYzfPRE1DCY9mm6oLtQ
QakfWpOQ8ruubG0I0NCv5li1jQPLe4qBQbJFQk7EAKXhkhx9oFTEQRKRXzNUKhILo8Szcmg9
inRc6DKtvNnbipiDBf4i2weMMyz1YlrjIqqz95oVX3i0PkGdopa5+642d4cbWmgZXocqbrow
6/LpXbn1loZjJIgzRB/hdJA4fpsleYvl/f7ND8mmPr7Jw+pjQzEZLDvWtcY7ejO5AD3nNive
+spBtNe/wUVTez7R5UJcSay6Yj/GjrwIQW684veVascP8a7w2ATrMl3D8GmHD4d28TkuwSqV
Rcc8LoaxwfuuZOKjxxk0fn3bdG01bK98gm8HVnssimFs9ZCU9CkEDYcR1fFW2OkHbb/EvX2s
DS48Bs7d+PTJi3ryheIcsuZw8kVIV26t1WWmEwNOHfZtX+//+vPx0/f5e4r9luF7isuIHgm4
QqMRuHwXGK+sio4yEwDqqWhxMpmOyBnwXV40n7csJlnz5e3Nb+zn58eXm/ylnaL1/g4/vn15
/Prz9R73NlYOfyuBSrF5vX9+uPnj55cvD6/jUb1xsLnJTrlAl7zG3Ae0uun55miSzMG04Z1Q
5tnQ2JTdE2YK/214VXVl3ls5I5A37RGSsxnA0U1nVnE7iTxKOi8EyLwQoPPawKTOtzXGFOes
tqCs6XcX+qWygPDtCJAyBxzwmb4qCSanFo1parrBl2mbsoPRfzKN8PCLMNwcs26gCpjyxrcp
djY9r1RV0RPpJHtWv/852VgThozY9rzrPAEFAG0FPSViwmNWduHCF7khOzHJK2gST7Rg7HHZ
U1cXAJH+irEhgyLwRudB2VUvN3xox/dejK+W3opcsT/CXFnhezKHjdAfg5A+7dOoD5L0koAI
2zNfCK0Mn5Z4W6dsYGBw+i0u4LfHjt7AAhYVG28L7JumaBrajgPhPk1Cb236jhelX0hYR3tR
ULLpzTSHadaJaGK0kJD5YBpEA20oKmtU8Uyctod+GS8WFn089XHEUkwhv7wSlEETkBYdqsdE
a99WIVGCpC9oWwhVB8ej4Xl5IOd8Neaz+0//eXr8+uePm/+9qfLCGzwAsFNeMSlHZcpQfAGZ
WxOfJyw71a85fjHBNuxTJrAFDX0ZnO5oZ+4XPla0aWrb+1jQioTm1wUXTB2lrCmEOky/oNNu
5mpxXef1xmf3cbhYVbRmd2HLCtjlXf8G6/JDXtfm0egbnX3u0WZrPUrH3/hmHp9RgkTT11gX
HtCUAsofpsGSV0MfhtrhzFi2mSo2JZPNUBu3W+rnCYOVO44dLDoaLIDgceO+VVq51IV+xW2T
2txOcCoE06HpFPRsQru7wvQ6iyTQ9wU3Pbkj8T0zHcRPlMm1U7m3MagABla1iYIfyg4h67Jb
l/dEB+me0KmSVrJdp8ieZOhQWHDY3vK6MfUKVRLQfmEeLeS7KLTzHFXsU1MVJ+YJw6QK1TX4
/Mvz7T1e9Mly5uJAlWs8lrey088+xmS+TMenVE5SWX4Y0GDD1w6iHZaL4OR4kajxmn+9OuF2
M7e7/xLaySQOQhxtPoYbKJsk+pbt3QKKXibU6YQuvHZ/EiRxvHD6SJXbEWzoGsHq8LB0ioJV
GQ0+rSd0BDhZ/lwsn7SQcbfcrAjSlHZop+Cec58flDOsdFvawlkxDWnquVma4PA67HmIq+A7
Wr9FLEMvul40Z4tgQZ/xKlhwxw7GgpvDceuJIqtSy2WY0grVCCceJVjB/WHj/3TBuopdaTGY
Aq/BFTteTa6zp+8Rz9n7YZ29HxeN5yRDT55+rMx3TUTbLCHMYfvmeQB6gX0hhs8Mxfs3c/B3
25SFn6OsZRB5wvBccL/cEL7bzKWikP6hiqB/jIK+F6yu9JoKf5Ye/CWfGPyfuG26bRC6Sq8p
OU3l7/3qkCyTZelxyKXXXa8TI4BrEXocGeiJ8bCjz6yUqsDbHvY4flyUkb9agK79X1aoJ56f
Xjs8bgbUYslZGl6ZR0b8jflZbYka6R8a+0MY+kt4FBvKYHBX/FOdcVkmpUoOmRYWcvNzTvU/
TpIWI9dVDb7b/1i+S5YmPsjMXgxV2JChMM2FJvLAArXeWmXSQR05++CtJHIkG+6x/pg4dtzj
oUitRnkRLmxTgCld29AHoga+u87RN3XpnprOmPYM9BC/tGD17jhpYaQksXFUKCBotQO9qfxy
kemFia2Vu2pdo5yInJgnPrHWMdDuUjYeD2RKrzz7nODh/MG7fMlv9HHrl5dX2F4/PHz/dP/0
cJO3w/lFff7y/PzyzWAdow8SSf5tOLwbq4B+ypjsiPZBRDJOAyCiwgyUYSWSnkSyLUynECZU
er8EW4QNr+YYFwdVisGyyrnaYGYW0NpoYxkGC/yTyn47FwwgqoS8doeCiTaDX5YnvpZ16Dup
+lvMqt1OZBTyORu+GaBqc2q57DHSeaMdktXo/43lVEUwTlnW53vpH7jIJpsNDN5W+YKbS24v
Hj+9vjw8PXz68fryDXfcQIK1BkfDveoh04fD1H1/P5VbxdGSnuzMEVPzKh7FC/WyxMs3yems
xod+026ZO1LPbB8Pp74gPTpO3YCOh/DvFoV9XF5gf0c4SjUnKWIPqLCCDaeh5xVRY8QCKwiW
jRy8SHIFsS23TXSlX9q4yO0yMC/VDfoypulxvCTpifn206Qvye/GkWkgYNBj8rtVHich8YGs
CFMa6E8yb+b0XEZxFRFF0gCRkwaISmsg9gFE9XDnVlHtoYCY6NgRoPtVg97sfAVYkZVchglZ
lWVonpladE95V1eKezgQvTsC3lRRENFFiJZ0ESLTnOtCj6OKzOgQLiz7tgkoBCcKVMpVQIkD
0EOqPKVMo4DoC6SHRGtoOt0Y214k1JzB67pBP1QLSuoEO6zTRUp8SiFRvGIeKF4Q9VRIsvIA
69CHRJTc6cyIThFSpOsgOd3lxRRD8yoPemftGaGGgGYYJCnRZgisUkJQRoDuAQWuCWEZAX8q
y4rXAbypogXVOCPgTwU1Jvp0Qrzp4iD8rxegU4HQkVLcVTAtE63e9XFCjQakU/xy21d2zLEz
wreCFbL1I3SJz2hXbi3LrQsDXrnB3qGt+IZTaojk3WZUVjxLv0eTllKE0YKYZxFIqBV6BDxV
kWIZU0MRFMmImtGQHlNt2XPYShBqSs9kGFNLTI9xQ6klHIFVQHxbASHxcQBASSBmmr5gq2VA
jNB+w9YYuHIOVPsoXDCeUyqBAdLNeWaIggNVgTM8Oz6fwW99gMpeRiwMVyWF6BXSg1AK2VCw
IKJWKZgr1xGltNyJNA6I3kE61ZqKTn0A6CmdzyogBjjSqQkE6dSEoOiEyCOdWn6RTom8otP1
Wq0IuUZ6SgwEoKfUMqnptBygvemC/vbak9eaWgcUnS7TeuXJZ0W39TolZOKj2pKtkzYkPoJL
9yomBiGadlO6rKITX6/ZkMZLonq1vt3xAFSZNEANzpbBBmXB9GX95PvZ2tpZSfQSgDec5Abu
Ar9zdqF6Vdh2rN0pnNhsns+1xh3mjhdzOwsgmgda8PPiQqTvynrb009FgdGxNh2BQedo5Hcx
uNAHAn89fEI/9Vic2XYX+dmyL0e/aiY1zwdfkDyNd6bbxDNJh4e2s2pb0sn8GbND/ioyHT1Z
QQMe684asaxuyYMaDfZNe7IdxSs632YYmXbja/JTviu7joraokEOv45urnnTSUba1mp02DJD
90CaYDmrqqPdmm3XFBxjjLlVzZXNqy97aJwe41TIbGENPgUe266U0v4OyNW2qTsujRXqQrOi
fSN7KSTRkm7wWwsqc8vNvqI1DuGjFcBLi7HIuD0QFXlD2uIitGtUrEwzgaI4HWxm1idp5HQG
FEQH07Spx9ImDDnsXeyQaki+YxX9hg7BPS/vpBv3UpXj2DH0MuqVQ47OJzy5OnFakfSeZaQL
SsT6O17vWO1WukZHor0ZGgjpVe44gVLEctYrVVk3e+oBuwKhocYphqDij9Z8aDHRTclDYjeI
rCpbVoQzaLteLpyJB8l3u7Ks5LXxrUwjRTOQtiWaoUIzP7tVBDtuKiZ3NlUZ9W9tv5aKm+dd
g55RfJ9o8Fi4PLqdiPHE+LUpuO653aR13/GtTWo6K3ysmlhYjV53qqazliKD7B8w54DJzzYV
tujH+uDWoMXAKjl9mK1wmDV0IFjfZN92HPQRt50hTVG6zdw1ec58bQwTsp4aLJqQQ721M5fO
hK6e0FwRIBXKqXLCfpl4XzLhfKJHqYQlunRmYihNWw3SLmUnnE7eYkRSJrlhAX8mzWZrKVjX
v2+OKt/LtYpBnSWB1cOZnGFCk2VZOMQdzBfC7YR+h2E1tD2Wp0UGVGROrYyc+TTcfCy7Zj6f
OnFVTIxzfN1j53PgIKE2CfO1G2CiEMrKx2MBegwZ5kQ1qIqUeNoNmZtwRHKoP74kVL98KkzV
SlNhpVS0s3dOUo3UN8dOl7SmJjhyaANEK7PsBUrUvr78ePn08kQ9EMCktxml4iKiZkvTsvON
fF02KxCg8gdPVVBF5eCWz9EZ79kAwMzVKGmzy7n9UsNuntGk0SaCuAnbKYYyAaha7onYpBPV
tetrBO0JOlzemDztcrtn7E86JnYqZV3DNJuXp7q8m563za76xOP3Tw9PT/ffHl5+flftO95A
23IyOfTCVyRc9u6nbHNQTwWbfnu628EcWukcHCirlFmy7MeBYdYEdhGgzMPCgZfuFTu+C21p
qi35xBgm+SWGSeFuWFRrJ6vDYqEa9dmuywF7fJf7RLccYbuEitqhZzgo/KnvCbTvsSMk7Aao
tFaswjN1IyuCujOt6e12PGAM6l071stA0KtikBzmwAbaHi/SZ0BDVrQ5F2AucI1bOHLFU0Ph
ehvLKg2CeYnOZKhN4368S1mSxLB73nmUBTWZQVrlYxQtk2ZjAYVn9EuXP91//z7f6iphtM1J
1OCbB1Az0LtC2PXolfMiHeAQ1p5/36jK9U2Hr3M+P/wFU9L3G7QKySW/+ePnj5usulXh3mRx
83z/a7IduX/6/nLzx8PNt4eHzw+f/+8Gwx6YOe0env5SlhTPL68PN4/fvrxMKbGi/Pn+6+O3
r/PgqWpEFbnjPQSferY+R0BqQBW1jNyxpIiwg5JkBFb8kOqVwnwWfSE3aprQPuae7n9AVZ5v
tk8/H26q+18Pr1NlhOo2waCanx8M72uqY3hzamrbda2ar+5y+gnQCNJWZ6pGOw5LZEltjKZh
hj5lfxHE+WA6A1BTmD3UW55zB6lYl6QEDlJah+Wq05Wtt9v+owX4eJrjG21TbEr1mojI9cR4
l6O/S0/2rLuNAvI5h8GkD1fI7POdvqyl8lYLxq4klXKDDa/48LiprEo75o35mRbmuQMN6UON
k0hJuBRtuSWRTV9gHMLGU/o9pxU4g4W37AOZtX2gZZam2M5s7vxcJ3ODZ5Y8DULT1sGG4ohu
qK16H0eXt72j6cNA0vFYCvaL6CX6Gu5phNuKjP5ocjQZx3CptDCIvIftQhR6slcP867nLxq5
0sOQzADRIJ7iLb2dVbokR/RJHIZRoqnP1GwvPC+MDa62CqMF5bTD4Gl6nqQxLf8fcjbQ8vBh
YBVqu57iyTZv0wPttshkYxvawNWansoONn28gyFOvmYyeY8ia3yTYf+G3Kjnye8d1wUGfoDJ
kNxOmrPWnVdwdfjrN/pC1LwuacHF9HlDD8ED7hhPwicsd1zusqZ+u6nlQLvOMTu+p+eOoS1W
6Waximhp1u+zni+rnL3/IJe7UvDE+RiQwsStJSuGngxKqb+/l+4cji7Z+/Fo0sqp8mqm00KR
H1d5Ejm7vuMUisFc4gu913W+oNYNz4G3qgteaRSgH+Bmx95wctgJZfstmxXaV+a+Y7AL3POs
s53ZqeI1d6zreNPZpUYd2WnxnSx7rTtv+KEfulmVuMQnpRvyfgngIyRx5pDyo2qKQ+iqZ7iH
gn/DODjQvkkUk4QNJ/wRxd6pbWJZJovlrLl4fYuPhtB7eenVT/Mda6S+VjiLbPvnr++Pn+6f
tBpKy2y7s3TOumn13jIv+d7zKR0pRd/9nRP2bLdvEL6ib0aLwDziuFJEuwW2DFQE2oC5P7al
T11EPfUk73ifG2fXQli3GO1dJ8sPMEwFlcuIugonMJ8yDP9GkKaHpun5+BGvUu3g3sg8Cq7e
GIj8X7L4F3JeORM4lxmT+yJZICYL2LTaX1OkE4Y8As1TysZ25HThoCNSGnjVbwSVdbMB5ZpJ
86bFBtXRsQ/s14EHgi2OkDvblecZH32Uk4Jx4drgv54Hkqon+EacPEboiOfZyuf2U6hgpZCY
Fh+FD5kTHwupA9TJm+UA5eUJSC+1siEDXgnjTR8Iud1s+Qfd83b9GrnjGbvSt6K/pRv4UNae
azqjkwSjbgAvDEwksTWpiVJIUA2oSwQ8AITlxDi8xl/a64KZxYV6UndTRFaKJetwqq9xIdzd
4RxZb9WhlhpO6IaBOBBWCVkdLcJ4TT+301nnIolCKkTXBY7TWaGVD1yqYy+ooUJMRMv+/Exc
m9Zxiuq6KlREHWwtnBVlpPu9eiqu66hyjEw96z6j8azkbRwrf4/q6HnWPoCGlD/GC+rWD4nJ
/CtpbBoZT0TLTvfSDLHbkiPVCdl4hizHpIp6ccJr09G4fzErXR/F62hW+dHXpb+5+5yhx0Jf
8/RVHq8tsz+dLRHE5Sxu8X99uREOzBWdyyjYVFGwdr8zAtrIzxli6nzvj6fHb//5LfhdLf3d
NrsZPaH8xKBq1MXQzW+X27ffZ4M0Q9WI2uDo4leHzlSkFRH9FTsk7cf7Io+zUbYiiKGyTDvX
sX99/PqVmkfwjnpbkjcNeinmsPfnvaWDcfh/DTN2TenJZcHy+V1O6byxUlywa2D5UQdy8eU0
c0PR9bmeWEkhLDC2An0/A1A2bOaXMvJY5+jgzHTHcKeo5md1aowDs0HNiI5C7Hzi3JDDYbYB
2RXLpRMaC1+nMZlz7tk17fogubW87Y8RqFtWl5VJhp/nmNULh9w1qq6xTdYrD4woKdHZ9i8b
VYF6Juwf/5hADDGE/ogy2EvbV7cmQq/PBodvgXSqNaYwWwzfPU9+QIgMEDYnR/0bp43BLOxI
ptWPEczw6bI5+ka68ivjFgm/4QSlHW8IP72+fH/58uNm9+uvh9d/7m++/nwAbZp4AfgW61SM
bVcerce7I+FUStNws2dbbtpWwFwCe2KjbdVv1xX7mapvLJX884/oYfRduFimV9hgQjc5Fw6r
4DKf+28Zwaypi1nJxt3IRXw02X8mODJwyYwPzZLn1Yr0rWzg4ZL6LgLUMb2Bm+c2F3Jqe9A1
AdrFgMlBO7E7c4jIcQBhM+BTCxXjPlwssGGIcmiWNg+jBDneygsYk2jMysZhEFgBUUxyOJc7
li+oZimYDBJBu8u4sCzS62VVudC5px7XiUbKt1mSpceJ98TShz6fHwbHNTlUOCWHCqDCD5j4
ypOQjH484UJEIetnPbWp4mDefww37rwJwlNKCRXOk7zzxtSdhqra3YeLW2qnOvLkyQHvpxri
K6LNk6vSX3wIwoxIWAPWY0iu+GpHj2xk5EODQ5hWJw4QJAX9/YplGLPomhDD6GbzaRGoBSM6
BOiCbCUABjp649iKaOX4IZplKOOQGkIYLtm//o5M6iZ4nINnI79f0zNirdIldJCdS8aFeZti
kTHOPZGvBtXrNH/Ge3GbLg7znNPQfAV0IcYk8UTMi7f634pn80FkTM+UCPW0ZHXNoPzOmm7Z
e1gr1uFAijOA/8/a0zQ3jut4f7/CNaf3qma2bfkj9mEPsiTbGusrouw4fVF5HHXHNYmdtZ2a
yfv1S5D6AEkw3W9rT4kBkAJJkARIEOBfp1HTu4FaSnqFcYG53mofh/Y4QkZOPhyql+pyfq3a
1NFNiGQVI6lP+5fz997t3Hs6fj/euCV1OJ94dUbZz+hwTQ36j+NvT8dLJXPQKHU2Grhf3MHz
4A8N0GbhUb/8o3qlFbV/2x842elQWZvUfu1OS5PGIXcjbTls3sv8sF5pzgjG+B+JZh+n23N1
PSodaaWRHjPV7a/z5U/R6I9/V5dfe+HrW/UkPuypA9NyPZ7pCSPqT/1kZbXU3LgU8ZLV5ftH
T0gIyFbo4R4L7qZ4stUAY8CsVYkv5dX1/ALG/Q9l7keUrdsjMRm6DpJhYdWNpHn2s//z/Q2q
5N+pete3qjo8KzE/aApNhZcR1psDQvf0dDkfn5QhSvw8hccNTA+304q4LKNXLDO+YZf9IiiX
fsxVSjJobh1qqHGX6SL0PhSFSFdcFmkBN+ZcP2co3FOHF+++JHrYeiEuWQnBRcDiRPdrScge
GePavmItQNB/L1qXuyiBIKfrh69KzroU+0bCr9ID/1t80AvAhEzXLVBaMFQB88PYMerQ8j+q
yI0lLcCa3dGZ1xobTgbAQkPSIKB3cvLmvKFQnqE1QC2keQvGyT47YJ11gPi8kVZcw+fug1lh
e2tqfH+eh/4y8MVNn4FU3XgbqJY8rQEzOm1jg1YvuVqouKSQCQr21z+rG5UzQMN0n96FUenu
QgiRv6C+vQiDyIfPKLFnVzGc4MPnWandU0Ig4RoHjsx8nKPIkskDahHnObQIC49JcfU6d5Un
YgrCvKnr6B5owQ24clVoUWVb5H20pBwb+fQEv0suVutNhjoCIp3CHM7ygE/vgJrfzWpXR/jy
Xs6HP2WMbdhxuj0Dqlkxf02uESiZJomcjaZjEsfCseZTpyHHFg0V0QxGtqpHulWHcHfU2oBI
PN8L7vp0iwA3c8aWyj0GcexKS8g2RLj1aI8jRCKz9OnnXWhIZFyReViw8iHPoogDE2e6ypCj
qmzwIsQhcTtYudiMR30uIbWfdKMn0eKApscDy8IE7ryN7VgWYuf3C5VuWIRrLlP0EkdC+Fyb
4yRFIfO2KORzwxdVd7uFuGE0T9ETqsbBu4xXG6Se8s03d8tYknbbiSxtuFnUus7r+Va9Xc4H
s0Uy8Q4Eg8acEiVkTW+v1+9EJVnMVDsDAOJclhh6iRR5vJbCQyQRL2E7aTUIOEDH1ie4SOFT
eWuVGNioQR1pVnLe/aenB67+opwrEsHVon+yj+uteu2lXHqej2//Al3rcPx2PCBnBqlfvXJr
gIMhnB6+iG1UKQIty4Hy9mQtZmJlcoDLef90OL/aypF4qcnvsi9dkL/78yW8t1XyI1JBe/yv
eGerwMAJ5P37/oWzZuWdxHeSJIIHmBFId8eX4+lvrc5u44UgdVtvg0WaKtFq2D819O3EhCxX
20Ue3Df7T/2ztzxzwtMZM1OjymW6bcIWpIkfxC5WHzFRFuQiAF+CszQoBKBj1UHCu0soRNAm
NiXmnlKRy5icd0ojjKc8XXvLYBsk+O5uV3jdu6Dg7xs3UZrXHUY1khjyP2uh+BtEnRP3VYMv
mMu34L4B13M31OAmb6VFP2lohsMxvYHVJFmRjG3nfjVJXkxnd0PqsKgmYPF4rJ5e14jGFY22
DPiKTIYyCPGNVQhXT5vFAmdO6GBcfyPB4EliJLsF/BqUVKBSi9V3wHwbp74l/10wtaq6jEEq
vspAvlsSB5Owhy6lSXfzKRF1AWMZME6Z2jOBXTTEyVRrgG4ezGN3MKUHeR57fPzlewf6Qtl1
LEV9l87L6cfcrsVqmQTMMEcCRNp+6O2qYKoc+mrHc4OyRoDZYcHBe00Nv94xf6b9VOPmrHfe
7+tBH0eYjL2hg++x4ti9G+HjzhqgVgRAJaErB0yVfJ0cMBuPB1qSxxqqAxQ3lHjnjfqW9L0c
N3HIbNysWE+HA+VGdD2du/WZ3P/9yLKVuztnptgIHDLpT0oRTbqNcksyzSlnM/ImxoM8pgNY
SpEsuTOQ12WmQINkG0RpBjkjisBTXJNXOxkPCjlvuBBQnE4lHxWeM8IRJwUAW0YCoKaUhbV4
OKGdgsCymgzoy6/Yy4YjNSx5uzgm5dfBdKq2PXE3d8rtodAdt7DV6L4xbfrYMlSq6OBbC5yD
FauJ+WIvi1NfOk8R3BaiVH86QBUKGOOTSalsu5gM+pau34YZpFWBMzGFtVrP2Ungf35Gvric
T7decHpSTnJhtcgD5rmR5p2qVo8K1wrx2wvXlgw9uIXKbzxXr8JnmlWn61k7Qi4il28PK+JJ
PlqUg8mUNH49NtWk2b23vKSE+sM8hA16mSkBSTM2VM7it1+nsx3ZC0ZDZCSp41MNEKfB0g5V
gzjVK7jcE+sX7DS620e7B/Rk/Xidj1ldRXMSJk0bljXlWp465ddAahuHWiGNq5fr+v5Bih2X
wL0UloPtzqBP5tXhiOFUuxQZj0aUVwVHjGdOXs5dHBZJQHG8IA5QTnjg92yitsjP0kIE/MZq
NRuNLJkz4okztGSG4EvbmEw8Boipg7cxLxvdqYcxhXB6GI8tmULkQsEpaDezz7q+vbJ7en99
/aitIBTJgY+oSJLEtfxlkGhDLU0XLYmSjpH2gZppWSeRiiTJvcHbP2S+zOp/3qvT4aO9pfo3
uFf6PvuSRVEb5F+crSzhumd/O1+++Mfr7XL8411P0PopnXwG/by/Vr9FnIyb4tH5/Nb7J//O
v3rfWj6uiA9c939asssK+GkLlUn1/eNyvh7ObxXvumYJbRfH5UBJvSd+q0K+2LnM4doDDdPV
Y7QiLR/zlGuclFBnm2EfR3isAeR6Iash9VOBwuppJ0PFcujozjaaxJv9Ilfkav9ye0bbTQO9
3Hr5/lb14vPpeNN3okUwGvWplQkMx/5AexQhYXTCR/JLCImZk6y9vx6fjrcPc3jd2BkOkL7l
r4oByi628kEr3FmGb7WBhHiWhKargjkOvdysig3p0s7Cu74SR5f/dhSd2WiIXH74vLuBp/Rr
tb++X6rXimsR77xjlAGYx2EtucSn1/EOh+APky1I3ERIHL4RUhCqXNcSF7F44jN6g/+EUek6
LdI3moPk/877fIgDrbrREILOIkDms9kQu3IIiIww2vXBaqBdFyOEujt68dAZTMnLBo5Rn09w
yNCh3vJxxKQ/1kgnkzEtF8vMcTM+4m6/T8fcapUGFjmz/oB6bKKSOIqDmIANHMpiw3ZwpAXh
quFZniIXnd+ZC7mp8Aly3h87ii2Tqy8utnxCjzymTXO+KJBPdmuUYscnqTsY9in+06zgg6/o
qhln0OkDlJxqg4GSF4H/HuGpV6yHQyVKa1FutiFzxgRIXZQLjw1HqvugAN1RplczXAUfmvEE
MSQAUw1wh09fOGA0xsGEN2w8mDro/GLrJdFICTMuIThS8jaIo0kfZ0PYRpMBPhn8yvuWd6Ty
VFOdqNLbev/9VN2kNU9M4bUavFf8HuPf/dlMtTXqs6LYXSaWRYuj+KLQJ6UVigVFGnMLPVcO
deLYG44dHLOgXrjEh+hdtOFBRzejt4q98XQ0tCL0pbJB5zGXMWNJ7rzSqS6Vnf3+cju+vVR/
K+ciwlbZ7LBxoxDWm8Xh5XiyjRM2lxKPm8K4B6k9UJ4ulnlaEDE822Wf+KRgpnkn0/sNvHxO
T1y7PlW64SxCFOWbrKBOLPFAwcMWysKjv6JogG/nG9+LjtizrrNqHHLq+uCsjA/vuB0ywo/1
wA7pD5QVGEB8zpKLe5FFVo3HwibZBN7EGxrRKM5mgyaNmqU6WUQq6pfqClszEo2uK+ZZf9KP
qXfG8zhzpoqaDL91ufczvov/4BhWBuntpnTWVw8ks2gwGNsWhCziCwI+L2XjCVYb5G/t+JTD
cOz1es5rfGCott6PR1gMVpnTnyD018zl2gLyhawBumud0fGdRnQC7zc8HngVVpD1EJ7/Pr6C
lshlvfd0vErnRmJAhUJA+/xGoe/mED8wKLdYpudq8J18AZ6VSo6HfKFEe9/NxkqiC45GsVq2
0XgY9XdmZ3zahP9fZ0O5ElWvb2C9qqJvimcRxJniIxDtZv3JgLRrBAr3VhFnfXxVIX4j0Sv4
EoZVJvHbUeJAUnwiBamgXYi2caAHcOz0pAfFs01uEvl97/B8fCNCU+b3EEkM+06UixA5l8CL
wNwFOsy2UWGneAmfkyxS40KHGaQRp2NO8ikYFMhZS3muKHCQ+OOReep2JOfG6rHH3v+4imvp
rlVN7kUZ/cIElnGYhXz5wui5F5frNHFFwA+1JJSogxHwQt14qnA10gbGyZBB9GhxMkhQGMa7
aXxvCbAhOd4FEcU3ILOdWzrTJBaBRnQuWiQ0zFK7l3muiAyiF47dLFulSVDGfjyZWB7zAGHq
BVEKZ525ryepbRYBZaxQabir9+goA95c3W7ntjAHHBNlaJnOXWa6+TYiLp18sUrRuvV2/rvh
PNn6YUzHjvRd6s4p4fMSBcIUP6Ua0/CyeujdLvuDWOP1qcgKVJb/AAutgLeTDM/HDsErLgsV
oedv5yCWbnIughzCUhzkBOFWgZsX8wC/VxIJastCSaTQwCxD0KKXlmLMkg2iJYgZ/eai+zAZ
MqtFd4+dm+MVs7fb87xMDVxUu4xlXE82o0t2DuqQuDFe5g25t6WkVlBJt1x8wiFKLPIg+BoY
2PqaKgMF3Es3WYR9D0R9ebAM8R1dutDgKpP+IqI4Yyi4K//RROTllrivuMoATga+NnwwTAol
TC7AmZIjQUDmAThPKGxycOqRah+8ouJdsBN7gW4gUTE9uJXEFfvl3cyhPE0AqzpCA0Q88aJN
K8NBLovLNFP0BKblQW/AURjPcdRzAMj7Ua/II3WC5fz/JPDQHPYgHD12C1nwWXq/cX2Zv6tT
+FX3IXkFcIRnD2JxRarO1gXNj2t93JTK3JwplXPNF8K74HYFu8Kx+SZz3PAT3MiGy4OQf5d/
zYL/3UA1s0IgsNAA5H7DjVOyIsBmKQu5MHi0uwBQWJJEAypNIkjUzLx8QyteQPTg5vSjfEDa
3cGXC2bt2dQzkY1aUuRGLzSwHzS2JfNWAde+QOSWue18uyXON0nJ3ITTlUSoBoXa3liJdxkf
d7q3u88Fi3LL9bIFzVYSRp/028KxiU6wg6cxC6bKtoTVkbzSjCoI4R1KwCsv/sEVEfwXHnU8
Ws5Kruvlj0ZURUwBDS0ot7UFS9KC94FyrypB5I4nMDLaCebBtRYRkwbTCgC83hHOw2I50nO3
dxoahJWuS4D086aTdJLCFrtMYgu+AXb9er+Ii3I70AEOAkApr1ByJEEY9gXT1xsFqc2YxQay
/1DkKR+TyH0ssYdeB4M8KGHO1+iS/+mYogjc6MHlGtmC2zDpA0kaJn6gOKQj3I6PqWD9UxYh
HKzrpdlj+6hjf3jGMbMXzHP5bMdrvADAOzX1zrlBrEJWpMvcpfXchso2pg0+nf8OfRBpIfkF
EmYMbRHU3MuW+L/lafzF3/piJ+s2MnS6kc64CWJbCzb+wkA136HrlsdtKfuycIsvSWH7bsw4
je2r20/e8iQFsec1Ozj9WWnUXqv3p3Pvm8JOOxVTyGiPzD8AgHVcRBqQ2/WRnwfIeWYd5Aku
25gm3UHwZskXhDk9r5r8D8tw6SYFGNJKrBv5R848pFYRjWkXVYhjIqTjkeuRscJJmkNEHbvO
4Pqf4BZ2XCCWaBt2ZS/IUTLJimVD/ITX+SfsfKYVfbLxbeahvaTHZ7MFxbgyyVY2Wd7Z64zD
hGsaNvUl/qTfMjvuPtmNPsVO7Nic+Ggj/ZB4AEdhEr8hwk4EmjBXxpvMcd0OJ0mir2mLpnfC
hm70s3Qr76copyPnp+i+ssInCVUy1MbPO6GJO2QQGgS/PFXfXva36heDUJ4s6BWI5046kEum
cnH2yLZWEf9k1uSpbey5QvOQ5mttWWmQzeqEfmNdQ/weYrmQEF3DxkjlYhgg7MGlHwZK8pK+
LRIpWxLbRiL4FpupFQ8KTh0Rzk/InqmJYBMIIiDSGkr5LXHFADywudqaoqc4oP7qP6EnlI7U
PTfZJsnxq0X5u1yqkT9rqN2y8IJsRQ+9F6o6H/yWeg916imwEJbsgetlLPA2edN/igIDVA+B
uy6zB9j86BMsQbXJIO+lHb9zi4K66hRII05fB7UER2rxcOiXiSQFnxD+BH+fCZiX+q59t7XO
01lmmaQRnoQRWmOO1/N0Op79NvgFoyEHLigb5Wh4pxZsMUq6ZRVzN7aUmWKHPA2jhALXcPTz
CY2Icm1VSUR2FkvxCXWHp5E4NuYnyg2rhqNutjQSa39NJlbMzMLMbDixYcZ9S22zoWPDjGb2
pt3ZmsYNBxCqcmrt74FjecWmU9GLN1CJ0JM/YGCgNqsBawPZgIc09YimHtPgid5fDYJ++4cp
Zj+kGFA+cgqBhdnBWB+KdRpOS/o9Q4umbwcAHbseKIRkFoMG7wVREXoqPxKeFMEmTwlMnrpF
iGOet5jHPIwiqralG0T4uqaF54GazbdBhB5kX6D23pYi2YSFWaNoL8ldscnXIVupiE2xUOTf
j8jUIUnoaVcBNahM4MFtFH4VfkFtJFfSuFWOouXjiurwfoH7fyN+rJ4UGn6XeXC/gQwP9h2p
zv/Hxw5K5GGypDaaAhJ4Br78CHrvJYzABq5+vPRXZcprF82k6hS6ApyO+nHAxA11kYeecuzR
kNAmWI0kd0YR0GPl5n6QcPbgfA9Oe4Se4tVJMzrLSiejPweOXJ6ggVxzqyDKSI+rJv5o1zwX
iXHE4v/+BV4FPJ3/Ov36sX/d//py3j+9HU+/XvffKl7P8enX4+lWfYdR/kUO+rq6nKqX3vP+
8lQJt5Zu8OWlTvV6vnz0jqcjOBEf/72v3yHU3+QWZwHse2suewkyMAQCHkNDr7SMY12zoYDb
NpWgu+6hP96g7by3T4J0kW5vLdJcnjDjeH0gcGl7anf5eLudewdIh3e+9J6rlzf8yEQS8+Yt
3Qzd1ylgx4QHrk8CTdJ5tPbCbIXvgnSMWWil5IhGQJM0V4LltjCS0DRAG9atnLg27tdZZlKv
s8ysAaxbk5QvqO6SqLeGKzphjYJ5RSn1SsHSDxmkrZMXKkb1y8XAmcabyEAkm4gGmqxn4i/B
oPhDbS9NV2yKVaAG664xZJiU7P2Pl+Phtz+rj95BSPH3y/7t+cMQ3py5Bo++KT+B5xEwQaiz
E3i5r4b4lN4d77dncHo87G/VUy84Ca4g4OBfx9tzz71ez4ejQPn7295g0/NifZKWSy82ePJW
fCdynX6WRo/gsk5MtGXI+DAaCBbch1uijSuXL1IQTk0GLxEvriBx5NXkcW72kbeYG3x7RU6N
f0Hayg0bc6PqKH8gqkkXlGNSK3wEizv1vqGZjcHjQ076+jTivWr7WG+gC1mPi405YhBnv+3K
1f76bOvJ2DX5XMUuJf073iY7l1tZqHHYra4382O5N3SIkQOw2Vm7enk1p69XDPp+SOWwb+SV
XJmtkhr7I6MDY1991FJDQy6lwumMDs/XTPXYHziW2NodxYR8kdzinfHE4JSDh07fnFErd2C0
IArngKCqsYMhGDMBHhq1s3hI9A+Du8x5St2LNUvoMh/MzG88ZPLLUhk4vj0rbv+oRW5g7hYW
mJJeswEnm3loaCGy5twzxYAEclXmYRESEtYgjJO+RnTdOOBGkmsuVC6o9rZCrDBnPkDNEYR2
+AEjRkZzQVSRC7lV6t9Yr9yvSozoepDdiLk4ya22IxALfuATE5nrCRm3VuxssXhEtKQgM/w2
yIeUHJka3vXxP+oAgG/glK4o2W2HiWsBs4u/pkRbpiPyRLUpMiKKiJuQz9YIuNgwNvd8f3o6
v/aS99c/qkvzIJni301YWHoZpXj6+XzZJK0gMJblX+LozBqYRG66JsIA/h4WRZAH4OScPRIf
BEWy5Ir9J6fMGiGr1eCfIs4tLhs6HRgM9iYDb5C/hhKKFZVw0WWPMaSw5RYo2NaQzq/rGYTM
NvOopmGbuZWsyGKFpvOfHPdnpRfkRbgIPbjf0n3dsrXHpuDIsgUs1NFStA1papcY6nKNV3LX
ZHLpKpCzC57CfhNq6FUkQ7oev5+kX//huTr8yW1I5Oorbqbw8USuuBuZeAaJY/C9GeCDXQFO
qF2zbQcOaeL/b2VHthu3EfuVPLZAGzTpws1LHnTuKitp5JHktfdFSALDMNq4gQ8gn18eI4lz
Ke5DgJikZufkNeQw0Tfu74WcG9xwWoPVjcEc0a6tFLQnKPCDejiHXLxiOkxGzJfHz2CIP/77
8nz/IJU2nVT5xdSJotQzZErBYoGDq633dTHFIDyqtAJJjQ/oi101ZwO0xTCNQ1U7BU50XoXU
P3YLyQebl6wCKsDI0ZTLwcjAwIBzL4VH5hTTAJoNBS+bqmGcLOOY1UfZwJ/vI+44mwQOWJHe
hJKMLYJdoPVEn2K7iylghsPtXlgKRbazRiIuc0CWG4VZkovMIl9D1kmbqyYyeENzRh0BGJYt
3M6sOThQeflvQzEm24fvgtS7ILV1bS+SyRAs6NfRnhG8fs9/T9cfLjwYpU90Pm2VXOw8YKKb
EGw4jE3qIfDFcL/dNPskV8FAI/O/jm3an2WakUCkgHgfxNTnJgkirs8RehWB7/wDK32q844C
1W3qVa2s17AkFH3HH8If4A8KVJoJBzz8QXESAz1mJkMSkr5XWUVvu8JCaKvGWULx2TKjhEFU
tcziNAjP5VxRsBZAwGbO9TRMF7tU3iEgBrpbJxS/cSC9RC4qfdlV0bC/fl/z/Inj3I1gsMlO
5ZeCTbY1Xn8L8vo8DYl8gFFfos0qPmk6KvQhWUSZi0HgO/2Y/QBmmCxNzXX38IXIrBPwHibA
6h667dv9wjzsdHhHJtnu7FmYE/T74/3D89+c1/jt9unOv+Gg6NkjvXRsiSsG46V82IXIcTX4
vnwNwqteHKV/RSkux6oYPi61AmZFxWthoaDKdKYjecEV9tZNcNMmYPqHYjHMPEXHvtgb9//c
/v58/80I/Sci/crwR3+mOJ7B6JceDENtx8w2rgS27+oqLP8EUX5KdBl+q0pQpUP4vY59nmJu
QNUFfWpFSz7eZkTrFiPu10GUcOgLCp22Sr/hFuyABWCSmB3+qEENp9YAGWSr2FcndrPATE2M
Mu4HJ9BjPjAd7EGsK1dhmoOl1XGDoCnS5V5T9U3CZbWlFmnhaDSYMBGKNif2c0rawYy8UxRg
3rszYuBuP0qFaWkcdoPvtHbWI8Wv3lfLOUj2FcXI6kvBXVbgckPEK/jxjx/vQlRuqQ7uK4dT
+XsSg1s9e9ZcOuW3X17u7iyLgAIMQJ/HZ/fMRZXVHOKJ44ZvQ/FrdWrDVgsZK6rqVevkLNiY
qVUm8eOnjUznQiu/kxwFHiktyjusTkJ+ZIOku77RLqHJqKvG/7Wrhtyw0SvihUrHfxKw3R70
wH3vt9+qphlNft3WmPgtYrpz3KAyGxnldtA3lZEQP2KN9VlFWSeBwTQ/H995d5jrdnJag48y
dQVmHwXxZf4Q+wMmcru7lNp7g0+0vXzno3X4/HAn36BQ2XHsAs+l9qocokgUNqT+SLIONlz2
GhrMZBsLGv0yBPyF6TDCfhySPlRv/HQJXAiYVa6svNDYAOXJwJ8EdqfCWUIW3nTtDxuJ8l6N
ooJsDxs1d4uEMtAWeQSbEzYsOj4hRZsvAsZZUPzRY1F0jh3MljZeMS175c0vT9/vH/Da6em3
N99enm9/3MJ/bp+/vn379ldXJKO+OQ7FtXQ9mx1kakS48Ai5PvVWRC5DQQtHRaOvoecuzqRa
scdrLh8sB065XLDRBozgjJghpxN3KKzt/Y95WSU3LASdq7W/JBCBR09jiz5gWC62UP1VOjKj
jHIl+HeFr9n2hf8telqiH3YmAcdeIk/OU5ZYZcljRmSgYoEpUCX1krGuszEkr+SEC1MpG+lt
fq/gLCJ+skZIggyStJfl9Lx/J/HOjCOouJTRs/MLIVan7TECT2D9Qq+ahT37tKNAFmNmdKin
8/RNhdb0sNIn1o3kgFUJkmOLPhzLVgycjf3aD1hvWXoQ6Cz6ONrsZlBu2aBybFmjo0nVMexe
J90hQsOCpaGsZRquzh0STEyi5URK0vbEnuPPM5t9IJDsMrcGejkv/jp4ewRhzQhM9Ab0Xm3q
MoQFOaBB3pRbDTED3iA4nGCqtwiMfTArm0wZyWvlqTGzF6bh76e+BYXioEL7NAX+A3q4qVk+
B1GJqWF40rb42hfWL6AP3GQ9lxyWc5OQhdTGRKT1kR4doPebYzmn645Zvb0/W2EyYT3+sppv
qAzNwyi9n56ZCmxmYD7UDJcMtOud18d8CCdL4hfEn0F5iaQ9E0kUm85CheRUfCA6xZvnDbx0
S0WpyPQC1WXabgz4ObLlCNdm0X2xsyWrHO2huMYMhY3pYEcMRyYGozgNVY8OHbf5IyCG4FsM
hCbnhixFhUDjCnKbAjDVm4t3dRyrDew1OfDieMzjLWt1ilNo9HEPyCbiNNH7QcJWeei+mHfm
UUTO8HDw1o/SiW142pUuBK97DorYl1UDsqxAGYWJCx9S2URZ6QZUpMJZC5O66q7FSGc5vhko
qNUO6+Xt0Kjcawx9gcCbQ1FHc3OoZFaD0xh8R9DVaVA0tMcFOyC7t53yZEjw2gjfNYw9ANBj
jeJgZMKYgqkmfJj4J5rjSV3t28YqJ8SzQ/RCh3V8k/8Bg+JWen6RAQA=

--zmxy6vhjo7u3bajm--
