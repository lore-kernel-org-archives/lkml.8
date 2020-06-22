Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F39C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386F62073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fz7Kv1Cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgFVV5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:57:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33477 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730576AbgFVV5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592863026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMbPsqGUvOKb001hQipRcEAVs1+07nW6ycVZC/UvqlI=;
        b=fz7Kv1CjoiaPMNbJ+KExNNKkk22EEd2lGZQnOCWW6cOIleTZ4VQqEVgpDyZymzh9DJEi5u
        QhlORtsdICb5sT1hGgAsJAYcaz3nnaG8ezCt5oaCZSOH9uzwmH+Q6orhopzXcoSigpWu+f
        NRYGHtX444jNdDO8g9Jb5aoxSuPMpbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-zgop9R65Nc-KYu6Pt_FCgw-1; Mon, 22 Jun 2020 17:57:02 -0400
X-MC-Unique: zgop9R65Nc-KYu6Pt_FCgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 557691883608;
        Mon, 22 Jun 2020 21:57:00 +0000 (UTC)
Received: from mail (ovpn-112-10.rdu2.redhat.com [10.10.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B76D410013D2;
        Mon, 22 Jun 2020 21:56:59 +0000 (UTC)
Date:   Mon, 22 Jun 2020 17:56:58 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Roman Gushchin <guro@fb.com>,
        Yang Shi <shy828301@gmail.com>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Will Deacon <will@kernel.org>
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
Message-ID: <20200622215658.GC12414@redhat.com>
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
 <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
 <20200619024026.GB21081@redhat.com>
 <20200622124646.GI3701@8bytes.org>
 <e31308f7-4e3c-b6bc-7201-3861b062d257@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31308f7-4e3c-b6bc-7201-3861b062d257@arm.com>
User-Agent: Mutt/1.14.2 (2020-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jun 22, 2020 at 04:30:41PM +0100, Robin Murphy wrote:
> On 2020-06-22 13:46, Joerg Roedel wrote:
> > + Robin
> > 
> > Robin, any idea on this?
> 
> After a bit of archaeology, this dates back to the original review:
> 
> https://lore.kernel.org/linux-arm-kernel/54C285D4.3070802@arm.com/
> https://lore.kernel.org/linux-arm-kernel/54DA2666.9030003@arm.com/
> 
> In summary: originally this inherited from other arch code that did 
> simply strip __GFP_COMP; that was deemed questionable because of the 
> nonsensical comment about CONFIG_HUGETLBFS that was stuck to it; the 
> current code is like it is because in 5 and a half years nobody said 
> that it's wrong :)
> 
> If there actually *are* good reasons for stripping __GFP_COMP, then I've 
> certainly no objection to doing so.

The main question is if there's any good reasons for not forbidding
__GFP_COMP to be specified in the callers. The reason given in the
comment isn't convincing.

I don't see how a caller that gets a pointer can care about how the
page structure looks like and in turn why it's asking for __GFP_COMP.

As far as I can tell there are two orthogonal issues in play here:

1) The comment about __GFP_COMP facilitating the sound driver to do
   partial mapping doesn't make much sense. It's probably best to
   WARN_ON immediately in dma_alloc_coherent if __GFP_COMP is
   specified, not only down the call stack in the
   __iommu_dma_alloc_pages() path.

   Note: the CMA paths would already ignore __GFP_COMP if it's
   specified so that __GFP_COMP request can already be ignored. It
   sounds preferable to warn the caller it's asking something it can't
   get, than to silently ignore __GFP_COMP.

   On a side note: hugetlbfs/THP pages can only be allocated with
   __GFP_COMP because for example put_page() must work on all tail
   pages (you can't call compound_head() unless the tail page is part
   of a compound page). But for private driver pages mapped by
   remap_pfn_range, any full or partial mapping is done manually and
   nobody can call GUP on VM_PFNMAP|VM_IO anyway (there's not even the
   requirement of a page struct backing those mappings in fact).

2) __iommu_dma_alloc_pages cannot use __GFP_COMP if it intends to
   return an array of small pages, which is the only thing that the
   current sg_alloc_table_from_pages() supports in input. split_page
   will work as expected to generate small pages from non-compound
   order>0 pages, incidentally it's implement on mm/page_alloc.c, not
   in huge_memory.c.

   split_huge_page as opposed is not intended to be used on newly
   allocated compound page. Maybe we should renamed it to
   split_trans_huge_page to make it more explicit, since it won't even
   work on hugetlbfs (compound) pages.

Thanks,
Andrea

