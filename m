Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ACDC433F1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6772071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbgGWBte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:49:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:35650 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgGWBte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:49:34 -0400
IronPort-SDR: YlR3QaPbj5FXFizj8d1UwsMb8q3DyyccbG/crMscL69aj4nxolIxplDt7kRdSUw7wbbxrGssAo
 cVeUI6O78h6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="211994602"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="211994602"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 18:49:33 -0700
IronPort-SDR: QNP5KVt6QKgtWmoKOqeRoCIe45AqIHZRKo7xbNWyj+G+DYPdMKxxIdxZ6DQosE8B7coErHBY0h
 jolHgiunVirA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="270910468"
Received: from schwings-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.132])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jul 2020 18:49:17 -0700
Date:   Thu, 23 Jul 2020 04:49:16 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Babu Moger <Babu.Moger@amd.com>,
        Omar Sandoval <osandov@fb.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] kprobes: Add text_alloc() and text_free()
Message-ID: <20200723014916.GD45081@linux.intel.com>
References: <20200714223239.1543716-1-jarkko.sakkinen@linux.intel.com>
 <20200714223239.1543716-2-jarkko.sakkinen@linux.intel.com>
 <20200716090253.GP10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716090253.GP10769@hirez.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:02:53AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 15, 2020 at 01:32:27AM +0300, Jarkko Sakkinen wrote:
> > +void *text_alloc(unsigned long size)
> > +{
> > +	void *p;
> > +
> > +	if (PAGE_ALIGN(size) > MODULES_LEN)
> > +		return NULL;
> > +
> > +	p = __vmalloc_node_range(size, MODULE_ALIGN,
> > +				    MODULES_VADDR + get_module_load_offset(),
> > +				    MODULES_END, GFP_KERNEL,
> > +				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> > +				    __builtin_return_address(0));
> > +	if (p && (kasan_module_alloc(p, size) < 0)) {
> > +		vfree(p);
> > +		return NULL;
> > +	}
> > +
> > +	return p;
> > +}
> > +
> > +void text_free(void *region)
> > +{
> > +	/*
> > +	 * This memory may be RO, and freeing RO memory in an interrupt is not
> > +	 * supported by vmalloc.
> > +	 */
> > +	WARN_ON(in_interrupt());
> 
> I think that wants to be:
> 
> 	lockdep_assert_irqs_enabled();
> 
> in_interrupt() isn't sufficient, interrupts must also not be disabled
> when issuesing TLB invalidations.

Shouldn't it be then also fixed in the module_memfree() fallback
implementation (kernel/module.c)?

/Jarkko
