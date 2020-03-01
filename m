Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4213DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 18:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E2D246B9
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 18:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCASXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 13:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgCASXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 13:23:08 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8F0124692;
        Sun,  1 Mar 2020 18:23:06 +0000 (UTC)
Date:   Sun, 1 Mar 2020 13:23:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to
 C-code
Message-ID: <20200301132305.68729da8@oasis.local.home>
In-Reply-To: <CALCETrVNcpoubrpVrtGjXSQrod8jzjweszEPX_WSJM747xr8wQ@mail.gmail.com>
References: <87imjofkhx.fsf@nanos.tec.linutronix.de>
        <AED99B11-8739-450F-932C-EF38C20D44CA@amacapital.net>
        <87d09wf6dw.fsf@nanos.tec.linutronix.de>
        <CALCETrVNcpoubrpVrtGjXSQrod8jzjweszEPX_WSJM747xr8wQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Mar 2020 08:00:01 -0800
Andy Lutomirski <luto@kernel.org> wrote:

> But the DEFINE_EVENT doesn't have the "_rcuidle" part.  And that's
> where I got lost in the macro maze.  I looked at the gcc asm output,
> and there is, indeed:
> 
> # ./include/trace/events/preemptirq.h:40:
> DEFINE_EVENT(preemptirq_template, irq_enable,
> 
> with a bunch of asm magic that looks like it's probably a tracepoint.
> I still don't quite see where the "_rcuidle" went.

See the code in include/linux/tracepoint.h and search for "rcuidle"
there. All defined trace events get a "_rcuidle" version, but as it is
declared a static inline, then they only show up if they are used.

-- Steve
