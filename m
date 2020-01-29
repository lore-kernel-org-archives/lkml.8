Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A862AC33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6799720732
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbZxDcdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgA2Ldc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:33:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23539 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726911AbgA2Ld2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580297607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GEYfV9T3mmr30WJa5BxoRI1mRb6fEe9HtZ53b7gXpIM=;
        b=hbZxDcdJ7z80xZc9M1cC5v7VzVLVSpEEosoWTIa2uFE6nMO606h0bQ9jzV8cbUTFZiEA8D
        sp6JoIwC/+GePYpMa+vIQvXw7C70N4PUNv+x1XiXPAbOXKXKZhPXbNIukRVRyaC1nkc1z8
        c17S0Mjq38wi3e24PeG6KAxwNRg09s8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-k-5V2fuoPlSJ_8L-WwMUkg-1; Wed, 29 Jan 2020 06:33:18 -0500
X-MC-Unique: k-5V2fuoPlSJ_8L-WwMUkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3355801A0A;
        Wed, 29 Jan 2020 11:33:16 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6430E8EA0F;
        Wed, 29 Jan 2020 11:33:02 +0000 (UTC)
Date:   Wed, 29 Jan 2020 19:32:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Chris Mason <chris.mason@fusionio.com>
Subject: Re: block/blk-merge.c:166:19: note: in expansion of macro
 'page_to_phys'
