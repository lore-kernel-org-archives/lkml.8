Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384A7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD1F2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgEVHgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:36:33 -0400
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:52194 "EHLO
        ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgEVHgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:36:33 -0400
X-Greylist: delayed 930 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2020 03:36:32 EDT
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from 88-109-182-220.dynamic.dsl.as9105.com ([88.109.182.220]:33852 helo=[192.168.1.219])
        by ppsw-31.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:465)
        with esmtpsa (PLAIN:amc96) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        id 1jc1ya-000pAW-LG (Exim 4.92.3)
        (return-path <amc96@hermes.cam.ac.uk>); Fri, 22 May 2020 08:20:16 +0100
Subject: Re: [patch V9 00/39] x86/entry: Rework leftovers (was part V)
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20200521200513.656533920@linutronix.de>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <5e68aa83-feac-2aa7-10ee-aebebc60c83e@citrix.com>
Date:   Fri, 22 May 2020 08:20:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521200513.656533920@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2020 21:05, Thomas Gleixner wrote:
> Folks!
>
> This is V9 of the rework series. V7 and V8 were never posted but I used the
> version numbers for tags while fixing up 0day complaints. The last posted
> version was V6 which can be found here:
>
>   https://lore.kernel.org/r/20200515234547.710474468@linutronix.de
>
> The V9 leftover series is based on:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
>
> That branch contains the merged part 1-4 of the original 5 part series.
>
> V9 has the following changes vs. V6:
>
>    - Rebase on tip x86/entry

Apologies for opening a related can of worms.

The new debug_enter() has propagated a pre-existing issue forward,
ultimately caused by bad advice in the SDM.

Because the RTM status bit in DR6 has inverted polarity, writing DR6 to
0 causes RTM to appear asserted to any logic which cares, despite RTM
debugging not being enabled.  The same is true in principle for what is
handed to userspace via u_debugreg[DR_STATUS].

On the subject of DR6, the SDM now reads:

"Certain debug exceptions may clear bits 0-3. The remaining contents of
the DR6 register are never cleared by the processor. To avoid confusion
in identifying debug exceptions, debug handlers should clear the
register (except bit 16, which they should set) before returning to the
interrupted task."

First of all, that should read "are never de-asserted by the processor"
rather than "cleared", but the advice has still failed to learn from its
first mistake.  The forward-compatible way to fix this is to set
DR6_DEFAULT (0xffff0ff0) which also covers future inverted polarity bits.

As for what to do about userspace, that is harder.  One approach is to
express everything in terms of positive polarity (i.e. pass on dr6 ^
DR6_DEFAULT), so DR6_RTM only appears set when RTM debugging is
enabled.  This approach is already taken with the VMCS PENDING_DBG
field, so there is at least previous form.

I realise that "do nothing" might be acceptable at this point, given the
lack of support for RTM debugging.

Thanks,

~Andrew
