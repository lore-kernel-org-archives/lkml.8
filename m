Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C678AC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA0621D56
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 05:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXAqKmma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgCAFkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 00:40:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46925 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725821AbgCAFkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 00:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583041200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3YIHlD0M+k+yxPJl/fAAm98gZtg1wXJwtbyuwCIFlGI=;
        b=LXAqKmmabnWn/rHjPi9dKiV6bGPSUzNPn3IfeAy5s7YIidFuVzAhmKqz05QSH3YiUtUQlX
        oOW8e08dsJ/fe13cUiKbUYq5q8HwE230oReJsicZyV0heUJZqTr+IuTtYA+vTjvwpb3BPS
        xJdOOxW5j4vpN4mR01362dWX9UpHXnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-f3ljMdhqNtu_2RzLzpQL9A-1; Sun, 01 Mar 2020 00:39:58 -0500
X-MC-Unique: f3ljMdhqNtu_2RzLzpQL9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F082800D4E;
        Sun,  1 Mar 2020 05:39:56 +0000 (UTC)
Received: from localhost (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C15605D9C9;
        Sun,  1 Mar 2020 05:39:53 +0000 (UTC)
Date:   Sun, 1 Mar 2020 13:39:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 2/2] mm/memory_hotplug: cleanup __add_pages()
Message-ID: <20200301053950.GO24216@MiWiFi-R3L-srv>
References: <20200228095819.10750-1-david@redhat.com>
 <20200228095819.10750-3-david@redhat.com>
 <20200228103442.GL24216@MiWiFi-R3L-srv>
 <65186cee-358a-5c23-49e0-5507730941ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65186cee-358a-5c23-49e0-5507730941ad@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/20 at 12:14pm, David Hildenbrand wrote:
> On 28.02.20 11:34, Baoquan He wrote:
> > On 02/28/20 at 10:58am, David Hildenbrand wrote:
> >> Let's drop the basically unused section stuff and simplify. The logic
> >> now matches the logic in __remove_pages().
> >>
> >> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Oscar Salvador <osalvador@suse.de>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Cc: Baoquan He <bhe@redhat.com>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: Wei Yang <richardw.yang@linux.intel.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/memory_hotplug.c | 18 +++++++-----------
> >>  1 file changed, 7 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >> index 8fe7e32dad48..1a00b5a37ef6 100644
> >> --- a/mm/memory_hotplug.c
> >> +++ b/mm/memory_hotplug.c
> >> @@ -307,8 +307,9 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
> >>  int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
> >>  		struct mhp_restrictions *restrictions)
> >>  {
> >> +	const unsigned long end_pfn = pfn + nr_pages;
> >> +	unsigned long cur_nr_pages;
> >>  	int err;
> >> -	unsigned long nr, start_sec, end_sec;
> >>  	struct vmem_altmap *altmap = restrictions->altmap;
> >>  
> >>  	err = check_hotplug_memory_addressable(pfn, nr_pages);
> >> @@ -331,18 +332,13 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
> >>  	if (err)
> >>  		return err;
> >>  
> >> -	start_sec = pfn_to_section_nr(pfn);
> >> -	end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> >> -	for (nr = start_sec; nr <= end_sec; nr++) {
> >> -		unsigned long pfns;
> >> -
> >> -		pfns = min(nr_pages, PAGES_PER_SECTION
> >> -				- (pfn & ~PAGE_SECTION_MASK));
> >> -		err = sparse_add_section(nid, pfn, pfns, altmap);
> >> +	for (; pfn < end_pfn; pfn += cur_nr_pages) {
> >> +		/* Select all remaining pages up to the next section boundary */
> >> +		cur_nr_pages = min(end_pfn - pfn,
> >> +				   SECTION_ALIGN_UP(pfn + 1) - pfn);
> >> +		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap);
> > 
> > Honestly, I am not a big fan of this kind of code refactoring. The old
> > code may span seveal more lines or define several several more veriables,
> > but logic is clear, and no visible defect. It's hard to say how much we
> 
> I'm sorry, but iterating over variables and not using a single one in
> the body is definitely not clean, at least IMHO. Leftover from

Hmm, sometime we do use iterator to loop over only, it's just not so good.
People usually have their own preferred coding style, and try to optimize to
remove the itch in heart, totally understand. I have no strong objection
to this, as long as it gets support from reviewers, it's not a bad
thing.

> sub-section hotadd support.
> 
> > can benefit from this kind of code simplifying, and reviewing it will take
> > people more time. While for the code style consistency with
> > __remove_page(), I would like to see it's merged. My personal opinion.
> 
> Thanks!
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb

