Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9E1C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AB62075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgEKJEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:04:12 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgEKJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:04:12 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MoOpq-1ijdWT2go4-00orc3 for <linux-kernel@vger.kernel.org>; Mon, 11 May
 2020 11:04:09 +0200
Received: by mail-qv1-f54.google.com with SMTP id c4so3704858qvi.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:04:09 -0700 (PDT)
X-Gm-Message-State: AGi0PubTylh5F+wtfm/Sl2K5RCH8yhp+1yFuILWCT6mqwCuE6SW3MJwm
        TBAxVTxi1Epj1I0hb28IcFj6X1WjVzZH0nJw9ok=
X-Google-Smtp-Source: APiQypIsp0Vz1NYHBNAuNb+aggTW7S4O2yJH5oSF8XBhGOGh3ivtKzgOl9r0vsN5FACIAplYY5hfkMxBpm1fu0iDekY=
X-Received: by 2002:a05:6214:1392:: with SMTP id g18mr3754084qvz.210.1589187848467;
 Mon, 11 May 2020 02:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
In-Reply-To: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 May 2020 11:03:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1BKGQjRDtdWB4h6Y6p6Usgr9ic45uH3w1H2v+N6g_gQA@mail.gmail.com>
Message-ID: <CAK8P3a1BKGQjRDtdWB4h6Y6p6Usgr9ic45uH3w1H2v+N6g_gQA@mail.gmail.com>
Subject: Re: I disabled more compiler warnings..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z5gpQWszXfOmDC1yGFh/yV5DQuGgH8frsjkFgCVSyMSp98vXsU0
 KjllQyy3upHDFGPiJCOzT7RWKsf8W+K2rY/QDi8oaznXuwK00GaJgFtZ21xs8WEljtCASTE
 Fa+Y5LNtqnfs69Z8tkEE9Zopa6sbNjuLlMRpLUIvR91WXNnM2c/bv3pmcz52ul1PoSKvkCu
 QDAApplivpcsaQnEjiqSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qXhr4BTIF50=:m2n977gK5ZTTeRTmH3Lxet
 4eXQ7WUoUzvbZBxwLwWQWJpTWiczzEKclAAGETQu395KZPpMHPTTlfa+3wnaZPL6CNNPD5I92
 UF8TsCd1Am8C5DTeSIhHSEAGU6mbcoDIIdwoKweWntkxv0apIPSBwRCssz9TwzKcEEBgjRZxg
 j7ZOrNWFJVBtS502zdd/1z99GFkfX5lC6/oRrZz0G35N8LJ8Ayhb6FYrZjQbVkL5W4Q3s8E4x
 cEtrkewljMbijEtwL6iK5xbFeulQPxs2lJfE+0Ap3LChOZ53/8wid8KU3gOp8vsL/YS6/Y7x0
 3fVNbooAi9T5ILFjiKiASeot/NDENb3OwJwx3MZa66TXePJk3XtNyurIyD227wnS0Cyj07HIh
 J1b+BZ6hrAPZxu2PykDFhavZaXP13/pMSBfTuB5VgfH58nJ3KI4cdI4rqwE2MlevfYDso2vAk
 A3IAdD853bGJh5hvg8u9I6s2YDsO4/kwQPz0OeI0TJbzVv9YvnC6NauE8gaAXzPG6zVznElBX
 mfhjbTd08ni5yliUCPOibwssvxyCPz/9JonVMb8mP9mH5VRpYvmEwcRB3KPhifGSuFWT3nYUD
 q442mT16bj/L+Xa7Dyjxn3MSYp9X10rLFcu8BLysJq1f7dxNThmDk+RO6cJUD5be08zX/DJxq
 ifZIl+hMBj6aHd2U4OEzr8H9q4O0PjFEDAIDrKf+X+XREW9qMrrxRGttYm+uLRFTrKWYxRZiZ
 Fuf52yD8+h9bV2Op993WpnM6yquXlGvH0nt5hDQ7C8CuZT5TzoOL5h0NKkIrHrstopSyRCuXW
 fisPUDxpcAqEv1OO0VJW4uEogOjItDSuNpiC0ygDcAAuO6FWWU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 9:33 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I don't think those parts are at all controversial. We'll get the
