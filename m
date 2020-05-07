Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7038EC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DAC2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEGRO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725949AbgEGRO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:14:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5765C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:14:27 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWk5x-0001Cu-3r; Thu, 07 May 2020 19:14:01 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6A472102652; Thu,  7 May 2020 19:14:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [patch V4 part 3 04/29] x86/traps: Make interrupt enable/disable symmetric in C code
In-Reply-To: <4b13ee35-da6f-a77d-cb19-1b32657cb939@oracle.com>
References: <20200505134354.774943181@linutronix.de> <20200505134903.622702796@linutronix.de> <4b13ee35-da6f-a77d-cb19-1b32657cb939@oracle.com>
Date:   Thu, 07 May 2020 19:14:00 +0200
Message-ID: <87tv0rekh3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Chartre <alexandre.chartre@oracle.com> writes:

> On 5/5/20 3:43 PM, Thomas Gleixner wrote:
>> Traps enable interrupts conditionally but rely on the ASM return code to
>> disable them again. That results in redundant interrupt disable and trace
>> calls.
>> 
>> Make the trap handlers disable interrupts before returning to avoid that,
>> which allows simplification of the ASM entry code.
>> 
>> Originally-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> 
>> ---
>>   arch/x86/kernel/traps.c |   28 +++++++++++++++++++---------
>>   arch/x86/mm/fault.c     |   15 +++++++++++++--
>>   2 files changed, 32 insertions(+), 11 deletions(-)
>> 
>
> So this patch makes C trap handlers disable interrupts on return but there's no
> change to the ASM entry code, which will still (also) disable interrupts. I suppose
> this is cleaned up in a next patch. So it's worth mentioning that the "simplification
> of the ASM entry code" is not in this patch.

I thought that was expressed by:

>> which allows simplification of the ASM entry code.

but yeah it's ambigous. Will clarify.

Thanks,

        tglx
