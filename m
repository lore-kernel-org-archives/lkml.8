Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72792C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4280C20730
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586478665;
	bh=lxTJ9E+/Tfcppp8nGUCUIj0XK8aMab6VGMt7G8RJl5M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HvTjbrN1cE+/S1GDEkIp8yT+L6UFfOxG1FGDRJSQAJHcbm+e+1fttUe6NLmLmRiqp
	 g1M6gaml6vU2zAU/nQhsHO/qt5tom1ukj6BoCtFRL6ziGavO2+tX1x7fhxXZkPKCnc
	 QTjt2jSuNY5EsDFFRkinQPyXE/TypxHCOubn0OaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgDJAbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:31:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44533 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgDJAbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:31:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id z26so414821ljz.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsxYxySWiEqGh4Vu0xe3MfhE02glm0tqP40evYhDqjs=;
        b=UsbRMqt2jgXvdMUS2Z054/DLYqIE4/7ylasav9e9bPPLL4YJFyI7YGsH9X0f+xpkAh
         H/XpuUR/VAu65Yndvzj363CuAoJDznmBmxMvxfzlQl5DnDi7YMDH0KxnG8RFsGbTG+XI
         Ozq7seFMOO2A814jeyHUft3ifxQbSjUxhvK2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsxYxySWiEqGh4Vu0xe3MfhE02glm0tqP40evYhDqjs=;
        b=EsmTE+1AE8SpCz0uxcHvvyZjdsieJDfEQFLN9ysjdi/6fML4kvmejEhp4pmyMh4WtG
         T2Jx710N9SbX00nnAAPWKLLaaCE7HPTltxMBnuYERpslJZhlLNYQ6f1qU2hbykooWJd/
         E2KlpoRivake3A0kGSfQnEdPqleIdYcJl7q4CcIUjgHRZGjNef4tR6mCwzDBTsoJ9EZd
         uZ4DaUtoIrkAH2M+Pb88pUpGU6FVavEfQrf+LP9sLBu1rs28rwmlgVOfW3anWGE+bdO5
         G5RoqrkBy0pPyQTH2+ZySAB4mIk3icRxJl05qm8ZUUltWocT1NJf4Lv0SRn0icxG6vfm
         FzuQ==
X-Gm-Message-State: AGi0PuajRxZA7vLTT++if1PzmZcPO/vGP3HheamB6Z+mbUoPxN/SomrZ
        9W/QyHsp+FTi7mUazmSlVejaKMpLNRk=
X-Google-Smtp-Source: APiQypIUnwffOU/3WaWb+6GCqCKPrVm4keZ0rWeCIR0rsbrw7shPlKw+Eetl+jX7NJ4tPeSTsEiMyQ==
X-Received: by 2002:a2e:8612:: with SMTP id a18mr1305718lji.250.1586478659188;
        Thu, 09 Apr 2020 17:30:59 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id o6sm171179lji.15.2020.04.09.17.30.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 17:30:58 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w145so261383lff.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:30:57 -0700 (PDT)
X-Received: by 2002:ac2:5ec5:: with SMTP id d5mr1095240lfq.142.1586478657465;
 Thu, 09 Apr 2020 17:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org> <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org> <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org> <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
 <87wo6or3pg.fsf@x220.int.ebiederm.org> <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
In-Reply-To: <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 17:30:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
Message-ID: <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 2:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'm not just good at "spotting odd corner cases". I told you why
> that bogus deadlock of yours failed - the execve was pointlessly
> waiting for a dead thread that had marked itself ptraced, and nobody
> was reaping it.

Side note: this does seem to be the only special case at least in this
particular area for execve().

The thing is, for actual _live_ threads that end up waiting for
ptracers, the SIGKILL that zap_other_threads() does should punch
through everything - it should not just break out anybody waiting for
the mutex, it should also break any "wait for tracer" ptrace waiting
conditions.

But already dead threads are special. Unlike SIGKILL'ed other threads,
they can stay around almost forever.

Because they're in Zombie state, and no amount of SIGKILL will do
anything to them (and zap_other_threads() didn't even try), and
they'll stay around until they are reaped by some entirely independent
party (which just happened to be the same one that was doing the
ptrace, but doesn't really have to be)

(Of course, who knows what other special cases there might be - I'm
not saying this is the _only_ special case, but in the particular area
of 'zap other threads and wait for them', already dead threads do seem
to be special).

So the fact that "zap_threads()" counts dead threads - but cannot do
anything about them - is fundamentally different, and that's why that
particular test-case has that odd behavior.

So I think we have basically three choices:

 (1) have execve() not wait for dead threads while holding the cred
mutex (that's effectively what that zap_threads() hacky patch does,
but it's not really correct because it can cause notify_count
underflows)

 (2) have zap_other_threads() force-reap Zombie threads

 (3) say that it's a user space bug, and if you're doing PTRACE_ATTACH
you need to make sure there are no dead threads of the target that
might be blocking an execve().

For an example of that (3) approach: making the test-case just do a
waitpid() before the PTRACE_ATTACH will unhang it, because it reaps
that thread that did the PTRACE_TRACEME.

So option (3) is basically saying "that test-case is buggy, exactly
like the two readers on a pipe".

But I continued to look at (1), but trying to deal with the fact that
"notify_count" will get decremented not just by live threads, but by
the ones that already died too.

Instead of trying to change how notify_count gets decremented, we
could do something like the attached patch: wait for it to go down to
zero, yes, but go back and re-check until you don't have to wait any
more. That should fix the underflow situation. The comment says it
all.

This patch is 100% untested. It probably compiles, that's all I'll
say. I'm not proud of it. And I may be missing some important thing
(and I'm not happy about the magical "am I not the
thread_group_leader?" special case etc).

It's worth noting that this code is the only one that cares about the
return value of zap_other_threads(), so changing the semantics to only
count non-dead threads is safe in that sense.

Whether it's safe to then share the signal structure ever the rest of
exevbe() - even if it's only with dead threads - I didn't check.

I think Oleg might be the only person alive who understands all of our
process exit code.

Oleg? Comments?

              Linus
