Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA21AC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918D32082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588253893;
	bh=QOVrxYcw/KtkynvgseuYHrW5JtbhUgcK/5+t6HAA4z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=It5owmB682XLo7V8QeA1AU+zw0pkfYLejCe5fGzcQmUS/eE17au3Yzm8FPkTgDHON
	 Tio85n2lDqXI6uMfBUpmozVwPZbkkNV+vPjwrPW8j+FbGbFcbh4MQazMP4N04snL22
	 czk1m4Csjbp60UerZejZjVGCfKreR5+rj23IWFGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgD3NiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgD3NiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:38:12 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91752C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:38:11 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f18so6478454lja.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pRCZ6kZWfVJxdxP6p9p7StOMMTYz2dP0EbXo5rgjQU=;
        b=EyGdH4vIo8rZD2dWljfyuvofwLAScuy9MrePCPLMC5SLAN0uCqQgWU8hOATGY8NIUG
         LwU5XqtrSsASECVWVUS0kqmaNFOJ+f7Gt60Rs46vskb78lwJIYXW+VaB0yoC9jwiDxnd
         eeFKa6lM8p9a1iPOaT8z276Ht3zSOkERrFaNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pRCZ6kZWfVJxdxP6p9p7StOMMTYz2dP0EbXo5rgjQU=;
        b=hMXeURv8z4cyB0eZUy50K+ysKxwuTT33EUlHIJF1CsoUmsNAYcmYll1U8eGcc+qdmO
         aU7qxo4acM7VJi0+Dle6Hrtk6M76Q6S3Q3R2BblRzqm8GX7s2tT5LyVf1bM4Gs8cpsC/
         yALael7WDDPrgU9yMfSO0vwp9/+GqV4MifHSgXk7xAw1bAIB6IntQURsPHZoGI9bpG0Q
         rXT041HENVjFjxNHfOl+Py6YKwQMT76r0IjO4ZqmVSosoxS2xN/RA8Nih/E/SNPK26mV
         Z5N2s+3feBA0YNOr4qvaB4waVzOKF6QGYbY0d2y8FQe0Jj1d8YhkE8FWx6M/fd6jjajt
         9LOQ==
X-Gm-Message-State: AGi0PuZDdPwjb7SSHpRmM0b3cH3jVw/PLdVmtrNxgQvgjE0c9CpN42pr
        ahN7rQFA8EOZ/CqT6bo+JsfYFw/1L2s=
X-Google-Smtp-Source: APiQypLe7WijtuskdrwKkYkSURtdiQHLf3zYc2QMtuE1gWGiztiCSqGp44sXXp3b3RPyWyroJ4TArA==
X-Received: by 2002:a2e:b885:: with SMTP id r5mr2223539ljp.118.1588253889516;
        Thu, 30 Apr 2020 06:38:09 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id u2sm4994076lfk.67.2020.04.30.06.38.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 06:38:08 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id u10so1228135lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:38:08 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr2305493lfd.10.1588253887778;
 Thu, 30 Apr 2020 06:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
 <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
 <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
 <AM6PR03MB5170C5D02C6FCB6D69DFE3ADE4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg6oKSLkVhY5oqOFyzCCSr9eYPGK2SHJfgCXF_QOmPKog@mail.gmail.com>
 <CAG48ez25=6qrCU51dEAV_ciyU2jvPuRFWfFOAAT22kmeAZccuQ@mail.gmail.com> <CAHk-=wjE_YJ4SFJUasF=tW0jMr6zg+rkRNuNt2hdODPu_LLTVw@mail.gmail.com>
In-Reply-To: <CAHk-=wjE_YJ4SFJUasF=tW0jMr6zg+rkRNuNt2hdODPu_LLTVw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Apr 2020 06:37:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcyDkW_eQ_f4j82dci6jteSgOZ_ONRh9nzs9ykWELQng@mail.gmail.com>
Message-ID: <CAHk-=wjcyDkW_eQ_f4j82dci6jteSgOZ_ONRh9nzs9ykWELQng@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Jann Horn <jannh@google.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 8:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Bernd's approach _without_ the restart is unacceptable.
>
> It's unacceptable because it breaks things that currently work, and
> returns EAGAIN in situations where that is simple not a valid error
> code.

Looking at my restart thing, I think it's a hack, and I don't think
that's acceptable either.

I was pleased with how clever it was, but it's one of those "clever
hacks" that is in the end more "hack" than "clever".

The basic issue is that releasing a lock in the middle just
fundamentally defeats the purpose of the lock unless you have a way to
redo the operation after fixing whatever caused the drop.

And the system call restart thing is dodgy, because there's none of
that "fixing".

It can cause that "write()" call to do the CPU busy loop too if it
hits that "execve() in process" situation.

The only difference with the "write()" case vs "ptrace()" is that
nobody has ever written an insane test-case that doesn't wait for
children, and then does a "write()" to the /proc file that can then
require zombie children to be reaped.

So I don't think the approach is valid even with the restart. Not
restarting isn't acceptable for write(), but restarting doesn't really
work either.

I guess we could have a very special lock that does something like

    int lock_exec_cred_mutex(struct task_struct *task)
    {
        if (mutex_trylock(&task->signal->cred_guard_mutex))
                return 0;

        if (lock_can_deadlock(task))
                return -EDEADLK;

        return mutex_lock_interruptible(&task->signal->cred_guard_mutex);
    }

might work. But that "lock_can_deadlock()" needs some kind of oracle
or heuristic.

And I can't come up with a perfect one, although I can come up with
things like "if the target has threads, and those threads have a
reaoer that is you, then you have to have SIGCHLD enabled". But it
gets ugly and hacky.

But I think actually releasing the lock in the middle of execve()
before it's done with is worse than ugly and hacky - it's
fundamentally broken.

Moving things around? Sure - like waiting for the threads _after_ the
lock and having done all the cred calculations. So I think Oleg's
patch works.

                 Linus
