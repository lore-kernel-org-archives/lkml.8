Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EF1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 05:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4260120776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 05:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSWKVcWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEZFsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 01:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgEZFsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 01:48:32 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F904C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 22:48:32 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d5so11186604ios.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 22:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fz1Eopb4QzL9a1RDMtAXkS7GQciMYbTyetHx6VLS6qU=;
        b=bSWKVcWyRcVadh6xJDKKh5NcyUDyIUatsXrN3uwZO93tiW+44TeAMr1QvUFoho3Bra
         l3p6jsfyVsH5dyGIQGkyLSZDQ91E1rVnGDfxlhwNufAiymLRTSKzNv2jeHTVYfsEJjQo
         tb9dei5XqMrfgODNLbke4m2tS3g24QL68T6gSQ919xI+VY5WkG/jYGR8yCgIKrr8bktl
         eq4LyBGnr8oEPJe5tKNhraMmfjS+63AfosiLtrwV0d0QI0Wu7PuUF14yqnsp+mq/J8PE
         TD86d2SumMfkjYR3QigDqrFVmCiqWqin9BUccoVmIk0PVfB+OKjAnzyejaplsavDbSM/
         9aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fz1Eopb4QzL9a1RDMtAXkS7GQciMYbTyetHx6VLS6qU=;
        b=CwWSmnkf4Tqk7b8KL6uWla4nrbJ8x2/UZNGTi1KYgLPUWt0/7gSDqcCwgV4reMArSt
         8J+D8DzzVYk5P07lqn6MdZTltRr2HH40VlXHB5UMWgPlta1LlQWLlxW9l402ZciGy+Ut
         iSAW9N/1UNBm9wxWu7Sceo+2G/vki6KYjh/+TRW3BRslEYn9UM3O+EWmcL1xWjbK1r5y
         6A+HudMNWfSFt6fuGIM0nnS9gl+AklBVGAqAtS6AjKXQBEsZ44gPpi6S4E9orXxb7Nvq
         QYp+e8VK2CXyeVno3gdfB97GTOzZ7ajoxxxyrK3tngBFaB7KMnyMpn6LdQ06gLzNTVUY
         zhBA==
X-Gm-Message-State: AOAM530DWTKyGzYoxC52O+4qeILHp3s7AQaj+WGy3hYouFCx3ltRZxFL
        Qf4KbeUi3AE38PlXeb4ZhDJZbx/ccu6XJorh9Xk=
X-Google-Smtp-Source: ABdhPJy3Wcf0OojQjulbubvSK1pCSJ1PJ3+40ydU3RhKgO6lt1KlOfp4XwCAVwaCN1XFKxxteUVsxxGWS9bvV99QMoc=
X-Received: by 2002:a02:6d46:: with SMTP id e6mr13489853jaf.43.1590472111699;
 Mon, 25 May 2020 22:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
 <20200526014221.2119-1-laijs@linux.alibaba.com> <20200526014221.2119-5-laijs@linux.alibaba.com>
 <CALCETrWyMY-0Z_NJ7DnF4PsSnhnbNsgt14X1GWkajcms-ZUSQA@mail.gmail.com>
 <CAJhGHyC82f+=YXYmv8zC=zPxZmk+TW_n+5pjcBE-2T8S9t5K0g@mail.gmail.com> <CALCETrW6mazV1JVXYtGW7tUXveNvMKnFwi4zqWUgwMXax_Ea_Q@mail.gmail.com>
In-Reply-To: <CALCETrW6mazV1JVXYtGW7tUXveNvMKnFwi4zqWUgwMXax_Ea_Q@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Tue, 26 May 2020 13:48:20 +0800
Message-ID: <CAJhGHyDkWs8=j0MEqoDxwqcXe+asYSQLGAXrQHiHi8y126YpqA@mail.gmail.com>
Subject: Re: [RFC PATCH V2 4/7] x86/hw_breakpoint: Prevent data breakpoints on user_pcid_flush_mask
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
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

On Tue, May 26, 2020 at 12:39 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, May 25, 2020 at 9:31 PM Lai Jiangshan
> <jiangshanlai+lkml@gmail.com> wrote:
> >
> > On Tue, May 26, 2020 at 12:21 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On Mon, May 25, 2020 at 6:42 PM Lai Jiangshan <laijs@linux.alibaba.com> wrote:
> > > >
> > > > The percpu user_pcid_flush_mask is used for CPU entry
> > > > If a data breakpoint on it, it will cause an unwanted #DB.
> > > > Protect the full cpu_tlbstate structure to be sure.
> > > >
> > > > There are some other percpu data used in CPU entry, but they are
> > > > either in already-protected cpu_tss_rw or are safe to trigger #DB
> > > > (espfix_waddr, espfix_stack).
> > >
> > > How hard would it be to rework this to have DECLARE_PERCPU_NODEBUG()
> > > and DEFINE_PERCPU_NODEBUG() or similar?
> >
> >
> > I don't know, but it is an excellent idea. Although the patchset
> > protects only 2 or 3 portions of percpu data, but there is many
> > percpu data used in tracing or kprobe code. They are needed to be
> > protected too.
> >
> > Adds CC:
> > Steven Rostedt <rostedt@goodmis.org>
> > Masami Hiramatsu <mhiramat@kernel.org>
>
> PeterZ is moving things in the direction of more aggressively
> disabling hardware breakpoints in the nasty paths where we won't
> survive a hardware breakpoint.  Does the tracing code have portions
> that won't survive a limited amount of recursion?

Agree, after "aggressively disabling hardware breakpoints in the nasty
paths", only percpu data used by entry code needs to be protected,
even non-instrumentable percpu data used by nmi_enter() doesn't need
to be marked protected, because #DB is disabled.

Only percpu data used by entry code in ranges that #DB is not disabled
needs to be protected, there are only a small number of portions,
I don't think we need DECLARE_PERCPU_NODEBUG() or so for merely 2 or 3
portions of data. This patchset is sufficient.
(espfix_waddr, espfix_stack are not counted into, which needs more
review besides me)

>
> I'm hoping that we can keep the number of no-breakpoint-here percpu
> variables low.  Maybe we could recruit objtool to help make sure we
> got all of them, but that would be a much larger project.
>
> Would we currently survive a breakpoint on the thread stack?  I don't
> see any extremely obvious reason that we wouldn't.  Blocking such a
> breakpoint would be annoying.
