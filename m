Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83EF22B43
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595924243;
	bh=3fxjXoDgSBiwnSHqXnV1f6LzXR3qMTb2G2BKx/anIjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TVbend5clDs12MmHwsYWDyq4KRAeuNsjZ2WFWD38raHbHL8VdzR5vm579MMuPKuOQ
	 BTIBG/mGpljzoiRIn9FGY3iM4WN1VKCYcLkZOa8uih7sm22ngg3P1uDoV9OX5dT0sd
	 6N27VsrNp+SXn/cAfbhgDu5dcgYOjj2aRLkOxUz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgG1IRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgG1IRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:17:21 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF532177B;
        Tue, 28 Jul 2020 08:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595924240;
        bh=3fxjXoDgSBiwnSHqXnV1f6LzXR3qMTb2G2BKx/anIjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cP/1mWVhwzYFHuE/o20/ObrPDNBusuSlukT/jhE9M6CttC1iJo8RejcopDujlYEaX
         KjN5FmG9MSsoE/RMN1/treziZsdRTrxwbFKigPD7cgkc2nLa1Q7CQA/SlfTe5byDM7
         83BQW/0C09K+ESYWg9I8N1wgw/6HjGWp5eawq+ek=
Date:   Tue, 28 Jul 2020 17:17:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
Message-Id: <20200728171715.0800093e2226e3d72b04a3ae@kernel.org>
In-Reply-To: <CAMj1kXHDK5RSbTu3SG1AzbLRJD_FsdAmCnjmf31P=Db6J0ktww@mail.gmail.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
        <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
        <20200724092746.GD517988@gmail.com>
        <20200725031648.GG17052@linux.intel.com>
        <20200726081408.GB2927915@kernel.org>
        <CAMj1kXHDK5RSbTu3SG1AzbLRJD_FsdAmCnjmf31P=Db6J0ktww@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 19:06:20 +0300
Ard Biesheuvel <ardb@kernel.org> wrote:

> On Sun, 26 Jul 2020 at 11:14, Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Sat, Jul 25, 2020 at 06:16:48AM +0300, Jarkko Sakkinen wrote:
> > > On Fri, Jul 24, 2020 at 11:27:46AM +0200, Ingo Molnar wrote:
> > > >
> > > > * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > > Use text_alloc() and text_free() instead of module_alloc() and
> > > > > module_memfree() when an arch provides them.
> > > > >
> > > > > Cc: linux-mm@kvack.org
> > > > > Cc: Andi Kleen <ak@linux.intel.com>
> > > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > ---
> > > > >  kernel/kprobes.c | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > > index 4e46d96d4e16..611fcda9f6bf 100644
> > > > > --- a/kernel/kprobes.c
> > > > > +++ b/kernel/kprobes.c
> > > > > @@ -40,6 +40,7 @@
> > > > >  #include <asm/cacheflush.h>
> > > > >  #include <asm/errno.h>
> > > > >  #include <linux/uaccess.h>
> > > > > +#include <linux/vmalloc.h>
> > > > >
> > > > >  #define KPROBE_HASH_BITS 6
> > > > >  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> > > > > @@ -111,12 +112,20 @@ enum kprobe_slot_state {
> > > > >
> > > > >  void __weak *alloc_insn_page(void)
> > > > >  {
> > > > > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > > > > + return text_alloc(PAGE_SIZE);
> > > > > +#else
> > > > >   return module_alloc(PAGE_SIZE);
> > > > > +#endif
> > > > >  }
> > > > >
> > > > >  void __weak free_insn_page(void *page)
> > > > >  {
> > > > > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > > > > + text_free(page);
> > > > > +#else
> > > > >   module_memfree(page);
> > > > > +#endif
> > > > >  }
> > > >
> > > > I've read the observations in the other threads, but this #ifdef
> > > > jungle is silly, it's a de-facto open coded text_alloc() with a
> > > > module_alloc() fallback...
> > >
> > > In the previous version I had:
> > >
> > >   https://lore.kernel.org/lkml/20200717030422.679972-4-jarkko.sakkinen@linux.intel.com/
> > >
> > > and I had just calls to text_alloc() and text_free() in corresponding
> > > snippet to the above.
> > >
> > > I got this feedback from Mike:
> > >
> > >   https://lore.kernel.org/lkml/20200718162359.GA2919062@kernel.org/
> > >
> > > I'm not still sure that I fully understand this feedback as I don't see
> > > any inherent and obvious difference to the v4. In that version fallbacks
> > > are to module_alloc() and module_memfree() and text_alloc() and
> > > text_memfree() can be overridden by arch.
> >
> > Let me try to elaborate.
> >
> > There are several subsystems that need to allocate memory for executable
> > text. As it happens, they use module_alloc() with some abilities for
> > architectures to override this behaviour.
> >
> > For many architectures, it would be enough to rename modules_alloc() to
> > text_alloc(), make it built-in and this way allow removing dependency on
> > MODULES.
> >
> > Yet, some architectures have different restrictions for code allocation
> > for different subsystems so it would make sense to have more than one
> > variant of text_alloc() and a single config option ARCH_HAS_TEXT_ALLOC
> > won't be sufficient.
> >
> > I liked Mark's suggestion to have text_alloc_<something>() and proposed
> > a way to introduce text_alloc_kprobes() along with
> > HAVE_KPROBES_TEXT_ALLOC to enable arch overrides of this function.
> >
> > The major difference between your v4 and my suggestion is that I'm not
> > trying to impose a single ARCH_HAS_TEXT_ALLOC as an alternative to
> > MODULES but rather to use per subsystem config option, e.g.
> > HAVE_KPROBES_TEXT_ALLOC.
> >
> > Another thing, which might be worth doing regardless of the outcome of
> > this discussion is to rename alloc_insn_pages() to text_alloc_kprobes()
> > because the former is way too generic and does not emphasize that the
> > instruction page is actually used by kprobes only.

The name of the insn_pages came from the struct kprobe_insn_page, so
if there is a text_alloc_kprobe(), I'm OK to rename it. (anyway, that
is an allocation operator, we don't call it directly.)

> Masami or Peter should correct me if I am wrong, but it seems to me
> that the way kprobes uses these pages does not require them to be in
> relative branching range of the core kernel on any architecture, given
> that they are populated with individual instruction opcodes that are
> executed in single step mode, and relative branches are emulated (when
> needed)

Actually, x86 and arm has the "relative branching range" requirements
for the jump optimized kprobes. For the other architectures, I think
we don't need it. Only executable text buffer is needed.

Thank you,

> So for kprobes in particular, we should be able to come up with a
> generic sequence that does not involve module_alloc(), and therefore
> removes the kprobes dependency on module support entirely (with the
> exception of power which maps the vmalloc space nx when module support
> is disabled). Renaming alloc_insn_page() to something more descriptive
> makes sense imo, but is a separate issue.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
