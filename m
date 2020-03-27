Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F694C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0545B206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8D9FdaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgC0Fbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 01:31:32 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36354 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgC0Fbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 01:31:31 -0400
Received: by mail-qv1-f66.google.com with SMTP id z13so4360890qvw.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 22:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0aSGmCSFNaK2u76JjA7BVQB1O79rv1aQ7YCzvcBdSxY=;
        b=F8D9FdaZDtIs1Nvnss6zo39ggbeUmDGReLfXNJ0uVpGGGoIv8HmaV+x09St1MFctvx
         8jCHCOkqMtYyI93+JUe2F1VL2D04tFx5vPN2FjtG6ZLCzvgT7CFZZFPmI934rbzuJRHi
         Soj9DuzRfLd1y+fbACoPWmAawlycl4CiqvFZpS9Y+eC8rtN0KKg5XRKbPh5g48insppB
         MUyTIhb5TytP8P4HnVcc/c53tgVuvrxKR14FIUgfxiY9I2MYDTZtIcyERJO66R4Ib6m5
         q5pVUVUWhc7F0IdpEdeBybxi91Yz5j8hzV7iZDMLqN3Ln/b/6hH9ypSb0zRMreXqlMgR
         1Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0aSGmCSFNaK2u76JjA7BVQB1O79rv1aQ7YCzvcBdSxY=;
        b=BrGB5CHHieFme6FbrTAeSKWYgCUsiO9JZ8J3tPW2wwoedVbWqWeU3D12VWTgosNk14
         ZQ+KTbXRlI3Nxtz2PROb+rE5LrD2AMDEmg9QHa5SWrgxZIGv5HediZJXrgkEFXA1LENx
         NZLTFnFbikMH7JKkqWf0bdwOwufR/Urb/2vSN8Ox7yJg6cf0NQv4osplifNV2Jchx2rO
         WnNn2x/L6WCyFCzBJ7VsSViTPRC4Rftil23Lx/GOUBpE+EDQ0PG8po1FKpykVKBB7kPI
         O+ElB5zdaVMXHHAUPPeMHkFSJWZTJr0+eBzhkjiWwIcyM9dqo8Jl/hXGyTl9CrMo9OWu
         IeUw==
X-Gm-Message-State: ANhLgQ2ZbormNdP0iQqSgUjKOJH5dqXA7LKTpzCyuXFPyneZa1pJYkQQ
        T9zZZSauonYX7TC0BLc8nSKKCHHpkdGnTU0z8JlNmQ==
X-Google-Smtp-Source: ADFU+vvZHyRSMkuHqqaZQ6WSnX8c8iDf4KDytk/AtxfsV2NeAGplCy0mk7umGT6VIwfQKkHw25AhDYA1JWVe/imNL6A=
X-Received: by 2002:ad4:4088:: with SMTP id l8mr9904318qvp.34.1585287089966;
 Thu, 26 Mar 2020 22:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
 <20200319164227.87419-4-trishalfonso@google.com> <CACT4Y+YHPfP3LP04=Zc4NgyhH8FMJ9m-eU_VPjmk5SmGWo_fTg@mail.gmail.com>
 <CAKFsvU+N=8=VmKVdNdf6os26z+vVD=vR=TL5GJtLQhR9FxOJUQ@mail.gmail.com>
 <CACT4Y+ZGcZhbkcAVVfKP1gUs7mg=LrSwBqhqpUozSX8Fof6ANA@mail.gmail.com> <CAKFsvUK-9QU7SfKLoL0w75VgSOneO8DWciHTDYMfU8aD98Unbw@mail.gmail.com>
In-Reply-To: <CAKFsvUK-9QU7SfKLoL0w75VgSOneO8DWciHTDYMfU8aD98Unbw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Mar 2020 06:31:18 +0100
Message-ID: <CACT4Y+ZhraraMNC+uvD9O7h3wMQntiEu5zSmVd_UYEaqvdxTaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] KASAN: Port KASAN Tests to KUnit
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 4:15 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
> > > > <kasan-dev@googlegroups.com> wrote:
> > > > >
> > > > > Transfer all previous tests for KASAN to KUnit so they can be run
> > > > > more easily. Using kunit_tool, developers can run these tests wit=
h their
> > > > > other KUnit tests and see "pass" or "fail" with the appropriate K=
ASAN
> > > > > report instead of needing to parse each KASAN report to test KASA=
N
> > > > > functionalities. All KASAN reports are still printed to dmesg.
> > > > >
> > > > > Stack tests do not work in UML so those tests are protected insid=
e an
> > > > > "#if IS_ENABLED(CONFIG_KASAN_STACK)" so this only runs if stack
> > > > > instrumentation is enabled.
> > > > >
> > > > > copy_user_test cannot be run in KUnit so there is a separate test=
 file
> > > > > for those tests, which can be run as before as a module.
> > > >
> > > > Hi Patricia,
> > > >
> > > > FWIW I've got some conflicts applying this patch on latest linux-ne=
xt
> > > > next-20200324. There are some changes to the tests in mm tree I thi=
nk.
> > > >
> > > > Which tree will this go through? I would be nice to resolve these
> > > > conflicts somehow, but I am not sure how. Maybe the kasan tests
> > > > changes are merged upstream next windows, and then rebase this?
> > > >
> > > > Also, how can I apply this for testing? I assume this is based on s=
ome
> > > > kunit branch? which one?
> > > >
> > > Hmm... okay, that sounds like a problem. I will have to look into the
> > > conflicts. I'm not sure which tree this will go through upstream; I
> > > expect someone will tell me which is best when the time comes. This i=
s
> > > based on the kunit branch in the kunit documentation here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest=
.git/log/?h=3Dkunit
> >
> > I've checked out:
> >
> > commit 0476e69f39377192d638c459d11400c6e9a6ffb0 (HEAD, kselftest/kunit)
> > Date:   Mon Mar 23 12:04:59 2020 -0700
> >
> > But the build still fails for me:
> >
> > mm/kasan/report.c: In function =E2=80=98kasan_update_kunit_status=E2=80=
=99:
> > mm/kasan/report.c:466:6: error: implicit declaration of function
> > =E2=80=98kunit_find_named_resource=E2=80=99 [-Werror=3Dimplicit-functio=
n-declar]
> >   466 |  if (kunit_find_named_resource(cur_test, "kasan_data")) {
> >       |      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > mm/kasan/report.c:467:12: warning: assignment to =E2=80=98struct
> > kunit_resource *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from=
 integer without a cas]
> >   467 |   resource =3D kunit_find_named_resource(cur_test, "kasan_data"=
);
> >       |            ^
> > mm/kasan/report.c:468:24: error: =E2=80=98struct kunit_resource=E2=80=
=99 has no member
> > named =E2=80=98data=E2=80=99
> >   468 |   kasan_data =3D resource->data;
> >       |                        ^~
> >
> > What am I doing wrong?
>
> This patchset relies on another RFC patchset from Alan:
> https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-email=
-alan.maguire@oracle.com/T/#t
>
> I thought I linked it in the commit message but it may only be in the
> commit message for part 2/3. It should work with Alan's patchset, but
> let me know if you have any trouble.

Please push your state of code to some git repository, so that I can
pull it. Github or gerrit or whatever.
