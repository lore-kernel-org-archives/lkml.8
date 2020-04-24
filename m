Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA12C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6302E21473
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587688623;
	bh=tC2001WkgCBwNlCeRGsPzZqCfwtG295aimilTWbtkPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=l17JPxSyncmU2lBNm2Y9ZE+fKiCf/zPNHPdM2xHH+kxn1PmzoYhhm8wy4Mef7Brx2
	 e4QZ2+QMVu1wvr5oXMmgNMAJCNtk0AxkqDf5s37VGO2ZYugLToSvd6Opc9YuKpMoEP
	 /4bVRTC4nGpVweGdd7+svawooIzBfxwhCdzOAAdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgDXAhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbgDXAhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 20:37:02 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB9F20724;
        Fri, 24 Apr 2020 00:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587688621;
        bh=tC2001WkgCBwNlCeRGsPzZqCfwtG295aimilTWbtkPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mCcuVeIxrvSePAS4k6nimdfYFtNup9/RbCL8uQOKtsUv1PIhP3zQ420IcUVF4qPOZ
         hw+2Pte9WnQGQLDmBjLhybNgT1iYhcX0MiyH/qnxsrbvvvCaR3OyF9Gjs4DTYb0NOZ
         9LMi8hZsa+qoYSJYWwj5+mK1ys6TNdGkeYA8GXFQ=
Date:   Thu, 23 Apr 2020 17:37:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 4/4] mm: Add PG_zero support
Message-Id: <20200423173700.b2c954b3960e4379a4f82e80@linux-foundation.org>
In-Reply-To: <344a3a78-62ad-48fe-40cf-18993175d1e0@suse.cz>
References: <20200412090945.GA19582@open-light-1.localdomain>
        <20200412101223.GK21484@bombadil.infradead.org>
        <5eb37d79-6420-fcb9-2b4c-6cc6194afcd9@linux.intel.com>
        <20200413140537.eb674579cf8c71b4e20581ab@linux-foundation.org>
        <344a3a78-62ad-48fe-40cf-18993175d1e0@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 16:09:00 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 4/13/20 11:05 PM, Andrew Morton wrote:
> > On Mon, 13 Apr 2020 08:11:59 -0700 Alexander Duyck <alexander.h.duyck@linux.intel.com> wrote:
> > 
> >> In addition, unlike madvising the page away there is a pretty 
> >> significant performance penalty for having to clear the page a second 
> >> time when the page is split or merged.
> > 
> > I wonder if there might be an issue with increased memory traffic (and
> > increased energy consumption, etc).  If a page is zeroed immediately
> > before getting data written into it (eg, plain old file write(),
> > anonymous pagefault) then we can expect that those 4096 zeroes will be
> > in CPU cache and mostly not written back.  But if that page was zeroed
> > a "long" time ago, the caches will probably have been written back. 
> > Net result: we go from 4k of memory traffic for a 4k page up to 8k of
> > memory traffic?
> 
> Heh, I was quite sure that this is not the first time background zeroing is
> proposed, so I went to google for it... and found that one BSD kernel actually
> removed this functionality in 2016 [1] and this was one of the reasons.
> 
> [1]
> https://gitweb.dragonflybsd.org/dragonfly.git/commitdiff/afd2da4dc9056ea79cdf15e8a9386a3d3998f33e

Interesting.

However this:

  - Pre-zeroing a page leads to a cold-cache case on-use, forcing the fault
    source (e.g. a userland program) to actually get the data from main
    memory in its likely immediate use of the faulted page, reducing
    performance.

implies that BSD was zeroing with non-temporal stores which bypass the
CPU cache.  And which presumably invalidate any part of the target
memory which was already in cache.  We wouldn't do it that way so
perhaps the results would differ.


