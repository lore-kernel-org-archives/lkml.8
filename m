Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E203C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A38C207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXDFIQGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgGRFyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 01:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgGRFyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:54:03 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180DEC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 22:54:03 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id o2so2693561qvk.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 22:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2k6UGv1LDKKpRhcTlEeKxXx4KzYCC+1w+JKMjKrFRu0=;
        b=SXDFIQGtPOO1FREUNIOxP6MWzaMjlwxoRi/POKmRyva84olDCacJCnT6XzOl2CHd0e
         lhy7pO0N82TpMOaZeLnvII1AvtSwGFJaoUa+nM9xa5PtLR9S7S0tkkUdtr8LaNLKMUZS
         E2ShrxF09uRjcuw01zNvHLn2t3Y1eA6X/ACLJ0K6QwKhNmbmb7ZIDCpvwWHXTQHkMv5T
         YkiBGvie7c9VBGwQxISEcIstBcy1tQhcn0KV+3gHMhFuBr4UviapSSRWR0v5aX2X3tYd
         3/NgYnHSAE2sD11wM7qOhkwof34OZm1jg43Gn3378JgC9YD7WtJGFiP+99yY4ANvOk17
         7P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2k6UGv1LDKKpRhcTlEeKxXx4KzYCC+1w+JKMjKrFRu0=;
        b=fu2jY+tL0o9caUq1xISDhkm9dKla8CAtdS4uCZA8eRxlibLyH0KVez4ZRoI0k6kXx1
         +0uLOOTskTShq0OuafRqFDBs7h/9s7BpizxAiKwoktZC5g1p8NtRl/FGBT20owrsDFNy
         GXnQ+FdBQqYUswR0qPY1t74WNI3T2IAPiIiT9BdrBJTLI6AYbpPoKDLkfqj5qF72zZu2
         XP9smtoAzYkdUKHgjcYbteAShbEY9nNieJSGnMoKTXGgIOS2UPaP/RZY+uMIx0jLxzIs
         6tiRF3F2eiRJkoIvG9JhkydNp/WlY2iIV7QjNRMsUdfCHck7604pMDAjNTFxSNLmjXzf
         lxFA==
X-Gm-Message-State: AOAM530/kQtvguTUE+NZLSaMWVTSHceQxJ36vURSTo0QleWVbHUq6YDW
        XwGqjfKQ7PpfICfnedsr3PrINFRo4tnQGACY+UDxag==
X-Google-Smtp-Source: ABdhPJzLY74RMzYmgbkHsJNzGi49eeFA+weL5NWdPNyO+SUJBca0pFWb987AKAtIyclrDdJOZrLpaaNe82NgIZanLZY=
X-Received: by 2002:a05:6214:14f4:: with SMTP id k20mr12441481qvw.231.1595051641884;
 Fri, 17 Jul 2020 22:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200718021331.940659-1-joshdon@google.com> <CALCETrXHEhwBS72_Fiv9LbPjsBGp_rMmU16oYMTZJFa=wTki8A@mail.gmail.com>
In-Reply-To: <CALCETrXHEhwBS72_Fiv9LbPjsBGp_rMmU16oYMTZJFa=wTki8A@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 17 Jul 2020 22:53:50 -0700
Message-ID: <CABk29NsN_3kH4xyY1v0FixMDuGb_rG_iUYDFtwd3U5n10LsjaA@mail.gmail.com>
Subject: Re: [RFC][PATCH] x86: optimization to avoid CAL+RES IPIs
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andy, thanks for taking a look.

On Fri, Jul 17, 2020 at 8:14 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> PeterZ and I fixed a whole series of bugs a few years ago, and remote
> wakeups *should* already do this. Did we miss something?  Did it
> regress?  Even the call_function_single path ought to go through this:
>
> void send_call_function_single_ipi(int cpu)
> {
>         struct rq *rq = cpu_rq(cpu);
>
>         if (!set_nr_if_polling(rq->idle))
>                 arch_send_call_function_single_ipi(cpu);
>         else
>                 trace_sched_wake_idle_without_ipi(cpu);
> }
>

Yep, I was sitting on this for a bit and raced with b2a02fc43a there.
90b5363ac also got rid of the last smp_send_reschedule() that was
triggering the ipiless handling.

One of the nice parts of the patch was that it could blanket apply to
all of the smp_call/reschedule.  However, with the above patches that
isn't a concern; it makes more sense to keep the existing
TIF_POLLING_NRFLAG logic.