Message-ID: <20200129113258.GA1831@ming.t460p>
References: <202001271456.g9ITPCEb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202001271456.g9ITPCEb%lkp@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 02:38:58PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
> commit: 429120f3df2dba2bf3a4a19f4212a53ecefc7102 block: fix splitting segments on boundary masks
> date:   4 weeks ago
> config: riscv-randconfig-a001-20200127 (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 429120f3df2dba2bf3a4a19f4212a53ecefc7102
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/riscv/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/seqlock.h:36,
>                     from include/linux/time.h:6,
>                     from include/linux/stat.h:19,
>                     from include/linux/module.h:13,
>                     from block/blk-merge.c:6:
>    include/linux/scatterlist.h: In function 'sg_phys':
>    include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
>     #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
>                                                          ^
>    include/linux/pfn.h:21:36: note: in definition of macro 'PFN_PHYS'
>     #define PFN_PHYS(x) ((phys_addr_t)(x) << PAGE_SHIFT)
>                                        ^
>    arch/riscv/include/asm/page.h:115:29: note: in expansion of macro 'pfn_to_phys'
>     #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>                                 ^~~~~~~~~~~
>    include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>     #define page_to_pfn __page_to_pfn
>                         ^~~~~~~~~~~~~
>    arch/riscv/include/asm/page.h:115:41: note: in expansion of macro 'page_to_pfn'
>     #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>                                             ^~~~~~~~~~~
>    include/linux/scatterlist.h:224:9: note: in expansion of macro 'page_to_phys'
>      return page_to_phys(sg_page(sg)) + sg->offset;
>             ^~~~~~~~~~~~
>    In file included from arch/riscv/include/asm/page.h:131:0,
>                     from arch/riscv/include/asm/thread_info.h:11,
>                     from include/linux/thread_info.h:38,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/riscv/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/seqlock.h:36,
>                     from include/linux/time.h:6,
>                     from include/linux/stat.h:19,
>                     from include/linux/module.h:13,
>                     from block/blk-merge.c:6:
>    include/linux/scatterlist.h: In function 'sg_page_iter_page':
>    include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
>     #define __pfn_to_page(pfn) (vmemmap + (pfn))
>                                 ^
>    include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
>     #define pfn_to_page __pfn_to_page
>                         ^~~~~~~~~~~~~
>    include/linux/mm.h:213:26: note: in expansion of macro 'pfn_to_page'
>     #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
>                              ^~~~~~~~~~~
>    include/linux/scatterlist.h:384:9: note: in expansion of macro 'nth_page'
>      return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
>             ^~~~~~~~
>    In file included from arch/riscv/include/asm/page.h:12:0,
>                     from arch/riscv/include/asm/thread_info.h:11,
>                     from include/linux/thread_info.h:38,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/riscv/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/seqlock.h:36,
>                     from include/linux/time.h:6,
>                     from include/linux/stat.h:19,
>                     from include/linux/module.h:13,
>                     from block/blk-merge.c:6:
>    block/blk.h: In function 'biovec_phys_mergeable':
>    include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
>     #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
>                                                          ^
>    include/linux/pfn.h:21:36: note: in definition of macro 'PFN_PHYS'
>     #define PFN_PHYS(x) ((phys_addr_t)(x) << PAGE_SHIFT)
>                                        ^
>    arch/riscv/include/asm/page.h:115:29: note: in expansion of macro 'pfn_to_phys'
>     #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>                                 ^~~~~~~~~~~
>    include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>     #define page_to_pfn __page_to_pfn
>                         ^~~~~~~~~~~~~
>    arch/riscv/include/asm/page.h:115:41: note: in expansion of macro 'page_to_pfn'
>     #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>                                             ^~~~~~~~~~~
>    block/blk.h:79:22: note: in expansion of macro 'page_to_phys'
>      phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
>                          ^~~~~~~~~~~~
>    block/blk-merge.c: In function 'get_max_segment_size':
>    include/asm-generic/memory_model.h:55:54: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
>     #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
>                                                          ^
>    include/linux/pfn.h:21:36: note: in definition of macro 'PFN_PHYS'
>     #define PFN_PHYS(x) ((phys_addr_t)(x) << PAGE_SHIFT)
>                                        ^
>    arch/riscv/include/asm/page.h:115:29: note: in expansion of macro 'pfn_to_phys'
>     #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>                                 ^~~~~~~~~~~
>    include/asm-generic/memory_model.h:81:21: note: in expansion of macro '__page_to_pfn'
>     #define page_to_pfn __page_to_pfn
>                         ^~~~~~~~~~~~~
>    arch/riscv/include/asm/page.h:115:41: note: in expansion of macro 'page_to_pfn'
>     #define page_to_phys(page) (pfn_to_phys(page_to_pfn(page)))
>                                             ^~~~~~~~~~~
> >> block/blk-merge.c:166:19: note: in expansion of macro 'page_to_phys'
>      offset = mask & (page_to_phys(start_page) + offset);
>                       ^~~~~~~~~~~~
>    In file included from arch/riscv/include/asm/page.h:131:0,
>                     from arch/riscv/include/asm/thread_info.h:11,
>                     from include/linux/thread_info.h:38,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/riscv/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/seqlock.h:36,
>                     from include/linux/time.h:6,
>                     from include/linux/stat.h:19,
>                     from include/linux/module.h:13,
>                     from block/blk-merge.c:6:
>    block/blk-merge.c: In function 'blk_rq_map_sg':
>    include/asm-generic/memory_model.h:54:29: error: 'vmemmap' undeclared (first use in this function); did you mean 'vm_mmap'?
>     #define __pfn_to_page(pfn) (vmemmap + (pfn))
>                                 ^
>    include/asm-generic/memory_model.h:82:21: note: in expansion of macro '__pfn_to_page'
>     #define pfn_to_page __pfn_to_page
>                         ^~~~~~~~~~~~~
>    arch/riscv/include/asm/page.h:112:30: note: in expansion of macro 'pfn_to_page'
>     #define virt_to_page(vaddr) (pfn_to_page(virt_to_pfn(vaddr)))
>                                  ^~~~~~~~~~~
>    block/blk-merge.c:545:19: note: in expansion of macro 'virt_to_page'
>       sg_set_page(sg, virt_to_page(q->dma_drain_buffer),
>                       ^~~~~~~~~~~~
> 
> vim +/page_to_phys +166 block/blk-merge.c
> 
>    159	
>    160	static inline unsigned get_max_segment_size(const struct request_queue *q,
>    161						    struct page *start_page,
>    162						    unsigned long offset)
>    163	{
>    164		unsigned long mask = queue_segment_boundary(q);
>    165	
>  > 166		offset = mask & (page_to_phys(start_page) + offset);
>    167		return min_t(unsigned long, mask - offset + 1,
>    168			     queue_max_segment_size(q));
>    169	}
>    170	
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

Hello,

Thanks for your report!

Could you test the following patch?

diff --git a/block/blk-merge.c b/block/blk-merge.c
index d783bdc4559b..e693d64e2565 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -7,6 +7,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/scatterlist.h>
+#include <linux/mm.h>
 
 #include <trace/events/block.h>
 


Thanks,
Ming

