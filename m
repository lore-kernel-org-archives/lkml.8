Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23463C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FF22076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgHRQat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:30:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:64042 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgHRQai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:30:38 -0400
IronPort-SDR: Sh0pAmPmWyknGk7dxXO5ruzBP5AJApwBSQmk98xE5euF0ECCRa0i/GhVYrIUduiF2HOCW0ZJdd
 UPzI4Lgs4JOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="135012611"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="135012611"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 09:30:37 -0700
IronPort-SDR: 2oNuJKXT27GJXRvN0VtkdmZc0gFcrv+OJCOWX4A5DdH6J7GIGNZ7RhM1s4gMvEvXBlHLCy9CHL
 hmCjerhZ6O0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="279440992"
Received: from ribnhajh-mobl.ger.corp.intel.com (HELO localhost) ([10.249.47.113])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2020 09:30:34 -0700
Date:   Tue, 18 Aug 2020 19:30:33 +0300
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
Message-ID: <20200818163033.GF137138@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
 <20200724092746.GD517988@gmail.com>
 <20200725031648.GG17052@linux.intel.com>
 <20200726081408.GB2927915@kernel.org>
 <20200818053029.GE44714@linux.intel.com>
 <20200818115141.GO752365@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818115141.GO752365@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:51:41PM +0300, Mike Rapoport wrote:
> On Tue, Aug 18, 2020 at 08:30:29AM +0300, Jarkko Sakkinen wrote:
> > On Sun, Jul 26, 2020 at 11:14:08AM +0300, Mike Rapoport wrote:
> > > > 
> > > > I'm not still sure that I fully understand this feedback as I don't see
> > > > any inherent and obvious difference to the v4. In that version fallbacks
> > > > are to module_alloc() and module_memfree() and text_alloc() and
> > > > text_memfree() can be overridden by arch.
> > > 
> > > The major difference between your v4 and my suggestion is that I'm not
> > > trying to impose a single ARCH_HAS_TEXT_ALLOC as an alternative to
> > > MODULES but rather to use per subsystem config option, e.g.
> > > HAVE_KPROBES_TEXT_ALLOC.
> > > 
> > > Another thing, which might be worth doing regardless of the outcome of
> > > this discussion is to rename alloc_insn_pages() to text_alloc_kprobes()
> > > because the former is way too generic and does not emphasize that the 
> > > instruction page is actually used by kprobes only.
> > 
> > What if we in kernel/kprobes.c just:
> > 
> > #ifndef CONFIG_ARCH_HAS_TEXT_ALLOC
> 
> I don't think that CONFIG_ARCH_HAS_TEXT_ALLOC will work for all
> architectures.
> 
> If an architecture has different restrictions for allocation of text
> for, say, modules, kprobes, bfp, it won't be able to use a single
> ARCH_HAS_TEXT_ALLOC. Which means that this architecture is stuck with
> dependency of kprobes on MODULES until the next rework.

I was thinking to name it as CONFIG_HAS_KPROBES_ALLOC_PAGE, alogn the
lines described below, so it is merely a glitch in my example.

> 
> > void __weak *alloc_insn_page(void)
> > {
> > 	return module_alloc(PAGE_SIZE);
> > }
> > 
> > void __weak free_insn_page(void *page)
> > {
> > 	module_memfree(page);
> > }
> > #endif
> > 
> > In Kconfig (as in v5):
> > 
> > config KPROBES
> > 	bool "Kprobes"
> > 	depends on MODULES || ARCH_HAS_TEXT_ALLOC
> > 
> > I checked architectures that override alloc_insn_page(). With the
> > exception of x86, they do not call module_alloc().
> > 
> > If no rename was done, then with this approach a more consistent.
> > config flag name would be CONFIG_ARCH_HAS_ALLOC_INSN_PAGE.
> > 
> > I'd call the function just as kprobes_alloc_page(). Then the
> > config flag would become CONFIG_HAS_KPROBES_ALLOC_PAGE.
> > 
> > > -- 
> > > Sincerely yours,
> > > Mike.
> > 
> > Thanks for the feedback!
> > 
> > /Jarkko
> 

> -- 
> Sincerely yours,
> Mike.

BR,
/Jarkko
