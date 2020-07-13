Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E855C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDF620724
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgGMFGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:06:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:65191 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMFGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:06:03 -0400
IronPort-SDR: sL2fcUf6C+NkHc5mUBucqGbhA83qxOaFX3miz3cUSsqbPO4Rg4Lx5HyoJmXwaDSLuPdUb731UU
 O/UnUuN+9q5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="210095587"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="210095587"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 22:06:02 -0700
IronPort-SDR: +VKpVcMkfAQDb15VehValzhPE3TscLiDj//1nLJDqUAquYJhVjbdYZLVxTOFAfSgO40aVHvDME
 KayTCToVPXbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="484883611"
Received: from lgrunert-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.52.195])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jul 2020 22:05:51 -0700
Date:   Mon, 13 Jul 2020 08:05:49 +0300
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
Message-ID: <20200713050549.GA956284@linux.intel.com>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
 <20200710090344.GX4800@hirez.programming.kicks-ass.net>
 <20200710103638.GA2614@linux.intel.com>
 <20200710104910.GG4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710104910.GG4800@hirez.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:49:10PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 10, 2020 at 01:36:38PM +0300, Jarkko Sakkinen wrote:
> > Just so that I know (and learn), what did exactly disable optprobes?
> 
> So regular, old-skool style kprobe is:
> 
>   - copy original instruction out
>   - replace instruction with breakpoint (int3 on x86)
>   - have exception handler return to the copied instruction with
>     single-step on
>   - have single step exception handler return to the original
>     instruction stream
> 
> which is 2 exceptions.

Out of pure interest, how does it handle a jump (as the original
opcode), given that it single steps a copy?

> optprobes avoid the single-step by not only writing a single
> instruction, but additionally placing a JMP instruction behind it such
> that it will automagically continue in the original instruction stream.
> 
> This brings the requirement that the copied instruction is placed
> within the JMP displacement of the regular kernel text (s32 on x86).
> 
> module_alloc() ensures the memory provided is within that range.

Right, a relative jump is placed instead of 0xcc to the breakpoint?

/Jarkko
