Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFE0C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB9620714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kB2HLnpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgC3S5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:57:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42183 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgC3S5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:57:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so22986786wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jpXPPGv1foHbi5ckVrxl/EHcxYcDyUhafMePdQC+Tic=;
        b=kB2HLnpAucvE8xw5ImIiYWWKYFZDLBKTM//fEC6JV/vEELi+r7oc2lktXWhrfOQMhE
         dYc8fqZxINyMm3U2GbYG2koGLlT0+nYJ9PUgA1xBNo7GGmdhrjw3Mr19/JatzB3IOGls
         nQ1ty5hR0LS15TLRcD2Z6xGy7bzSqCKol4eqyx2CbdX0bdd/FhN+hWVjo/runM70cRLV
         U0QTB0B1uPxPvVFDNMvz2cViMDnrLgAhsEY6ZMTzPYzFIEBB+/O4O6VdzrXcKTVSyxxB
         5QAIs/ev7zgiS0ns6bgu5PsSkfrUlNpNsThnIKwtsf8R7A//hkZV7/hBYRHgJc8DgJ63
         vZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jpXPPGv1foHbi5ckVrxl/EHcxYcDyUhafMePdQC+Tic=;
        b=T/MyWM0piuqxxNyLI1HcF4E54oEKHNVrPaPCIXDhW/BWudBK/rbZ/QH99DCBP41TcC
         bvgnJovB9lWOG4VoHSEtQCITXtYcPqmv0QApsXQoZLWOOqVstgnYXA9arn6oUOtRdlJh
         /F5xwhypv5QBPH7yzaRJkHRHbqjnBPQQBQlZF2OxcSAr3Awvyi2+W8HQGlIv/PGFWRSR
         610I7PMNuvk7XRVRU124bAdshTvhH7PfixMGR7Vt4e7criUtwDKNDXHpgKJ2Xfo6UZJU
         rSq/6KCU5+N21DrJSQoNGVcx94HqKccPrnZ1uWEl/V8GjHymmPWOiX3nrxWrblSKz1gv
         maQw==
X-Gm-Message-State: ANhLgQ3zi1XM7elWGrnlsx7M0HzS2NmNn/xK39aJpnRCxhbpvcnEEGhJ
        g1OQWxw2Lrr6msyqop0J0NTQVrWJBVq1gALf5jpJ0A==
X-Google-Smtp-Source: ADFU+vuqKa+1dB5LwOkOFlUD1HfVLJbddY8m0xV1AYkY/R0nNZNF4n9+sXL4owZqbuvt4CBfqK98wb2x3Wb19Q2XChM=
X-Received: by 2002:a5d:46ca:: with SMTP id g10mr15797736wrs.290.1585594672130;
 Mon, 30 Mar 2020 11:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
 <20200319164227.87419-4-trishalfonso@google.com> <CACT4Y+YHPfP3LP04=Zc4NgyhH8FMJ9m-eU_VPjmk5SmGWo_fTg@mail.gmail.com>
 <CAKFsvU+N=8=VmKVdNdf6os26z+vVD=vR=TL5GJtLQhR9FxOJUQ@mail.gmail.com>
 <CACT4Y+ZGcZhbkcAVVfKP1gUs7mg=LrSwBqhqpUozSX8Fof6ANA@mail.gmail.com>
 <CAKFsvUK-9QU7SfKLoL0w75VgSOneO8DWciHTDYMfU8aD98Unbw@mail.gmail.com> <CACT4Y+ZhraraMNC+uvD9O7h3wMQntiEu5zSmVd_UYEaqvdxTaA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZhraraMNC+uvD9O7h3wMQntiEu5zSmVd_UYEaqvdxTaA@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Mon, 30 Mar 2020 11:57:39 -0700
Message-ID: <CAKFsvUKaeHnHp0Y9BUiB=RRHLd0TNoEA99VaUZVyfrQy8ptTqA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] KASAN: Port KASAN Tests to KUnit
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Thu, Mar 26, 2020 at 10:31 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Mar 26, 2020 at 4:15 PM Patricia Alfonso
> <trishalfonso@google.com> wrote:
> > > > > <kasan-dev@googlegroups.com> wrote:
> > > > > >
> > > > > > Transfer all previous tests for KASAN to KUnit so they can be r=
un
> > > > > > more easily. Using kunit_tool, developers can run these tests w=
ith their
> > > > > > other KUnit tests and see "pass" or "fail" with the appropriate=
 KASAN
> > > > > > report instead of needing to parse each KASAN report to test KA=
SAN
> > > > > > functionalities. All KASAN reports are still printed to dmesg.
> > > > > >
> > > > > > Stack tests do not work in UML so those tests are protected ins=
ide an
> > > > > > "#if IS_ENABLED(CONFIG_KASAN_STACK)" so this only runs if stack
> > > > > > instrumentation is enabled.
> > > > > >
> > > > > > copy_user_test cannot be run in KUnit so there is a separate te=
st file
> > > > > > for those tests, which can be run as before as a module.
> > > > >
> > > > > Hi Patricia,
> > > > >
> > > > > FWIW I've got some conflicts applying this patch on latest linux-=
next
> > > > > next-20200324. There are some changes to the tests in mm tree I t=
hink.
> > > > >
> > > > > Which tree will this go through? I would be nice to resolve these
> > > > > conflicts somehow, but I am not sure how. Maybe the kasan tests
> > > > > changes are merged upstream next windows, and then rebase this?
> > > > >
> > > > > Also, how can I apply this for testing? I assume this is based on=
 some
> > > > > kunit branch? which one?
> > > > >
> > > > Hmm... okay, that sounds like a problem. I will have to look into t=
he
> > > > conflicts. I'm not sure which tree this will go through upstream; I
> > > > expect someone will tell me which is best when the time comes. This=
 is
> > > > based on the kunit branch in the kunit documentation here:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselfte=
st.git/log/?h=3Dkunit
> > >
> > > I've checked out:
> > >
> > > commit 0476e69f39377192d638c459d11400c6e9a6ffb0 (HEAD, kselftest/kuni=
t)
> > > Date:   Mon Mar 23 12:04:59 2020 -0700
> > >
> > > But the build still fails for me:
> > >
> > > mm/kasan/report.c: In function =E2=80=98kasan_update_kunit_status=E2=
=80=99:
> > > mm/kasan/report.c:466:6: error: implicit declaration of function
> > > =E2=80=98kunit_find_named_resource=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declar]
> > >   466 |  if (kunit_find_named_resource(cur_test, "kasan_data")) {
> > >       |      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > mm/kasan/report.c:467:12: warning: assignment to =E2=80=98struct
> > > kunit_resource *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer fr=
om integer without a cas]
> > >   467 |   resource =3D kunit_find_named_resource(cur_test, "kasan_dat=
a");
> > >       |            ^
> > > mm/kasan/report.c:468:24: error: =E2=80=98struct kunit_resource=E2=80=
=99 has no member
> > > named =E2=80=98data=E2=80=99
> > >   468 |   kasan_data =3D resource->data;
> > >       |                        ^~
> > >
> > > What am I doing wrong?
> >
> > This patchset relies on another RFC patchset from Alan:
> > https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-ema=
il-alan.maguire@oracle.com/T/#t
> >
> > I thought I linked it in the commit message but it may only be in the
> > commit message for part 2/3. It should work with Alan's patchset, but
> > let me know if you have any trouble.
>
> Please push your state of code to some git repository, so that I can
> pull it. Github or gerrit or whatever.

Here's a Gerrit link: https://kunit-review.googlesource.com/c/linux/+/3513

--=20
Best,
Patricia Alfonso
