Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D6FC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDD02072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBZTvS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:51:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59365 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBZTvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:51:18 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j72hx-0005Qo-QL; Wed, 26 Feb 2020 20:51:01 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3C141104099; Wed, 26 Feb 2020 20:51:01 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
In-Reply-To: <83D8A083-792A-4A82-985C-CAC33BC702DB@amacapital.net>
References: <20200226081726.GQ18400@hirez.programming.kicks-ass.net> <83D8A083-792A-4A82-985C-CAC33BC702DB@amacapital.net>
Date:   Wed, 26 Feb 2020 20:51:01 +0100
Message-ID: <87sgixb00q.fsf@nanos.tec.linutronix.de>
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

Andy Lutomirski <luto@amacapital.net> writes:
>> On Feb 26, 2020, at 12:17 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> ﻿On Tue, Feb 25, 2020 at 09:43:46PM -0800, Andy Lutomirski wrote:
>>> Your earlier patches suggest quite strongly that tracing isn't safe
>>> until enter_from_user_mode().  But trace_hardirqs_off() calls
>>> trace_irq_disable_rcuidle(), which looks [0] like a tracepoint.
>>> 
>>> Did you perhaps mean to do this *after* enter_from_user_mode()?
>> 
>> aside from the fact that enter_from_user_mode() itself also has a
>> tracepoint, the crucial detail is that we must not trace/kprobe the
>> function calling this.
>> 
>> Specifically for #PF, because we need read_cr2() before this. See later
>> patches.
>
> Indeed. I’m fine with this patch, but I still don’t understand what
> the changelog is about.

Yeah, the changelog is not really helpful. Let me fix that.

> And I’m still rather baffled by most of the notrace annotations in the
> series.

As discussed on IRC, this might be too broad, but then I rather have the
actual C-entry points neither traceable nor probable in general and
relax this by calling functions which can be traced and probed.

My rationale for this decision was that enter_from_user_mode() is marked
notrace/noprobe as well, so I kept the protection scope the same as we
had in the ASM maze which is marked noprobe already.

Thanks,

        tglx
