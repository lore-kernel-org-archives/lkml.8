Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77681C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE2F21556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lm4u8G+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388956AbgFSTcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387907AbgFSTcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:32:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842CEC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:32:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j4so4305764plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6pNECJHvGGo04RDB6FGiFe7cqfTlSabjrTVzSNhffo=;
        b=lm4u8G+6xBJp/u/tfZ6W4QB3eDaPcNn8Gr+lIzoILXOx2Kj/Hqaul6eLUdBPxHefvA
         pQM9K8l0AkbePEk6ovHqqZz3Vj/VJfyaow8VlqOh4t/LGyM9M0/hEUTJ8u4IvTRB+PG/
         MqfJ01qXdUshNEzBMOmwSzfxJRUkxv2yZGURqKLq0ve4wlcgMvIh38xTNPspYLc7j46x
         fqFufjmzMG9s1TJilozY9RswkoLJdhVOIHcE/FbcdzvWHXxjAXUBNVNlfS447YpHtVo2
         sAeRjZe709JcYMSCSdRhvQy6jKEISzJJGsSqy/qt9Z9URlksjllfeJkHfoQebEHBKftn
         sEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6pNECJHvGGo04RDB6FGiFe7cqfTlSabjrTVzSNhffo=;
        b=kWmzaBel/r/rLO6aEqUyB8fzJWdpxH5eJlDJtq7qqL+cB5P+TqHK6aj3M6M9qIpWAO
         UsP7f2o/VZVNYcZr08T2KOjVh860NOytRk4v1hp1gvFGvlGTTD9dRmh/luo4CfMpjWvD
         gBfbwtCp5W9qem/mHEYhwmp7y09ydxSwpb9OUfwsTMBvBlFk+/gtk3QRY0rqW/7dlbZr
         yT2OwLdC/SnNVIFcTjYJnBo8V94AV88q/8kn6MCmJ+BniKlhib4hqiq/649BfVRToXeS
         52xjjkLsJaCz1psuY7+LmyfSdvgTarDN6MtfcA4IOFYuqTKwF4uscuKWbDu5dxNWYo0+
         YTDw==
X-Gm-Message-State: AOAM533kNCAqLFcx97oaIgTg2YcHlx61onIdY9E7OSrucgRfdcjFkn+I
        Xfb7j1Znp33zW4xQso2qh+xNduoHyVEDxYpvXtOj3g==
X-Google-Smtp-Source: ABdhPJwBNNjvabPIUwUBBIl/SSANdgLOh4rsYgRth4Nx2nalMDaHLdz+BV03D2WjF3viQLc98eo52D747Rq5Y6hgkjk=
X-Received: by 2002:a17:902:ea91:: with SMTP id x17mr9554513plb.325.1592595133363;
 Fri, 19 Jun 2020 12:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CABVgOSkrKHs_uWLZ++_fBC_mfe3RgDxmCvnkcyn1P_wjXTV9Og@mail.gmail.com>
 <CY4PR13MB11756803217A9D20456E826FFD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAFd5g458XTDftQAOm-K4Squ5-ZuZnZcFdVUG0JtUWF56cODOVg@mail.gmail.com> <CY4PR13MB1175CB6221D5859AAC9920C6FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
