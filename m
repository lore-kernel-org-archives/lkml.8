Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256F3C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0816A2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGMF43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:56:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:14263 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgGMF43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:56:29 -0400
IronPort-SDR: JAj2NYA/3t+Z0XuYd/cpbPdGGSIzJeaq6j/0CyjR7wa6+/QT+mmXAevyNiLPFJx8CjlqYmvovc
 0fV7WOfBLDjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="128136612"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="128136612"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 22:56:29 -0700
IronPort-SDR: XlPxoJ0oZgltWaoHwtoARhIrR24Ub0qKWskkUrQJy/RfCSWb0ZhPw72wwPFS8l1I1QQqK6tHyv
 zyE3zbjU/j3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="285279608"
Received: from lgrunert-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.52.195])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2020 22:56:16 -0700
Date:   Mon, 13 Jul 2020 08:56:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Ghiti <alex@ghiti.fr>,
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
Message-ID: <20200713055614.GF956284@linux.intel.com>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
 <20200710193257.4eeb19e9cd042d99cbca7f9a@kernel.org>
 <202007100849.9FA1E414A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007100849.9FA1E414A@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:51:56AM -0700, Kees Cook wrote:
> On Fri, Jul 10, 2020 at 07:32:57PM +0900, Masami Hiramatsu wrote:
> > On Fri, 10 Jul 2020 02:45:19 +0300
> > Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > > +#ifdef CONFIG_MODULES
> > >  	/* Lock modules while optimizing kprobes */
> > >  	mutex_lock(&module_mutex);
> > > +#endif
> > 
> > Hmm, can you reduce these "#ifdef CONFIG_MODULE"s ?
> > 
> > e.g. 
> > 
> > #ifdef CONFIG_MODULES
> > static void lock_modules(void)
> > {
> > 	mutex_lock(&module_mutex);
> > }
> > ...
> > #else
> > #define lock_modules() do { } while (0)
> > ...
> > #endif
> 
> I prefer using "static inline" for no-op functions just because they
> will maintain argument type validation by the compiler regardless of the
> CONFIG state (though it doesn't really matter here since it's void).
> 
> #else
> static inline lock_modules(void) { }
> #endif
> 
> -- 
> Kees Cook

Thanks Kees, good remark.

/Jarkko
