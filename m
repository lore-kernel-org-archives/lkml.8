Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7B0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D112084D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbgFXDqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:46:52 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:38933 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388572AbgFXDqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:46:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0Yx7JE_1592970398;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0Yx7JE_1592970398)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 11:46:39 +0800
Date:   Wed, 24 Jun 2020 11:46:38 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200624034638.GA10687@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <CAPcyv4ipnZ2jXd-obBk4KMGPNz4DMu0jGXFEEPCnST+A2zR+Uw@mail.gmail.com>
 <20200624014737.GG3346@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624014737.GG3346@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 09:47:37AM +0800, Baoquan He wrote:
>On 06/23/20 at 05:21pm, Dan Williams wrote:
>> On Tue, Jun 23, 2020 at 2:43 AM Wei Yang
>> <richard.weiyang@linux.alibaba.com> wrote:
>> >
>> > For early sections, we assumes its memmap will never be partially
>> > removed. But current behavior breaks this.
>> 
>> Where do we assume that?
>> 
>> The primary use case for this was mapping pmem that collides with
>> System-RAM in the same 128MB section. That collision will certainly be
>> depopulated on-demand depending on the state of the pmem device. So,
>> I'm not understanding the problem or the benefit of this change.
>
>I was also confused when review this patch, the patch log is a little
>short and simple. From the current code, with SPARSE_VMEMMAP enabled, we
>do build memmap for the whole memory section during boot, even though
>some of them may be partially populated. We just mark the subsection map
>for present pages. 
>
>Later, if pmem device is mapped into the partially boot memory section,
>we just fill the relevant subsection map, do return directly, w/o building
>the memmap for it, in section_activate(). Because the memmap for the
>unpresent RAM part have been there. I guess this is what Wei is trying to 
>do to keep the behaviour be consistent for pmem device adding, or
>pmem device removing and later adding again.
>
>Please correct me if I am wrong.

You are right here.

>
>To me, fixing it looks good. But a clear doc or code comment is
>necessary so that people can understand the code with less time.
>Leaving it as is doesn't cause harm. I personally tend to choose
>the former.
>

The former is to add a clear doc?

>	paging_init()
>	    ->sparse_init()
>	        ->sparse_init_nid()
>	          {
>                      ...
>                      for_each_present_section_nr(pnum_begin, pnum) {
>                          ...
>                          map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
>                                     nid, NULL);
>                          ...
>                      }
>                  }
>             ...
>             ->zone_sizes_init()
>                 ->free_area_init()
>                   {
>                       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
>                           subsection_map_init(start_pfn, end_pfn - start_pfn);
>                       }
>                   {
>		
>         __add_pages()
>             ->sparse_add_section()
>                 ->section_activate()
>                   {
>                       ...
>                       fill_subsection_map();
>                       if (nr_pages < PAGES_PER_SECTION && early_section(ms))   <----------*********
>                           return pfn_to_page(pfn);
>                       ...
>                   }
>> 

-- 
Wei Yang
Help you, Help me
