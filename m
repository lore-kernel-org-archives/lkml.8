Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B4DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BB12070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgA2Ne0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:34:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:12309 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgA2Ne0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:34:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 05:34:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; 
   d="scan'208";a="277467906"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.172.225]) ([10.249.172.225])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jan 2020 05:34:23 -0800
Subject: Re: [kbuild-all] Re: block/blk-merge.c:166:19: note: in expansion of
 macro 'page_to_phys'
To:     Ming Lei <ming.lei@redhat.com>, kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Chris Mason <chris.mason@fusionio.com>
References: <202001271456.g9ITPCEb%lkp@intel.com>
 <20200129113258.GA1831@ming.t460p>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <bd726c66-afb6-cbc2-ae1c-4a6633272f13@intel.com>
Date:   Wed, 29 Jan 2020 21:34:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200129113258.GA1831@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/2020 7:32 PM, Ming Lei wrote:
> On Mon, Jan 27, 2020 at 02:38:58PM +0800, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
>> commit: 429120f3df2dba2bf3a4a19f4212a53ecefc7102 block: fix splitting segments on boundary masks
>> date:   4 weeks ago
>> config: riscv-randconfig-a001-20200127 (attached as .config)
>> compiler: riscv64-linux-gcc (GCC) 7.5.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          git checkout 429120f3df2dba2bf3a4a19f4212a53ecefc7102
>>          # save the attached .config to linux build tree
>>          GCC_VERSION=7.5.0 make.cross ARCH=riscv
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>                      from include/asm-generic/preempt.h:5,
>>                      from ./arch/riscv/include/generated/asm/preempt.h:1,
>>                      from include/linux/preempt.h:78,
>>                      from include/linux/spinlock.h:51,
>>                      from include/linux/seqlock.h:36,
>>                      from include/linux/time.h:6,
>>                      from include/linux/stat.h:19,
>>                      from include/linux/module.h:13,
>>                      from block/blk-merge.c:6:
>>     include/linux/scatterlist.h: In function 'sg_phys':
>>     include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
>>      #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
>>                                                           ^
>>     include/linux/pfn.h:21:36: note: in definition of macro 'PFN_PHYS'
>>      #define PFN_PHYS(x) ((phys_addr_t)(x) << PAGE_SHIFT)
>>                                         ^
>>     arch/riscv/include/asm/page.h:115:29: note: in expansion of macro 'pfn_to_phys'
>>      #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>>                                  ^~~~~~~~~~~
>>     include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>>      #define page_to_pfn __page_to_pfn
>>                          ^~~~~~~~~~~~~
>>     arch/riscv/include/asm/page.h:115:41: note: in expansion of macro 'page_to_pfn'
>>      #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>>                                              ^~~~~~~~~~~
>>     include/linux/scatterlist.h:224:9: note: in expansion of macro 'page_to_phys'
>>       return page_to_phys(sg_page(sg)) + sg->offset;
>>              ^~~~~~~~~~~~
>>     In file included from arch/riscv/include/asm/page.h:131:0,
>>                      from arch/riscv/include/asm/thread_info.h:11,
>>                      from include/linux/thread_info.h:38,
>>                      from include/asm-generic/preempt.h:5,
>>                      from ./arch/riscv/include/generated/asm/preempt.h:1,
>>                      from include/linux/preempt.h:78,
>>                      from include/linux/spinlock.h:51,
>>                      from include/linux/seqlock.h:36,
>>                      from include/linux/time.h:6,
>>                      from include/linux/stat.h:19,
>>                      from include/linux/module.h:13,
>>                      from block/blk-merge.c:6:
>>     include/linux/scatterlist.h: In function 'sg_page_iter_page':
>>     include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
>>      #define __pfn_to_page(pfn) (vmemmap + (pfn))
>>                                  ^
>>     include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
>>      #define pfn_to_page __pfn_to_page
>>                          ^~~~~~~~~~~~~
>>     include/linux/mm.h:213:26: note: in expansion of macro 'pfn_to_page'
>>      #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
>>                               ^~~~~~~~~~~
>>     include/linux/scatterlist.h:384:9: note: in expansion of macro 'nth_page'
>>       return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
>>              ^~~~~~~~
>>     In file included from arch/riscv/include/asm/page.h:12:0,
>>                      from arch/riscv/include/asm/thread_info.h:11,
>>                      from include/linux/thread_info.h:38,
>>                      from include/asm-generic/preempt.h:5,
>>                      from ./arch/riscv/include/generated/asm/preempt.h:1,
>>                      from include/linux/preempt.h:78,
>>                      from include/linux/spinlock.h:51,
>>                      from include/linux/seqlock.h:36,
>>                      from include/linux/time.h:6,
>>                      from include/linux/stat.h:19,
>>                      from include/linux/module.h:13,
>>                      from block/blk-merge.c:6:
>>     block/blk.h: In function 'biovec_phys_mergeable':
>>     include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
>>      #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
>>                                                           ^
>>     include/linux/pfn.h:21:36: note: in definition of macro 'PFN_PHYS'
>>      #define PFN_PHYS(x) ((phys_addr_t)(x) << PAGE_SHIFT)
>>                                         ^
>>     arch/riscv/include/asm/page.h:115:29: note: in expansion of macro 'pfn_to_phys'
>>      #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>>                                  ^~~~~~~~~~~
>>     include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>>      #define page_to_pfn __page_to_pfn
>>                          ^~~~~~~~~~~~~
>>     arch/riscv/include/asm/page.h:115:41: note: in expansion of macro 'page_to_pfn'
>>      #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>>                                              ^~~~~~~~~~~
>>     block/blk.h:79:22: note: in expansion of macro 'page_to_phys'
>>       phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
>>                           ^~~~~~~~~~~~
>>     block/blk-merge.c: In function 'get_max_segment_size':
>>     include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
>>      #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
>>                                                           ^
>>     include/linux/pfn.h:21:36: note: in definition of macro 'PFN_PHYS'
>>      #define PFN_PHYS(x) ((phys_addr_t)(x) << PAGE_SHIFT)
>>                                         ^
>>     arch/riscv/include/asm/page.h:115:29: note: in expansion of macro 'pfn_to_phys'
>>      #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>>                                  ^~~~~~~~~~~
>>     include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>>      #define page_to_pfn __page_to_pfn
>>                          ^~~~~~~~~~~~~
>>     arch/riscv/include/asm/page.h:115:41: note: in expansion of macro 'page_to_pfn'
>>      #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>>                                              ^~~~~~~~~~~
>>>> block/blk-merge.c:166:19: note: in expansion of macro 'page_to_phys'
>>       offset = mask & (page_to_phys(start_page) + offset);
>>                        ^~~~~~~~~~~~
>>     In file included from arch/riscv/include/asm/page.h:131:0,
>>                      from arch/riscv/include/asm/thread_info.h:11,
>>                      from include/linux/thread_info.h:38,
>>                      from include/asm-generic/preempt.h:5,
>>                      from ./arch/riscv/include/generated/asm/preempt.h:1,
>>                      from include/linux/preempt.h:78,
>>                      from include/linux/spinlock.h:51,
>>                      from include/linux/seqlock.h:36,
>>                      from include/linux/time.h:6,
>>                      from include/linux/stat.h:19,
>>                      from include/linux/module.h:13,
>>                      from block/blk-merge.c:6:
>>     block/blk-merge.c: In function 'blk_rq_map_sg':
>>     include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
>>      #define __pfn_to_page(pfn) (vmemmap + (pfn))
>>                                  ^
>>     include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
>>      #define pfn_to_page __pfn_to_page
>>                          ^~~~~~~~~~~~~
>>     arch/riscv/include/asm/page.h:112:30: note: in expansion of macro 'pfn_to_page'
>>      #define virt_to_page(vaddr) (pfn_to_page(virt_to_pfn(vaddr)))
>>                                   ^~~~~~~~~~~
>>     block/blk-merge.c:545:19: note: in expansion of macro 'virt_to_page'
>>        sg_set_page(sg, virt_to_page(q->dma_drain_buffer),
>>                        ^~~~~~~~~~~~
>>
>> vim +/page_to_phys +166 block/blk-merge.c
>>
>>     159	
>>     160	static inline unsigned get_max_segment_size(const struct request_queue *q,
>>     161						    struct page *start_page,
>>     162						    unsigned long offset)
>>     163	{
>>     164		unsigned long mask = queue_segment_boundary(q);
>>     165	
>>   > 166		offset = mask & (page_to_phys(start_page) + offset);
>>     167		return min_t(unsigned long, mask - offset + 1,
>>     168			     queue_max_segment_size(q));
>>     169	}
>>     170	
>>
>> ---
>> 0-DAY kernel test infrastructure                 Open Source Technology Center
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> Hello,
>
> Thanks for your report!
>
> Could you test the following patch?

Hi Ming,

We're on leave for the Chinese New Year, could you try the following steps?

reproduce:
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # save the attached .config to linux build tree
         GCC_VERSION=7.5.0 make.cross ARCH=riscv

Best Regards,
Rong Chen

>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index d783bdc4559b..e693d64e2565 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -7,6 +7,7 @@
>   #include <linux/bio.h>
>   #include <linux/blkdev.h>
>   #include <linux/scatterlist.h>
> +#include <linux/mm.h>
>   
>   #include <trace/events/block.h>
>   
>
>
> Thanks,
> Ming
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

