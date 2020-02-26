Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D88C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9372468A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582729818;
	bh=g5VTwMGaK0OJyOYHoeCbwp4ZrmRijn3kpXqLNP75A7I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=skqdC1lR2XR6anxju1W/frnw0ZiGYj2L6mIs56M/et6sitkTSsFZMG2jl9O/Gwqjq
	 AqhH06xJZksmtB0yzTmd2B6cH/vhvLsUirKboJljJTGRcPDukoK0/KICnpVNgct/C1
	 6iXxv47ZC52VaAh16dwQUev/vsyq1WiT50uut008=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBZPKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgBZPKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:10:14 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50FA724699
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582729814;
        bh=g5VTwMGaK0OJyOYHoeCbwp4ZrmRijn3kpXqLNP75A7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=shsGvBGnxoWCENXkmKFIyQ9eTaVpnrbA9TdPaNcOvz5/Zr9zmCHMM8kfgwGonlQZf
         bFrmsma8GaXj9dWzvK/6igcMGt67yeox4Yzw+5JLSZf7nICuZP2MFlW7LD2gzyH+mO
         yqIWcqQHlbJaAAsmYphHCDugAXOzbcuBVe/a9lew=
Received: by mail-wm1-f48.google.com with SMTP id c84so3513722wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:10:14 -0800 (PST)
X-Gm-Message-State: APjAAAXO8LmUNR1UENCELStqldouoRQVfppMkILh+Yn++w7kV7Cy8jcw
        P46CokrOEIj9GTvXg3C2T4NCvpdN2Yi41Wp1qT5muA==
X-Google-Smtp-Source: APXvYqxHqvMuokp6gjjz27NtY+2v//tiyKm2qp9CXz2Xk4Ota1Qpg+IP35TnCgdUut7h1RAeEfPFsV58oM33C3bfwZs=
X-Received: by 2002:a1c:3906:: with SMTP id g6mr6314490wma.49.1582729812585;
 Wed, 26 Feb 2020 07:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20200225213636.689276920@linutronix.de> <20200225220216.315548935@linutronix.de>
 <20200226011349.GH9599@lenoir> <d9bde3a6-1e19-1340-1fda-bc6de2eb4f7c@kernel.org>
 <20200226132850.GX18400@hirez.programming.kicks-ass.net>
In-Reply-To: <20200226132850.GX18400@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 26 Feb 2020 07:10:01 -0800
X-Gmail-Original-Message-ID: <CALCETrVXzwmwNOB6qUk7aM=LQRBySrMJPdRZ244T3y1bpRBzaQ@mail.gmail.com>
Message-ID: <CALCETrVXzwmwNOB6qUk7aM=LQRBySrMJPdRZ244T3y1bpRBzaQ@mail.gmail.com>
Subject: Re: [patch 02/10] x86/mce: Disable tracing and kprobes on do_machine_check()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 5:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 25, 2020 at 09:29:00PM -0800, Andy Lutomirski wrote:
>
> > >> +void notrace do_machine_check(struct pt_regs *regs, long error_code)
> > >>  {
> > >>    DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
> > >>    DECLARE_BITMAP(toclear, MAX_NR_BANKS);
> > >> @@ -1360,6 +1366,7 @@ void do_machine_check(struct pt_regs *re
> > >>    ist_exit(regs);
> > >>  }
> > >>  EXPORT_SYMBOL_GPL(do_machine_check);
> > >> +NOKPROBE_SYMBOL(do_machine_check);
> > >
> > > That won't protect all the function called by do_machine_check(), right?
> > > There are lots of them.
> > >
> >
> > It at least means we can survive to run actual C code in
> > do_machine_check(), which lets us try to mitigate this issue further.
> > PeterZ has patches for that, and maybe this series fixes it later on.
> > (I'm reading in order!)
>
> Yeah, I don't cover that either. Making the kernel completely kprobe
> safe is _lots_ more work I think.
>
> We really need some form of automation for this :/ The current situation
> is completely nonsatisfactory.

I've looked at too many patches lately and lost track a bit of which
is which.  Shouldn't a simple tracing_disable() or similar in
do_machine_check() be sufficient?  We'd maybe want automation to check
everything before it.  We still need to survive hitting a kprobe int3,
but that shouldn't have recursion issues.

(Yes, that function doesn't exist in current kernels.  And we'd need
to make sure that BPF respects it.)
