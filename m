Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6439CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1B420671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgETLiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:38:24 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:56676 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETLiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:38:23 -0400
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: 84iK1yZ81elW9v6wX/8JlsUWvCrnxYXB8qmY4V2t2ZFfInudAu588lA+HkkADnrmFrkn3CTkiS
 0gOzPd2PmM+IQyhfSspQzytUSXSPl1R6fFzEjfJYIHoKhL+0ZVUGQPg7BmE/5cx55FcAnYLwcA
 S6d4DPKu9NCN4S+yKrYmGZ5VDFcFQGgMb6nt0wsFcd81EotnQmW6hv1YUVQRtKZbOzisakRA4T
 sK3h/+CPAfBThI/N9xLyyra2hwyDh1vqcIxOF5rtlu5fFCft/1ivdqT8J9e38crYFg42pEkxwJ
 6q8=
X-SBRS: 2.7
X-MesageID: 17967281
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,413,1583211600"; 
   d="scan'208";a="17967281"
Subject: Re: [patch V6 10/37] x86/entry: Switch XEN/PV hypercall entry to
 IDTENTRY
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20200515234547.710474468@linutronix.de>
 <20200515235125.425810667@linutronix.de>
 <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com>
 <87imgr7nwp.fsf@nanos.tec.linutronix.de>
 <CALCETrW4BxfTVzv8mXntNXiAPnKxqdMEv7djUknGZcrno2WJHg@mail.gmail.com>
 <3dd0e972-1b80-cd6b-6490-5b745ada68c8@suse.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <a6c3b5b5-89d3-2d05-47eb-8d4caf34fe0a@citrix.com>
Date:   Wed, 20 May 2020 12:31:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3dd0e972-1b80-cd6b-6490-5b745ada68c8@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: FTLPEX02CAS03.citrite.net (10.13.99.94) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2020 09:06, Jürgen Groß wrote:
> On 19.05.20 21:44, Andy Lutomirski wrote:
>> On Tue, May 19, 2020 at 11:58 AM Thomas Gleixner <tglx@linutronix.de>
>> wrote:
>>>
>>> Andy Lutomirski <luto@kernel.org> writes:
>>>> B: Turn this thing around.  Specifically, in the one and only case we
>>>> care about, we know pretty much exactly what context we got this entry
>>>> in: we're running in a schedulable context doing an explicitly
>>>> preemptible hypercall, and we have RIP pointing at a SYSCALL
>>>> instruction (presumably, but we shouldn't bet on it) in the hypercall
>>>> page.  Ideally we would change the Xen PV ABI so the hypercall would
>>>> return something like EAGAIN instead of auto-restarting and we could
>>>> ditch this mess entirely.  But the ABI seems to be set in stone or at
>>>> least in molasses, so how about just:
>>>>
>>>> idt_entry(exit(regs));
>>>> if (inhcall && need_resched())
>>>>    schedule();
>>>
>>> Which brings you into the situation that you call schedule() from the
>>> point where we just moved it out. If we would go there we'd need to
>>> ensure that RCU is watching as well. idtentry_exit() might have it
>>> turned off ....
>>
>> I don't think this is possible.  Once you untangle all the wrappers,
>> the call sites are effectively:
>>
>> __this_cpu_write(xen_in_preemptible_hcall, true);
>> CALL_NOSPEC to the hypercall page
>> __this_cpu_write(xen_in_preemptible_hcall, false);
>>
>> I think IF=1 when this happens, but I won't swear to it.  RCU had
>> better be watching.
>
> Preemptible hypercalls are never done with interrupts off. To be more
> precise: they are only ever done during ioctl() processing.
>
> I can add an ASSERT() to xen_preemptible_hcall_begin() if you want.
>
>>
>> As I understand it, the one and only situation Xen wants to handle is
>> that an interrupt gets delivered during the hypercall.  The hypervisor
>> is too clever for its own good and deals with this by rewinding RIP to
>> the beginning of whatever instruction did the hypercall and delivers
>> the interrupt, and we end up in this handler.  So, if this happens,
>> the idea is to not only handle the interrupt but to schedule if
>> scheduling would be useful.
>
> Correct. More precise: the hypercalls in question can last very long
> (up to several seconds) and so they need to be interruptible. As said
> before: the interface how this is done is horrible. :-(

Forget seconds.  DOMCTL_domain_kill gets to ~14 minutes for a 2TB domain.

The reason for the existing logic is to be able voluntarily preempt.

It doesn't need to remain the way it is, but some adequate form of
pre-emption does need to stay.

~Andrew
