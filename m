Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4D0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6702468E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgB2X6l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:58:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgB2X6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:58:41 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78F8520409;
        Sat, 29 Feb 2020 23:58:39 +0000 (UTC)
Date:   Sat, 29 Feb 2020 18:58:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to
 C-code
Message-ID: <20200229185837.7d92cd2e@oasis.local.home>
In-Reply-To: <4EFF3B04-2C8A-4D63-BB63-B5804EBFFE2F@amacapital.net>
References: <87lfolfo79.fsf@nanos.tec.linutronix.de>
        <4EFF3B04-2C8A-4D63-BB63-B5804EBFFE2F@amacapital.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Feb 2020 11:25:24 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> > While the tracer itself seems to handle this correctly, what about
> > things like BPF programs which can be attached to tracepoints and
> > function trace entries?  
> 
> I think that everything using the tracing code, including BPF, should
> either do its own rcuidle stuff or explicitly not execute if we’re
> not in CONTEXT_KERNEL.  That is, we probably need to patch BPF.

That's basically the route we are taking.

-- Steve
