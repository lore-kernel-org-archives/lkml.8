Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03F5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A911920787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgEZHoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:44:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:36968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbgEZHoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:44:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4AC15B029;
        Tue, 26 May 2020 07:44:16 +0000 (UTC)
Subject: Re: [patch V9-1 13/39] x86/entry: Switch XEN/PV hypercall entry to
 IDTENTRY
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
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
 <20200521202118.055270078@linutronix.de>
 <87y2pjrfaz.fsf@nanos.tec.linutronix.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <af0bf4de-f963-f3af-a055-4ea945de7f5d@suse.com>
Date:   Tue, 26 May 2020 09:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87y2pjrfaz.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.20 20:32, Thomas Gleixner wrote:
> Convert the XEN/PV hypercall to IDTENTRY:
> 
>    - Emit the ASM stub with DECLARE_IDTENTRY
>    - Remove the ASM idtentry in 64bit
>    - Remove the open coded ASM entry code in 32bit
>    - Remove the old prototypes
> 
> The handler stubs need to stay in ASM code as it needs corner case handling
> and adjustment of the stack pointer.
> 
> Provide a new C function which invokes the entry/exit handling and calls
> into the XEN handler on the interrupt stack if required.
> 
> The exit code is slightly different from the regular idtentry_exit() on
> non-preemptible kernels. If the hypercall is preemptible and need_resched()
> is set then XEN provides a preempt hypercall scheduling function.
> 
> Move this functionality into the entry code so it can use the existing
> idtentry functionality.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Juergen Gross <jgross@suse.com>
Tested-by: Juergen Gross <jgross@suse.com>


Juergen
