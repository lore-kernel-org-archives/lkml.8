Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBB0C4345C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA2720781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbgGWBjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:39:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:59630 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387460AbgGWBjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:39:51 -0400
IronPort-SDR: YagH8AHVp1QrPpeL06Q04iBwjU35RaZVf4Dy1JiHLf5N1sCNe9rih5CSiQxW55VUmYNSIlLlLi
 XP81clHh5hmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="168586203"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="168586203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 18:39:51 -0700
IronPort-SDR: U3BLgg8jTpLnq+r5fBR6CHDgFDv0LSr+n+3WtfjemhiHOy/cTLPx/6r6zZiVJ44FvorSjt5bza
 9z5Lp5iJ6zjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="310844028"
Received: from schwings-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.132])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jul 2020 18:39:36 -0700
Date:   Thu, 23 Jul 2020 04:39:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20200723013934.GC45081@linux.intel.com>
References: <20200714223239.1543716-1-jarkko.sakkinen@linux.intel.com>
 <20200714223239.1543716-2-jarkko.sakkinen@linux.intel.com>
 <202007151232.0DA220B2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007151232.0DA220B2@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 12:36:02PM -0700, Kees Cook wrote:
> On Wed, Jul 15, 2020 at 01:32:27AM +0300, Jarkko Sakkinen wrote:
> > Introduce new API for allocating space for code generaed at run-time
> > leveraging from module_alloc() and module_memfree() code. Use this to
> > perform memory allocations in the kprobes code in order to loose the
> > bound between kprobes and modules subsystem.
> > 
> > Initially, use this API only with arch/x86 and define a new config
> > flag CONFIG_ARCH_HAS_TEXT_ALLOC to promote the availability of the
> > new API.
> > [...]
> > diff --git a/include/linux/text.h b/include/linux/text.h
> > new file mode 100644
> > index 000000000000..a27d4a42ecda
> > --- /dev/null
> > +++ b/include/linux/text.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef _LINUX_TEXT_H
> > +#define _LINUX_TEXT_H
> > +
> > +/*
> > + * An allocator used for allocating modules, core sections and init sections.
> > + * Returns NULL on failure.
> > + */
> > +void *text_alloc(unsigned long size);
> > +
> > +/*
> > + * Free memory returned from text_alloc().
> > + */
> > +void text_free(void *region);
> > +
> > +#endif /* _LINUX_TEXT_H */
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 2e97febeef77..fa7687eb0c0e 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/ftrace.h>
> >  #include <linux/cpu.h>
> >  #include <linux/jump_label.h>
> > +#include <linux/text.h>
> >  
> >  #include <asm/sections.h>
> >  #include <asm/cacheflush.h>
> > @@ -111,12 +112,20 @@ enum kprobe_slot_state {
> >  
> >  void __weak *alloc_insn_page(void)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +	return text_alloc(PAGE_SIZE);
> > +#else
> >  	return module_alloc(PAGE_SIZE);
> > +#endif
> 
> This seems like it shouldn't be needed. I think text_alloc() should
> always be visible. In the ARCH_HAS... case it will call the arch
> implementation, and without it should just call module_alloc():
> 
> For example:
> void *text_alloc(unsigned long size)
> {
> #ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> 	return arch_text_alloc(size);
> #else
> 	return module_alloc(size);
> #endif
> }
> 
> -- 
> Kees Cook

I fully agree with your comments and I posted a follow-up series where I
think these should be resolved. Please check it because before I got
this review, It was already posted.

Thank you.

/Jarkko
