Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ABCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5CA22209
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594727115;
	bh=KBVGwEZPi1g9YxK6fNaw250dyQo7rBMsKhBhkVEiwnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KRIZCftQ78ORu6NKqMP85NBTryo7nS8W3PBa0wMaHlOBb9R+WorU2+ZCWEXNMZP03
	 6sW5o7YNXfFONAPySAjSoCmTTV5M1qi38Z2YHf0/iRnMzSqffMx91JZcrQrcltE+7T
	 BF0sAYvowiZW8H9fICVp/lhSHSfHzVTkqLyQBGiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGNLpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgGNLpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:45:12 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAA7222201;
        Tue, 14 Jul 2020 11:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594727112;
        bh=KBVGwEZPi1g9YxK6fNaw250dyQo7rBMsKhBhkVEiwnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RzWbu5RtJqcEVBTvHmTGJlOHHjNMnFAhUdfHSXgDNreMOjEzRPuBcVxD0g6oNsgpS
         yYa49EkXZ91cieWM8o/IeHsJZlFtEB8ROEQbqcjwaQDAarrqHPd4C+XtZQemIUtPYM
         LdI+ZtEQKrWZIXYqPn/uKM7hw9iOc1h+CB8gIAAA=
Date:   Tue, 14 Jul 2020 20:45:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
        Jiri Olsa <jolsa@redhat.com>, hch@lst.de
Subject: Re: [PATCH RFC] kprobes: Remove MODULES dependency
Message-Id: <20200714204503.833eceb606a37f4bb93d95bd@kernel.org>
In-Reply-To: <20200713054955.GC956284@linux.intel.com>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
        <20200710193257.4eeb19e9cd042d99cbca7f9a@kernel.org>
        <20200710113238.GH4800@hirez.programming.kicks-ass.net>
        <20200713054955.GC956284@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 08:49:55 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

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
> Thanks for the remarks.
> 
> The current module_alloc looks like this:
> 
> void * __weak module_alloc(unsigned long size)
> {
> 	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> 			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> 			NUMA_NO_NODE, __builtin_return_address(0));
> }
> 
> What if I create inline functions for text_alloc() and text_memfree() and
> convert this function as:
> 
> void * __weak module_alloc(unsigned long size)
> {
> 	return text_alloc(size);
> }

Yeah, that'll be good.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
