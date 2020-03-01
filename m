Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A88C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 10:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E82214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 10:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCAKQq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 05:16:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40021 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCAKQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 05:16:46 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j8Le7-0003DH-Ix; Sun, 01 Mar 2020 11:16:27 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D68BD100EA2; Sun,  1 Mar 2020 11:16:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
In-Reply-To: <20200229185837.7d92cd2e@oasis.local.home>
References: <87lfolfo79.fsf@nanos.tec.linutronix.de> <4EFF3B04-2C8A-4D63-BB63-B5804EBFFE2F@amacapital.net> <20200229185837.7d92cd2e@oasis.local.home>
Date:   Sun, 01 Mar 2020 11:16:26 +0100
Message-ID: <87imjofkhx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Sat, 29 Feb 2020 11:25:24 -0800
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>> > While the tracer itself seems to handle this correctly, what about
>> > things like BPF programs which can be attached to tracepoints and
>> > function trace entries?  
>> 
>> I think that everything using the tracing code, including BPF, should
>> either do its own rcuidle stuff or explicitly not execute if we’re
>> not in CONTEXT_KERNEL.  That is, we probably need to patch BPF.
>
> That's basically the route we are taking.

Ok, but for the time being anything before/after CONTEXT_KERNEL is unsafe
except trace_hardirq_off/on() as those trace functions do not allow to
attach anything AFAICT.

Thanks,

        tglx
