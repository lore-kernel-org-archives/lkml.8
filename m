Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D37AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D55214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeMZZ4er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCAE70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 23:59:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25878 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgCAE70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 23:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583038763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNM5EcwU6Xrosu2wB4Ut6M3JY1JS6NHiTrWyRpXHF/Y=;
        b=MeMZZ4erTdyk3kjprPk7gM9h4ozqdSDmSBJHWPdJup8eNLbAWkNYpZPKYENCZq0ggR+WKc
        eUg3vn1X9Lvb/IM0+ugjQF3pqWoDEvbyZzYx9MvrTIqU3XHiWNXEAMbOP7O48q9Uw3I6UX
        GSXs+BoUP5pHwl9THBxw+zSyJZMl6T4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-7bgMQm36PpqNaK0uKc1c6Q-1; Sat, 29 Feb 2020 23:59:19 -0500
X-MC-Unique: 7bgMQm36PpqNaK0uKc1c6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8902A107ACC9;
        Sun,  1 Mar 2020 04:59:17 +0000 (UTC)
Received: from localhost (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77C0760BF3;
        Sun,  1 Mar 2020 04:59:13 +0000 (UTC)
Date:   Sun, 1 Mar 2020 12:59:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        osalvador@suse.de, dan.j.williams@intel.com, mhocko@suse.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 2/7] mm/sparse.c: introduce new function
 fill_subsection_map()
Message-ID: <20200301045911.GM24216@MiWiFi-R3L-srv>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-3-bhe@redhat.com>
 <81082609-bac8-5071-c090-3b96f7b07b91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81082609-bac8-5071-c090-3b96f7b07b91@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/20 at 03:27pm, David Hildenbrand wrote:
> On 20.02.20 05:33, Baoquan He wrote:
> > Wrap the codes filling subsection map from section_activate() into
> 
> "Factor out the code that fills the subsection" ...

Fine to me, I will replace it with this. Thanks.

> 
> > fill_subsection_map(), this makes section_activate() cleaner and
> > easier to follow.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/sparse.c | 45 ++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 34 insertions(+), 11 deletions(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index b8e52c8fed7f..977b47acd38d 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -790,24 +790,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >  		ms->section_mem_map = (unsigned long)NULL;
> >  }
> >  
> > -static struct page * __meminit section_activate(int nid, unsigned long pfn,
> > -		unsigned long nr_pages, struct vmem_altmap *altmap)
> > +/**
> > + * fill_subsection_map - fill subsection map of a memory region
> > + * @pfn - start pfn of the memory range
> > + * @nr_pages - number of pfns to add in the region
> > + *
> > + * This fills the related subsection map inside one section, and only
> > + * intended for hotplug.
> > + *
> > + * Return:
> > + * * 0		- On success.
> > + * * -EINVAL	- Invalid memory region.
> > + * * -EEXIST	- Subsection map has been set.
> > + */
> 
> Without this comment (or a massively reduced one :) )

Yeah, as we discussed, I will remove it.

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Thanks,
> 
> David / dhildenb

