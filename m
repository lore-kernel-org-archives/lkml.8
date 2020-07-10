Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08609C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C7420767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgGJKhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:37:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:26779 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgGJKg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:36:57 -0400
IronPort-SDR: /XqtUrnSpVZ7BFhSup8i2WFSWyiZjLhSgWwF76Nu/PZLHE6wLZSGFhkM3CL6JY0U1iwphbLnDh
 Lrf+9dOdfjdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="136382806"
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="136382806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 03:36:51 -0700
IronPort-SDR: b5Uc1qDHLxPtwLj3uxBJX3YS5FuCdSRNLj8xgrOUqVaF4wgiyM1nJrxcUyR+l9eBe1AvkGH7/w
 0jj7QjFcN4lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="484140386"
Received: from taverna-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.137])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2020 03:36:39 -0700
Date:   Fri, 10 Jul 2020 13:36:38 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20200710103638.GA2614@linux.intel.com>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
 <20200710090344.GX4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710090344.GX4800@hirez.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 11:03:44AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 10, 2020 at 02:45:19AM +0300, Jarkko Sakkinen wrote:
> > Remove MODULES dependency and migrate from module_alloc to vmalloc().
> > According to Andi, the history with this dependency is that kprobes
> > originally required custom LKM's, which does not hold today anymore.
> > 
> > Right now one has to compile LKM support only to enable kprobes.  With
> > this change applied, it is somewhat easier to create custom test
> > kernel's with a proper debugging capabilities, thus making Linux more
> > developer friendly.
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> NAK
> 
> this patch is horrific, it sprinkles a metric ton of #ifdef and silently
> disables a lot of kprobe features (like all the opt stuff).

Perfectly nderstandable. I just drafted something quick andy dirty
together for idea's sake (and put RFC tag to state that).

The application where I use this chhange, is when I refactor large patch
set that I'm working on (namely SGX patch set in my case). I just want
squeece all the extra out from the kernel build and still have means for
instrumentation. A static kernel is very convenient for this kind of
purpose, as with EFI stub and statically linked user space you can have
a single test binary.

> How about unconditionally providing module_alloc() instead?

I believe so, yes.

Just so that I know (and learn), what did exactly disable optprobes?
Not too familiar with this part of the kernel - that's why I'm asking.
Does the module_alloc to vmalloc change disable it?

/Jarkko
