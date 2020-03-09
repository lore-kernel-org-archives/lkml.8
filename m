Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7CEC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6BD20578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCIPlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:41:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59492 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgCIPlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:41:07 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBKWU-0002Bp-Kl; Mon, 09 Mar 2020 16:40:54 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 495871040A7; Mon,  9 Mar 2020 16:40:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [patch part-II V2 02/13] x86/entry: Mark enter_from_user_mode() notrace and NOKPROBE
In-Reply-To: <20200309151423.GE9615@lenoir>
References: <20200308222359.370649591@linutronix.de> <20200308222609.125574449@linutronix.de> <20200309151423.GE9615@lenoir>
Date:   Mon, 09 Mar 2020 16:40:54 +0100
Message-ID: <87pndl7czd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:

> On Sun, Mar 08, 2020 at 11:24:01PM +0100, Thomas Gleixner wrote:
>> Both the callers in the low level ASM code and __context_tracking_exit()
>> which is invoked from enter_from_user_mode() via user_exit_irqoff() are
>> marked NOKPROBE. Allowing enter_from_user_mode() to be probed is
>> inconsistent at best.
>> 
>> Aside of that while function tracing per se is safe the function trace
>> entry/exit points can be used via BPF as well which is not safe to use
>> before context tracking has reached CONTEXT_KERNEL and adjusted RCU.
>> 
>> Mark it notrace and NOKROBE.
>
> Ok for the NOKPROBE, also I remember from the inclusion of kprobes
> that spreading those NOKPROBE couldn't be more than some sort of best
> effort to mitigate the accidents and it's up to the user to keep some
> common sense and try to stay away from the borderline functions. The same
> would apply to breakpoints, steps, etc...
>
> Now for the BPF and function tracer, the latter has been made robust to
> deal with these fragile RCU blind spots. Probably the same requirements should be
> expected from the function tracer users. Perhaps we should have a specific
> version of __register_ftrace_function() which protects the given probes
> inside rcu_nmi_enter()? As it seems the BPF maintainer doesn't want the whole
> BPF execution path to be hammered.

Right. The problem is that as things stand e.g. for tracepoints you need
to invoke trace_foo_rcuidle() which then does the scru/rcu_irq dance
around the invocation, but then the functions attached need to be fixed
that they are not issuing rcu_read_lock() or such.

While that is halfways doable for tracepoints when you place them, the
whole function entry/exit hooks along with kprobes are even more
interesting because functions can be called from arbitrary contexts...

So to make this sane, you'd need to do:

   if (!rcu_watching()) {
   	....
   } else {
        ....
   }

and the reverse when leaving the thing. So in the worst case you end up
with a gazillion of scru/rcu_irq pairs which really make crap slow.

So we are way better off to have well defined off limit regions and are
careful about them and then switch over ONCE and be done with it.

Thanks,

        tglx
