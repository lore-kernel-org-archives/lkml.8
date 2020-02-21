Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C43FC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CED208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByW91E7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgBUO3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:29:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31551 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgBUO3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582295339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qHYxqjiQ0oEmxCIWDFBXrjd9RI939ficZCOAX/384U=;
        b=ByW91E7Uc1HvfPjdcs6rceHBcm1EWxyfm7QldiS5IV05WXEtXugz8FlOpEmsD1T95tpln9
        iibnfxPqfVYlUEs338g/L09FB3Lh0xd+jXhY7UFs5UcHZYJQmOdk4CJ3AT+gXoW9ruVv8u
        XBg1CLwMFiPtP8DkTM9CV3pDZQG8p+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-GjHpkPtaOOe_H6ATf9zyuQ-1; Fri, 21 Feb 2020 09:28:55 -0500
X-MC-Unique: GjHpkPtaOOe_H6ATf9zyuQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66488800EB4;
        Fri, 21 Feb 2020 14:28:53 +0000 (UTC)
Received: from localhost (ovpn-13-17.pek2.redhat.com [10.72.13.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 313C25D9C5;
        Fri, 21 Feb 2020 14:28:49 +0000 (UTC)
Date:   Fri, 21 Feb 2020 22:28:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 0/7] mm/hotplug: Only use subsection map in VMEMMAP
 case
Message-ID: <20200221142847.GG4937@MiWiFi-R3L-srv>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220103849.GG20509@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220103849.GG20509@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/20 at 11:38am, Michal Hocko wrote:
> On Thu 20-02-20 12:33:09, Baoquan He wrote:
> > Memory sub-section hotplug was added to fix the issue that nvdimm could
> > be mapped at non-section aligned starting address. A subsection map is
> > added into struct mem_section_usage to implement it. However, sub-section
> > is only supported in VMEMMAP case.
> 
> Why? Is there any fundamental reason or just a lack of implementation?
> VMEMMAP should be really only an implementation detail unless I am
> missing something subtle.

Thanks for checking.

VMEMMAP is one of two ways to convert a PFN to the corresponding
'struct page' in SPARSE model. I mentioned them as VMEMMAP case, or
!VMEMMAP case because we called them like this previously when reviewed
patches, hope it won't cause confusion.

Currently, config ZONE_DEVICE depends on SPARSEMEM_VMEMMAP. The
subsection_map is added to struct mem_section_usage to track which sub
section is present, VMEMMAP fills those bits which corresponding
sub-sections are present, while !VMEMMAP, namely classic SPARSE, fills
the whole map always.

As we know, VMEMMAP builds page table to map a cluster of 'struct page'
into the corresponding area of 'vmemmap'. Subsection hotplug can be
supported naturally, w/o any change, just map needed region related to
sub-sections on demand. For !VMEMMAP, it allocates memmap with
alloc_pages() or vmalloc, thing is a little complicated, e.g the mixed
section, boot memory occupies the starting area, later pmem hot added to
the rear part.

About !VMEMMAP which doesn't support sub-section hotplog, Dan said 
it's more because the effort and maintenance burden outweighs the
benefit. And the current 64 bit ARCHes all enable
SPARSEMEM_VMEMMAP_ENABLE by default.

So no need to keep subsection_map and its handling in SPARSE|!VMEMMAP.

> 
> > Hence there's no need to operate
> > subsection map in SPARSEMEM|!VMEMMAP case. In this patchset, change
> > codes to make sub-section map and the relevant operation only available
> > in VMEMMAP case.
> > 
> > And since sub-section hotplug added, the hot add/remove functionality
> > have been broken in SPARSEMEM|!VMEMMAP case. Wei Yang and I, each of us
> > make one patch to fix one of the failures. In this patchset, the patch
> > 1/7 from me is used to fix the hot remove failure. Wei Yang's patch has
> > been merged by Andrew.
> 
> Not sure I understand. Are there more issues to be fixed?

Only these two. Wei Yang firstly posted the patch to fix the hot add
failure in SPARSE|!VMEMMAP. When I reviewed his patch and tested, found
hot remove failed too. So the patch 1/7 is to fix the hot remove failure
in !VMEMMAP. With these two patches, hot add/remove works well in !VMEMMAP.
Not sure if it's clear.

> >  include/linux/mmzone.h |   2 +
> >  mm/sparse.c            | 178 +++++++++++++++++++++++++++++------------
> >  2 files changed, 127 insertions(+), 53 deletions(-)
> 
> Why do we need to add so much code to remove a functionality from one
> memory model?

Hmm, Dan also asked this before.

The adding mainly happens in patch 2, 3, 4, including the two newly
added function defitions, the code comments above them, and those added
dummy functions for !VMEMMAP.

Thanks
Baoquan

