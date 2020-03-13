Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703B9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43249206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCMPDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:03:08 -0400
Received: from foss.arm.com ([217.140.110.172]:56758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCMPDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:03:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DC3331B;
        Fri, 13 Mar 2020 08:03:03 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A1893F67D;
        Fri, 13 Mar 2020 08:03:02 -0700 (PDT)
Date:   Fri, 13 Mar 2020 15:03:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] arm64: define __alloc_zeroed_user_highpage
Message-ID: <20200313150300.GD3857972@arrakis.emea.arm.com>
References: <20200312155920.50067-1-glider@google.com>
 <20200312164922.GC21120@lakrids.cambridge.arm.com>
 <CAG_fn=VfRW6Gi-a9WCMwoK1-Nc+i+NFLN3ZyhFAUzr-K3LeaZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VfRW6Gi-a9WCMwoK1-Nc+i+NFLN3ZyhFAUzr-K3LeaZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 08:59:28PM +0100, Alexander Potapenko wrote:
> On Thu, Mar 12, 2020 at 5:49 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Thu, Mar 12, 2020 at 04:59:20PM +0100, glider@google.com wrote:
> > > When running the kernel with init_on_alloc=1, calling the default
> > > implementation of __alloc_zeroed_user_highpage() from include/linux/highmem.h
> > > leads to double-initialization of the allocated page (first by the page
> > > allocator, then by clear_user_page().
> > > Calling alloc_page_vma() with __GFP_ZERO, similarly to e.g. x86, seems
> > > to be enough to ensure the user page is zeroed only once.
> >
> > Just to check, is there a functional ussue beyond the redundant zeroing,
> > or is this jsut a performance issue?
> 
> This is just a performance issue that only manifests when running the
> kernel with init_on_alloc=1.
> 
> > On architectures with real highmem, does GFP_HIGHUSER prevent the
> > allocator from zeroing the page in this case, or is the architecture
> > prevented from allocating from highmem?
> 
> I was hoping one of ARM maintainers can answer this question. My
> understanding was that __GFP_ZERO should be sufficient, but there's
> probably something I'm missing.

On architectures with aliasing D-cache (whether it's VIVT or aliasing
VIPT), clear_user_highpage() ensures that the correct alias, as seen by
the user, is cleared (see the arm32 v6_clear_user_highpage_aliasing() as
an example). The clear_highpage() call as done by page_alloc.c does not
have the user address information, so it can only clear the kernel
alias.

On arm64 we don't have such issue, so we can optimise this case as per
your patch. We may change this function later with MTE if we allow tags
other than 0 on the first allocation of anonymous pages.

-- 
Catalin
