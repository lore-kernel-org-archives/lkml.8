Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA67BC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80D820731
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEIKHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 06:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbgEIKHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 06:07:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643D6C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 03:07:08 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jXMNJ-0005Q1-AH; Sat, 09 May 2020 12:06:29 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 247B1100C8A; Sat,  9 May 2020 12:06:28 +0200 (CEST)
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
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V4 part 2 12/18] x86,objtool: Make entry_64_compat.S objtool clean
In-Reply-To: <CALCETrW7dNE2eoYANRjkRMzdXDh0jDD=cDT4WaKhQKsxYkkb4w@mail.gmail.com>
References: <20200505134112.272268764@linutronix.de> <20200505134341.272248024@linutronix.de> <CALCETrW7dNE2eoYANRjkRMzdXDh0jDD=cDT4WaKhQKsxYkkb4w@mail.gmail.com>
Date:   Sat, 09 May 2020 12:06:28 +0200
Message-ID: <87sgg94e3f.fsf@nanos.tec.linutronix.de>
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

> On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Currently entry_64_compat is exempt from objtool, but with vmlinux
>> mode there is no hiding it.
>>
>> Make the following changes to make it pass:
>>
>>  - change entry_SYSENTER_compat to STT_NOTYPE; it's not a function
>>    and doesn't have function type stack setup.
>>
>>  - mark all STT_NOTYPE symbols with UNWIND_HINT_EMPTY; so we do
>>    validate them and don't treat them as unreachable.
>>
>>  - don't abuse RSP as a temp register, this confuses objtool
>>    mightily as it (rightfully) thinks we're doing unspeakable
>>    things to the stack.
>>
>
> Acked-by: Andy Lutomirski <luto@kernel.org>
>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Did a From line get eaten?

Yes. A couple of patches which were just handed back and forth between
me and Peter lost them. Fixed them all up localy already.

Thanks,

        tglx
