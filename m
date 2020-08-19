Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D325DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FDD207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHSVIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:08:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:29237 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgHSVIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:08:02 -0400
IronPort-SDR: 93cvKI7WfbKvkWb55DmYDkD4AQGNKRwLGcJnFOwmfxFD7qoFkpsVvHV/i2p+pnqKtlEVgTGtWe
 J6VILpQ4Jc3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="134717792"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="134717792"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 14:08:01 -0700
IronPort-SDR: ko6JSKjybxh+lTOjTQtyf7YzvuEAjFrFlB6G5X0yjeoHs4+7EnUL4PEG09DYeY0yWjnr+xCo8R
 j5+1jfS1PoGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="334795281"
Received: from abojanow-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.52.107])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Aug 2020 14:07:57 -0700
Date:   Thu, 20 Aug 2020 00:07:56 +0300
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
Message-ID: <20200819210756.GE9942@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
 <20200724092746.GD517988@gmail.com>
 <20200725031648.GG17052@linux.intel.com>
 <20200726081408.GB2927915@kernel.org>
 <20200818053029.GE44714@linux.intel.com>
 <20200818115141.GO752365@kernel.org>
 <20200818163033.GF137138@linux.intel.com>
 <20200819064718.GR752365@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819064718.GR752365@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 09:47:18AM +0300, Mike Rapoport wrote:
> On Tue, Aug 18, 2020 at 07:30:33PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Aug 18, 2020 at 02:51:41PM +0300, Mike Rapoport wrote:
> > > On Tue, Aug 18, 2020 at 08:30:29AM +0300, Jarkko Sakkinen wrote:
> > > > On Sun, Jul 26, 2020 at 11:14:08AM +0300, Mike Rapoport wrote:
> > > > > > 
> > > > > > I'm not still sure that I fully understand this feedback as I don't see
> > > > > > any inherent and obvious difference to the v4. In that version fallbacks
> > > > > > are to module_alloc() and module_memfree() and text_alloc() and
> > > > > > text_memfree() can be overridden by arch.
> > > > > 
> > > > > The major difference between your v4 and my suggestion is that I'm not
> > > > > trying to impose a single ARCH_HAS_TEXT_ALLOC as an alternative to
> > > > > MODULES but rather to use per subsystem config option, e.g.
> > > > > HAVE_KPROBES_TEXT_ALLOC.
> > > > > 
> > > > > Another thing, which might be worth doing regardless of the outcome of
> > > > > this discussion is to rename alloc_insn_pages() to text_alloc_kprobes()
> > > > > because the former is way too generic and does not emphasize that the 
> > > > > instruction page is actually used by kprobes only.
> > > > 
> > > > What if we in kernel/kprobes.c just:
> > > > 
> > > > #ifndef CONFIG_ARCH_HAS_TEXT_ALLOC
> > > 
> > > I don't think that CONFIG_ARCH_HAS_TEXT_ALLOC will work for all
> > > architectures.
> > > 
> > > If an architecture has different restrictions for allocation of text
> > > for, say, modules, kprobes, bfp, it won't be able to use a single
> > > ARCH_HAS_TEXT_ALLOC. Which means that this architecture is stuck with
> > > dependency of kprobes on MODULES until the next rework.
> > 
> > I was thinking to name it as CONFIG_HAS_KPROBES_ALLOC_PAGE, alogn the
> > lines described below, so it is merely a glitch in my example.
>  
> IMHO, it would be better to emphasize that this is text page. I liked
> Mark's idea [1] to have text_alloc_<subsys>() naming for the allocation
> functions. The Kconfig options then would become
> HAVE_TEXT_ALLOC_<SUBSYS>.
> 
> [1] https://lore.kernel.org/linux-riscv/20200714133314.GA67386@C02TD0UTHF1T.local/

I think I got the point now, the point being in future other subsystems
could use the same naming convention for analogous stuff?

I'll follow this convention. Thank you for the patience with this!

/Jarkko
