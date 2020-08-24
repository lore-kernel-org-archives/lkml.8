Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D5CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623852078A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="WZGapyBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHXL0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:26:45 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:30179 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHXL0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1598268367;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uLgLB2a4q8HfLdEXDk5PQGoYMPXoqYPypC34pa6oibk=;
  b=WZGapyBfkow7da63bNeRbZUX1xc5PGDEqgTJYnx5Ya9vepXGEIzlTL7m
   zE6Q+C1JgGjF0Xni90z0zoF0mwB2fs6VFyW+XkYfkP6XAk6OkxP9/zoL5
   8xHIHb7C0nBcbfJSP8nO4CascukwSWXNT/yy2SHsOvV5lQQv4g8unbC+b
   o=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: +QzTGq+VE6i8n0Fo73gs3DCcdhauAN45Hj4+BMtTzoBybZhNdWqRPZmXH4wigvJsP+WT1ul3yy
 Rf8dblAgZpvEf/L3QvnVD8x9hayFYafHuHn0ClibaAgSMvaMP2+QJkzWJ9V0RJq46luGTNepgP
 1E4ZmT4VpcYOu1PJzKGfjogruiRhwlhZKr7rVP18kYLS6mTTtC2UtrYHGU28zGiJUF7eaUPGxy
 W7vv0XRKXoMcus7Ye87Z/3fiQBNwdRHXpiCkEC6qL+KwaXMsyyeRxwmieGLS/U0iGIcLD54xO4
 fnM=
X-SBRS: 2.7
X-MesageID: 25286533
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,348,1592884800"; 
   d="scan'208";a="25286533"
Subject: Re: [PATCH v2 5/8] x86/debug: Simplify #DB signal code
To:     <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
References: <20200821093912.815135402@infradead.org>
 <20200821102053.034965283@infradead.org>
 <CALCETrVBB3YNCqCQ6bFBrSM10OTe354zyh=WbPFaEBxK1_Sa7g@mail.gmail.com>
 <20200824110501.GT1362448@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <b5ff8a44-1039-645c-de3e-d5f085cbc3f0@citrix.com>
Date:   Mon, 24 Aug 2020 12:26:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824110501.GT1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2020 12:05, peterz@infradead.org wrote:
> On Sun, Aug 23, 2020 at 04:09:42PM -0700, Andy Lutomirski wrote:
>> On Fri, Aug 21, 2020 at 3:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>> Get rid of the two variables, avoid computing si_code when not needed
>>> and be consistent about which dr6 value is used.
>>>
>>> -       if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
>>> -               send_sigtrap(regs, 0, si_code);
>>> +       /*
>>> +        * If dr6 has no reason to give us about the origin of this trap,
>>> +        * then it's very likely the result of an icebp/int01 trap.
>>> +        * User wants a sigtrap for that.
>>> +        */
>>> +       if (dr6 & (DR_STEP | DR_TRAP_BITS) || !dr6)
>>> +               send_sigtrap(regs, 0, get_si_code(dr6));
>> The old condition was ... || (actual DR6 value) and the new condition
>> was ... || (stupid notifier-modified DR6 value).  I think the old code
>> was more correct.
> Hurmph.. /me goes re-read the SDM.
>
> INT1 is a trap,
> instruction breakpoint is a fault
>
> So if you have:
>
> 	INT1
> 1:	some-instr
>
> and set an X breakpoint on 1, we'll loose the INT1, right?

You should get two.  First with a dr6 of 0 (ICEBP, RIP pointing at 1:),
and a second with dr6 indicating the X breakpoint (again, RIP pointing
at 1:).

SDM Vol3 6.9 PRIORITY AMONG SIMULTANEOUS EXCEPTIONS AND INTERRUPTS

Traps on previous instructions are at priority 4, because they still
"part" of the previous instruction.  X breakpoints are priority 7.

The two #DB's shouldn't merge because nothing inhibits delivery[1] of
the trap at priority 4, and on return from the handler, RF isn't set so
the instruction breakpoint will trigger.

~Andrew

[1] Anyone playing with MovSS gets to keep all resulting pieces.
