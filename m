Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DCDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F542074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgFCTSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:18:52 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:15979 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:18:51 -0400
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: CruC9dfVaMVojQr/UOPY2mTe6T5ioywzr4Lhi+VQtLDQf+yiFmGiKJePNXDh6ScnBDsk0bhKhk
 CYtgn2FCTKnsw/3Xq1ObURfbyC4bGzAekdIG4nEbqzs6v9YnPa0PB4Sy1bKI1p+fLD3Yjf8fjK
 zVNlltByLT1wwGadp/mlqQpVZ/wEjOiwaE4Jtz+uTXKvt1vwUxnBoiQYMUv0aTZ0hB/+HzBddT
 butFUFP8Pf8/HtccoW02pjF64/Gh5VVmOIYFnCe1JKHfJBjKoD55l/whDBhbyUY5Cgzp0zora/
 EUQ=
X-SBRS: 2.7
X-MesageID: 19508042
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,468,1583211600"; 
   d="scan'208";a="19508042"
Subject: Re: [patch V9 00/39] x86/entry: Rework leftovers (was part V)
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
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
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>
References: <20200521200513.656533920@linutronix.de>
 <5e68aa83-feac-2aa7-10ee-aebebc60c83e@citrix.com>
 <20200522211706.GZ2483@worktop.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <83474edd-195f-f10b-9fe9-8ee168344e29@citrix.com>
Date:   Wed, 3 Jun 2020 20:18:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522211706.GZ2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2020 22:17, Peter Zijlstra wrote:
> On Fri, May 22, 2020 at 08:20:15AM +0100, Andrew Cooper wrote:
>> Apologies for opening a related can of worms.
>>
>> The new debug_enter() has propagated a pre-existing issue forward,
>> ultimately caused by bad advice in the SDM.
>>
>> Because the RTM status bit in DR6 has inverted polarity, writing DR6 to
>> 0 causes RTM to appear asserted to any logic which cares, despite RTM
>> debugging not being enabled.  The same is true in principle for what is
>> handed to userspace via u_debugreg[DR_STATUS].
>>
>> On the subject of DR6, the SDM now reads:
>>
>> "Certain debug exceptions may clear bits 0-3. The remaining contents of
>> the DR6 register are never cleared by the processor. To avoid confusion
>> in identifying debug exceptions, debug handlers should clear the
>> register (except bit 16, which they should set) before returning to the
>> interrupted task."
> *URGH*
>
>> First of all, that should read "are never de-asserted by the processor"
>> rather than "cleared", but the advice has still failed to learn from its
>> first mistake.  The forward-compatible way to fix this is to set
>> DR6_DEFAULT (0xffff0ff0) which also covers future inverted polarity bits.
>>
>> As for what to do about userspace, that is harder.  One approach is to
>> express everything in terms of positive polarity (i.e. pass on dr6 ^
>> DR6_DEFAULT), so DR6_RTM only appears set when RTM debugging is
>> enabled.  This approach is already taken with the VMCS PENDING_DBG
>> field, so there is at least previous form.
>>
>> I realise that "do nothing" might be acceptable at this point, given the
>> lack of support for RTM debugging.
> This! I'm thinking "do nothing" is, at this moment, the right thing to
> do. If/when someone goes and tries to make RTM debugging work, they get
> to figure out how to deal with this mess.

Well that didn't last long...

The new ISE (rev 39, published today) introduces BUS LOCK DEBUG
EXCEPTION which is now a second inverted polarity sticky bit (bit 11) in
%dr6.

This one is liable to get more traction than RTM debugging, so something
probably does want fixing in the #DB handler.

~Andrew