In-Reply-To: <CY4PR13MB1175CB6221D5859AAC9920C6FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 19 Jun 2020 12:32:01 -0700
Message-ID: <CAFd5g44qO4+jE9ZXMM6KFwAFW-56ndV93E-TQbGNeemgkfLg9w@mail.gmail.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     David Gow <davidgow@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 1:37 PM Bird, Tim <Tim.Bird@sony.com> wrote:
>
> > -----Original Message-----
> > From: Brendan Higgins <brendanhiggins@google.com>
> >
> > On Mon, Jun 15, 2020 at 10:34 AM Bird, Tim <Tim.Bird@sony.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: David Gow <davidgow@google.com>
> > > >
> > > > On Thu, Jun 11, 2020 at 2:11 AM Bird, Tim <Tim.Bird@sony.com> wrote:
> > [...]
> > > > KUnit is currently outputting "TAP version 14", as we were hoping some
> > > > of our changes would get into the TAP14 spec. (Any comments, Brendan?)
> > > > Maybe this should end up saying "KTAP version 1" or something?
> > >
> > > I don't know if this will break any existing results parsers or not.
> > > I hesitate to use "TAP version 14", as TAP appears to be a dormant
> > > initiative at the moment, and there's no guarantee that the kernel's
> > > changes will get adopted into an official spec.
> >
> > We were using "TAP version 14" since the "extensions" we are using
> > were all proposed among the TAP people to go into the next version of
> > TAP. Based on discussions among them they seem to like the subtest
> > stuff:
> >
> > https://github.com/TestAnything/testanything.github.io/pull/36
> >
> > Anyway, I can still appreciate that they might change their minds.
> I don't know if there's anyone left around to change their mind.
>
> I have to agree with isaacs (who proposed TAP14 5 years ago),
> that the TAP specification is in a weird state.
>
> https://github.com/TestAnything/testanything.github.io/pull/36#issuecomment-566321633
>
> There have been commits to the github respository by a few different
> people recently (3 commits in the last 9 months).  But there's no body to approve or
> disapprove of a new spec.
>
> >
> > > If we are a strict super-set of TAP, then I suppose we could just
> > > start using TAP version 14, and unilaterally declare that our changes
> > > make a new spec.  But since we don't control the web site this feels
> > > like a hostile takeover.
> >
> > I just thought it was okay because it was already in their proposed
> > TAP14 spec, but yeah, if we just decide amongst ourselves to use it,
> > we should probably do something else.
> >
> > > I'm most comfortable with calling our thing KTAP, and just
> > > referencing TAP as inspiration.  I don't have a strong opinion on
> >
> > I am cool with that.
> I hate forks, but if we do go with declaring our own fork as KTAP,
> then we should probably pull in the TAP14 spec as a starting point.
> Since it has no home other than in a pull request, it seems a bit tentative.
> We may need to put the spec in the kernel source or something.

Yeah, I didn't really want to fork either, but I don't see any other
way around it given the current state of TAP. Seems like if we want an
updated maintained spec that doesn't live in a pull request, then it
is up to us to give it a new home.

> I think we're definitely not doing anything with the yaml blocks at
> the moment (or maybe ever), so there's one big point of departure.

Yeah, seeing that everyone seems amenable to the expectation blocks
that KUnit uses in our version of the spec, I don't see any other
reason to keep YAML, and I agree it is probably the least desirable
thing that they have in the spec. So yeah, I am on board with omitting
YAML from KTAP.

> > > KTAP vs TAP, but I do feel strongly that kselftest and kunit should use the
> > > same version line (if we can get them to use the same conventions).
> >
> > Yeah, I agree: it would be better if there was just one version of
> > (K)TAP in the kernel.
>
> One thing that needs to be rationalized between KUnit and selftest
> is the syntax for subtests.  KUnit follows the TAP14 spec, and starts
> subtests with indented "# Subtest: name of the child test"
> and selftests just indents the output from the child test, so it
> starts with indented "TAP version 13".  One issue I have with the
> TAP14/KUnit approach is that the output from the child is different
> depending on whether the test is called in the context of another
> test or not.

I can see (in later emails), why you would say that. On the flip side,
I think that indenting and starting off with "# Subtest: name of the
child test" makes it a lot more readable for a human.

> In KUnit, is it the parent test or the child test that prints out the
> "# Subtest: ..." line?

Short answer: The child test.

Long answer: The answer is complicated. From KUnit's perspective the
"parent test" is always just the collection of all test suites. Right
now there is no loop that runs each test suite; each one is a
late_initcall. However, that is something that we are working on
fixing (I really need to get the next version of that patchset out).

Cheers
