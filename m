Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01EBC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 13:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840A020731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 13:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgEJNk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 09:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728238AbgEJNk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 09:40:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C93C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 06:40:27 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jXmBM-0007cb-2w; Sun, 10 May 2020 15:39:52 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 766F6100D21; Sun, 10 May 2020 15:39:51 +0200 (CEST)
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
Subject: Re: [patch V4 part 2 01/18] x86/entry/64: Move non entry code into .text section
In-Reply-To: <CALCETrWJDdxnP5pJQinMkyL+mb3th1tWGY7psYqod8nDnrV2YQ@mail.gmail.com>
References: <20200505134112.272268764@linutronix.de> <20200505134340.227579223@linutronix.de> <CALCETrWJDdxnP5pJQinMkyL+mb3th1tWGY7psYqod8nDnrV2YQ@mail.gmail.com>
Date:   Sun, 10 May 2020 15:39:51 +0200
Message-ID: <87mu6f52oo.fsf@nanos.tec.linutronix.de>
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
>> All ASM code which is not part of the entry functionality can move out into
>> the .text section. No reason to keep it in the non-instrumentable entry
>> section.
>
> Ick.  How about just moving that code into another file altogether?

Peter wanted to do that separately.

>> +.pushsection .text, "ax"
>>  SYM_FUNC_START(native_load_gs_index)
>>         FRAME_BEGIN
>>         pushfq
>> @@ -1058,6 +1063,7 @@ SYM_FUNC_START(native_load_gs_index)
>>         ret
>>  SYM_FUNC_END(native_load_gs_index)
>>  EXPORT_SYMBOL(native_load_gs_index)
>> +.popsection
>
> native_load_gs_index is toast if it gets instrumented in the wrong way.

I'll keep it in the noinstr section then.

Thanks,

        tglx
