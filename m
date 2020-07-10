Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F255C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CAA20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGJNEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:04:39 -0400
Received: from verein.lst.de ([213.95.11.211]:43233 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgGJNEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:04:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 99CC968AEF; Fri, 10 Jul 2020 15:04:30 +0200 (CEST)
Date:   Fri, 10 Jul 2020 15:04:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
        Jiri Olsa <jolsa@redhat.com>, hch@lst.de
Subject: Re: [PATCH RFC] kprobes: Remove MODULES dependency
Message-ID: <20200710130429.GA8619@lst.de>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com> <20200710193257.4eeb19e9cd042d99cbca7f9a@kernel.org> <20200710113238.GH4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710113238.GH4800@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 01:32:38PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 10, 2020 at 07:32:57PM +0900, Masami Hiramatsu wrote:
> > > -	page = module_alloc(PAGE_SIZE);
> > > +	page = vmalloc(PAGE_SIZE);
> > 
> > No, you can not use vmalloc here. The reason why we use module_alloc()
> > is to allocate the executable memory for trampoline code.
> > So, you need to use vmalloc_exec() instead.
> 
> vmalloc_exec() would be broken too, also hch recently got rid of that
> thing.
> 
> module_alloc() really is the only sane choice here.
> 
> We should make module_alloc() unconditionally available, and maybe even
> rename it to text_alloc().

I think unconitionally might be a bit too much, but for
MODULES || KRPOBES or a new symbol select by them makes sense.  As does
the rename.
