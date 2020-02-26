Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCCAC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09BD20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/pW6XQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBZIRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:17:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40934 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgBZIRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2MwOqkNX2qPgKsky0vnBn63NQXbYgA+3jDCa4bEWSLA=; b=U/pW6XQUfiLQEMgz0/wSHoufYv
        EVDeAAnLao33RfLssNi6hTTuKi4khIGdhNORXZz+klZNoxgsUs1S78UffMNrld1iw32wETQQj33Tu
        0IxA9+f3XNzkCVPzF0rSdGhVqNOP/d+BnE//GY5VDOmVrYiulbXarXSgiRSpwMdzl3rom5qrRlrId
        4VF7jbqb1O2JrYWzp0ws/EVpjk3GKRyUZZcLI54gotJiMj0DvJ94uqwdNVPgZieNyG3MxsjsSmyOU
        X/Tio/auZreshbks/HFGuSlGvB4Fg7zU5Av8FIcaWCrJ1d7g+N7Fk4aag/oa0/ZGUCL8SAUIOF2L7
        dEPAFpTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6rsl-0007Yd-Uv; Wed, 26 Feb 2020 08:17:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A33F300478;
        Wed, 26 Feb 2020 09:15:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AA91203CBB5F; Wed, 26 Feb 2020 09:17:26 +0100 (CET)
Date:   Wed, 26 Feb 2020 09:17:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to
 C-code
Message-ID: <20200226081726.GQ18400@hirez.programming.kicks-ass.net>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.605144982@linutronix.de>
 <6c4188c7-558e-b225-5a41-2ffaa5fa120e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c4188c7-558e-b225-5a41-2ffaa5fa120e@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 09:43:46PM -0800, Andy Lutomirski wrote:
> On 2/25/20 2:08 PM, Thomas Gleixner wrote:
> > Now that the C entry points are safe, move the irq flags tracing code into
> > the entry helper.
> 
> I'm so confused.
> 
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/x86/entry/common.c          |    5 +++++
> >  arch/x86/entry/entry_32.S        |   12 ------------
> >  arch/x86/entry/entry_64.S        |    2 --
> >  arch/x86/entry/entry_64_compat.S |   18 ------------------
> >  4 files changed, 5 insertions(+), 32 deletions(-)
> > 
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -57,6 +57,11 @@ static inline void enter_from_user_mode(
> >   */
> >  static __always_inline void syscall_entry_fixups(void)
> >  {
> > +	/*
> > +	 * Usermode is traced as interrupts enabled, but the syscall entry
> > +	 * mechanisms disable interrupts. Tell the tracer.
> > +	 */
> > +	trace_hardirqs_off();
> 
> Your earlier patches suggest quite strongly that tracing isn't safe
> until enter_from_user_mode().  But trace_hardirqs_off() calls
> trace_irq_disable_rcuidle(), which looks [0] like a tracepoint.
> 
> Did you perhaps mean to do this *after* enter_from_user_mode()?

aside from the fact that enter_from_user_mode() itself also has a
tracepoint, the crucial detail is that we must not trace/kprobe the
function calling this.

Specifically for #PF, because we need read_cr2() before this. See later
patches.