> zero-sized arrays converted, and then we'll have another slew of
> one-sized array declarations that will also have to be taken care of,
> but I hope we can re-enable those array limit warnings in the not too
> distant future. They should be fairly unambiguously a good thing once
> we've sorted out the legacy code, which people are working on anyway.

Agreed, I have sent patches for all the zero-length arrays. Some
of them still need more discussion or better ideas when they are not
trivially changed to flexible arrays, but there are not actually so many
of them that cause warnings right now.

> Same to some degree goes for the 'restrict' warning, which we don't
> need right now and triggers for what is a somewhat odd - but not
> entirely unusual - case for the kernel.

I think in this case it's not the warning that is new, but (same as
the free free() case) the compiler now knows that snprintf() comes with
a restrict pointer in standard C even when we don't mention it in our
declaration.

> and two were fixes/cleanups to the kernel to avoid new warnings:
>
>    gcc-10: mark more functions __init to avoid section mismatch warnings
>    gcc-10: avoid shadowing standard library 'free()' in crypto

I think I had sent the same patches and they got merged into linux-next,
but the maintainers did not consider them to be v5.7 material as
this was all old code.

> but the one commit I wanted to point out - because I think Arnd may
> care - is me giving up on the "maybe initialized" warning once again.
>
> This is the usual "gcc optimizations changed, now it can't follow the
> flow of code it used to handle fine, and it warns in several new
> places that are almost certainly false positives":
>
>    Stop the ad-hoc games with -Wno-maybe-initialized
>
> so now -Wno-maybe-uninitialized is the default behavior, and if you
> want to see those (very unreliable) warnings, you need to use "W=2"
> which has explicitly enabled it for a longish time.
>
> I simply refuse to be in the situation where I might miss an
> _important_ warning (or, like happened yesterday, an actual failure),
> because the stupid warning noise is hiding things that matter. Yes, I
> caught the build error despite the noise, but that was partly luck (I
> did another pull before I pushed out, and caught the error on the
> second build). And yes, I've made my workflow now hopefully make sure
> that the actual build error will stand out more, but even hiding just
> other - more real - warnings is a problem, so I do not want to see the
> pointless noise.
>
> But I wish there was a better model for handling those "maybe
> uninitialzed" issues. Some of them _have_ been valid, even if a huge
> amount are just the compiler not following the use of the variables
> well enough.
>
> So I thought I'd at least mention this thing, and see if people have
> any sane solutions.

Thanks for looping me in. I will try to investigate what is going on,
as I did not see a huge increase in these warnings after I moved
to gcc-10, and clearly something is going very wrong. Some more
notes on the topic:

- I absolutely agree that on a release kernel, doing 'make -s
  allmodconfig; make -skj30' should produce zero output,
  and anything else is a problem that needs to be addressed
  in some form, so turning them off for the moment is sensible.

- I also think that the warning about possibly uninitialized variables
  is an important tool in general, as long as it works well enough,
  as Rusty explained many years ago in
  https://rusty.ozlabs.org/?p=232
  It is super-annoying to see false-positivies pop up in old code, but
  when writing new code, that warning has saved me from running
  some stupidly broken code many times.

- Jason Donenfeld noticed that the gcc-10 inliner is much less
  aggressive in -O2 and suggested using -O3 by default to get
  the original behavior back.
  https://lore.kernel.org/lkml/20200507224530.2993316-1-Jason@zx2c4.com/
  I'm not sure we want all the things that -O3 does, but whatever
  changed in the inliner is probably the root cause for the new
  warnings, and for the same reason we previously turned off the
  warning in "-Os".

- There is a big difference between the handling of this warning
  between gcc and clang: while both have false positives and
  false negatives (see: halting problem), the behavior of clang is
  more reliable as the set of warnings it produces does not
  depend on inlining decisions.

- There is a good chance that some trivial difference between
  mainline and linux-next, or between linux-next and my test
  branch (with a couple hundred fixup patches) is causing you
  to see many warnings that I don't get. I'll try to reproduce and
  bisect what I find.

      Arnd
