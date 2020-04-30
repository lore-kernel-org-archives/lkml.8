Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC26C83003
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136F02082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588217167;
	bh=z3pTkIFBVNr+3ZsQm78UbryBpZKNfoi08jEr0PDPxjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T5hWZKwHqOToD24iYPjRR9EYWsWqFyEV1XsxUs6Yz2uygK9UOfzjFBcA5HYMAJryN
	 IsqlUl83Au/ba+r+JYvhexVu7E/K4IYDCWayomPxwOmlijZCwn17EgO/ETcJx7yYpO
	 MmmVgLYgpx7Y6Zz6iT+miW/4LuL2g9kQSRwDgY1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgD3D0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgD3D0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:26:05 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F46C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:26:05 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 188so3483574lfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rep5Pfyn5wwxEy4YRJRyifa2EtharymFjZwIOhhAhjI=;
        b=hxPz/T6gnizicMHSps1pqHyi5LPdmmZAEZZ6ZvmYNNumXDosb4mxFs185exk2bmlag
         MzcTztnXTDRN0IqPCvpeFPqLrBVxtw2iaUxPXXHLeyci2LAR7IKzylYEMDPIi/x5ZIy+
         Ni65GjbEcyASwyPX8s3S6S7ZKWXPtR2caNdDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rep5Pfyn5wwxEy4YRJRyifa2EtharymFjZwIOhhAhjI=;
        b=NJmUqqi2dfrVtE5Hlh2+hcehHeaHz+602o+RZDAqyqTj0h7h03hLjA3rAKMwcQegjV
         g/6HC+l/mijrswRDeiLaT2T2xm375ocuow51rUPKQI3Y66IvMMV0NbHzzO1UJ86XOWh5
         A39X44P/jdouJtcPyPetRZfcETTqhikvtqwdgWFGFAiPqAWbb0h3IbU7zyApXxI6ekJa
         TF8871vxKaGC9DrCvM6X+U9TSarNSJurp0CKr215+0RGNQPnMm9Z8NztEUPlQn48y7hJ
         NTxJ+4rzHISjYG/PvKxrX5i7/EJxzpRutI0gRL8821NV7sWOYDuNvbTgN0DjY0ZxHbZ6
         c1gA==
X-Gm-Message-State: AGi0PuZREzYru2aJzjrYk8mHj07ixj0oW3q0otUQdFGOIQ0jXTxnFnmD
        NbwmiJeKPVkJOE0W1vT1bqEMD70XSJs=
X-Google-Smtp-Source: APiQypKrbkwwWgLwYM1J9rsuN4rYBBU28xIcbkfuxveLPwwlAfnUenaG84Fx5MaWG5c7IcS915Igcg==
X-Received: by 2002:a05:6512:695:: with SMTP id t21mr653024lfe.158.1588217163039;
        Wed, 29 Apr 2020 20:26:03 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id u3sm4021639lff.26.2020.04.29.20.26.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 20:26:01 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id j3so4868341ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:26:01 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr791220lji.201.1588217161107;
 Wed, 29 Apr 2020 20:26:01 -0700 (PDT)
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
 <CAHk-=wg6oKSLkVhY5oqOFyzCCSr9eYPGK2SHJfgCXF_QOmPKog@mail.gmail.com> <CAG48ez25=6qrCU51dEAV_ciyU2jvPuRFWfFOAAT22kmeAZccuQ@mail.gmail.com>
In-Reply-To: <CAG48ez25=6qrCU51dEAV_ciyU2jvPuRFWfFOAAT22kmeAZccuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 20:25:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjE_YJ4SFJUasF=tW0jMr6zg+rkRNuNt2hdODPu_LLTVw@mail.gmail.com>
Message-ID: <CAHk-=wjE_YJ4SFJUasF=tW0jMr6zg+rkRNuNt2hdODPu_LLTVw@mail.gmail.com>
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

On Wed, Apr 29, 2020 at 8:00 PM Jann Horn <jannh@google.com> wrote:
>
> But if we go with Bernd's approach together with your restart
> suggestion,

So repeat after me: Bernd's approach _without_ the restart is unacceptable.

It's unacceptable because it breaks things that currently work, and
returns EAGAIN in situations where that is simple not a valid error
code.

His original patch also happens to be unacceptable because it's an
unmaintainable mess, but that's independent of the bug it introduced.

That bug has nothing to do with ptrace(). It's literally a "write()"
to a file in /proc.

What is so hard to get about this basic thing?

> then simply doing PTRACE_ATTACH on two threads A and B
> would be enough to livelock, right?

The same case that just causes a recursive wait. Yes. No worse off than we were.

And the fact is, *THAT* case looks truly trivial to work around.

Just make the ptrace() code - but not the fs/proc/base.c code - do
something like

        if (lock_exec_creds(tsk))
                return -EINTR;

and now ptrace() doesn't repeat (simply because it doesn't return that
ERESTARTNOINTR. It would go through that "return through signal
handling code" in the kernel, but it wouldn't actually retry the
system call).

But I'm getting less and less interested in trying to "fix" this
problem, when people don't seem to realize that the important case is
to not break _good_ programs, and the pointless buggy garbage
test-case is entirely uninteresting. It's buggy user code. If it
causes a wait or a livelock, nobody sane should care in the least. Fix
the bug in user space.

Introducing new bugs in the kernel where they didn't exist before - in
order to try to work around buggy user-space that has never ever
worked - is not acceptable.

                       Linus
