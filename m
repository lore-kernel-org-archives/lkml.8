Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,GUARANTEED_100_PERCENT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86E7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD5E2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Xv3r4JPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDJO02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:26:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35290 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgDJO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:26:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id s30so1550812qth.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PkdgbuXbnEZlYFm3D+9vBRJpFZPEdF0IK8AxUyUKtX4=;
        b=Xv3r4JPaMQeJP9cBNqN9Jmih7Wq5TsBASI0B/KgtnAZ2GP+VgVRpR4sMquyxX70NZQ
         6UwYLxMmLxfANNzN/3LY5Q930Nrqmb5EQUQHDamLk0shRht4ud2UwLg8xfloaSV91/l6
         BtFiyaDTmPes4lfely/8df1CQ5jk8ojz2YPGKZpZYK4bvFKoq7+dIWkUWT8KC/7yB/j9
         jikMkHcVQxHKqE3xRVPPLtG2dj9scW6/YcivXPQ2tgHRKzVzKV+fze+jzNGksPksIP+e
         oUpIYxosviKr0N1jWqKWtwE8YuhmW49MqbRS3r3CdMPlpT+G30vHYCcDcZyIb+/z2/7M
         4KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PkdgbuXbnEZlYFm3D+9vBRJpFZPEdF0IK8AxUyUKtX4=;
        b=mtDdKPQP8lRGhhsHvfPrngt3Obm5GJzpDfLfGEpPi0Zgjc0a84y+XSBbfAdaVDl1ub
         NTCZHVpgcaua+y92hjE2vA0S1mtcyy/1ZdVadv7Wm2FsGHhbSZXT/IwhiblLz/aysKFs
         Gt+N2bH/rW1zrx+w9boTe1eqr1Snl15CNFHJ9Tp7wy85Uxk6hfF7Kjr+BQy75LaSpmPP
         j3gbPn37hMdy+8QPnxmEfiURUZlENjUgxCSnoBemSKJwxcXizHAUS2CanHiAFnE7iJFv
         PjT+oeoWY/alktxwYEjKB97GlLGgRPhYoHF9+bqm8+DsUIfPCuJ5bcunCxGqMq2yZu6X
         03iw==
X-Gm-Message-State: AGi0PuaZK+55qie8PIl5zZFkgIKPcYQxkHxmWaJ437VsfdQGwunfY6Ww
        In54Qknyew2ePp9KoB8o1b5Uow==
X-Google-Smtp-Source: APiQypLvqv3x9fw3KJWa5wqcVzm8wN0BLPlVx6we8nGWH4gq53VQ9rO9lFx1Ff/afIgYDY+3KfrkNg==
X-Received: by 2002:ac8:2668:: with SMTP id v37mr4732954qtv.143.1586528785345;
        Fri, 10 Apr 2020 07:26:25 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e17sm1939961qtw.1.2020.04.10.07.26.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 07:26:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <76e8bbed-21d1-22e1-4148-5a5766652c0d@I-love.SAKURA.ne.jp>
Date:   Fri, 10 Apr 2020 10:26:23 -0400
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <22DAFAC7-9F39-4042-BC79-B27963A13E3D@lca.pw>
References: <CAHk-=wjfngA7nHAsie7bW_JmKBhUyV9oV7zmDbZuchkJK3sR1w@mail.gmail.com>
 <AFD0DADD-0558-463F-B219-5F098E6C2EDF@lca.pw>
 <CAHk-=wgFn4rHZM8ttPWvdSzV3pL1nS3EDcAh+83OObObkot4-g@mail.gmail.com>
 <9C21961E-24D3-4C97-A5AB-B70451E4F952@lca.pw>
 <76e8bbed-21d1-22e1-4148-5a5766652c0d@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 10, 2020, at 9:12 AM, Tetsuo Handa =
<penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>=20
> On 2020/04/10 6:14, Qian Cai wrote:
>>=20
>>=20
>>> On Apr 9, 2020, at 2:06 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>>>=20
>>> On Thu, Apr 9, 2020 at 10:58 AM Qian Cai <cai@lca.pw> wrote:
>>>>=20
>>>> Agree to make a big deal part. My point is that when kicking trees =
of linux-next, it also could reduce the exposure of many patches (which =
could be bad) to linux-next and miss valuable early testing either from =
robots or human.
>>>=20
>>> Sure. But I'd want to be notified when something gets kicked out, so
>>> that I then know not to pull it.
>>>=20
>>> So it would reduce the exposure of patches, but it would also make
>>> sure those patches then don't make it upstream.
>>>=20
>>> Untested patches is fine - as long as nobody else has to suffer =
through them.
>>=20
>> Excellent. It now very much depends on how Stephen will notify you =
when
>> a tree, a patchset or even a developer should be blacklisted for some =
time
>> to make this a success.
>>=20
>=20
> Since patch flow forms tree structure, I don't know whether =
maintainers can
> afford remembering which tree, patchset or developer should be =
blacklisted
> when problems come from leaf git trees.
>=20
>=20
>=20
> By the way...
>=20
> Removing problematic trees might confuse "#syz test:" request, for
> developers might ask syzbot to test proposed patches on a kernel which
> does not contain problematic trees. In lucky case, test request fails
> as patch failure or build failure. But in unlucky case, syzbot fails =
to
> detect that proposed patch was tested on a kernel without problematic
> trees. A bit related to =
https://github.com/google/syzkaller/issues/1609 .
>=20

I looked at those blocking bug list sent by Dmitry. I wonder =E2=80=9Cboys=
, why they
did=E2=80=99t send those out earlier to linux-next or somewhere more =
visible?=E2=80=9D because
I had dealt with most of those before, and I knew the solutions to =
unblock them!

Even though my testing setup is somewhat different from syzbot. I =
don=E2=80=99t do
fuzzers, and my config is only focus on mm, iommu and a few core kernel =
pieces
with more debugging options on, but it does bare-metal and multi-arch, =
there are
still lots of opportunities to help each other with dealing with =
blocking issues.

A few things I am doing differently with syzbot on linux-next where =
would help to
be run continuous without blocking most of the time are,

I don=E2=80=99t set panic_on_warn. I=E2=80=99ll deal with warnings =
afterwards.

Occasionally, there are hard failures that I have to deal with right =
now. I=E2=80=99ll get to
the end of it, and figured out the exact commit caused it.

In syzbot mode, the bisection (by robot) is the hard part, because if =
you don=E2=80=99t
figure out the exact commit, most of times people (CC by the bug =
reports) would
have no clue and will be ignored. (even if the bad commit was figured =
out, it is
not 100% guaranteed developers would know what=E2=80=99s going on but it =
helps
dramatically, and at least we can revert it without blocking if =
everything else fails).

Thus, it would be really help if syzbot (or human operators) could help =
bisect, even
if it could only figure out one of merge commit in linux-next is bad =
(where with high
accuracy) and may get those ignored less.=
