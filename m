Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C93C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3D3206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFy+937e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgCEWal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:30:41 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38421 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgCEWak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:30:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id x75so551330oix.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cuWr9b9CX0abyzsrEF2iLgokkUE78xXPZ0J1M4ESfQ=;
        b=IFy+937eI4j0qwYYIm2/HqbQ0ojz3WfSPHXbnaLd8zs186jr87wmtBkbNOV6HkaYoQ
         RK9ldIDWO9omjsSgJaSWKI01OsLVPLuBKJTe4tTxTshpu3ADwgrEm647/AP6jE1a7U0H
         ZjwSTJNBQHO/d5fwmNETUvpu0oXhLVwevh1wWt0+SnqNJIXRdSXIyOGZyNgpPEW6nCN1
         1vt7ebzxZ0S7FxXf/jfBXO6GVx52qe8NeFmJQzQxp7ARCJUNQ1zIecwuIQkZTnMZBvPL
         YQoQv4x7Jyb0gDys3rQeVp29hXUluZGudDBHwcXn1dpm2rL/X0CjVNVtNhpJZiQl4vLr
         4w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cuWr9b9CX0abyzsrEF2iLgokkUE78xXPZ0J1M4ESfQ=;
        b=Tqv8+piG8Jkr+QI3hPdcJRAWKO5OzlhgIWieC+9smFkPmrjWZ7uZyFQi+6fWIARXk/
         EIlVevFFwNBSq0AOoi5QkQLhXmB4VUzeNSEQGQLmMDe9SO18kslGss4Idc+jvnzKCIU/
         Q9OaNd+qQNLv5mFQlug5U9MR5UgXVpkrRLU8GoNlSIwb41NSWc9WcEaO/FJ4ywMWras0
         KXk0dd2C2HMUt70lAQ3au3coje0zd5ATgeKe6hN2eOIr4ROKiQPVZ4M0B991MxwCdkzd
         3NRg3A6L37adNFhEOW1ENOawcLuq8yqQOXctt49KZ+G71/owBOWVNj59tGqhv6rjXjz6
         6pwA==
X-Gm-Message-State: ANhLgQ2G1eJM+ym4nELtqzKrnD8LLY9qDSDBzQ9m9Lt2KO48VzBQKrAT
        NXbcn2RP1mTwMyaS9L5Kxd6g8cBmYw2Xro1ui4fRNA==
X-Google-Smtp-Source: ADFU+vt+vEjyDebjV5gCEwNADQBMIuwSVs6AqfMgXkuYWAviR+7r0nFGLmYtQTI3ml3F0wCFiNMhvyoMnoFaFDviZdc=
X-Received: by 2002:aca:d954:: with SMTP id q81mr480833oig.157.1583447439793;
 Thu, 05 Mar 2020 14:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20200305220657.46800-1-jannh@google.com> <20200305171344.1f35d971@gandalf.local.home>
In-Reply-To: <20200305171344.1f35d971@gandalf.local.home>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 5 Mar 2020 23:30:13 +0100
Message-ID: <CAG48ez0UGBot8xe10pWW_bFTyFOhmQaMVpBJjEmtfM4CqdcF5w@mail.gmail.com>
Subject: Re: [PATCH v2] exit: Move preemption fixup up, move blocking
 operations down
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 11:13 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu,  5 Mar 2020 23:06:57 +0100
> Jann Horn <jannh@google.com> wrote:
>
> > With CONFIG_DEBUG_ATOMIC_SLEEP=y and CONFIG_CGROUPS=y, kernel oopses in
> > non-preemptible context look untidy; after the main oops, the kernel prints
> > a "sleeping function called from invalid context" report because
> > exit_signals() -> cgroup_threadgroup_change_begin() -> percpu_down_read()
> > can sleep, and that happens before the preempt_count_set(PREEMPT_ENABLED)
> > fixup.
> >
> > It looks like the same thing applies to profile_task_exit() and
> > kcov_task_exit().
> >
> > Fix it by moving the preemption fixup up and the calls to
> > profile_task_exit() and kcov_task_exit() down.
[...]
> > +     if (unlikely(in_atomic())) {
> > +             pr_info("note: %s[%d] exited with preempt_count %d\n",
> > +                     current->comm, task_pid_nr(current),
> > +                     preempt_count());
>
> This should be more than a pr_info. It should also probably state the
> "Dazed and confused, best to reboot" message.
>
> Because if something crashed in a non preempt section, it may likely be
> holding a lock that it will never release, causing a soon to be deadlock!

I didn't write that code, I'm just moving it around. :P But I guess if
you want, I can change it in the same patch... something like this on
top? Does that look reasonable?

        if (unlikely(in_atomic())) {
-               pr_info("note: %s[%d] exited with preempt_count %d\n",
+               pr_emerg("note: %s[%d] exited with preempt_count %d,
system might deadlock, please reboot\n",
                        current->comm, task_pid_nr(current),
                        preempt_count());
                preempt_count_set(PREEMPT_ENABLED);
