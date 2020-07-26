Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4C6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A6E206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595751259;
	bh=0Ugs3nzQwvO6yznH7RroocSfULUynQc9l0K3nV2dAKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HrexSvY/cawXihHFIGVgQX1YK3k8aKUEpQQR5SR3OdYuSsokgOXUIxHYa+8UBqb5X
	 Tx0av3LJfi06BsJ13jGuR6KGeBOR3rvwE2mXritAk+AJzlLf2d0PK2EIEDQDt069Io
	 ajJyfn9Y1kPXZFd0HCxZHwWUov3YiH19Icc0jYOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgGZIOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 04:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGZIOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:14:17 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC382065C;
        Sun, 26 Jul 2020 08:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595751257;
        bh=0Ugs3nzQwvO6yznH7RroocSfULUynQc9l0K3nV2dAKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jNvHaJFvbUhDBHhffeEiR9RMCy32xuoLioJ1FEyTg0UxW0JL1nIWm+AiLynfPsk5o
         hZxK++FTMLbd/0fSAIEiAH1JqNfkgsHi6qpRm8ppJ4RZ+wBelxApwIF3yWPhD4JaK6
         WOEBufF6vEy5p+aPqD21HNTXluJHHLp1sCoPhyCE=
Date:   Sun, 26 Jul 2020 11:14:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jessica Yu <jeyu@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
Message-ID: <20200726081408.GB2927915@kernel.org>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
 <20200724092746.GD517988@gmail.com>
 <20200725031648.GG17052@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725031648.GG17052@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 06:16:48AM +0300, Jarkko Sakkinen wrote:
> On Fri, Jul 24, 2020 at 11:27:46AM +0200, Ingo Molnar wrote:
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
> > > +	return text_alloc(PAGE_SIZE);
> > > +#else
> > >  	return module_alloc(PAGE_SIZE);
> > > +#endif
> > >  }
> > >  
> > >  void __weak free_insn_page(void *page)
> > >  {
> > > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > > +	text_free(page);
> > > +#else
> > >  	module_memfree(page);
> > > +#endif
> > >  }
> > 
> > I've read the observations in the other threads, but this #ifdef 
> > jungle is silly, it's a de-facto open coded text_alloc() with a 
> > module_alloc() fallback...
> 
> In the previous version I had:
> 
>   https://lore.kernel.org/lkml/20200717030422.679972-4-jarkko.sakkinen@linux.intel.com/
> 
> and I had just calls to text_alloc() and text_free() in corresponding
> snippet to the above.
> 
> I got this feedback from Mike:
> 
>   https://lore.kernel.org/lkml/20200718162359.GA2919062@kernel.org/
> 
> I'm not still sure that I fully understand this feedback as I don't see
> any inherent and obvious difference to the v4. In that version fallbacks
> are to module_alloc() and module_memfree() and text_alloc() and
> text_memfree() can be overridden by arch.

Let me try to elaborate.

There are several subsystems that need to allocate memory for executable
text. As it happens, they use module_alloc() with some abilities for
architectures to override this behaviour.

For many architectures, it would be enough to rename modules_alloc() to
text_alloc(), make it built-in and this way allow removing dependency on
MODULES.

Yet, some architectures have different restrictions for code allocation
for different subsystems so it would make sense to have more than one
variant of text_alloc() and a single config option ARCH_HAS_TEXT_ALLOC
won't be sufficient.

I liked Mark's suggestion to have text_alloc_<something>() and proposed
a way to introduce text_alloc_kprobes() along with
HAVE_KPROBES_TEXT_ALLOC to enable arch overrides of this function.

The major difference between your v4 and my suggestion is that I'm not
trying to impose a single ARCH_HAS_TEXT_ALLOC as an alternative to
MODULES but rather to use per subsystem config option, e.g.
HAVE_KPROBES_TEXT_ALLOC.

Another thing, which might be worth doing regardless of the outcome of
this discussion is to rename alloc_insn_pages() to text_alloc_kprobes()
because the former is way too generic and does not emphasize that the 
instruction page is actually used by kprobes only.

> /Jarkko
> 

-- 
Sincerely yours,
Mike.
