Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DFDC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF6F206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3kUGi5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCYIgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:36:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44069 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbgCYIgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sdYIddxfgLwXOGvGXxs8sWbwIPBrEhwforhRRHvBbFw=;
        b=h3kUGi5DP+IScIVdpJMLkySBfFIKLMn4AfNZ9v4bHbKoDums6IUGLOL3fz+uOwMEhRKJPr
        Xo7LlcTvnCjQEOxSTJMlKSBlWdJxF6Q36c7E5X58sPL/6cO4If4A1NAozdc4fly0cvullK
        R2qKk66vF2Ag9ut1wP8jTkCyllFcGoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-XhB42Jt9P6iZjwf7I6OJXQ-1; Wed, 25 Mar 2020 04:36:49 -0400
X-MC-Unique: XhB42Jt9P6iZjwf7I6OJXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10349190B2A1;
        Wed, 25 Mar 2020 08:36:47 +0000 (UTC)
Received: from localhost (ovpn-12-88.pek2.redhat.com [10.72.12.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6544A7F1;
        Wed, 25 Mar 2020 08:36:40 +0000 (UTC)
Date:   Wed, 25 Mar 2020 16:36:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        dan.j.williams@intel.com, mhocko@kernel.org, david@redhat.com
Subject: Re: [PATCH] mm/sparse: Fix kernel crash with pfn_section_valid check
Message-ID: <20200325083637.GJ3039@MiWiFi-R3L-srv>
References: <20200325031914.107660-1-aneesh.kumar@linux.ibm.com>
 <20200325070643.GH3039@MiWiFi-R3L-srv>
 <20200325073707.GI3039@MiWiFi-R3L-srv>
 <5cdf5334-7fbb-8427-1918-ed67d5f23834@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cdf5334-7fbb-8427-1918-ed67d5f23834@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/20 at 01:42pm, Aneesh Kumar K.V wrote:
> On 3/25/20 1:07 PM, Baoquan He wrote:
> > On 03/25/20 at 03:06pm, Baoquan He wrote:
> > > On 03/25/20 at 08:49am, Aneesh Kumar K.V wrote:
> > 
> > > >   mm/sparse.c | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > > index aadb7298dcef..3012d1f3771a 100644
> > > > --- a/mm/sparse.c
> > > > +++ b/mm/sparse.c
> > > > @@ -781,6 +781,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> > > >   			ms->usage = NULL;
> > > >   		}
> > > >   		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> > > > +		/* Mark the section invalid */
> > > > +		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
> > > 
> > > Not sure if we should add checking in valid_section() or pfn_valid(),
> > > e.g check ms->usage validation too. Otherwise, this fix looks good to
> > > me.
> > 
> > With SPASEMEM_VMEMAP enabled, we should do validation check on ms->usage
> > before checking any subsection is valid. Since now we do have case
> > in which ms->usage is released, people still try to check it.
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index f0a2c184eb9a..d79bd938852e 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1306,6 +1306,8 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
> >   {
> >   	int idx = subsection_map_index(pfn);
> > +	if (!ms->usage)
> > +		return 0;
> >   	return test_bit(idx, ms->usage->subsection_map);
> >   }
> >   #else
> > 
> 
> We always check for section valid, before we check if pfn_section_valid().
> 
> static inline int pfn_valid(unsigned long pfn)
> 
> 	struct mem_section *ms;
> 
> 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> 		return 0;
> 	ms = __nr_to_section(pfn_to_section_nr(pfn));
> 	if (!valid_section(ms))
> 		return 0;
> 	/*
> 	 * Traditionally early sections always returned pfn_valid() for
> 	 * the entire section-sized span.
> 	 */
> 	return early_section(ms) || pfn_section_valid(ms, pfn);
> }
> 
> 
> IMHO adding that if (!ms->usage) is redundant.

Yeah, I tend to agree. Consider this happens in the only small window
between ms->usage releasing and ms->section_mem_map releasing when
removing a section. Just thought adding this check to enhance it even
though we have had your fix, because we only check ms->section_mem_map
in valid_section(). Anyway, your fix looks good to me, see if other
people have any comment.

Thanks
Baoquan

