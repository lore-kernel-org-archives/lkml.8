Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB272C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAD522464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuUu2WL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBGDuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 22:50:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57416 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727131AbgBGDuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581047434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cx8e2wfAv9dePW9BR8XJjN0ewzvUtV9OKTioZ+Wm6BA=;
        b=cuUu2WL/twcExMymMpnvqibLKGnAxStHWoYcz+H+v+4e3wVoC3w+Az1Ehbrc3e6XxBQ1Kf
        tXCmW/FiU3z22goY84qhxzekO97u3/x8/mNSO6OChX7G2exlD5QM0LUvYIRteDL9QWugnW
        T3agiJ/WVkTRdtPmadBFJnluAw+sahs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-6GQjwyIGP5GxR10_2uQUXQ-1; Thu, 06 Feb 2020 22:50:30 -0500
X-MC-Unique: 6GQjwyIGP5GxR10_2uQUXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F24C9802CAC;
        Fri,  7 Feb 2020 03:50:28 +0000 (UTC)
Received: from localhost (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08EF55DA7D;
        Fri,  7 Feb 2020 03:50:25 +0000 (UTC)
Date:   Fri, 7 Feb 2020 11:50:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 3/3] mm/sparsemem: avoid memmap overwrite for
 non-SPARSEMEM_VMEMMAP
Message-ID: <20200207035023.GT8965@MiWiFi-R3L-srv>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
 <20200206231629.14151-4-richardw.yang@linux.intel.com>
 <CAPcyv4hLW5Ww1Bo0MmNi8fzUNQEvudtWpGOK23MWaiqQ+MemfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hLW5Ww1Bo0MmNi8fzUNQEvudtWpGOK23MWaiqQ+MemfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 at 06:06pm, Dan Williams wrote:
> On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> >
> > In case of SPARSEMEM, populate_section_memmap() would allocate memmap
> > for the whole section, even we just want a sub-section. This would lead
> > to memmap overwrite if we a sub-section to an already populated section.
> >
> > Just return the populated memmap for non-SPARSEMEM_VMEMMAP case.
> >
> > Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > CC: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  mm/sparse.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 56816f653588..c75ca40db513 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -836,6 +836,16 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >         if (nr_pages < PAGES_PER_SECTION && early_section(ms))
> >                 return pfn_to_page(pfn);
> >
> > +       /*
> > +        * If it is not SPARSEMEM_VMEMMAP, we always populate memmap for the
> > +        * whole section, even for a sub-section.
> > +        *
> > +        * Return its memmap if already populated to avoid memmap overwrite.
> > +        */
> > +       if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
> > +               valid_section(ms))
> > +               return __section_mem_map_addr(ms);
> 
> Again, is check_pfn_span() failing to prevent this path?

The answer should be yes, this patch is not needed.

> 

