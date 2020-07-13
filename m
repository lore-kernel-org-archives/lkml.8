Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5B2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2E42073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgGMFwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:52:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:29760 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMFwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:52:53 -0400
IronPort-SDR: Wr+Wj6Y0ocSbIR9yAO92WNuh/YGLbyobEvHDXiG1ZexwGov45LOfcQQmE2Q2a1bCQ5XDZg/i0L
 Z2c/F8ybzlRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="213401065"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="213401065"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 22:52:53 -0700
IronPort-SDR: 3NBT5Xwb6SEKRo45jGptQA52qwK8aymWmWJkzOuVO7mj+KHu+sIDPD98SAV3q69rlVSl8og9gI
 Y6u8Hiyq+EZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="307334400"
Received: from lgrunert-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.52.195])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 22:52:41 -0700
Date:   Mon, 13 Jul 2020 08:52:40 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH RFC] kprobes: Remove MODULES dependency
Message-ID: <20200713055240.GD956284@linux.intel.com>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
 <20200710193257.4eeb19e9cd042d99cbca7f9a@kernel.org>
 <20200710113238.GH4800@hirez.programming.kicks-ass.net>
 <20200710130429.GA8619@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710130429.GA8619@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 03:04:29PM +0200, Christoph Hellwig wrote:
> On Fri, Jul 10, 2020 at 01:32:38PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 10, 2020 at 07:32:57PM +0900, Masami Hiramatsu wrote:
> > > > -	page = module_alloc(PAGE_SIZE);
> > > > +	page = vmalloc(PAGE_SIZE);
> > > 
> > > No, you can not use vmalloc here. The reason why we use module_alloc()
> > > is to allocate the executable memory for trampoline code.
> > > So, you need to use vmalloc_exec() instead.
> > 
> > vmalloc_exec() would be broken too, also hch recently got rid of that
> > thing.
> > 
> > module_alloc() really is the only sane choice here.
> > 
> > We should make module_alloc() unconditionally available, and maybe even
> > rename it to text_alloc().
> 
> I think unconitionally might be a bit too much, but for
> MODULES || KRPOBES or a new symbol select by them makes sense.  As does
> the rename.

Given that they are simple wrappers, would it be too much harmo to have
inline functions for text_alloc() and text_memfree() and use them inside
module_alloc() and alloc_memfree() in order not to initially turn things
over too much?

/Jarkko
