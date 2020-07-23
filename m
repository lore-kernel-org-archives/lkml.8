Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793E6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4709820825
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgGWW2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:28:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:61172 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgGWW2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:28:39 -0400
IronPort-SDR: fDaO3YeD9eLDbsj7iS/hg6PkrvMUutGPAvxAefIoqrEsP9JsfYd3kFBHwLiQEZlMY/C8s4d7Km
 /t0bG2aI1CHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="148552515"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="148552515"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 15:28:38 -0700
IronPort-SDR: 12e5EXJKPrvHJpozBK7ppGhRLaekf3U7FE30h8xFNpdgHvX/QEGaM+J0OQPJ444D8waIBIFc/X
 YFSHVKtVhWNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="272424091"
Received: from abdelh1x-mobl.amr.corp.intel.com (HELO localhost) ([10.249.38.107])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jul 2020 15:28:36 -0700
Date:   Fri, 24 Jul 2020 01:28:35 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH v4 3/7] vmalloc: Add text_alloc() and text_free()
Message-ID: <20200723222835.GC12405@linux.intel.com>
References: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
 <20200717030422.679972-4-jarkko.sakkinen@linux.intel.com>
 <20200718162359.GA2919062@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718162359.GA2919062@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 07:23:59PM +0300, Mike Rapoport wrote:
> On Fri, Jul 17, 2020 at 06:04:17AM +0300, Jarkko Sakkinen wrote:
> > Introduce functions for allocating memory for dynamic trampolines, such
> > as kprobes. An arch can promote the availability of these functions with
> > CONFIG_ARCH_HAS_TEXT_ALLOC. Provide default/fallback implementation
> > wrapping module_alloc() and module_memfree().
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  include/linux/vmalloc.h | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 0221f852a7e1..e981436e30b6 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -9,6 +9,7 @@
> >  #include <asm/page.h>		/* pgprot_t */
> >  #include <linux/rbtree.h>
> >  #include <linux/overflow.h>
> > +#include <linux/moduleloader.h>
> >  
> >  #include <asm/vmalloc.h>
> >  
> > @@ -249,4 +250,26 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> >  int register_vmap_purge_notifier(struct notifier_block *nb);
> >  int unregister_vmap_purge_notifier(struct notifier_block *nb);
> >  
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +/*
> > + * Allocate memory to be used for dynamic trampoline code.
> > + */
> > +void *text_alloc(unsigned long size);
> > +
> > +/*
> > + * Free memory returned from text_alloc().
> > + */
> > +void text_free(void *region);
> > +#else
> > +static inline void *text_alloc(unsigned long size)
> > +{
> > +	return module_alloc(size);
> > +}
> > +
> > +static inline void text_free(void *region)
> > +{
> > +	module_memfree(region);
> > +}
> 
> Using module_alloc() as the default implementation of generic
> text_alloc() does not sound right to me.
> 
> I would suggest rename module_alloc() to text_alloc() on x86, as Peter
> proposed and then add text_alloc_kprobes() that can be overridden by the
> architectures. x86 could use text_alloc(), arm64 vmalloc() with options
> of their choice and the fallback would remain module_alloc(). Something
> like (untested) patch below:

I'm not exactly sure which of the below is relevant as the patch set
includes the exact same changes with maybe different phrasing:

https://lore.kernel.org/lkml/20200717030422.679972-1-jarkko.sakkinen@linux.intel.com/

If there is something that these patches are missing, please do remark
but these seven patches have been at least tested and split in
reasonable manner.

/Jarkko
