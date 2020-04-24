Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FAAC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CBB20724
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H3Zm81/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgDXAmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDXAmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 20:42:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B1C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 17:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4AdspqavztR41mCN3oiG0KE8fZVOClkZARRy1ufwIEw=; b=H3Zm81/hes7RES+nwbKtow+CTh
        VzOWJrKeo8KSn/Mv1qbyLDl2B5pwS08COcWMQsfvUzpIYU3gQwYZ5Dw54Kqo9cAE/4uMCn0NC7tDx
        VHVrcn1fUPVmL/MArJwD+E3FzML3qXP3o+TceNuWXhK5CTzGzADGLpHXfeKksn8X1JNziZjohctN+
        dEoAif01nmB5AzFyLKSkjqMxIOaQBU1MhtmZ2j4+53jS4vXU8gFfwG7zWEZshhWKJemAbuDLsng2X
        iOAAZyMV1ewsE0lsf4ZSuWPOi0RDvMDQC4e5JyLZylv2MzeSVmr0JsA1QFMvjPxpBYLBQ3qnrZR2h
        e7/Ec1ZA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRmPg-0007FP-AL; Fri, 24 Apr 2020 00:41:52 +0000
Date:   Thu, 23 Apr 2020 17:41:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 4/4] mm: Add PG_zero support
Message-ID: <20200424004152.GD13910@bombadil.infradead.org>
References: <20200412090945.GA19582@open-light-1.localdomain>
 <20200412101223.GK21484@bombadil.infradead.org>
 <5eb37d79-6420-fcb9-2b4c-6cc6194afcd9@linux.intel.com>
 <20200413140537.eb674579cf8c71b4e20581ab@linux-foundation.org>
 <344a3a78-62ad-48fe-40cf-18993175d1e0@suse.cz>
 <20200423173700.b2c954b3960e4379a4f82e80@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423173700.b2c954b3960e4379a4f82e80@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 05:37:00PM -0700, Andrew Morton wrote:
> On Wed, 22 Apr 2020 16:09:00 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> > Heh, I was quite sure that this is not the first time background zeroing is
> > proposed, so I went to google for it... and found that one BSD kernel actually
> > removed this functionality in 2016 [1] and this was one of the reasons.
> > 
> > [1]
> > https://gitweb.dragonflybsd.org/dragonfly.git/commitdiff/afd2da4dc9056ea79cdf15e8a9386a3d3998f33e
> 
> Interesting.
> 
> However this:
> 
>   - Pre-zeroing a page leads to a cold-cache case on-use, forcing the fault
>     source (e.g. a userland program) to actually get the data from main
>     memory in its likely immediate use of the faulted page, reducing
>     performance.
> 
> implies that BSD was zeroing with non-temporal stores which bypass the
> CPU cache.  And which presumably invalidate any part of the target
> memory which was already in cache.  We wouldn't do it that way so
> perhaps the results would differ.

Or just that the page was zeroed far enough in advance that it fell out
of cache naturally.

I know Arjan looked at zeroing on free instead of zeroing on alloc,
and that didn't get merged (or even submitted afaik), so presumably the
results weren't good.

When I was at Microsoft, there was a usecase that made sense, and that
was virtualisation.  If the hypervisor has zeroed the page before giving
it to the guest, then there's no need for the guest to zero it again.
It's already cache hot, and can be given straight to userspace.
