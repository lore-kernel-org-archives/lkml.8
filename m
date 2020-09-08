Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB97C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1235421582
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="N1fyX1lR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgIHEei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 00:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgIHEee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 00:34:34 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE9C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 21:34:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so19446321ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 21:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ho/MVOFsxBrf05olerngk+Ij+lPsQ5qotmQ01o79B9w=;
        b=N1fyX1lRw7N73ObUwfhFTrCxmuKBAcdBKEmoPKrml6ogu6kF2pYA34r0KEUvGnlciY
         3eoZrJfgo5DGaPXRVzWRUtizp1JqIYWAwWx6i0YvNmqWpeJpcn2WSbvKyEZqI/TUXtVs
         iLbSQI+T83S1i+MRrDs/zLApFFZLjUuMNHlKNFSKxExlzQduKZSHDkMLKaYq1wHRaQ2G
         SJoJt2NWYFfgu7qg5VtH+1PSQ+udtSDcYxIJKjudfO/W0aWvUv3jHLgJ0sZarR7+rSgJ
         GFjNxoHC/j/kXtXNauJ7BzasvC27bk9VFrLsKT2L+qTsYdMfDGauLhiN9MAmo2Bnnr0C
         8f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ho/MVOFsxBrf05olerngk+Ij+lPsQ5qotmQ01o79B9w=;
        b=druMJkO+hDLJqTA9cA4mTk2Skmm1vhGr0cN4U1AyvuU0AwgkX2wR9s9ByewUeIOxae
         uXDocGMII/+Is3QlohoVekqRBjTwPoVzr2wS42n+ZnMmMPJNzfVPWAvS8UzS9+LqavBE
         wzNCXX0kALwI1IIY0mfJHwuvBQhwO7PS4WzdzJp7adgWjVX6eXyhWpUKYlS3qpQK4FrX
         +ETEQs6I238VdMtekznn7AlXoD+OpuHwTxYhWA/D+dSsbTI4WuGtzfkX1JYTe6hGShlv
         XRtJG2TxWjl5fBIpQUq9H1fvCtR5w7x5B4II7YcoCrKN09mf2ykIT/CfFSBcIyYqRjl+
         3CVQ==
X-Gm-Message-State: AOAM531fn0DZH8NK/HQ4j0hrNwKPC1xju/luenfzd0lDJUxgZDmsBk3q
        gvTOtjW7rwmGPwJDHIq5j8ZynrCjCyvxZn6PN6fUIg==
X-Google-Smtp-Source: ABdhPJyA5FKUSHOOPnu2u3ji2rbHpiyYBsIvePe/RnL/76ALZm5H5Fn2dOOn3ke1q2ldaGT5y27wzJACCwcqqDp4zf8=
X-Received: by 2002:a17:906:a101:: with SMTP id t1mr4446244ejy.203.1599539672420;
 Mon, 07 Sep 2020 21:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200829015609.GA32566@brightrain.aerifal.cx> <202008311228.A0E7430BC@keescook>
In-Reply-To: <202008311228.A0E7430BC@keescook>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 7 Sep 2020 21:34:19 -0700
Message-ID: <CAP045ArTvPPXqW_RcwGw=DvPi5vnP-+_iiE+9Ni7vLcFm-x3_w@mail.gmail.com>
Subject: Re: [PATCH] seccomp: kill process instead of thread for unknown actions
To:     Kees Cook <keescook@chromium.org>
Cc:     Rich Felker <dalias@libc.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 12:37 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Aug 28, 2020 at 09:56:13PM -0400, Rich Felker wrote:
> > Asynchronous termination of a thread outside of the userspace thread
> > library's knowledge is an unsafe operation that leaves the process in
> > an inconsistent, corrupt, and possibly unrecoverable state. In order
> > to make new actions that may be added in the future safe on kernels
> > not aware of them, change the default action from
> > SECCOMP_RET_KILL_THREAD to SECCOMP_RET_KILL_PROCESS.
> >
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > ---
> >
> > This fundamental problem with SECCOMP_RET_KILL_THREAD, and that it
> > should be considered unsafe and deprecated, was recently noted/fixed
> > seccomp in the man page and its example. Here I've only changed the
> > default action for new/unknown action codes. Ideally the behavior for
> > strict seccomp mode would be changed too but I think that breaks
> > stability policy; in any case it's less likely to be an issue since
> > strict mode is hard or impossible to use reasonably in a multithreaded
> > process.
> >
> > Unfortunately changing this now won't help older kernels where unknown
> > new actions would still be handled unsafely, but at least it makes it
> > so the problem will fade away over time.
>
> I think this is probably fine to change now. I'd always wanted to
> "upgrade" the default to KILL_PROCESS, but wanted to wait for
> KILL_PROCESS to exist at all for a while first. :)
>
> I'm not aware of any filter generators (e.g. libseccomp, Chrome) that
> depend on unknown filter return values to cause a KILL_THREAD, and
> everything I've seen indicates that they aren't _accidentally_ depending
> on it either (i.e. they both produce "valid" filters). It's possible
> that something out there doesn't, and in that case, we likely need to
> make a special case for whatever bad filter value it chose, but we can
> cross that bridge when we come to it.
>
> I've added Kyle and Robert to CC as well, as they have noticed subtle
> changes to seccomp behavior in the past. I *think* this change should be
> fine, but perhaps they will see something I don't. :)

I can't think of anything here that would break stuff, though I do
believe rr needs some changes to how it handles this (I don't think
our current behavior is an accurate emulation of the kernel).

- Kyle

> >
> >  kernel/seccomp.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index d653d8426de9..ce1875fa6b39 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -910,10 +910,10 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
> >                       seccomp_init_siginfo(&info, this_syscall, data);
> >                       do_coredump(&info);
> >               }
> > -             if (action == SECCOMP_RET_KILL_PROCESS)
> > -                     do_group_exit(SIGSYS);
> > -             else
> > +             if (action == SECCOMP_RET_KILL_THREAD)
> >                       do_exit(SIGSYS);
> > +             else
> > +                     do_group_exit(SIGSYS);
>
> I need to think a little more, but I suspect we should change the coredump
> logic (above the quoted code) too... (i.e. "action == SECCOMP_RET_KILL_PROCESS"
> -> "action != SECCOMP_RET_KILL_THREAD")
>
> >       }
> >
> >       unreachable();
> > --
> > 2.21.0
> >
>
> Thanks!
>
> -Kees
>
> --
> Kees Cook
