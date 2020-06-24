Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B840C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0236C20702
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5K8c8og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbgFXBrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:47:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49042 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387780AbgFXBrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592963269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYnZNnpS2HgqC1iM73H/jgj0+9mKXjT6JgH/NmNe1Q4=;
        b=P5K8c8ogkYuh9VyroGh2eDNKxXqJBmIYWcxcvmAk1sIQmub5+qqVxfafdCwHDdNqA0Q/lA
        LbV7KlAVEsKiF/6qj63QLKV407QUUZORwN+nZtsMTG0RFmwvPXhAkO3R0h/QP+qHm0bMvl
        D84Sb9LEL+j0HyPiPq3FLG0sC24FgfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-JVTAxYjrPreR86AyXCDayw-1; Tue, 23 Jun 2020 21:47:45 -0400
X-MC-Unique: JVTAxYjrPreR86AyXCDayw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 317C7BFC2;
        Wed, 24 Jun 2020 01:47:44 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B610C5D9E7;
        Wed, 24 Jun 2020 01:47:40 +0000 (UTC)
Date:   Wed, 24 Jun 2020 09:47:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200624014737.GG3346@MiWiFi-R3L-srv>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <CAPcyv4ipnZ2jXd-obBk4KMGPNz4DMu0jGXFEEPCnST+A2zR+Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ipnZ2jXd-obBk4KMGPNz4DMu0jGXFEEPCnST+A2zR+Uw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/20 at 05:21pm, Dan Williams wrote:
> On Tue, Jun 23, 2020 at 2:43 AM Wei Yang
> <richard.weiyang@linux.alibaba.com> wrote:
> >
> > For early sections, we assumes its memmap will never be partially
> > removed. But current behavior breaks this.
> 
> Where do we assume that?
> 
> The primary use case for this was mapping pmem that collides with
> System-RAM in the same 128MB section. That collision will certainly be
> depopulated on-demand depending on the state of the pmem device. So,
> I'm not understanding the problem or the benefit of this change.

I was also confused when review this patch, the patch log is a little
short and simple. From the current code, with SPARSE_VMEMMAP enabled, we
do build memmap for the whole memory section during boot, even though
some of them may be partially populated. We just mark the subsection map
for present pages. 

Later, if pmem device is mapped into the partially boot memory section,
we just fill the relevant subsection map, do return directly, w/o building
the memmap for it, in section_activate(). Because the memmap for the
unpresent RAM part have been there. I guess this is what Wei is trying to 
do to keep the behaviour be consistent for pmem device adding, or
pmem device removing and later adding again.

Please correct me if I am wrong.

To me, fixing it looks good. But a clear doc or code comment is
necessary so that people can understand the code with less time.
Leaving it as is doesn't cause harm. I personally tend to choose
the former.

	paging_init()
	    ->sparse_init()
	        ->sparse_init_nid()
	          {
                      ...
                      for_each_present_section_nr(pnum_begin, pnum) {
                          ...
                          map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
                                     nid, NULL);
                          ...
                      }
                  }
             ...
             ->zone_sizes_init()
                 ->free_area_init()
                   {
                       for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
                           subsection_map_init(start_pfn, end_pfn - start_pfn);
                       }
                   {
		
         __add_pages()
             ->sparse_add_section()
                 ->section_activate()
                   {
                       ...
                       fill_subsection_map();
                       if (nr_pages < PAGES_PER_SECTION && early_section(ms))   <----------*********
                           return pfn_to_page(pfn);
                       ...
                   }
> 

