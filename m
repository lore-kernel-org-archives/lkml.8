Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D039C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2193224695
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583078417;
	bh=6efDZnmGDkJL77bmpEcO3rXxowZRDGagRBQHbPMJzkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gwQ5q6rbMT8AZPke6kLIpwN9pyeHYCIyfVeEd3n7+oGLPlO705jys+SvayKV5HHC9
	 5r9n5627UulyzJXqPlNp+1B/dZBgJrDtRe+haCi7UPlxUizqlLVNED93b3v4wKdU8M
	 rzRXyFVkh64z1+T6RVtUb68fkT0JLrjGQNHiyT5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCAQAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 11:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCAQAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:00:15 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C0D24699
        for <linux-kernel@vger.kernel.org>; Sun,  1 Mar 2020 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583078414;
        bh=6efDZnmGDkJL77bmpEcO3rXxowZRDGagRBQHbPMJzkQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rkVGb1M0gWa9aItjisU6DZW23p/pFOObZSdHAA7CP3t2H2C8vgYED2qlRl5fiRyWk
         jFufCtEArscTQyaWSBZYGY4V6Oz+1DZhcPtlWENncqPbt+B39FmkMnOx++4XBfRMzG
         CV98dwGd1FkqWaFTpUP9yGyvw6GVTOVeMDMfbDPA=
Received: by mail-wr1-f47.google.com with SMTP id z15so9418929wrl.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 08:00:14 -0800 (PST)
X-Gm-Message-State: APjAAAVuZe0U+rGknjAvemQMy/p6icaj4CJhtpLY+OeUuPijlFXzv713
        0aHPxBBA6yrFVCaoNpTLSpbYkfSb3+HeX7n8pl666Q==
X-Google-Smtp-Source: APXvYqztrpI+89yhqZUt2L3rT48/Ijlnf78uBMShm928Pz/l01ZvUEf0d1qcB4iBzOAwH8/nx+2lc15sY408T35c+50=
X-Received: by 2002:adf:df0c:: with SMTP id y12mr16702017wrl.257.1583078412945;
 Sun, 01 Mar 2020 08:00:12 -0800 (PST)
MIME-Version: 1.0
References: <87imjofkhx.fsf@nanos.tec.linutronix.de> <AED99B11-8739-450F-932C-EF38C20D44CA@amacapital.net>
 <87d09wf6dw.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d09wf6dw.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 1 Mar 2020 08:00:01 -0800
X-Gmail-Original-Message-ID: <CALCETrVNcpoubrpVrtGjXSQrod8jzjweszEPX_WSJM747xr8wQ@mail.gmail.com>
Message-ID: <CALCETrVNcpoubrpVrtGjXSQrod8jzjweszEPX_WSJM747xr8wQ@mail.gmail.com>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 1, 2020 at 7:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@amacapital.net> writes:
> >> On Mar 1, 2020, at 2:16 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Ok, but for the time being anything before/after CONTEXT_KERNEL is unsafe
> >> except trace_hardirq_off/on() as those trace functions do not allow to
> >> attach anything AFAICT.
> >
> > Can you point to whatever makes those particular functions special?  I
> > failed to follow the macro maze.
>
> Those are not tracepoints and not going through the macro maze. See
> kernel/trace/trace_preemptirq.c

That has:

void trace_hardirqs_on(void)
{
        if (this_cpu_read(tracing_irq_cpu)) {
                if (!in_nmi())
                        trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
                tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
                this_cpu_write(tracing_irq_cpu, 0);
        }

        lockdep_hardirqs_on(CALLER_ADDR0);
}
EXPORT_SYMBOL(trace_hardirqs_on);
NOKPROBE_SYMBOL(trace_hardirqs_on);

But this calls trace_irq_enable_rcuidle(), and that's the part of the
macro maze I got lost in.  I found:

#ifdef CONFIG_TRACE_IRQFLAGS
DEFINE_EVENT(preemptirq_template, irq_disable,
             TP_PROTO(unsigned long ip, unsigned long parent_ip),
             TP_ARGS(ip, parent_ip));

DEFINE_EVENT(preemptirq_template, irq_enable,
             TP_PROTO(unsigned long ip, unsigned long parent_ip),
             TP_ARGS(ip, parent_ip));
#else
#define trace_irq_enable(...)
#define trace_irq_disable(...)
#define trace_irq_enable_rcuidle(...)
#define trace_irq_disable_rcuidle(...)
#endif

But the DEFINE_EVENT doesn't have the "_rcuidle" part.  And that's
where I got lost in the macro maze.  I looked at the gcc asm output,
and there is, indeed:

# ./include/trace/events/preemptirq.h:40:
DEFINE_EVENT(preemptirq_template, irq_enable,

with a bunch of asm magic that looks like it's probably a tracepoint.
I still don't quite see where the "_rcuidle" went.

But I also don't see why this is any different from any other tracepoint.

--Andy
