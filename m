Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781EEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440C52073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgGMFzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:55:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:3187 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgGMFzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:55:17 -0400
IronPort-SDR: TrnXLB5T8KV+6qQv0ENLLvAZ9/0e9joomVOf8lKioxsixYlBLoCk8f3qUcR1ovOKGbu1aF1Mnx
 0vj4Lg642EIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="128616161"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="128616161"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 22:55:16 -0700
IronPort-SDR: 04Y8FVYlgaJqSU6R0QtpvvyRPt6Sq04lDLvVlOD42KuZCEXulWehfJyfFs0IGn8RvD7NIpp/5x
 APD5EBedfLQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="281287992"
Received: from lgrunert-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.52.195])
  by orsmga003.jf.intel.com with ESMTP; 12 Jul 2020 22:55:04 -0700
Date:   Mon, 13 Jul 2020 08:55:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
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
        Jiri Olsa <jolsa@redhat.com>, hch@lst.de
Subject: Re: [PATCH RFC] kprobes: Remove MODULES dependency
Message-ID: <20200713055503.GE956284@linux.intel.com>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
 <20200710193257.4eeb19e9cd042d99cbca7f9a@kernel.org>
 <20200710113238.GH4800@hirez.programming.kicks-ass.net>
 <20200710221802.da2f4cf077ce1bb51c7e11ca@kernel.org>
 <20200710092243.076e9b44@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710092243.076e9b44@oasis.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:22:43AM -0400, Steven Rostedt wrote:
> On Fri, 10 Jul 2020 22:18:02 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > 
> > Agreed. As far as I know, ftrace and bpf also depends on module_alloc(),
> > so text_alloc() will help them too.
> > 
> 
> Yes please.
> 
> arch/x86/kernel/ftrace.c:
> 
> #ifdef CONFIG_MODULES
> #include <linux/moduleloader.h>
> /* Module allocation simplifies allocating memory for code */
> static inline void *alloc_tramp(unsigned long size)
> {
> 	return module_alloc(size);
> }
> static inline void tramp_free(void *tramp)
> {
> 	module_memfree(tramp);
> }
> #else
> /* Trampolines can only be created if modules are supported */
> static inline void *alloc_tramp(unsigned long size)
> {
> 	return NULL;
> }
> static inline void tramp_free(void *tramp) { }
> #endif
> 
> -- Steve

Thanks, note taken. I'll take this into account in the next version.

/Jarkko
