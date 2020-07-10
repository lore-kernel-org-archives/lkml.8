Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A28BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EB420748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594387094;
	bh=yvoZVi3E0/UpDfzsZqUsBbugQqbpY2zB6NVoG6jwr+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hSjuNbhomtlU2+TPSEuiOoY70HyqmIx2xNaxceyEGaFWLq924/rwDHXZhsSpgs+O9
	 HMX8+qCaxe28rMfw8yFs907/KAgRwZXSPB6g9PtonDTuoiZAW+ugkIJv/MpjnGYD62
	 F1Cxt/BpBylLTqc400VjctPpP6mCnRuy0qru578M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGJNSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgGJNSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:18:12 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFF8B206A5;
        Fri, 10 Jul 2020 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594387091;
        bh=yvoZVi3E0/UpDfzsZqUsBbugQqbpY2zB6NVoG6jwr+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rJUjxoC3SbojUnpJq46ZYWSTVhKLEtlY0eyl4YKTc4Gb8CVAr6Q9RCMUKZgAWnoz4
         7fC4E0a5Q/4/bZQrf3TMOjgjUfdj0HouK0YLF7X79SvHftqjw7/ecJXgNJdNnROz+o
         gX7XW/SBKgRgNOv0xYEzm3BSCGptHbdWEEwa+nSw=
Date:   Fri, 10 Jul 2020 22:18:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
Message-Id: <20200710221802.da2f4cf077ce1bb51c7e11ca@kernel.org>
In-Reply-To: <20200710113238.GH4800@hirez.programming.kicks-ass.net>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
        <20200710193257.4eeb19e9cd042d99cbca7f9a@kernel.org>
        <20200710113238.GH4800@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 13:32:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

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

Agreed. As far as I know, ftrace and bpf also depends on module_alloc(),
so text_alloc() will help them too.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
