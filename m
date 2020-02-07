Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0E3C352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67F12082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Av6DTn9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBGHX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:23:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20476 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgBGHX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581060204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AEOHHq1NHXQs3ZsnGWPJx6llX/TbhDB3MJJr3fAxidE=;
        b=Av6DTn9dvo7Bg9o58V/82EUXPA1l0Y8TkKxXlJ7AX0sQr1KetubIeD+irYUut/ZrHQ9bIl
        duhycVjlnULad8L1hh/3NDrz46Zc/lXPv7LvEzqvHeYsqWAczgQbNCJ+eoHbDTDbLIw8QJ
        G/1E5lt9QoU4lvsQLCoAPuf/Zk9/HBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-Suz8BHsCNou3jELJ_ApsZg-1; Fri, 07 Feb 2020 02:23:21 -0500
X-MC-Unique: Suz8BHsCNou3jELJ_ApsZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADBD6801A01;
        Fri,  7 Feb 2020 07:23:19 +0000 (UTC)
Received: from localhost (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F196E5DA7D;
        Fri,  7 Feb 2020 07:23:16 +0000 (UTC)
Date:   Fri, 7 Feb 2020 15:23:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
Message-ID: <20200207072313.GH26758@MiWiFi-R3L-srv>
References: <20200206125343.9070-1-richardw.yang@linux.intel.com>
 <6d9e36cb-ee4a-00c8-447b-9b75a0262c3a@redhat.com>
 <20200206135016.GA25537@MiWiFi-R3L-srv>
 <87bb4563-481d-cce9-b916-50a098558210@redhat.com>
 <20200206140703.GB25537@MiWiFi-R3L-srv>
 <c63452a4-6a97-8995-0060-65c65adcad78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63452a4-6a97-8995-0060-65c65adcad78@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 at 03:37pm, David Hildenbrand wrote:
> On 06.02.20 15:07, Baoquan He wrote:
> > On 02/06/20 at 02:55pm, David Hildenbrand wrote:
> >> On 06.02.20 14:50, Baoquan He wrote:
> >>> On 02/06/20 at 02:28pm, David Hildenbrand wrote:
> >>>> On 06.02.20 13:53, Wei Yang wrote:
> >>>>> When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
> >>>>> doesn't work before sparse_init_one_section() is called. This leads to a
> >>>>> crash when hotplug memory.
> >>>>>
> >>>>> We should use memmap as it did.
> >>>>>
> >>>>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> >>>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >>>>> CC: Dan Williams <dan.j.williams@intel.com>
> >>>>> ---
> >>>>>  mm/sparse.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/mm/sparse.c b/mm/sparse.c
> >>>>> index 5a8599041a2a..2efb24ff8f96 100644
> >>>>> --- a/mm/sparse.c
> >>>>> +++ b/mm/sparse.c
> >>>>> @@ -882,7 +882,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> >>>>>  	 * Poison uninitialized struct pages in order to catch invalid flags
> >>>>>  	 * combinations.
> >>>>>  	 */
> >>>>> -	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
> >>>>> +	page_init_poison(memmap, sizeof(struct page) * nr_pages);
> >>>>
> >>>> If you add sub-sections that don't fall onto the start of the section,
> >>>>
> >>>> pfn_to_page(start_pfn) != memmap
> >>>>
> >>>> and your patch would break that under SPARSEMEM_VMEMMAP if I am not wrong.
> >>>
> >>> It returns the pfn_to_page(pfn) from __populate_section_memmap() and
> >>> assign to memmap in vmemmap case, how come it breaks anything. Correct
> >>> me if I was wrong.
> >>
> >> I'm sorry, I can't follow :) Can you elaborate?
> >>
> >> Was your comment targeted at why the old code cannot be broken or why
> >> this patch cannot be broken?
> > 
> > Sorry for the confusion :-) the latter. I mean the returned memmap has been
> > at the pfn_to_page(start_pfn) in SPARSEMEM_VMEMMAP case.
> 
> Yeah, at least for SPARSEMEM_VMEMMAP it is indeed right. Thanks :)
> 
> 
> Now, about SPARSEMEM:
> 
> populate_section_memmap() does not care about nr_pages and will allocate
> a memmap for the whole section. So, whenever we add sub-sections to a
> section, we allocate a new memmap for the whole section. And we do
> overwrite the memmap pointer in our section. ( sparse_add_section() )
> 
> That makes me assume that sub-section hot-add under SPARSEMEM is either
> 
> a) never enabled and only works with SPARSEMEM_VMEMMAP
> b) horribly broken
> 
> And I think a) applies (looking at pfn_section_valid()). Therefore, we
> don't have to care about sub-section hot-add specifics (and I would be
> broken already)

Yeah, I have the same thought as you. And later Dan's words confirms it
in another threaad.

