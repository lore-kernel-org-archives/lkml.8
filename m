Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9984A2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596217340;
	bh=BJ6AJiaX7Nzu5eZgUJYXd369reLLS6gyuy9w1TfkhV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AlxRTKU4Caku6VaxNRvh2QPNRQuRqU1FBojoMiwr6476DH866K2Scj/EovjxyJ3XE
	 vV8R0NrnqncLrwFEXW1MB44YZXWVtgxDC0qOZmGr2aMaOcUd94sO6LOpGoNOHJsCNh
	 BWS/UUUAZ/wo0J1Ufx8Drl1DQPk1UTXMd30Mta68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgGaRmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbgGaRmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:42:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0009C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 10:42:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so3402432ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=28cR6MxZbujlZ14NZ0HVtiSgAqlUlORhwpPRlaJnnaw=;
        b=ARF0tJgweiX8TuwD/1AuE8ihqF28A/0GG/2hOKEe5zsa5dn6IQ7vjuiCyXUDIEpTTu
         zkma0hSorXfSXFzP5ErNIzvSEoDve/Vh8jrM5DAnEExvyO5v/D6+sPEczzTrI1FPjJfl
         t4GEgq5BrOqFLTYFU8zRTlt69XfwnP6VESCBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28cR6MxZbujlZ14NZ0HVtiSgAqlUlORhwpPRlaJnnaw=;
        b=tiQaK4S2Rx86jZNkMlNY++LtOOAO8au0N4Vg0AbYox+1rvSdvtpE63XkWQg5EEBUu2
         MCyf1iHLvjhkouzWKwaOmWJHd4eJQkX3B83EdiOqqhQnEaQFOjgaQAwSLSSJmBiLPsGD
         BcQSFtZ3YAwSD5MczP1ebV/FvRmFbS/RN+Z1dPLC48KtF6bXTOTnQLFuOWTXAVfpD2SE
         UAXh74OiS1xv9XzCUgJBxqD4jjgKjgPK/7DhFeeZ9A9/fgMyPQhDv/KxsEAa293kXu73
         J8wAwQxaosjn0ykw9n1jnB7nsIGIlNWNGTKUjxLIWwoFCyDwBnEbOOncNS7LXuB7CDgT
         vJsg==
X-Gm-Message-State: AOAM533AFNrKHK1gVxsqREFC7gJhs8omrbroUXutOOrovUjCbU7pnRUY
        eifodH6OxfRaVwmga3oirPR94kje1ak=
X-Google-Smtp-Source: ABdhPJztPIpMs/6U00LW40rMhRlaEVjZSIyN3k8JJCwsA+Pr9xcalM3uFH05Lw82wIWubBCmtC5O9g==
X-Received: by 2002:a05:651c:204a:: with SMTP id t10mr2425310ljo.194.1596217326137;
        Fri, 31 Jul 2020 10:42:06 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id j144sm2516902lfj.54.2020.07.31.10.42.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 10:42:05 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id t6so20321802ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 10:42:04 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr2425348ljj.312.1596217324449;
 Fri, 31 Jul 2020 10:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <87h7tsllgw.fsf@x220.int.ebiederm.org> <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
 <87d04fhkyz.fsf@x220.int.ebiederm.org> <87h7trg4ie.fsf@x220.int.ebiederm.org>
 <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
 <878sf16t34.fsf@x220.int.ebiederm.org> <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wjMcHGDh8Wx+dwaYHOGVNN+zzCPEKZEc5qb3spsEydNKg@mail.gmail.com> <87pn8by58y.fsf@x220.int.ebiederm.org>
In-Reply-To: <87pn8by58y.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Jul 2020 10:41:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_5Lu_3OACT4pSqrf1eJ3=PR_fUjL1vLSbBZM2_OAC5w@mail.gmail.com>
Message-ID: <CAHk-=wh_5Lu_3OACT4pSqrf1eJ3=PR_fUjL1vLSbBZM2_OAC5w@mail.gmail.com>
Subject: Re: [RFC][PATCH] exec: Conceal the other threads from wakeups during exec
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

On Fri, Jul 31, 2020 at 10:19 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Even limited to opt-in locations I think the trick of being able to
> transform the wait-state may solve that composition problem.

So the part I found intriguing was the "catch things in the signal
handling path".

Catching things there - and *only* there - would avoid a lot of the
problems we had with the freezer. When you're about to return to user
mode, there are no lock inversions etc.

And it kind of makes conceptual sense to do, since what you're trying
to capture is the signal group - so using the signal state to do so
seems like a natural thing to do. No touching of any runqueues or
scheduler data structures, do everything _purely_ with the signal
handling pathways.

So that "feels" ok to me.

That said, I do wonder if there are nasty nasty latency issues with
odd users. Normally, you'd expect that execve() with other threads in
the group shouldn't be a performance issue, because people simply
shouldn't do that. So it might be ok.

And if you capture them all in the signal handling pathway, that ends
up being a very convenient place to zap them all too, so maybe my
latency worry is misguided.

IOW, I think that you could try to do your "freese other threads" not
at all like the freezer, but more like a "collect all threads in their
signal handler parts as the first phase of zapping them".

So maybe this approach is salvageable. I see where something like the
above could work well. But I say that with a lot of handwaving, and
maybe if I see the patch I'd go "Christ, I was a complete idiot for
ever even suggesting that".

                    Linus
