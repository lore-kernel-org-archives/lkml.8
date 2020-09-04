Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0A8C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1579206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIT8ojs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgIDH7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgIDH7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:59:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66134C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 00:59:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k15so2820714pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4sO3K9KUt0lx1jX3LT5Qymn7SNSmjZ7mgkYLWSMNBaA=;
        b=IIT8ojs3Nphf5jUQlNRD+WdyJ7QgPdCDWGeS+Cf9dHwvTtzymqZ5CJfN6cYwvNnzfL
         RZt4TKNYjzspKAP86CMfbqvRCqZyvIsCXJX59+jz8vKOnvZuyYZK2sYmgORS55b/zH6w
         jCut7AyX94mREgkX9hgMWHU3ZArX7DJhi2Br/oDphVk49Dx3j+bwrAikNhvv5XLJ6ZfZ
         pIa5063N+161yywi96AGx/Z8XvbHjbDp40eiLIBm0H7avjGvFjkaLi3EsSMVBVa83XHC
         SOhhVrMZUG0A1cD23H4oS+HIKCrJgv7D0BT2KYJV74W8cB+FA7Xw7dAQqIzBM8TG0IU7
         8/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4sO3K9KUt0lx1jX3LT5Qymn7SNSmjZ7mgkYLWSMNBaA=;
        b=b3wmT0yhEwp6pnyJ8zdq2sPFrG/nSBcil3TSGjvMjyVmIN89f7Oj1jEdFjITfuVuJk
         gPSFZZgL6iHfBT/7NrqLideArocbFFyu8i84bsGkRvEhp+WRk+T1DzEyqSanfxdPtnhA
         poN+DeAzUenSd+E3DMnQjtAwi7FbJgqAoWT6FskRFuPCTvTUMmBYb8I39Mlm9tYSuuxD
         Vynp7g2aYHdFBHg/uauRsYstBP0GaRMYsdT3kqqHwjQs/mq6hjnWlSLvRtkoqo4fdA+P
         1ocjrkv+pze+PZ7fUTKaxx6Is4MKYb2XmMaDNmG86MjmAiU6gL4ctUyph439YnzbmGl0
         mAbg==
X-Gm-Message-State: AOAM533c34nmsHCOzU3RkheDoVfHhEzEY7acSSSLnNNzPD/tIvjiW4Tr
        qrzulia8bT/219h0SLHUvuve65gIzl2PUDPtoOIPnw==
X-Google-Smtp-Source: ABdhPJwcr9ntIJAx1uVoOxLFhbawv85XiwvUMkctNVJ4VlDH49I6YFh6OAIpfBe+5b5h6pqAcSyv6KOQPu/P1CqMTME=
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr7022389pjb.20.1599206381503;
 Fri, 04 Sep 2020 00:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200902180950.4bc7c4de@canb.auug.org.au> <3abfa193-a56e-66ba-1080-885906fa0196@infradead.org>
 <fdf322d4-cc01-2c85-67cd-86b2d6f4ebff@infradead.org>
In-Reply-To: <fdf322d4-cc01-2c85-67cd-86b2d6f4ebff@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 4 Sep 2020 00:59:30 -0700
Message-ID: <CAFd5g44g6OrL3fxQNRZ1rR0PruAty8tBZr8JDzM-oonZJRDZyw@mail.gmail.com>
Subject: Re: linux-next: Tree for Sep 2 (lib/ubsan.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 11:12 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/2/20 8:44 AM, Randy Dunlap wrote:
> > On 9/2/20 1:09 AM, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> Changes since 20200828:
> >>
> >
> >
> > on i386:
> >
> > ../lib/ubsan.c: In function =E2=80=98ubsan_prologue=E2=80=99:
> > ../lib/ubsan.c:141:2: error: implicit declaration of function =E2=80=98=
kunit_fail_current_test=E2=80=99; did you mean =E2=80=98kunit_init_test=E2=
=80=99? [-Werror=3Dimplicit-function-declaration]
> >   kunit_fail_current_test();
> >
> >
> > Full randconfig file is attached.
> >
>
> Hi Brendan,
>
> Do you know anything about this build error?
>
> I can't find kunit_fail_current_test() anywhere.

Yeah, this got applied for some reason without the prerequisite
patches. It is from a two patch series, the other being here:

https://lore.kernel.org/linux-kselftest/20200813205722.1384108-1-urielguaja=
rdojr@gmail.com/

which in turn depends on another patchset which didn't make it into 5.9.

Again, I don't know why this was applied without it's prereqs. Sorry about =
that.
