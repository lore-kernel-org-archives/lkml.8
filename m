Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41808C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AB8206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbgEMHLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:11:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:58192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEMHLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:11:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B847BAC90;
        Wed, 13 May 2020 07:11:44 +0000 (UTC)
Subject: Re: [patch V5 01/38] x86/kvm/svm: Use uninstrumented wrmsrl() to
 restore GS
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
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
References: <20200512210059.056244513@linutronix.de>
 <20200512213809.492016025@linutronix.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <00ceab91-c86e-be17-0ac9-e4a45d8e7b25@suse.com>
Date:   Wed, 13 May 2020 09:11:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512213809.492016025@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.20 23:01, Thomas Gleixner wrote:
> On guest exit MSR_GS_BASE contains whatever the guest wrote to it and the
> first action after returning from the ASM code is to set it to the host
> kernel value. This uses wrmsrl() which is interesting at least.
> 
> wrmsrl() is either using native_write_msr() or the paravirt variant. The
> XEN_PV code is uninteresting as nested SVM in a XEN_PV guest does not work.
> 
> But native_write_msr() can be placed out of line by the compiler especially
> when paravirtualization is enabled in the kernel configuration. The
> function is marked notrace, but still can be probed if
> CONFIG_KPROBE_EVENTS_ON_NOTRACE is enabled.
> 
> That would be a fatal problem as kprobe events use per-CPU variables which
> are GS based and would be accessed with the guest GS. Depending on the GS
> value this would either explode in colorful ways or lead to completely
> undebugable data corruption.
> 
> Aside of that native_write_msr() contains a tracepoint which objtool
> complains about as it is invoked from the noinstr section.
> 
> As this cannot run inside a XEN_PV guest there is no point in using
> wrmsrl(). Use native_wrmsrl() instead which is just a plain native WRMSR
> without tracing or anything else attached.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Juergen Gross <jgross@suse.com>

Acked-by: Juergen Gross <jgross@suse.com>


Juergen
