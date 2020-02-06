Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8B7C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 00:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1CA2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 00:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDmKe+3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgBFAht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:37:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34297 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727306AbgBFAhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 19:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580949468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Z6nE63gkylXxznMu19+y8UaaSgJhxKrGIJf/yXmjUY=;
        b=BDmKe+3qGBwa3hnRvSSeVlTDycXwKtIadDuZWOpimaQzKvndThSp6H5pHKqDuoR24CjlqU
        JitoUmFJRd3+M4Vc6P0DTGAv95ipDOWLFjU3ZsAOcIk3H/90PUhFT2v531xOhdiBYovhUA
        ZpQJRhbJ44zeBkSJNSRoVcrkWiK00eU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-fQOd-l-lNTSkXVrIatLn2g-1; Wed, 05 Feb 2020 19:37:44 -0500
X-MC-Unique: fQOd-l-lNTSkXVrIatLn2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 935B11005513;
        Thu,  6 Feb 2020 00:37:42 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77E9D60BF7;
        Thu,  6 Feb 2020 00:37:39 +0000 (UTC)
Date:   Thu, 6 Feb 2020 08:37:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: Easier calculation to get pages to
 next section boundary
Message-ID: <20200206003736.GI8965@MiWiFi-R3L-srv>
References: <20200205135251.37488-1-david@redhat.com>
 <20200205231945.GB28446@richard>
 <20200205235007.GA28870@richard>
 <20200206001317.GH8965@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206001317.GH8965@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 at 08:13am, Baoquan He wrote:
> On 02/06/20 at 07:50am, Wei Yang wrote:
> > On Thu, Feb 06, 2020 at 07:19:45AM +0800, Wei Yang wrote:
> > >On Wed, Feb 05, 2020 at 02:52:51PM +0100, David Hildenbrand wrote:
> > >>Let's use a calculation that's easier to understand and calculates the
> > >>same result. Reusing existing macros makes this look nicer.
> > >>
> > >>We always want to have the number of pages (> 0) to the next section
> > >>boundary, starting from the current pfn.
> > >>
> > >>Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> > >>Cc: Andrew Morton <akpm@linux-foundation.org>
> > >>Cc: Michal Hocko <mhocko@kernel.org>
> > >>Cc: Oscar Salvador <osalvador@suse.de>
> > >>Cc: Baoquan He <bhe@redhat.com>
> > >>Cc: Wei Yang <richardw.yang@linux.intel.com>
> > >>Signed-off-by: David Hildenbrand <david@redhat.com>
> > >
> > >Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> > >
> > >BTW, I got one question about hotplug size requirement.
> > >
> > >I thought the hotplug range should be section size aligned, while taking a
> > >look into current code function check_hotplug_memory_range() guard the range.
> 
> A good question. The current code should be block size aligned. I
> remember in some places we assume each block comprise all the sections.
> Can't imagine one or some of them are half section filled.

I could be wrong, half filled block may not cause problem. 

> 
> It truly has a risk that system ram is very huge to make the block
> size is 2G, someone try to insert a 1G memory board. However, it should
> only exist in experiment environment, e.g build a guest with enough ram,
> then hot add 1G DIMM. In reality, we don't need to worry about it, at
> least what I saw is 512G order of magnitude.
> 
> > >
> > >This function says the range should be block_size aligned. And if I am
> > >correct, block size on x86 should be in the range
> > >
> > >    [MIN_MEMORY_BLOCK_SIZE, MEM_SIZE_FOR_LARGE_BLOCK]
> > >    
> > >And MIN_MEMORY_BLOCK_SIZE is section size.
> 
> No, if I got it right, the range on x86 is
> [MIN_MEMORY_BLOCK_SIZE, MAX_BLOCK_SIZE].
> 
> MEM_SIZE_FOR_LARGE_BLOCK is the starting point from which block size can
> be adjusted. Otherwise it's MIN_MEMORY_BLOCK_SIZE.
> 
> /* Amount of ram needed to start using large blocks */                                                                                            
> #define MEM_SIZE_FOR_LARGE_BLOCK (64UL << 30)
> 
> > >
> > >Seems currently we support subsection hotplug? Then how a subsection range got
> > >hotplug? Or this patch is a pre-requisite?
> 
> The sub-section hotplug feature was added by your colleague Dan
> Williams. It intends to fix a nvdimms issue that nvdimms device could be
> mapped into a non section size aligned starting address. And nvdimms
> makes use of the existing memory hotplug mechanism to manage pages.
> Not sure if we are saying the same thing.
> 
> > >
> > 
> > One more question is we support hot-add subsection memory but not support
> > hot-online subsection memory.
> > 
> > Is my understanding correct?
> > 
> > -- 
> > Wei Yang
> > Help you, Help me
> > 

