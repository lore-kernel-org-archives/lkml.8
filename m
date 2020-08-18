Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF03206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597751526;
	bh=V6zWYb60MNl5LiY+q8W9QZ7ZvQ5dlxEVJ0ia/eFZhOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NsjGuMGNZiKaoZOfamLhSZu0uqRN24KXAwwmSbjDfRGjfGFzl1EM3XDCFXx67s0h8
	 3pDnM+LP5eJbxByKaN3ktbIGuHFAYefivKGZ6hhD8g+wnarvd5oeh+G6NefEh+hE5R
	 535dvD6g8BYl7NZ84+wx+hTbNEFM01KXmUzCO1mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHRLwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgHRLv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:51:58 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034932075E;
        Tue, 18 Aug 2020 11:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597751517;
        bh=V6zWYb60MNl5LiY+q8W9QZ7ZvQ5dlxEVJ0ia/eFZhOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdiKSbZj6yupVmUP+5fgsTfrtgHsXTtYGQPZhK0G3omTz9/YKqeHIIHQLPBMHEdSQ
         5dKAsH8xPi+rdLUQW0npUmLUMS/ryx/nh+pzlI+uc3OpzrNKpOL0XN8SoaoezTn7B8
         cgbqmLJSwKXwQfA9Xib/PN269LIn3jo72JuPsQJk=
Date:   Tue, 18 Aug 2020 14:51:41 +0300
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
Message-ID: <20200818115141.GO752365@kernel.org>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
 <20200724092746.GD517988@gmail.com>
 <20200725031648.GG17052@linux.intel.com>
 <20200726081408.GB2927915@kernel.org>
 <20200818053029.GE44714@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818053029.GE44714@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 08:30:29AM +0300, Jarkko Sakkinen wrote:
> On Sun, Jul 26, 2020 at 11:14:08AM +0300, Mike Rapoport wrote:
> > > 
> > > I'm not still sure that I fully understand this feedback as I don't see
> > > any inherent and obvious difference to the v4. In that version fallbacks
> > > are to module_alloc() and module_memfree() and text_alloc() and
> > > text_memfree() can be overridden by arch.
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
> 
> What if we in kernel/kprobes.c just:
> 
> #ifndef CONFIG_ARCH_HAS_TEXT_ALLOC

I don't think that CONFIG_ARCH_HAS_TEXT_ALLOC will work for all
architectures.

If an architecture has different restrictions for allocation of text
for, say, modules, kprobes, bfp, it won't be able to use a single
ARCH_HAS_TEXT_ALLOC. Which means that this architecture is stuck with
dependency of kprobes on MODULES until the next rework.

> void __weak *alloc_insn_page(void)
> {
> 	return module_alloc(PAGE_SIZE);
> }
> 
> void __weak free_insn_page(void *page)
> {
> 	module_memfree(page);
> }
> #endif
> 
> In Kconfig (as in v5):
> 
> config KPROBES
> 	bool "Kprobes"
> 	depends on MODULES || ARCH_HAS_TEXT_ALLOC
> 
> I checked architectures that override alloc_insn_page(). With the
> exception of x86, they do not call module_alloc().
> 
> If no rename was done, then with this approach a more consistent.
> config flag name would be CONFIG_ARCH_HAS_ALLOC_INSN_PAGE.
> 
> I'd call the function just as kprobes_alloc_page(). Then the
> config flag would become CONFIG_HAS_KPROBES_ALLOC_PAGE.
> 
> > -- 
> > Sincerely yours,
> > Mike.
> 
> Thanks for the feedback!
> 
> /Jarkko

-- 
Sincerely yours,
Mike.
