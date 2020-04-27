Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC253C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30222072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588019453;
	bh=3OaU0s347QfqeFqIzMECGLi3g6NTgnY6bjs+lqsqumo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=C5swaLuqg+72oewR5eJN6MzKSIiZa/Uk8DWPGpeogrugR4j1fwIaOqfpqH/hIxtPu
	 mli5Zri0m1L9r2vsZlWMSjCtqLWhY4+2wYNtN1YvguaGja8ZJBq0+3D1qNgMZj5HaX
	 sTssk1+aVq47PstfFAhs0cy/HUmWMLkWq2NHSeXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgD0Uax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgD0Uaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:30:52 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04AD7206D4;
        Mon, 27 Apr 2020 20:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588019452;
        bh=3OaU0s347QfqeFqIzMECGLi3g6NTgnY6bjs+lqsqumo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WqOkTOeEGwBaKAM+DhtEkIARd8K6PGThTZPLzxxNPuk0yjqwzqWZ/yv2BR3ViUPTQ
         G9Z5skn6CjwjQesmvO+yI62J2raArApqb0KUyhxrZPBZhp8Q5p3/UmRQTZZxD7iSFH
         sTaegxf/bjyaKpzRobuOVZ1rqVDWIGjnViFb8NwQ=
Date:   Mon, 27 Apr 2020 13:30:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start
 failing soon
Message-Id: <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
        <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
        <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Apr 2020 20:12:58 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> > > blockable allocations and then queue a worker to asynchronously oom kill
> > > if it finds watermarks to be sufficiently low as well.
> > > 
> > 
> > Well, what's really going on here?
> > 
> > Is networking potentially consuming an unbounded amount of memory?  If
> > so, then killing a process will just cause networking to consume more
> > memory then hit against the same thing.  So presumably the answer is
> > "no, the watermarks are inappropriately set for this workload".
> > 
> > So would it not be sensible to dynamically adjust the watermarks in
> > response to this condition?  Maintain a larger pool of memory for these
> > allocations?  Or possibly push back on networking and tell it to reduce
> > its queue sizes?  So that stuff doesn't keep on getting oom-killed?
> > 
> 
> No - that would actually make the problem worse.
> 
> Today, per-zone min watermarks dictate when user allocations will loop or 
> oom kill.  should_reclaim_retry() currently loops if reclaim has succeeded 
> in the past few tries and we should be able to allocate if we are able to 
> reclaim the amount of memory that we think we can.
> 
> The issue is that this supposes that looping to reclaim more will result 
> in more free memory.  That doesn't always happen if there are concurrent 
> memory allocators.
> 
> GFP_ATOMIC allocators can access below these per-zone watermarks.  So the 
> issue is that per-zone free pages stays between ALLOC_HIGH watermarks 
> (the watermark that GFP_ATOMIC allocators can allocate to) and min 
> watermarks.  We never reclaim enough memory to get back to min watermarks 
> because reclaim cannot keep up with the amount of GFP_ATOMIC allocations.

But there should be an upper bound upon the total amount of in-flight
GFP_ATOMIC memory at any point in time?  These aren't like pagecache
which will take more if we give it more.  Setting the various
thresholds appropriately should ensure that blockable allocations don't
get their memory stolen by GPP_ATOMIC allocations?

I took a look at doing a quick-fix for the
direct-reclaimers-get-their-stuff-stolen issue about a million years
ago.  I don't recall where it ended up.  It's pretty trivial for the
direct reclaimer to free pages into current->reclaimed_pages and to
take a look in there on the allocation path, etc.  But it's only
practical for order-0 pages.

