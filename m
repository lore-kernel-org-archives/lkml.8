Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55E9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6EA2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591304779;
	bh=KbEg3kYnbQKCatClm2Pm8yun8OfgGLWbhLU6TLlAOeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZRXeH2gEgCDd1hT+Ux+v1g/+PWqHVGl4ygXnwvYmFUqIYzjPDyOTAk4p3LG8suaWI
	 E515fGKqj1U9v+XnCJ5lbpvFy0lnNFOpviD+3nHIsVOFcwS/c/E1s6Anl9KdkmE+Fg
	 xo7gzl9XxhiPLZ8yDB2JXOp1P6MMrl19R6PFAEao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgFDVGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgFDVGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:06:18 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99FC92067B;
        Thu,  4 Jun 2020 21:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591304777;
        bh=KbEg3kYnbQKCatClm2Pm8yun8OfgGLWbhLU6TLlAOeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i3ShVfqi5ptVJ/Uj2E1JiTm/xUpO4tgXwyhnoSRsSSlADuUf81XhIx1Q2US4DR5G9
         e9rGKY3wgTpcO9B9R7nIKEFaTxq4aZNTQQ5difxN/BVzlKz1tHUbSUbsVNNlRNnKga
         3K1KRx22usq+EAd4IFJCUKzaHJmJ7lh2+nMyFYes=
Date:   Thu, 4 Jun 2020 14:06:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joerg Roedel <jroedel@suse.de>, Guenter Roeck <linux@roeck-us.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
Message-Id: <20200604140617.e340dd507ee68b0a05bd21cb@linux-foundation.org>
In-Reply-To: <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
References: <20200603232311.GA205619@roeck-us.net>
        <20200604083512.GN6857@suse.de>
        <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 10:16:07 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Jun 4, 2020 at 1:35 AM Joerg Roedel <jroedel@suse.de> wrote:
> >
> > I posted the fix for this already:
> >
> >         https://lore.kernel.org/lkml/20200604074446.23944-1-joro@8bytes.org/
> 
> Ugh.
> 
> I was going to apply this directly, but as I looked at the patch I
> just found it fairly illegible.
> 
> Is there some reason why the 5level-fixup.h versions use that
> very-hard-to-follow macro, rather than the inline functions that the
> main mm.h file uses?
> 
> I'm _assuming_ it's because it gets included in some place where not
> everything is defined yet, so making it a macro means that it works
> (later on) when everything has come together..
> 
> But the solution to that would seem to make all the p.._alloc_track()
> macros just be in a different header file, and make them be all
> together. We already have that
> 
>    #if !__ARCH_HAS_5LEVEL_HACK
> 
> in linux/mm.h, so it's not like we really have isolated that issue
> into just 5level-fixup.h anyway, and creating a new
> <linux/pagetable-alloc.h> header that has all the variations in one
> place, and that is only included by the two (!) users of these things
> would seem to be a good idea regardless.
> 
> Because <linux/mm.h> is included by pretty much everything. Why do we
> have those alloc_track functions defined in such a common header when
> they are _so_ special?
> 
> Please? I'd obviously like this to be fixed on ppc asap, but I'd also
> like the fix to improve on the current somewhat confusing situation..
> 
> For extra point, the p??_alloc_track() functions could even be
> generated from a macro pattern, because the pattern is pretty much set
> in stone.
> 
> I think the only thing that really differs is the types and the
> PGTBL_xyz_MODIFIED mask, and which entry is tested for "none" (which
> is also the only thing that makes the 5level fixup case different -
> no?

As discussed over in
https://lore.kernel.org/linux-mm/20200604164814.GA7600@kernel.org/,
Mike's "mm: remove __ARCH_HAS_5LEVEL_HACK" patchset
(http://lkml.kernel.org/r/20200414153455.21744-1-rppt@kernel.org) is
expected to fix this.  5level-fixup.h gets removed.

I hope to have that patchset sent over later today.
