Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3F3C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D879320714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595895624;
	bh=k5BXMaN8Bls6BfVStYf5RqEue1kWXkyyD5lK624B8pg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oJMR4AqT88VdEWenqjU5hw1Kx2l8mtiTj8yO6F0l6Zo4sGnyJM3+f+YiOtaYyQzCL
	 PNkH0H4PbOffnp9lQeDFXi/957xKeK3RcRABu0/fetlhe+q8RaiuJJDdNkfY39vCu4
	 cIk7/geyAeiFa+x6OE81ecr2QDInHK5Hkj2+QeSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgG1AUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG1AUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 20:20:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE08FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 17:20:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b11so9999103lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 17:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nc/nP5wKiguMneXbXSJeuwd2J2JdfIPm6d2gp9TDTp4=;
        b=K57xCEgmCnx3un1myMyG3doUk8PfyAxh6wpSJCXTTatOfILXA2k61QBey0SYiLzT6A
         hv0hibIl7n/ebSO6pNjoOBnaxB83yqhWFxsPhJVnk4N1s8fiN/QkHPTbrqWUojBe3AIK
         n2Dy++TUdhfTGTKqOsw1597ysxfLrxiEzAnKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nc/nP5wKiguMneXbXSJeuwd2J2JdfIPm6d2gp9TDTp4=;
        b=n4tAtxPYpnivngCsOGYtZ4rb1+W57vFK7AiGlef9V7DkMjvHO0wCuWqPEEqMHdK9Ko
         V1poeZG+JGoWoSac6xceTIqMBk4v4DHpOHlLORpMH02/P1SOI+BJs9I9n93nrO4chqhT
         C2rMMaOYAobnGIG9JbbLjBgEfP+nqRAZWmifZ4XiJpyNZJ5Wqyfh8aSeINLI0uOLHpz6
         Cq1hCX6I1UkEdT6dve6kA131zX/fOgxFD84ci8IZ/j/l80lAu3PU3NDjHM9jzerbLUug
         Mw174PH/ZeI2ihR0y2EQdsANJrpcJ8nzBkvKaW8c63Ehk2QUlpRGdGcDwyUvj0YUmEjC
         JHSA==
X-Gm-Message-State: AOAM532TuDRKpTFvB0ql71pvw+LLy2L5vkHM8WaKkV+WOZUQW6uWDXZZ
        hYARNb4bUjR2lbsoj376I8vD3s/5k/o=
X-Google-Smtp-Source: ABdhPJzuPx/5aEtQoTujYCsbQmwumjYHnYDx3W0ZkBmtDXNJWjn+EDp0GDlPmadWQ3YxsORKGt8irA==
X-Received: by 2002:a19:8b55:: with SMTP id n82mr12908723lfd.35.1595895620966;
        Mon, 27 Jul 2020 17:20:20 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t18sm3378280lfb.69.2020.07.27.17.20.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 17:20:20 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id i19so9994877lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 17:20:20 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr13077378lfl.30.1595895619719;
 Mon, 27 Jul 2020 17:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <87h7tsllgw.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7tsllgw.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jul 2020 17:20:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
Message-ID: <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] exec: Freeze the other threads during a
 multi-threaded exec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 2:06 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Therefore make it simpler to get exec correct by freezing the other
> threads at the beginning of exec.  This removes an entire class of
> races, and makes it tractable to fix some of the long standing
> issues with exec.

I hate the global state part of the freezer.

It's also pointless. We don't want to trigger all the tests that
various random driver kernel threads do.

I also really don't like how now execve() by any random person will
suddenly impact everything that might be doing freezing.

It also makes for a possible _huge_ latency regression for execve(),
since freezing really has never been a very low-latency operation.

Other threads doing IO can now basically block execve() for a long
long long time.

Finally, I think your patch is fundamentally broken for another
reason: it depends on CONFIG_FREEZER, and that isn't even required to
be set!

So no, this is not at all acceptable in that form.

Now, maybe we could _make_ it acceptable, by

 (a) add a per-process freezer count to avoid the global state for this case

 (b)  make a small subset of the freezing code available for the
!CONFIG_FREEZER thing

 (c) fix this "simple freezer" to not actually force wakeups etc, but
catch things in the

but honestly, at that point nothing of the "CONFIG_FREEZER" code even
really exists any more. It would be more of a "execve_synchronize()"
thing, where we'd catch things in the scheduler and/or system call
entry/exit or whatever.

Also, that makes these kinds of nasty hacks that just make the
existign freezer code even harder to figure out:

> A new function exec_freeze_threads based upon
> kernel/power/process.c:try_to_freeze_tasks is added.  To play well
> with other uses of the kernel freezer it uses a killable sleep wrapped
> with freezer_do_not_count/freezer_count.

Ugh. Just _ugly_.

And honestly, completely and utterly broken. See above.

I understand the wish to re-use existing infrastructure. But the fact
is, the FREEZER code is just about the _last_ thing you should want to
use. That, and stop_machine(), is just too much of a big hammer.

                Linus
