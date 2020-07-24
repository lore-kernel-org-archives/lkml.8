Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27893C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06751206E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGXXk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:40:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:33322 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbgGXXk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:40:56 -0400
IronPort-SDR: 6/k+66Q2GyQk5r5jjrOdGheaLrEW3Bt0WXPF35sknkTnSjyfeDxLW6XlAX+pDZmGFtXUJVjj6t
 tocOB3dbelDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="152072502"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="152072502"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 16:40:53 -0700
IronPort-SDR: BqdVcPt3MfBCQAQuAdkO5t3owXWmJyO0xcDvlLil8k+ZYMM/xNXpFu+hDa3Ow/TodiDaDesdcY
 AlPT90GnMZLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="272711681"
Received: from assenmac-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.38.15])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2020 16:40:50 -0700
Date:   Sat, 25 Jul 2020 02:40:48 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH v4 3/7] vmalloc: Add text_alloc() and text_free()
Message-ID: <20200724234048.GC1903189@linux.intel.com>
References: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
 <20200717030422.679972-4-jarkko.sakkinen@linux.intel.com>
 <20200718162359.GA2919062@kernel.org>
 <20200723222835.GC12405@linux.intel.com>
 <20200724101302.GF927924@kernel.org>
 <20200724233112.GA1903189@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724233112.GA1903189@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 02:31:16AM +0300, Jarkko Sakkinen wrote:
> On Fri, Jul 24, 2020 at 01:13:02PM +0300, Mike Rapoport wrote:
> > On Fri, Jul 24, 2020 at 01:28:35AM +0300, Jarkko Sakkinen wrote:
> > > On Sat, Jul 18, 2020 at 07:23:59PM +0300, Mike Rapoport wrote:
> > > > On Fri, Jul 17, 2020 at 06:04:17AM +0300, Jarkko Sakkinen wrote:
> > > > > Introduce functions for allocating memory for dynamic trampolines, such
> > > > > as kprobes. An arch can promote the availability of these functions with
> > > > > CONFIG_ARCH_HAS_TEXT_ALLOC. Provide default/fallback implementation
> > > > > wrapping module_alloc() and module_memfree().
> > > > > 
> > > > > Cc: Andi Kleen <ak@linux.intel.com>
> > > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > ---
> > > > >  include/linux/vmalloc.h | 23 +++++++++++++++++++++++
> > > > >  1 file changed, 23 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > > > > index 0221f852a7e1..e981436e30b6 100644
> > > > > --- a/include/linux/vmalloc.h
> > > > > +++ b/include/linux/vmalloc.h
> > > > > @@ -9,6 +9,7 @@
> > > > >  #include <asm/page.h>		/* pgprot_t */
> > > > >  #include <linux/rbtree.h>
> > > > >  #include <linux/overflow.h>
> > > > > +#include <linux/moduleloader.h>
> > > > >  
> > > > >  #include <asm/vmalloc.h>
> > > > >  
> > > > > @@ -249,4 +250,26 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> > > > >  int register_vmap_purge_notifier(struct notifier_block *nb);
> > > > >  int unregister_vmap_purge_notifier(struct notifier_block *nb);
> > > > >  
> > > > > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > > > > +/*
> > > > > + * Allocate memory to be used for dynamic trampoline code.
> > > > > + */
> > > > > +void *text_alloc(unsigned long size);
> > > > > +
> > > > > +/*
> > > > > + * Free memory returned from text_alloc().
> > > > > + */
> > > > > +void text_free(void *region);
> > > > > +#else
> > > > > +static inline void *text_alloc(unsigned long size)
> > > > > +{
> > > > > +	return module_alloc(size);
> > > > > +}
> > > > > +
> > > > > +static inline void text_free(void *region)
> > > > > +{
> > > > > +	module_memfree(region);
> > > > > +}
> > > > 
> > > > Using module_alloc() as the default implementation of generic
> > > > text_alloc() does not sound right to me.
> > > > 
> > > > I would suggest rename module_alloc() to text_alloc() on x86, as Peter
> > > > proposed and then add text_alloc_kprobes() that can be overridden by the
> > > > architectures. x86 could use text_alloc(), arm64 vmalloc() with options
> > > > of their choice and the fallback would remain module_alloc(). Something
> > > > like (untested) patch below:
> > > 
> > > I'm not exactly sure which of the below is relevant as the patch set
> > > includes the exact same changes with maybe different phrasing:
> > 
> > The difference in parsing is what differentiates semantically clean code
> > from duct tape.
> > 
> > As several people pointed out, a single text_alloc(), and apprently a
> > single ARCH_HAS_TEXT_ALLOC, would not fit all architectures and some
> > ground work required to implement a generic text allocation.
> > 
> > Your patch works aroung this for x86 with broken semantics of
> > text_alloc() when ARCH_HAS_TEXT_ALLOC is not defined.
> > 
> > My suggestion does not make text_alloc() a special case of
> > module_alloc() but rather makes text_alloc_kprobes() to fallback to
> > module_alloc() when architecture does not provide its implementation.
> 
> OK, I see your point now. I'll response in detail to v5 comments.
> 
> Thank you.

I also extended the explicit CC list heavily for follow up version.
Apologies if this have been somewhat confusing so far (e.g. getting
only a subportion of patches).

/Jarkko
