Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D00DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C95620657
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgENSob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726667AbgENSob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:44:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055B6C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:44:31 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZIq1-0005j2-Pr; Thu, 14 May 2020 20:44:09 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 019A81004CE; Thu, 14 May 2020 20:44:08 +0200 (CEST)
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
Subject: Re: [patch V4 part 4 08/24] x86/entry: Provide IDTENTRY_IST
In-Reply-To: <CALCETrWKi=+GUbAi+3OJ3CMaegz2HqQYNQKdwmRHb_xoc+YVgQ@mail.gmail.com>
References: <20200505134926.578885807@linutronix.de> <20200505135314.137125609@linutronix.de> <CALCETrWKi=+GUbAi+3OJ3CMaegz2HqQYNQKdwmRHb_xoc+YVgQ@mail.gmail.com>
Date:   Thu, 14 May 2020 20:44:08 +0200
Message-ID: <87v9kyxsp3.fsf@nanos.tec.linutronix.de>
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
> On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Same as IDTENTRY but for exceptions which run on Interrupt STacks (IST) on
>> 64bit. For 32bit this maps to IDTENTRY.
>>
>> There are 3 variants which will be used:
>>       IDTENTRY_MCE
>>       IDTENTRY_DB
>>       IDTENTRY_NMI
>>
>> These map to IDTENTRY_IST, but only the MCE and DB variants are emitting
>> ASM code as the NMI entry needs hand crafted ASM still.
>>
>> The function defines do not contain any idtenter/exit calls as these
>> exceptions need special treatment.
>
> Okay I guess, but in the long run I'm guessing that we'll want to
> merge a bunch of this to DECLARE_IDTENTRY_NOASM and just manually emit
> the special cases in entry_32/64.S.

The ASM is still the paranoid muck which is emitted nicely.

But on the C side this needs a different treatment than the regular
exceptions which all use idtentry_enter() before and idtentry_exit()
after the handler function body.

Those need magic things before and after nmi_enter/exit(). That's why
the C function is directly called and does not have any automatically
emitted enter/exit stuff like the other IDTENTRY variants.

Thanks,

        tglx


