Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0F5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE86206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgENMd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:33:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8283C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:33:27 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZD2t-0006Lq-6u; Thu, 14 May 2020 14:33:03 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7484A1004CE; Thu, 14 May 2020 14:33:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 17/29] x86/entry: Convert Invalid Opcode exception to IDTENTRY
In-Reply-To: <CALCETrVkcKvAQgO6uutBOpBYELQ9hYy9mPTXyDzCYkT1we3aTg@mail.gmail.com>
References: <20200505134354.774943181@linutronix.de> <20200505134904.955511913@linutronix.de> <CALCETrVkcKvAQgO6uutBOpBYELQ9hYy9mPTXyDzCYkT1we3aTg@mail.gmail.com>
Date:   Thu, 14 May 2020 14:33:02 +0200
Message-ID: <87k11ezog1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> Convert #UD to IDTENTRY:
>>   - Implement the C entry point with DEFINE_IDTENTRY
>>   - Emit the ASM stub with DECLARE_IDTENTRY
>>   - Remove the ASM idtentry in 64bit
>>   - Remove the open coded ASM entry code in 32bit
>>   - Fixup the XEN/PV code
>>   - Fixup the FOOF bug call in fault.c
>>   - Remove the old prototyoes
>>
>> No functional change.
>
> I think there *is* a functional change:
>
>
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -567,7 +567,7 @@ static int is_f00f_bug(struct pt_regs *r
>>                 nr = (address - idt_descr.address) >> 3;
>>
>>                 if (nr == 6) {
>> -                       do_invalid_op(regs, 0);
>> +                       handle_invalid_op(regs);
>
> I suspect the old code was wrong and no one noticed because no one has
> a F00F-buggy machine any more.

I don't think so. It's really just the same thing. The old #UD C
function was:

void do_invalid_op(struct pt_regs *regs, long error_code)
{
	do_error_trap(regs, error_code, "invalid opcode", X86_TRAP_UD,
                      SIGILL, ILL_ILLOPN, (void __user *)uprobe_get_trap_addr(regs));
}

after expanding the DO_ERROR() muck.

The new one does:

void handle_invalid_op(struct pt_regs *regs)
{
	do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
		      ILL_ILLOPN, error_get_trap_addr(regs));
}

which is exactly the same except for the error code being hardcoded to
zero in handle_invalid_op() because #UD does not have one.

> So maybe document that you fixed up the F00F bug, too.  Otherwise:

Not sure what to document :)

Thanks,

        tglx
