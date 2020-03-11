Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA57C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929672074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gM/y9MfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbgCKWdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:33:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38755 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731349AbgCKWdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:33:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id h83so511220wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3G5G1ycGcqjr+5+9XmfiHnkfrEJ8jgyfY9rjLHkFkw=;
        b=gM/y9MfWhSnnbm8eeUSasmQXOPlws32nRpKOxYTiGkFzq3ExukIEkdmaPnoFFb+hly
         Edp6/fOWGy1j61w7XjnyjH1XIr5mzwi9mgWMO/08CpAe1+hG3isKsDEhDcckcOwsnsOF
         PYUbHOyDxmEPhKFng1suxUrvzY6MU2VzAhUv+OL9O87ErBDP0pVEc8fPRQbv5tAopIed
         hWiQpv+KEtL+v8CXlOrmccLUJxL27LF2vv7w9hwoB1wvZ7QqwZy49AxpBPt5qkOl5/on
         n+1xF++cKS8oXVEFp3hK69d8Pda0gOSn8pdNHb5SYRp18Yxzg9KC5JeZnBWGgSrsVE1v
         DV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3G5G1ycGcqjr+5+9XmfiHnkfrEJ8jgyfY9rjLHkFkw=;
        b=mXeHst8/nsQV3o39WDsFH3OU0pbR4Y2O4u4vgEgpv9pPINWnWS8A5ujOHgkotbeM+M
         /BxuMJTXMyJdTXx2Z8VJGKedQY9sRC4CgfR7DMt6rdzDuctgs4/HsbdIiIYmnVypBifr
         p8NWQ1eni9QbRIYYEzwp8tYlr6MlKq6d3z/qkcJgIhgang5oQVVC1qe/nh0/U0NkA5sj
         klN45uUS1mJI0fo4Piln9uDYy1AsyyYUm95kFzo+Dqg/kssbDp2NCn8CL7Qjtsfe/siI
         6gRRE+sgtA0npMraJCrSF6gcLuMgyOv7VORLsV/WHNNF8L2L798NE1u7mfL/aGvL/vud
         No9w==
X-Gm-Message-State: ANhLgQ1Wk8h+gRk9szYAFUyFq/kLT7F7DCUqZC0qJxERQkghO3bolxDv
        UZjY0KBwqA+XGVRZDvP0A+i8+b8qgu0LIOuVN0y8OQ==
X-Google-Smtp-Source: ADFU+vsVepM/n20MoHSUwvvubq011fZk6aTVCA/59Pxn4eMwXDh8rmcymmIEBVDyPzyZ71E2hiQs3MUCrwoZ0slywhw=
X-Received: by 2002:a1c:8103:: with SMTP id c3mr837777wmd.166.1583965991033;
 Wed, 11 Mar 2020 15:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com> <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
In-Reply-To: <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Wed, 11 Mar 2020 15:32:59 -0700
Message-ID: <CAKFsvULGSQRx3hL8HgbYbEt_8GOorZj96CoMVhx6sw=xWEwSwA@mail.gmail.com>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 3:32 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi,
>
> > Hi all, I just want to bump this so we can get all the comments while
> > this is still fresh in everyone's minds. I would love if some UML
> > maintainers could give their thoughts!
>
> I'm not the maintainer,
That's okay! I appreciate that you took the time to look at it.

> and I don't know where Richard is, but I just
> tried with the test_kasan.ko module, and that seems to work. Did you
> test that too? I was surprised to see this because you said you didn't
> test modules, but surely this would've been the easiest way?
>
I had not tested with test_kasan.ko. I have been using KUnit to test
KASAN from the beginning so to be completely honest, I hadn't even
learned how to run modules until today.

> Anyway, as expected, stack (and of course alloca) OOB access is not
> detected right now, but otherwise it seems great.
>
Great! Thanks for putting time into this.

> Here's the log:
> https://p.sipsolutions.net/ca9b4157776110fe.txt
>
> I'll repost my module init thing as a proper patch then, I guess.
>
That would be really helpful, thank you!

>
> I do see issues with modules though, e.g.
> https://p.sipsolutions.net/1a2df5f65d885937.txt
>
> where we seem to get some real confusion when lockdep is storing the
> stack trace??
>
> And https://p.sipsolutions.net/9a97e8f68d8d24b7.txt, where something
> convinces ASAN that an address is a user address (it might even be
> right?) and it disallows kernel access to it?
>
>
I'll need some time to investigate these all myself. Having just
gotten my first module to run about an hour ago, any more information
about how you got these errors would be helpful so I can try to
reproduce them on my own.

> Also, do you have any intention to work on the stack later? For me,
> enabling that doesn't even report any issues, it just hangs at 'boot'.
>
I was originally planning on it, but it's not a high priority for me
or my team at this time.

> johannes
>

-- 
Best,
Patricia Alfonso
