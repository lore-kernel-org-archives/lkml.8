Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48E8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A786120936
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598561217;
	bh=/SAmc1652cUaNhfPFMabZ9kEIl7VLeh3KNE8K96zKfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MPpLkV974ly3C1KFr3oXfcYSRppSRWZ/euokd72ze48blYlPDqTbD/VASoxJtJGDg
	 vboJTHKWZajRTP7xHJr3bbdDmBMLUjc64bZy8rL97n/PEiPHXH88PqJ/IqiMRwq7G/
	 nueXInY7mquhpXBFViiesHfU8WtVcmtOzJW+KNZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgH0Uqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0Uqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 16:46:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74E7C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:46:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t23so7977461ljc.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uJmaIn37p4OsHSX2KGyckphesZwRqBisQT5i+At1Vw=;
        b=K/zPWkpW8FLizgMpgClAwYsZa9jXw8xbooOwDofoj3HtVBdFqK2GUbU3gubX/GMfAh
         1xvsFKqOAQYQbrHx19wzczN5NZsHiXTREternXldFhy/FYN1lLfpGM7vblHktRtvKepn
         Qjj1zvtPNyp//T4BoDD6BZgM40Ygz4+r+jNvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uJmaIn37p4OsHSX2KGyckphesZwRqBisQT5i+At1Vw=;
        b=HQR9j5HMTEO51v5Xx5hF9PtJlH+Ja0ZPEtZ/2YUJ0lqhWpiToap2b/r0bR8JTHKg0M
         07968y/ogrg/xT91/LzFG3i3ZRi2N7hMZ6KS/huj4Zgmp43HDepesrkDdzMtFZPSmzHz
         21z3yFz+fXmU6IRMlCAFfzBpDz0/cbqRuqFI4+nB3k4Ct7U9cwuGPffyGVQreaSqXHf9
         xBt47aOuXYyS4xN3umv68+WUoCZKw9yV71HAqs5Jbhk77zNrk+6HU01xezqkw08vWQ/T
         qfVMzFAUMi24VFwaa5+hGc+j2oWtPgdsdF97uiCRgOn9uv8q5gyOcWJuv2znRJQu6xqN
         lYPw==
X-Gm-Message-State: AOAM5322dzqIcDHWOLTFS0aNZsbyD4P4IH5P2fz+7S9oJthEfspeRge6
        Dbh1dIeMLmuLSaplCZ8V8TFYA+CpdjSjCA==
X-Google-Smtp-Source: ABdhPJw502oNUVd2FM5MNfRBwQOfaHYsW3Y4HCxfY+cb6PhsAb+JHTjfvan5uyGxu+24yZa1wE6/Dg==
X-Received: by 2002:a2e:854b:: with SMTP id u11mr9767332ljj.55.1598561211267;
        Thu, 27 Aug 2020 13:46:51 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id r1sm771432lfc.44.2020.08.27.13.46.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 13:46:50 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id t6so7953884ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:46:50 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr11358453ljp.312.1598561209673;
 Thu, 27 Aug 2020 13:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200827013636.149307-1-allen.lkml@gmail.com> <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
 <1598553133.4237.8.camel@HansenPartnership.com> <CAHk-=wi8o+FvfQkUiH_2MUs3J19FzfMzumOViAJ2aboGg9qY7Q@mail.gmail.com>
 <CAHk-=wingJWToQfoc+m2am7Q=7r8XD+6p0FXasCRAzOdcRyngw@mail.gmail.com> <202008271150.7231B901@keescook>
In-Reply-To: <202008271150.7231B901@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 13:46:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDhHWQo_QjZp36=x=GLMGOJ2xnfsUk9xkUuWRz=i9gOg@mail.gmail.com>
Message-ID: <CAHk-=whDhHWQo_QjZp36=x=GLMGOJ2xnfsUk9xkUuWRz=i9gOg@mail.gmail.com>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
To:     Kees Cook <keescook@chromium.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:28 PM Kees Cook <keescook@chromium.org> wrote:
>
> The common raw pattern for callbacks is:
>
> void callback(struct callback_handle *inner)
> {
>         struct outer *instance;
>         ...
>         instance = container_of(inner, struct outer, member_name_of_inner);
>
> There's so much redundancy here.

What?

It's not all that complicated or even particularly redundant. The main
redundancy comes from you splitting up the declaration from the
initialization - which is certainly fine, and often a good idea, but
it does mean that you mention "struct outer" and "instance" twice.

I don't see that kind of redundancy being a _problem_, though. "So
much redundancy" is just over-stating the issue completely.

In fact, we often encourage people to split declaration from
initialization exactly because it results in simpler expressions and
more legible code, even if that name is now redundant. So it's a small
extra typing of the type. Big deal.

The above is also a common pattern that once you know how
container_of() works, it's very legible.

Sure, if you're new to the kernel, and haven't seen "container_of()"
in other projects, it might initially be a bit of an odd pattern, but
that's the advantage of having one single standardized model: it
becomes a pattern, and you don't have to think about it.

And particularly with that argument-type pattern, you really have to
work at making over-long lines, since the indentation level will by
definition be just one.

Looking around, I do see a lot of people doing line-breaks, but that
tends to be when they insist on putting the variable initialization in
the declaration. And even then, it often seems pointless (eg

        struct idp_led *led = container_of(cdev,
                        struct idp_led, cdev);

was split for no good reason I can see, but it seems to be a pattern
in that file).

You really have to pick some pretty excessive type names (or variable
names) to get close to 80 characters. Again, to pick an example:

        struct timer_group_priv *priv = container_of(handle,
                        struct timer_group_priv, timer[handle->num]);

ends up being long even if you were to split it, but that funky
container_from() wouldn't have helped the real problem - the fact that
the above is complex and nasty.

And I had to _search_ for that example. All the normal cases of
split-line container-of's were due to doing it with the declaration,
or beause the first argument ended up being an expression in itself
and the nested expressions made it more complex.

And in the above example, the real complexity - and the reason the
line ends up long - is because the "member" isn't a member. The above
case works - and it's in fact *intended* to work, I'm not claiming
it's some mis-use of the macro.  But it's really a rather complex
case, where it would probably have been a good idea to add a comment
about how this really depends on handle->num being set correctly.

And in fact, it would probably have been a *perfect* example of where
a helper function really would have improved the code, not so much
from a line length perspective, but exactly because the above is a
much more complicated case than most container_of() cases are.

So a helper function like the kvm one I quoted would have been a good
idea. In ways that "container_from()" would not have been, since it
doesn't actually even address the source of complexity.

               Linus
