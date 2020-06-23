Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B55EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EC220702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3UM5mS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389879AbgFWVTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393445AbgFWVSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:18:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C57C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:18:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so9674809plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJWzvNZU1DMsijzcM8pSgSd+l6gBq4CZTTDgQGADwPk=;
        b=d3UM5mS3Lwn1zCoUYBgL4MOdtaGDbpZ45FPQQmIiPWsUMcrblQ5pb3qHERiGLD+POo
         npuxt5fXnoKsGH+DKJAJ+ul8Y6EIbNJlyhdRsgqhAJJVelU3+pcBdfBAZbEE0IALc384
         HvWlGLE8Lxqn759AEnWNmPzbSamSO0pLN7FZSwLXeXqyRZnZlzI1T+dLxqjN669bHpfc
         4PUyBqpVX/KHW0QckUDmH8mwi2foQLWmoCOCWIHp9tf3Vad3W1LL3blo7BhXrgl1U32a
         ZjXCghkz45tieXrFU8exdMXC0j/7LeiqFZ1w/Xc8XlOUWq/TprLg9rEQAMqc44FXv3Xc
         rFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJWzvNZU1DMsijzcM8pSgSd+l6gBq4CZTTDgQGADwPk=;
        b=ED+ce+h2FL1cBUY4SAMFta5qdZcNx9QPC4RNCP+/ADSnkQjkMWJKWVdJv+T8Vi8csG
         h0rQBbhB+txVRg1C+OETm21UUMrp6M/I9xWnbDV6owuYM7V7SkIh8+oLFW1dq/yyCjBU
         MiV2HObC9WDUBkBPmO6VSV+LqJeo8gbgYU1aikd8MXQcV/FLcvuni8M3uG7BM6gHTXyi
         2JfIaidu4GbDtGCjZt3H5qWK0u8nnly5djtQDKnPkILSWATeQe8U51tbV7vrM0YESk1B
         piPTyqJFk7xlpexb1FsWxKtovffPuoHaruvdVORtBGe+1+FgwyiK/6xNkiKzRTcpJWDM
         NAfw==
X-Gm-Message-State: AOAM5338XhEkP6O0ri0m/d0lmvTQ9Lo76qcA1e7zMa65vTqrszsGcyGN
        ykOvX/rlZC1z3EQobDlMWh/pDeSP4RTZNLPajzzqoA==
X-Google-Smtp-Source: ABdhPJxLAk9Ot+Z5BtINKEITMd+CQ0dUpAGNCdMnfGs22621xhkUMbtlO0eW9G4/rU2unSlLcfsNUito8iq6hb4/NFI=
X-Received: by 2002:a17:902:32d:: with SMTP id 42mr15721221pld.297.1592947128738;
 Tue, 23 Jun 2020 14:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <d38bf9f9-8a39-87a6-8ce7-d37e4a641675@gmail.com> <CABVgOSkwZUAEjxrqO46kqj=uY5HDzr-E_LR9i04yXEKqjp91Og@mail.gmail.com>
In-Reply-To: <CABVgOSkwZUAEjxrqO46kqj=uY5HDzr-E_LR9i04yXEKqjp91Og@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 23 Jun 2020 14:18:37 -0700
Message-ID: <CAFd5g44+cUBhbHCx7dGk_dyn0Ph7U8dpaBzESWRi6L6qQizbFQ@mail.gmail.com>
Subject: Re: RFC: KTAP documentation - expected messages
To:     David Gow <davidgow@google.com>, Dmitry Vyukov <dvyukov@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 7:47 PM David Gow <davidgow@google.com> wrote:
>
> On Mon, Jun 22, 2020 at 6:45 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > Tim Bird started a thread [1] proposing that he document the selftest result
> > format used by Linux kernel tests.
> >
> > [1] https://lore.kernel.org/r/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com
> >
> > The issue of messages generated by the kernel being tested (that are not
> > messages directly created by the tests, but are instead triggered as a
> > side effect of the test) came up.  In this thread, I will call these
> > messages "expected messages".  Instead of sidetracking that thread with
> > a proposal to handle expected messages, I am starting this new thread.
>
> Thanks for doing this: I think there are quite a few tests which could
> benefit from something like this.
>
> I think there were actually two separate questions: what do we do with
> unexpected messages (most of which I expect are useless, but some of
> which may end up being related to an unexpected test failure), and how
> to have tests "expect" a particular message to appear. I'll stick to
> talking about the latter for this thread, but even there there's two
> possible interpretations of "expected messages" we probably want to
> explicitly distinguish between: a message which must be present for
> the test to pass (which I think best fits the "expected message"
> name), and a message which the test is likely to produce, but which
> shouldn't alter the result (an "ignored message"). I don't see much
> use for the latter at present, but if we wanted to do more things with
> messages and had some otherwise very verbose tests, it could
> potentially be useful.

+Dmitry Vyukov, I think you were interested in this for KASAN before
we went with the signalling approach. Any thoughts?

> The other thing I'd note here is that this proposal seems to be doing
> all of the actual message filtering in userspace, which makes a lot of
> sense for kselftest tests, but does mean that the kernel can't know if
> the test has passed or failed. There's definitely a tradeoff between
> trying to put too much needless string parsing in the kernel and
> having to have a userland tool determine the test results. The
> proposed KCSAN test suite[1] is using tracepoints to do this in the
> kernel. It's not the cleanest thing, but there's no reason KUnit or
> similar couldn't implement a nicer API around it.
>
> [1]: https://lkml.org/lkml/2020/6/22/1506
>
> > I implemented an API for expected messages that are triggered by tests
> > in the Devicetree unittest code, with the expectation that the specific
> > details may change when the Devicetree unittest code adapts the KUnit
> > API.  It seems appropriate to incorporate the concept of expected
> > messages in Tim's documentation instead of waiting to address the
> > subject when the Devicetree unittest code adapts the KUnit API, since
> > Tim's document may become the kernel selftest standard.
>
> Is having a nice way to handle expected messages the only thing
> holding up porting this to KUnit?
>
> > Instead of creating a very long email containing multiple objects,
> > I will reply to this email with a separate reply for each of:
> >
> >   The "expected messages" API implemention and use can be from
> >   drivers/of/unittest.c in the mainline kernel.
> >
> >   of_unittest_expect - A proof of concept perl program to filter console
> >                        output containing expected messages output
> >
> >                        of_unittest_expect is also available by cloning
> >                        https://github.com/frowand/dt_tools.git
> >
> >   An example raw console output with timestamps and expect messages.
> >
> >   An example of console output processed by filter program
> >   of_unittest_expect to be more human readable.  The expected
> >   messages are not removed, but are flagged.
> >
> >   An example of console output processed by filter program
> >   of_unittest_expect to be more human readable.  The expected
> >   messages are removed instead of being flagged.
>
> Cheers,
> -- David
