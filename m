Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D836FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCAF207ED
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590467946;
	bh=qcaKmI4fvRBY3YN+p3LJ2ANFZnuN83WNUpjNp3A1Ujw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QrTIJK5Z+BE0n7klLnPP4CkkUJI73F6IHBj6KaTAjAcrUcQ6QdF+blH/IxtF1MFex
	 uM+S97piAK14K7lPB6y8snghE0uLtpXkDw2R59CKiMUQ6i6sbaawyS1oJ3FhSk0qk0
	 KeSOTcRACZjtz5n9MhbmnFRvxtBJ2Gl6It9hSELA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgEZEjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 00:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgEZEjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 00:39:05 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C52208B3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590467944;
        bh=qcaKmI4fvRBY3YN+p3LJ2ANFZnuN83WNUpjNp3A1Ujw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RmlSdhv+dSvKI9hlbRJKaNnTOWmyu3cZDTqQM8ikQebw1NbwU9dgg6R8AFmTF5ZZO
         ZgpeWsNJftiF+T6ys5oO2G+1d4imJ1mHpy7f8zo9YfaCmoycP1jkhJ0B0GC3NTe9r/
         NqalKYT7cB0fKOPNKaYjYkLppXuRhQxzjrrvcgK8=
Received: by mail-wr1-f49.google.com with SMTP id x13so4385386wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 21:39:04 -0700 (PDT)
X-Gm-Message-State: AOAM531SyFwevUcDt99wJYYx9j8ZrZsPuBkE5G1R5FRcNSVO0+un6+CI
        A36yHj9gdZlrewXqBRFnoiRu+3GAHq4MXRMcGqdyGQ==
X-Google-Smtp-Source: ABdhPJx5RGhYX6nKGk1B5a57xXXKXzkKRexSu+Efxo1Skiy5fG7LRt7/mJn57txrauT2IYdRkzMraOjrZaqL8ppDdbE=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr16122724wrm.75.1590467942702;
 Mon, 25 May 2020 21:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
 <20200526014221.2119-1-laijs@linux.alibaba.com> <20200526014221.2119-5-laijs@linux.alibaba.com>
 <CALCETrWyMY-0Z_NJ7DnF4PsSnhnbNsgt14X1GWkajcms-ZUSQA@mail.gmail.com> <CAJhGHyC82f+=YXYmv8zC=zPxZmk+TW_n+5pjcBE-2T8S9t5K0g@mail.gmail.com>
In-Reply-To: <CAJhGHyC82f+=YXYmv8zC=zPxZmk+TW_n+5pjcBE-2T8S9t5K0g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 May 2020 21:38:51 -0700
X-Gmail-Original-Message-ID: <CALCETrW6mazV1JVXYtGW7tUXveNvMKnFwi4zqWUgwMXax_Ea_Q@mail.gmail.com>
Message-ID: <CALCETrW6mazV1JVXYtGW7tUXveNvMKnFwi4zqWUgwMXax_Ea_Q@mail.gmail.com>
Subject: Re: [RFC PATCH V2 4/7] x86/hw_breakpoint: Prevent data breakpoints on user_pcid_flush_mask
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 9:31 PM Lai Jiangshan
<jiangshanlai+lkml@gmail.com> wrote:
>
> On Tue, May 26, 2020 at 12:21 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Mon, May 25, 2020 at 6:42 PM Lai Jiangshan <laijs@linux.alibaba.com> wrote:
> > >
> > > The percpu user_pcid_flush_mask is used for CPU entry
> > > If a data breakpoint on it, it will cause an unwanted #DB.
> > > Protect the full cpu_tlbstate structure to be sure.
> > >
> > > There are some other percpu data used in CPU entry, but they are
> > > either in already-protected cpu_tss_rw or are safe to trigger #DB
> > > (espfix_waddr, espfix_stack).
> >
> > How hard would it be to rework this to have DECLARE_PERCPU_NODEBUG()
> > and DEFINE_PERCPU_NODEBUG() or similar?
>
>
> I don't know, but it is an excellent idea. Although the patchset
> protects only 2 or 3 portions of percpu data, but there is many
> percpu data used in tracing or kprobe code. They are needed to be
> protected too.
>
> Adds CC:
> Steven Rostedt <rostedt@goodmis.org>
> Masami Hiramatsu <mhiramat@kernel.org>

PeterZ is moving things in the direction of more aggressively
disabling hardware breakpoints in the nasty paths where we won't
survive a hardware breakpoint.  Does the tracing code have portions
that won't survive a limited amount of recursion?

I'm hoping that we can keep the number of no-breakpoint-here percpu
variables low.  Maybe we could recruit objtool to help make sure we
got all of them, but that would be a much larger project.

Would we currently survive a breakpoint on the thread stack?  I don't
see any extremely obvious reason that we wouldn't.  Blocking such a
breakpoint would be annoying.
