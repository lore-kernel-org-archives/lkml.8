Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A391CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED3C20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nScvOLV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGJKtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:49:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FBEC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AxVVCQeeOzIrbDpXQzQLviQKPDCJ2J00omBMDFGGswA=; b=nScvOLV2wKB/e07W1eR8zN31B+
        sIw1iq3WWW2WdZmC6cnHsjTYL8yYk7Jc5yg9xqiG3XF8axzK+SjlXhcZsMIt16vdpeYbYJ472IPNq
        jTbZmbZe6K2iNxrwb4CpkZ/lFddq3HqhexM11q1O6meST/E2YlduPJBFaP3AuBePqzAyYcluSASNo
        yBMMao1Uh/UiNpPsP9V03KxIgzu98Ki2ETwV127tvN7KO/+wrVr/NtO3FtAulAtTE/UUngqGPHh/P
        x9ACcuip1oCfrPOvisqY5vxLxxixqWMlbRa7SToliZPQ9NYZLJQqgyIIYVsvG3to3N2MSSkhDj3dq
        mcQRqXyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtqae-0001YG-P0; Fri, 10 Jul 2020 10:49:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4FAA3059C6;
        Fri, 10 Jul 2020 12:49:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AAA8820A2955A; Fri, 10 Jul 2020 12:49:10 +0200 (CEST)
Date:   Fri, 10 Jul 2020 12:49:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
Message-ID: <20200710104910.GG4800@hirez.programming.kicks-ass.net>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
 <20200710090344.GX4800@hirez.programming.kicks-ass.net>
 <20200710103638.GA2614@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710103638.GA2614@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 01:36:38PM +0300, Jarkko Sakkinen wrote:
> Just so that I know (and learn), what did exactly disable optprobes?

So regular, old-skool style kprobe is:

  - copy original instruction out
  - replace instruction with breakpoint (int3 on x86)
  - have exception handler return to the copied instruction with
    single-step on
  - have single step exception handler return to the original
    instruction stream

which is 2 exceptions.

optprobes avoid the single-step by not only writing a single
instruction, but additionally placing a JMP instruction behind it such
that it will automagically continue in the original instruction stream.

This brings the requirement that the copied instruction is placed
within the JMP displacement of the regular kernel text (s32 on x86).

module_alloc() ensures the memory provided is within that range.


