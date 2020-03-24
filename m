Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7ADC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39EA20786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsydS4fN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCXJab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:30:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43919 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgCXJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:30:31 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125so17811926oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/0KAii201T0LPKgB9S97/7pdilYmedqXQq8pqjza4Q=;
        b=tsydS4fNF/NawIXvCg86I+MG1NzHQ1Sa5aWtwNl2oRuLaKpZpgjMBqEGWsOebtxBGu
         HgTGGtTqAVow1EuCXBYEsugpLRv4MeF4EcqFZm8G9TvZ5vYFPe0+Q/k/Oyvk3yMKufao
         zNqNtY+HOKv6RHNb6OJxhEtNRs4dQbGREfJb2j68SkGuy3KP2QG0QCpBWwSRcUGrotxp
         JMuXFWaKR38pz4ZRwKJmyCekeU11PFwWMjcSDbgkJfIBbE56TkKtKc8JTei+oSNq/bZW
         vFHB9Kbtjx8hFcxsCYtpNfFXCsmy4CAlsmR12tOBoKVkemjrqRiaZyTQV6sNyvQjUb3R
         pAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/0KAii201T0LPKgB9S97/7pdilYmedqXQq8pqjza4Q=;
        b=iOg2aGYdn/JBc27WFkcl7SfX+XsR0C+h6xnR7BaF8nSeEWWGZB05a9kQfrtjPVWiIB
         7duPDwoQe+V0euOjAMEcQ3mYL76tYW7k16jEN3CmNcUOE5Aabf90yzpincDb0jSbuGu7
         K4NAo1s9XUC6zmvkGf2qjXOvu+qhop+gUU3kcttDwQ/k0FMjdM8wU2NvVIvsJsL+DH5q
         kQucPC1S71j+RZD8zcFNYMyV67UHRpDPBLCrMsdXiS7jgkhsB+523QuRilxUge5ki8kj
         rlUhOmVW2s051ydGTJc3FCJe5PzffASqmuDzmW15AU49KyGwt1A+nA4lNrytqhgz0QMt
         EbNg==
X-Gm-Message-State: ANhLgQ3Oo09muaoDBBecuMmdPSQHlBprODdFUROHHwifwqJzthW6qLP3
        uVCuwW9Ti9CviNWPf4+1JToWgYUvWPoUAegBmiMNNQ==
X-Google-Smtp-Source: ADFU+vuOZ0TaE14JHbGrFtk3euPj/osHZ1tI+cYnZozht7DZ4yncreGiYl/Si8YEggMCgqSWkJUGUDjg4REmWEjwE60=
X-Received: by 2002:a05:6808:8db:: with SMTP id k27mr2729131oij.175.1585042228749;
 Tue, 24 Mar 2020 02:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200305220657.46800-1-jannh@google.com>
In-Reply-To: <20200305220657.46800-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 24 Mar 2020 10:30:02 +0100
Message-ID: <CAG48ez2qd6r6FfDBHbqpoqKFU1oA64Usx86Ps33wHjCZmxYmbA@mail.gmail.com>
Subject: Re: [PATCH v2] exit: Move preemption fixup up, move blocking
 operations down
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 11:07 PM Jann Horn <jannh@google.com> wrote:
> With CONFIG_DEBUG_ATOMIC_SLEEP=y and CONFIG_CGROUPS=y, kernel oopses in
> non-preemptible context look untidy; after the main oops, the kernel prints
> a "sleeping function called from invalid context" report because
> exit_signals() -> cgroup_threadgroup_change_begin() -> percpu_down_read()
> can sleep, and that happens before the preempt_count_set(PREEMPT_ENABLED)
> fixup.
>
> It looks like the same thing applies to profile_task_exit() and
> kcov_task_exit().
>
> Fix it by moving the preemption fixup up and the calls to
> profile_task_exit() and kcov_task_exit() down.
>
> Fixes: 1dc0fffc48af ("sched/core: Robustify preemption leak checks")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> As so often, I have no idea which tree this should go through. tip? mm?

Do the tip folks want to take this, since it's vaguely locking-related
and the fixed commit also came that way? Or should it go through
akpm's tree?
