Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8B3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FC720738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgEUSlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgEUSlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:41:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3E9C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:41:49 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbq81-0006rj-7U; Thu, 21 May 2020 20:41:13 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 97BAC100C2D; Thu, 21 May 2020 20:41:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     paulmck@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 12/37] x86/entry: Provide idtentry_entry/exit_cond_rcu()
In-Reply-To: <20200521133920.GY2869@paulmck-ThinkPad-P72>
References: <874ksb7hbg.fsf@nanos.tec.linutronix.de> <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com> <20200520022353.GN2869@paulmck-ThinkPad-P72> <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com> <CALCETrVPM1x5v8Gq7xyF+QqxSWSWTShhc7K02nGJZuB-oVDxNw@mail.gmail.com> <20200520180546.GQ2869@paulmck-ThinkPad-P72> <87o8qiv135.fsf@nanos.tec.linutronix.de> <20200520221531.GW2869@paulmck-ThinkPad-P72> <20200520232550.GA20812@paulmck-ThinkPad-P72> <87zha1u1tc.fsf@nanos.tec.linutronix.de> <20200521133920.GY2869@paulmck-ThinkPad-P72>
Date:   Thu, 21 May 2020 20:41:11 +0200
Message-ID: <87mu61t9ko.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:
> On Thu, May 21, 2020 at 10:31:11AM +0200, Thomas Gleixner wrote:
>> And I made this a NOP for for !NOHZ_FULL systems and avoided the call if
>> context tracking is not enabled at boot.
>> 
>> void __rcu_irq_enter_check_tick(void);
>> 
>> static inline void rcu_irq_enter_check_tick(void)
>> {
>> 	if (context_tracking_enabled())
>>         	__rcu_irq_enter_check_tick();
>> }
>
> That certainly is a better approach!
>
> So let's go with your version.  But could you please post it, just in
> case reviewing an alternative version causes me to spot something?

I'm just testing the complete rework of this series and will post it if
it survives smoke testing.

Thanks,

        tglx
