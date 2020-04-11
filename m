Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF53CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 17:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC542075E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 17:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ysa6u9Ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgDKRaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 13:30:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33439 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgDKRaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 13:30:35 -0400
Received: by mail-io1-f68.google.com with SMTP id o127so4951642iof.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 10:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2MJRhpXThU+pszquP1SrhCFEA1eduxYr0/EAlj1eIEM=;
        b=Ysa6u9Ic9ZZS1fGsElP7Gf9wLbJf0Ihc8dImxiAWFDHTrWHDgxtFVVDcEzRUzyZI46
         6iyfgUcIYs9QA9axJnmG4JECF4zZSrCS2RlUujTpYWRmdbsBK7fNy2lNje1NQD76v4zi
         1hAcolAnROlw2x8xendhQIK4V6B2QeMekdMHzP1/Vpts5sR+56LsVprNBG/dgHnab8N3
         JtSnSZj7EL3pGV+AlIfhPPgzG8uhYvYZ1uGi25z781dEHBnsU2ENFcASv9kmdZ4PxSrx
         TzJROWaFcR/G6T3ovijQjc2DIoxQn4mnPV4M5m3Dc+b2bkyU/gfA8XloErI4FspK5Noz
         wwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2MJRhpXThU+pszquP1SrhCFEA1eduxYr0/EAlj1eIEM=;
        b=jQWW2ttDBu2HXrHViUNt1HVw03LGyY1qyLBGcvZAM3BKNIFY86+kkgHOtiOg/UlSwH
         QoK26eHycSG8uG9E8xXZ4/Uk+1bjDhUdZEbzhpjx0FScU2MRuB68Xna5xfpkwkvSCSqX
         LEFhxx+L+WmbnQbtVvgHbx9+TyeG7zv7jU5QsqJ1FIyJEv3V+iPpqV5S6wuk2gmdJkY7
         jMGh+fFC3/jITbX0pX0waHJ4ze1AlnnQ9KmUGjFH3DNzCJitjE0dCGZzm50ndHUaM/hc
         K1l6WCWPtOGToJ4zUh3E8ndkaHNhsxdmHIgFauWzoAmcJoMiO+heu/2sZ3FEZa3Iny3a
         vl+w==
X-Gm-Message-State: AGi0PuYNO2S2EjrH0PGFf5PQT0u5zU8lcpTWpiO4vk59UJDfT0itPvQf
        EYG9yiA9Ac0QgqyNrpqBXu8OfCABGRwOqj97VcyYqHZ+nEA=
X-Google-Smtp-Source: APiQypKYNk8psLNRwQVvdFPmaJ5h+Tv6lfwFf/9XEF0kFujPrSltnbZThJXvyYezxDvHrfrKFyyyiYw3wQcnX7yoTk8=
X-Received: by 2002:a02:2505:: with SMTP id g5mr8927108jag.114.1586626235478;
 Sat, 11 Apr 2020 10:30:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:a58b:0:0:0:0:0 with HTTP; Sat, 11 Apr 2020 10:30:34
 -0700 (PDT)
In-Reply-To: <20200409073807.GA2483@worktop.programming.kicks-ass.net>
References: <CAOzgRdbWsKY7mXgiTx3um_gdJvgPN1O2p1vxmWv9eApQAy9UzQ@mail.gmail.com>
 <CAOzgRdYkJMiQM9M-UHv5Z-6CLzaV0P8YTK5Ft-CmT5-JqCnYSA@mail.gmail.com> <20200409073807.GA2483@worktop.programming.kicks-ass.net>
From:   youling 257 <youling257@gmail.com>
Date:   Sun, 12 Apr 2020 01:30:34 +0800
Message-ID: <CAOzgRdZyueBhX+jzpgSgdyeto830O444SwmxaLEAQzSsEaGczg@mail.gmail.com>
Subject: Re: Merge branch 'core-objtool-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     viro@zeniv.linux.org.uk, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i build 64bit kernel on 32bit host. please fix.

2020-04-09 15:38 GMT+08:00, Peter Zijlstra <peterz@infradead.org>:
> On Thu, Apr 09, 2020 at 10:00:53AM +0800, youling 257 wrote:
>> d937a6dfc9428f470c3ce4d459c390944ddef538 caused 64bit kernel build
>> failed on 32bit userspace.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Dd937a6dfc9428f470c3ce4d459c390944ddef538
>>
>> 2020-04-08 16:13 GMT+08:00, youling 257 <youling257@gmail.com>:
>> > after this merge branch, build 64bit kernel failed on 32bit userspace.
>> >
>> >
>> >   CC       tools/objtool/builtin-check.o
>> >   CC       tools/objtool/builtin-orc.o
>> > In file included from check.h:10,
>> >                  from builtin-check.c:18:
>> > elf.h: In function =E2=80=98sec_offset_hash=E2=80=99:
>> > elf.h:102:14: error: right shift count >=3D width of type
>> > [-Werror=3Dshift-count-overflow]
>> >   102 |  oh =3D offset >> 32;
>> >       |              ^~
>
> Oh right; I figured it wouldn't matter since we don't do objtool for
> 32bit kernels, but I suppose you're cross building a 64bit kernel on a
> 32bit host or something daft like that?
>
> I'll go fix it.
>
