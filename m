Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A0C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 02:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602A4214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 02:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl2cILSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgBFCsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 21:48:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48995 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727307AbgBFCs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 21:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580957308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=scPthlMCXPeadRfg0S1DOYHQjNbqePUziN1beyiv4iw=;
        b=cl2cILSIJ4NwXJhY7Dp/37xaX8Z6FPRbsLaTikqYJro6GAH4giholxbFM4A4uFza0//7mQ
        pGVQnWMquQB6k+ZfahoCj1XBWYekQGIrGRoiZLnPj7+G/TadK3prBh9f9jqxWpqOclXQmo
        br+iEtZyupJzqvmGV1TWl2AnDW+/oVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-OdVFOAnnPdmHaHjcIcFyPw-1; Wed, 05 Feb 2020 21:48:24 -0500
X-MC-Unique: OdVFOAnnPdmHaHjcIcFyPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD46218AB2C0;
        Thu,  6 Feb 2020 02:48:22 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BAD960BF7;
        Thu,  6 Feb 2020 02:48:19 +0000 (UTC)
Date:   Thu, 6 Feb 2020 10:48:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: Easier calculation to get pages to
 next section boundary
Message-ID: <20200206024816.GK8965@MiWiFi-R3L-srv>
References: <20200205135251.37488-1-david@redhat.com>
 <20200205231945.GB28446@richard>
 <20200205235007.GA28870@richard>
 <20200206001317.GH8965@MiWiFi-R3L-srv>
 <20200206003736.GI8965@MiWiFi-R3L-srv>
 <20200206022644.6u7pxf7by2w5trmi@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206022644.6u7pxf7by2w5trmi@master>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 at 02:26am, Wei Yang wrote:
> On Thu, Feb 06, 2020 at 08:37:36AM +0800, Baoquan He wrote:
> >On 02/06/20 at 08:13am, Baoquan He wrote:
> >> On 02/06/20 at 07:50am, Wei Yang wrote:
> >> > On Thu, Feb 06, 2020 at 07:19:45AM +0800, Wei Yang wrote:
> >> > >On Wed, Feb 05, 2020 at 02:52:51PM +0100, David Hildenbrand wrote:
> >> > >>Let's use a calculation that's easier to understand and calculates the
> >> > >>same result. Reusing existing macros makes this look nicer.
> >> > >>
> >> > >>We always want to have the number of pages (> 0) to the next section
> >> > >>boundary, starting from the current pfn.
> >> > >>
> >> > >>Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> >> > >>Cc: Andrew Morton <akpm@linux-foundation.org>
> >> > >>Cc: Michal Hocko <mhocko@kernel.org>
> >> > >>Cc: Oscar Salvador <osalvador@suse.de>
> >> > >>Cc: Baoquan He <bhe@redhat.com>
> >> > >>Cc: Wei Yang <richardw.yang@linux.intel.com>
> >> > >>Signed-off-by: David Hildenbrand <david@redhat.com>
> >> > >
> >> > >Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> >> > >
> >> > >BTW, I got one question about hotplug size requirement.
> >> > >
> >> > >I thought the hotplug range should be section size aligned, while taking a
> >> > >look into current code function check_hotplug_memory_range() guard the range.
> >> 
> >> A good question. The current code should be block size aligned. I
> >> remember in some places we assume each block comprise all the sections.
> >> Can't imagine one or some of them are half section filled.
> >
> >I could be wrong, half filled block may not cause problem. 
> >
> 
> David must be angry about our flooding the mail list :-)

Believe he won't, :-) If you like, we can talk off line.

> 
> Check the code again, there are two memory range check:
> 
>   * check_hotplug_memory_range(), block/section aligned
>   * check_pfn_span(), subsection aligned
> 
> The second check, check_pfn_span() in __add_pages(), enable the capability to
> add a memory range with subsection size.
> 
> This means hotplug still keeps section alignment.

memremap_pages() also call add_pages(), it doesn't have the
check_hotplug_memory_range() invocation. check_pfn_span() is made for
it specifically.

> 
> BTW, __add_pages() share the same logic as __remove_pages(). Why not change it
> too? Do I miss something or I don't have the latest source code?

Good question, and I think it need. Just David is refactoring/cleaning
up the remove_pages() code path, this is found out by Segher from patch
reviewing.

