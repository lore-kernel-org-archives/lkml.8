Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79C0C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85AB21927
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2lTPZov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBGDgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 22:36:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43067 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726674AbgBGDgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581046608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNfsZMrXvLDDzVoLhL2jmupSGehSTD9Rv6cnjwYywf4=;
        b=e2lTPZov5X9cx3mNVtEcy0XW4TdNuhcf5z/6/MlcDodEDU66xlqoNnpaKmpK4aQ/JR//Wd
        Ohpuq2Q5qO3mnsyd08R+4s7+gYCTES3l40Pk/qU0Ci+aCgQ9NHHsMyHnk+a26hM36V5CPU
        qeYotsiwiEn11WipYwJv+FwRAod1H8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-6F2C0xAQMZucxI96X8Y58Q-1; Thu, 06 Feb 2020 22:36:44 -0500
X-MC-Unique: 6F2C0xAQMZucxI96X8Y58Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA9A01088382;
        Fri,  7 Feb 2020 03:36:42 +0000 (UTC)
Received: from localhost (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96643384;
        Fri,  7 Feb 2020 03:36:39 +0000 (UTC)
Date:   Fri, 7 Feb 2020 11:36:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
Message-ID: <20200207033636.GS8965@MiWiFi-R3L-srv>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-3-richardw.yang@linux.intel.com>
 <CAPcyv4h7dKE85EQ9jR1akXnT6PcG2M2g7YCCLqse=kKieP1H9w@mail.gmail.com>
 <20200207031011.GR8965@MiWiFi-R3L-srv>
 <CAPcyv4jDVe-LZ5OqyV3wJ=7xcXsp5WEtf79fqFPTpRs5KcpA8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jDVe-LZ5OqyV3wJ=7xcXsp5WEtf79fqFPTpRs5KcpA8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 at 07:21pm, Dan Williams wrote:
> On Thu, Feb 6, 2020 at 7:10 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > Hi Dan,
> >
> > On 02/06/20 at 06:19pm, Dan Williams wrote:
> > > On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> > > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > > index b5da121bdd6e..56816f653588 100644
> > > > --- a/mm/sparse.c
> > > > +++ b/mm/sparse.c
> > > > @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> > > >         /* Align memmap to section boundary in the subsection case */
> > > >         if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
> > > >                 section_nr_to_pfn(section_nr) != start_pfn)
> > > > -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
> > > > +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));
> > >
> > > Yes, this looks obviously correct. This might be tripping up
> > > makedumpfile. Do you see any practical effects of this bug? The kernel
> > > mostly avoids ->section_mem_map in the vmemmap case and in the
> > > !vmemmap case section_nr_to_pfn(section_nr) should always equal
> > > start_pfn.
> >
> > The practical effects is that the memmap for the first unaligned section will be lost
> > when destroy namespace to hot remove it. Because we encode the ->section_mem_map
> > into mem_section, and get memmap from the related mem_section to free it in
> > section_deactivate(). In fact in vmemmap, we don't need to encode the ->section_mem_map
> > with memmap.
> 
> Right, but can you actually trigger that in the SPARSEMEM_VMEMMAP=n case?

I think no, the lost memmap should only happen in vmemmap case.

> 
> > By the way, sub-section support is only valid in vmemmap case, right?
> 
> Yes.
> 
> > Seems yes from code, but I don't find any document to prove it.
> 
> check_pfn_span() enforces this requirement.

Thanks for your confirmation. Do you mind if I add some document
sentences somewhere make clear this?

