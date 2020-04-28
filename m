Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D11C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CED20731
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588112103;
	bh=53P/Jx7WGJ66DDOfW8WB8+PbaNgX+/t+bDg3MILIzEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Gb481+gHH2T/aF+sJMtSfFW753t/9ezOJwlwo5qXlLaSBW1xx+wJjOuDr+XGSf3lO
	 AKd3Q+DZBOIkXhBXDhoOaAKJNEMmsFdv3VDvUkrpw2VyiM+UK1VkY8sqjvGlvsId34
	 jegiSsG5CrDXYdZjiXIHr36/jmNVpl04sbFNDhzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgD1WPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726559AbgD1WPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:15:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638CC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:15:00 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w145so18132374lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2oghUgdw8FKTw2gbtCLPncxWRlTmFnYYnhIyY7cVD0=;
        b=GFZyY3OUWl1iOMrNHxSkI0vtAmTEJwc5rLOu6Eefgtq1vu+FWWHu6kobiy4ymJmTth
         LQiB690O6IiG6VFgp5FgWTi+l2xm3YmC+nTdFGA0vNueM7ylnUtNfo1vcD+GhQ5Vur5x
         Y3LvLGprBmN3nfCmdDuxMJJbOm26UsScuTfpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2oghUgdw8FKTw2gbtCLPncxWRlTmFnYYnhIyY7cVD0=;
        b=FZmcHhxpe10tCdHxRhFGb79uZRCdsbrX/7pfIeingHU/xFizww+4UyfTgQeemOMPDa
         boxeQI2xn3ZJT84Zdev6abqLMWxvO2jx+bIMRubB/Jc8kfjYOYld7uHTKn2OKnJodWfB
         9dZJKNuXyPz9GAZ3D5ciGzLpssFY+uMh9Y/h/Ohrgco/ePbrTYTHcCsOo52JSccLVihz
         i1PYldKvQmuCFfcLfQtXgJMAxJoH9F+w1uOFT3jG4TiNlLBVljrb99n4it2N4+2DrTS7
         G0rfI0jua/BI4NEV20Z+1odsqvWtXOgMU+Fdl7m4jPGot59Ylrx/iU/NFq5APPkEnXjc
         hvgA==
X-Gm-Message-State: AGi0PuZu2gWmTvNAYs2Fy+Xsrqhvi4gCg9UeOx2lu4iTcpGhZfY8qV6g
        muXrGsTmpax8eIp8H450gG1aUxb4+T8=
X-Google-Smtp-Source: APiQypKI2WOaucEIs3B9/PMHlIob4YN/S2kxX1w4XdjhNLPYelJffeQkPLrhB6I2k7IKf54p9+NvHg==
X-Received: by 2002:a05:6512:1082:: with SMTP id j2mr20743033lfg.53.1588112098579;
        Tue, 28 Apr 2020 15:14:58 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id c21sm551822lfh.16.2020.04.28.15.14.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 15:14:56 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u10so18119290lfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:14:56 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr21056059lfd.10.1588112096168;
 Tue, 28 Apr 2020 15:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com> <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com> <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
In-Reply-To: <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Apr 2020 15:14:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
Message-ID: <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
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

On Tue, Apr 28, 2020 at 2:53 PM Jann Horn <jannh@google.com> wrote:
>
> You don't need LSM_UNSAFE_PTRACE if the tracer has already passed a
> ptrace_may_access() check against the post-execve creds of the target
> - that's no different from having done PTRACE_ATTACH after execve is
> over.

Hmm. That sounds believable, I guess.

But along these ways, I'm starting to think that we might perhaps skip
the lock entirely.

What if we made the rule instead be:

 - we move check_unsafe_exec() down. As far as I can tell, there's no
reason it's that early - the flags it sets aren't actually used until
when we actually do that final set_creds..

 - we add a "next cred" pointer to the signal struct (or task struct)

 - make the rule be that check_unsafe_exec() checks p->ptrace under
the tasklist_lock (or sighand lock - whatever ends up being most
convenient)

 - set "next cred" to be the known next cred there too under the lock.
We call this small locked region the "cred sync point".

 - ptrace will check if we have the "in_exec" flag set and have one of
those "next cred" pointers, in which case it checks both the old and
the next credentials.

No cred_guard_mutex at all, instead the rule is that as execve() goes
through that "cred sync point", we have two cases

 (a) either ptrace has attached (because task->ptrace is set), and it
does the LSM_UNSAFE_PTRACE dance.

or

 (b) it knows that ptrace will check the next creds if it races with execve.

And then after execve has installed the final new creds, it just
clears the "next cred" pointer again, because at that point it knows
that now any subsequent PTRACE_ATTACH will be checking the new creds.

So instead of taking and dropping the cred_guard_mutex, we'd basically
get rid of it entirely.

Yeah, I didn't look at the seccomp case, but I guess the issues will be similar.

             Linus
