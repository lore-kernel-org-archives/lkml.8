Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F95C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE04221E8
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScYVsVHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgIJVNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgIJVLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:11:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2CC061786
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 14:11:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so10817503ejf.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2Fjne8H+Cg3bJEd1GSB4j314ZebR7pleObLwl830fs=;
        b=ScYVsVHCZlVh7Ci/3ehi1uakHdj9qnQ9FYyz9hPXQc/e9uvw9Ybg77wJD3gWPHx/lN
         oJjcajaLilUV00ZbqRFWOpGIIQ/pjS4ge040nFK/Xnk29BGf0AppVDAfW35o0selWBxs
         tv7s7bV3wkeNz2hD8ble8Y8voryZA384+K8+25DS+W99uS2fsFg8XFJrUo3mpG+GfVnt
         aVzMV9vnMTnLydG4qmxB0KE8A3WS2zYUGC2Vot/PZ5zf7tU3uF2exEpFDr/G3k8aVvGt
         XOuqUkU/7QvKAeWJhVePl/f3EZFBRyvcTs/HTzLQ9NYVNxAYa6ERfH86Hw3qAF0dRy2W
         Uphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2Fjne8H+Cg3bJEd1GSB4j314ZebR7pleObLwl830fs=;
        b=T30CkB56utSRLB+TxPJnxyaAG8/l9/5Jo0unsHA8UaidIK1DpkOibVx8ew1vhVu02x
         /sY1ueei6JWHZoAQn5ZdsJqwOu0bMMBZCfXgkresK9WwboXeM+DRaIIz7q4xyvyBK3Dy
         mS1CFX50+uR1dn2oiZRm0Qz2wqHotlmxvp9PyY3EpvU59D7scUEqOYudpzVliGhvrpPg
         wR4F3oyPzFGboYOZtLmtYKzPlOdOO6TgB7YMXpoKoxVnuykz8AN9u/ROemvyCRqSqZzg
         5+4NjnB58M04FIiXrntXEUA3BaQaKCuHiUu936nRr/2av27kEOIfAery2A9DUiCqlCvF
         RM1w==
X-Gm-Message-State: AOAM5332ia2dLlCUafZ/VxKmF6FFnUndnVJYNAC9up0FX4HNzvQQebIE
        xTwjXZ43EqsSMbgnX19Bnh5rs3qSaHXk0wxVkDmMJA==
X-Google-Smtp-Source: ABdhPJyNcf3ROxrc5CjvX9eqcm/Jags1MQ2ChzI30b0vpomzdYZOF0LTDDEZynORXIJAbG2ZaBuePa4L+nucdti2Xdg=
X-Received: by 2002:a17:907:94cf:: with SMTP id dn15mr11296236ejc.114.1599772264641;
 Thu, 10 Sep 2020 14:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202107.3799376-1-keescook@chromium.org> <20200910202107.3799376-6-keescook@chromium.org>
In-Reply-To: <20200910202107.3799376-6-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 10 Sep 2020 23:10:38 +0200
Message-ID: <CAG48ez1gbu+eBA_PthLemcVVR+AU7Xa1zzbJ8tLMLBDCe_a+fQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] security/fbfam: Detect a fork brute force attack
To:     Kees Cook <keescook@chromium.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:22 PM Kees Cook <keescook@chromium.org> wrote:
> To detect a fork brute force attack it is necessary to compute the
> crashing rate of the application. This calculation is performed in each
> fatal fail of a task, or in other words, when a core dump is triggered.
> If this rate shows that the application is crashing quickly, there is a
> clear signal that an attack is happening.
>
> Since the crashing rate is computed in milliseconds per fault, if this
> rate goes under a certain threshold a warning is triggered.
[...]
> +/**
> + * fbfam_handle_attack() - Fork brute force attack detection.
> + * @signal: Signal number that causes the core dump.
> + *
> + * The crashing rate of an application is computed in milliseconds per fault in
> + * each crash. So, if this rate goes under a certain threshold there is a clear
> + * signal that the application is crashing quickly. At this moment, a fork brute
> + * force attack is happening.
> + *
> + * Return: -EFAULT if the current task doesn't have statistical data. Zero
> + *         otherwise.
> + */
> +int fbfam_handle_attack(int signal)
> +{
> +       struct fbfam_stats *stats = current->fbfam_stats;
> +       u64 delta_jiffies, delta_time;
> +       u64 crashing_rate;
> +
> +       if (!stats)
> +               return -EFAULT;
> +
> +       if (!(signal == SIGILL || signal == SIGBUS || signal == SIGKILL ||
> +             signal == SIGSEGV || signal == SIGSYS))
> +               return 0;

As far as I can tell, you can never get here with SIGKILL, since
SIGKILL doesn't trigger core dumping and also isn't used by seccomp?

> +
> +       stats->faults += 1;

This is a data race. If you want to be able to increment a variable
that may be concurrently incremented by other tasks, use either
locking or the atomic_t helpers.

> +       delta_jiffies = get_jiffies_64() - stats->jiffies;
> +       delta_time = jiffies64_to_msecs(delta_jiffies);
> +       crashing_rate = delta_time / (u64)stats->faults;

Do I see this correctly, is this computing the total runtime of this
process hierarchy divided by the total number of faults seen in this
process hierarchy? If so, you may want to reconsider whether that's
really the behavior you want. For example, if I configure the minimum
period between crashes to be 30s (as is the default in the sysctl
patch), and I try to attack a server that has been running without any
crashes for a month, I'd instantly be able to crash around
30*24*60*60/30 = 86400 times before the detection kicks in. That seems
suboptimal.

(By the way, it kind of annoys me that you call it the "rate" when
it's actually the inverse of the rate. "Period" might be more
appropriate?)



> +       if (crashing_rate < (u64)sysctl_crashing_rate_threshold)
> +               pr_warn("fbfam: Fork brute force attack detected\n");
> +
> +       return 0;
> +}
> +
> --
> 2.25.1
>
