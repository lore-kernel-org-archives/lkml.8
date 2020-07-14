Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD01EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979912220F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594727539;
	bh=QYU0TXeHgHnvQkESGYaDICoZUKqFcpcnTea3YB1qu/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pRJJGByfq4CcdlQ+LykcBoIXw4VJevF4pXRel2UPmtLDNBJJShVgPY129YedDnR/Y
	 y9d/yTd45OvzpgKUrPCqE7EMMZlp1lvsAYuAqs4omADrr9uOp0ckhj71oBwiqrBtN2
	 KRoks18mFInWAADZea1beSSoJ5vSExj5lG/2/AQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGNLwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgGNLwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:52:13 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F66222208;
        Tue, 14 Jul 2020 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594727532;
        bh=QYU0TXeHgHnvQkESGYaDICoZUKqFcpcnTea3YB1qu/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tu5pwN1uVwWmvDGkMkW4Z1rRWzTxMSd68pez14xgmab9ooEGJTnOgHN/Yp8xZBzvP
         x8XollKgByRKdCsCFUyE8SPU8znpyguI9TjZxl9pRlK6orJYphS4a64z+S8Gs4rp5E
         WXphEEYM8KsALIB8sOxvctoqOgWPgtt3tWKWdA2E=
Date:   Tue, 14 Jul 2020 20:52:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
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
Message-Id: <20200714205204.210a558f0560d8feae19e55d@kernel.org>
In-Reply-To: <20200713050549.GA956284@linux.intel.com>
References: <20200709234521.194005-1-jarkko.sakkinen@linux.intel.com>
        <20200710090344.GX4800@hirez.programming.kicks-ass.net>
        <20200710103638.GA2614@linux.intel.com>
        <20200710104910.GG4800@hirez.programming.kicks-ass.net>
        <20200713050549.GA956284@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 08:05:49 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> On Fri, Jul 10, 2020 at 12:49:10PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 10, 2020 at 01:36:38PM +0300, Jarkko Sakkinen wrote:
> > > Just so that I know (and learn), what did exactly disable optprobes?
> > 
> > So regular, old-skool style kprobe is:
> > 
> >   - copy original instruction out
> >   - replace instruction with breakpoint (int3 on x86)
> >   - have exception handler return to the copied instruction with
> >     single-step on
> >   - have single step exception handler return to the original
> >     instruction stream
> > 
> > which is 2 exceptions.
> 
> Out of pure interest, how does it handle a jump (as the original
> opcode), given that it single steps a copy?

Yes, the jump will be executed with a single-step on the copy buffer
and kprobes (on x86) fixes up the result, this means we modifies
the regs->ip. Also, there are some architectures which emulate the
jump instead of single-stepping.

> 
> > optprobes avoid the single-step by not only writing a single
> > instruction, but additionally placing a JMP instruction behind it such
> > that it will automagically continue in the original instruction stream.
> > 
> > This brings the requirement that the copied instruction is placed
> > within the JMP displacement of the regular kernel text (s32 on x86).
> > 
> > module_alloc() ensures the memory provided is within that range.
> 
> Right, a relative jump is placed instead of 0xcc to the breakpoint?

Yes, a relative (far) jump is used. So the target address (copied buffer)
must be in +-2GB range from the jump.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
