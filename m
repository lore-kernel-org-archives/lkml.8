Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1A3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C037204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHRFaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:30:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:23245 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHRFae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:30:34 -0400
IronPort-SDR: HYJEAGVrbfq6DqtPpiji/3BNcVCu6/m+vVSpmKiRagfoak6KzXeU4f+kSw0Iad53hbAiVtGiFu
 IyA/6tk/hFmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142671900"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="142671900"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 22:30:33 -0700
IronPort-SDR: JCeOFRprVuwng85bEu6hJrSPQv4h6XQZrKdSlv/9/73LvIJ3QNcbWjyrYwtbXogMDgree0RS59
 Q1pGXk7ylpaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="326628848"
Received: from lcrossx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.46.217])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2020 22:30:30 -0700
Date:   Tue, 18 Aug 2020 08:30:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jessica Yu <jeyu@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
Message-ID: <20200818053029.GE44714@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
 <20200724092746.GD517988@gmail.com>
 <20200725031648.GG17052@linux.intel.com>
 <20200726081408.GB2927915@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726081408.GB2927915@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 11:14:08AM +0300, Mike Rapoport wrote:
> On Sat, Jul 25, 2020 at 06:16:48AM +0300, Jarkko Sakkinen wrote:
> > > I've read the observations in the other threads, but this #ifdef 
> > > jungle is silly, it's a de-facto open coded text_alloc() with a 
> > > module_alloc() fallback...
> > 
> > In the previous version I had:
> > 
> >   https://lore.kernel.org/lkml/20200717030422.679972-4-jarkko.sakkinen@linux.intel.com/
> > 
> > and I had just calls to text_alloc() and text_free() in corresponding
> > snippet to the above.
> > 
> > I got this feedback from Mike:
> > 
> >   https://lore.kernel.org/lkml/20200718162359.GA2919062@kernel.org/
> > 
> > I'm not still sure that I fully understand this feedback as I don't see
> > any inherent and obvious difference to the v4. In that version fallbacks
> > are to module_alloc() and module_memfree() and text_alloc() and
> > text_memfree() can be overridden by arch.
> 
> Let me try to elaborate.
> 
> There are several subsystems that need to allocate memory for executable
> text. As it happens, they use module_alloc() with some abilities for
> architectures to override this behaviour.
> 
> For many architectures, it would be enough to rename modules_alloc() to
> text_alloc(), make it built-in and this way allow removing dependency on
> MODULES.
> 
> Yet, some architectures have different restrictions for code allocation
> for different subsystems so it would make sense to have more than one
> variant of text_alloc() and a single config option ARCH_HAS_TEXT_ALLOC
> won't be sufficient.
> 
> I liked Mark's suggestion to have text_alloc_<something>() and proposed
> a way to introduce text_alloc_kprobes() along with
> HAVE_KPROBES_TEXT_ALLOC to enable arch overrides of this function.
> 
> The major difference between your v4 and my suggestion is that I'm not
> trying to impose a single ARCH_HAS_TEXT_ALLOC as an alternative to
> MODULES but rather to use per subsystem config option, e.g.
> HAVE_KPROBES_TEXT_ALLOC.
> 
> Another thing, which might be worth doing regardless of the outcome of
> this discussion is to rename alloc_insn_pages() to text_alloc_kprobes()
> because the former is way too generic and does not emphasize that the 
> instruction page is actually used by kprobes only.

What if we in kernel/kprobes.c just:

#ifndef CONFIG_ARCH_HAS_TEXT_ALLOC
void __weak *alloc_insn_page(void)
{
	return module_alloc(PAGE_SIZE);
}

void __weak free_insn_page(void *page)
{
	module_memfree(page);
}
#endif

In Kconfig (as in v5):

config KPROBES
	bool "Kprobes"
	depends on MODULES || ARCH_HAS_TEXT_ALLOC

I checked architectures that override alloc_insn_page(). With the
exception of x86, they do not call module_alloc().

If no rename was done, then with this approach a more consistent.
config flag name would be CONFIG_ARCH_HAS_ALLOC_INSN_PAGE.

I'd call the function just as kprobes_alloc_page(). Then the
config flag would become CONFIG_HAS_KPROBES_ALLOC_PAGE.

> -- 
> Sincerely yours,
> Mike.

Thanks for the feedback!

/Jarkko
