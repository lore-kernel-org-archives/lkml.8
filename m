Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747B3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518792070C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGYDTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 23:19:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:64414 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgGYDTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:19:19 -0400
IronPort-SDR: p1fCmPYYJggvcYmHPaywObo2/8T0/KAWO4dAHiSVm/gM9toWuh2Cj4G6+B+r60DFzalZ9cYkxn
 kraHVn76qoGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="150801395"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="150801395"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 20:19:19 -0700
IronPort-SDR: rF/DkQl54TI4Kf7+dlXHs3+a+C2DbqtD6D7pz5Fjiclb1b+Wq8Nd2Ee4WrJzgbyUzdgZM1Szvp
 tE+SJlCJ+m1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="363549309"
Received: from jcrametz-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.73])
  by orsmga001.jf.intel.com with ESMTP; 24 Jul 2020 20:19:13 -0700
Date:   Sat, 25 Jul 2020 06:19:11 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()]
Message-ID: <20200725031911.GH17052@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
 <20200724092746.GD517988@gmail.com>
 <CAMj1kXHeSVn7W-Awq2Z57w4OevaLLLX7QrPgnzceiaQ2PooQXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHeSVn7W-Awq2Z57w4OevaLLLX7QrPgnzceiaQ2PooQXg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 03:16:08PM +0300, Ard Biesheuvel wrote:
> On Fri, 24 Jul 2020 at 12:27, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > > Use text_alloc() and text_free() instead of module_alloc() and
> > > module_memfree() when an arch provides them.
> > >
> > > Cc: linux-mm@kvack.org
> > > Cc: Andi Kleen <ak@linux.intel.com>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > ---
> > >  kernel/kprobes.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index 4e46d96d4e16..611fcda9f6bf 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -40,6 +40,7 @@
> > >  #include <asm/cacheflush.h>
> > >  #include <asm/errno.h>
> > >  #include <linux/uaccess.h>
> > > +#include <linux/vmalloc.h>
> > >
> > >  #define KPROBE_HASH_BITS 6
> > >  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> > > @@ -111,12 +112,20 @@ enum kprobe_slot_state {
> > >
> > >  void __weak *alloc_insn_page(void)
> > >  {
> > > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > > +     return text_alloc(PAGE_SIZE);
> > > +#else
> > >       return module_alloc(PAGE_SIZE);
> > > +#endif
> > >  }
> > >
> > >  void __weak free_insn_page(void *page)
> > >  {
> > > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > > +     text_free(page);
> > > +#else
> > >       module_memfree(page);
> > > +#endif
> > >  }
> >
> > I've read the observations in the other threads, but this #ifdef
> > jungle is silly, it's a de-facto open coded text_alloc() with a
> > module_alloc() fallback...
> >
> 
> Also, as I attempted to explain before, there is no reason to allocate
> kasan shadow for any of these use cases, so cloning module_alloc() to
> implement text_alloc() is not the correct approach even on x86.
> 
> I suppose module_alloc() could be reimplemented in terms of
> text_alloc() in this case, but simply relabelling it like this seems
> inappropriate on all architectures.

I agree with this. Even if there was chance to do a merge of some
kind, it should probably happen over time and accept some redundancy
first.

/Jarkko
