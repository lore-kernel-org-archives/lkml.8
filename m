Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC4FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 11:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2982F207D3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 11:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="r3/9LGFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgEQLR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 07:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgEQLR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 07:17:58 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E594C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 04:17:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b91so5993030edf.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4+u2L05qamryNPAo2T4bzOw/jmfe9BMj+ubXlFIP3M=;
        b=r3/9LGFiYPgwjcwX6d1PLqCTLUBo9OdlxmUFn1astZTDgXFVIOQPcFGV6gDJVgO9Yc
         g/U7d6pS4ayuWtjYbz4YbamZqxVRupQ7iJkTa7uDCYoXOzqonderuwAURCVreToE1SUo
         Dv3B+yX4s3fvWOWBSqAKZiXZcBA1NWHB0EUmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4+u2L05qamryNPAo2T4bzOw/jmfe9BMj+ubXlFIP3M=;
        b=FB8BkPIDSRjZV0KHGwXmrPwMgxrm3MucZ2vCW4CJI6s0Fk+PoTpHqvpjOrmYDxH4x3
         lQqQ2yWf0VD9nc2YSaAj+GyoSdl9nN0iU4pA3g2lGtdHSw1JIeKGbA0ca7lTvn/om2QY
         x3onhXoscAzE5ZbvB8CSzuPDnRQy7jAva94i07sTpSqg2l/v/WscBne7dy5rD3O7WXuc
         +hioIOkdTEwm8UWENBy31vWL9rs+neG4SwUG8orgg+/GcXvK5ED8jyrL3nv5eaF/8D3g
         QoLFMbxo+ISnw+TthkqxeV2nBiwCs4G8052oRAwhB42cUsz/XgnZ3D0cC+kdnVFoOFcR
         K4IQ==
X-Gm-Message-State: AOAM533qlQ7kOkcKsfIFLn/1Wxi10MJnr6fK/dI4RkjbPkZYJsBZwy4w
        dAdn9/H4N3zIQY/Mtiks0WzloGbsXkn4I5KJ1OVA6g==
X-Google-Smtp-Source: ABdhPJySir2IEf/xIHAzDY5chi9uwUVmvi9gPyjR+LEZtW4loF25ecwGZN6Jzv+7FB2NgAj6AGF5k+olpj0lnUZ1PL8=
X-Received: by 2002:aa7:c617:: with SMTP id h23mr8804881edq.305.1589714275547;
 Sun, 17 May 2020 04:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234005.32370-1-sargun@sargun.me> <202005162344.74A02C2D@keescook>
In-Reply-To: <202005162344.74A02C2D@keescook>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sun, 17 May 2020 04:17:19 -0700
Message-ID: <CAMp4zn-Ak0062t9HfMMZvKNv1+EAujgEeg5c4-gtjD-pAGAtTw@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 12:17 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 15, 2020 at 04:40:05PM -0700, Sargun Dhillon wrote:
> > This includes the thread group leader ID in the seccomp_notif. This is
> > immediately useful for opening up a pidfd for the group leader, as
> > pidfds only work on group leaders.
> >
> > Previously, it was considered to include an actual pidfd in the
> > seccomp_notif structure[1], but it was suggested to avoid proliferating
> > mechanisms to create pidfds[2].
> >
> > [1]: https://lkml.org/lkml/2020/1/24/133
> > [2]: https://lkml.org/lkml/2020/5/15/481
>
> nit: please use lore.kernel.org/lkml/ URLs
>
> > Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > ---
> >  include/uapi/linux/seccomp.h                  |  2 +
> >  kernel/seccomp.c                              |  1 +
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 50 +++++++++++++++++++
> >  3 files changed, 53 insertions(+)
> >
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> > index c1735455bc53..f0c272ef0f1e 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -75,6 +75,8 @@ struct seccomp_notif {
> >       __u32 pid;
> >       __u32 flags;
> >       struct seccomp_data data;
> > +     __u32 tgid;
> > +     __u8 pad0[4];
> >  };
>
> I think we need to leave off padding and instead use __packed. If we
> don't then userspace can't tell when "pad0" changes its "meaning" (i.e.
> the size of seccomp_notif becomes 88 bytes with above -- either via
> explicit padding like you've got or via implicit by the compiler. If
> some other u32 gets added in the future, user space will still see "88"
> as the size.
>
I've had previous feedback about using "packed". See:
https://lore.kernel.org/lkml/87o8w9bcaf.fsf@mid.deneb.enyo.de/
https://lore.kernel.org/lkml/a328b91d-fd8f-4f27-b3c2-91a9c45f18c0@rasmusvillemoes.dk/
> So I *think* the right change here is:
>
> -};
> +       __u32 tgid;
> +} __packed;
>
> Though tgid may need to go above seccomp_data... for when it grows.
> Agh...
(How) can seccomp_data grow safely, even with this extensibility mechanism?
>
> _However_, unfortunately, I appear to have no thought this through very
> well, and there is actually no sanity-checking in the kernel for dealing
> with an old userspace when sizes change. :( For example, if a userspace
> doesn't check sizes and calls an ioctl, etc, the kernel will clobber the
> user buffer if it's too small.
>
> Even the SECCOMP_GET_NOTIF_SIZES command lacks a buffer size argument.
> :(
>
> So:
>
> - should we just declare such userspace as "wrong"? I don't think
>   that'll work, especially since what if we ever change the size of
>   seccomp_data...  that predated the ..._SIZES command.
>
> - should we add a SECCOMP_SET_SIZES command to tell the kernel what
>   we're expecting? There's no "state" associated across seccomp(2)
>   calls, but maybe that doesn't matter because only user_notif writes
>   back to userspace. For the ioctl, the state could be part of the
>   private file data? Sending seccomp_data back to userspace only
>   happens here, and any changes in seccomp_data size will just be seen
>   as allowing a filter to query further into it.
Will we ever grow seccomp_data?

I suggest we throw away the _SIZES api, and just introduce RECV2, which sends
back a known, fixed format, and deprecate these dynamically sized uapi
shenanigans.

(Queue RECV3, etc..)

Maybe we do something like perf_event_open, where there's a read_format,
and that's used by the user to determine how big of a response / fields they
want to get?

>
> - should GET_SIZES report "useful" size? (i.e. exclude padding?)
>
> > diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
>
> Yay test updates! :)
>
> > +TEST(user_notification_groupleader)
>
> In my first pass of review I was going to say "can you please also check
> the sizes used by the ioctl?" But that triggered the above size checking
> mess in my mind.
>
> Let me look at this more closely on Monday, and I'll proposed something.
> :P
To summarize my set of ideas:
1. We take the ptrace-style API, where we have a request to get the tgid of
a given request ID (or any new / extensible field)
2. We add a perf_event_open style API, where you have to tell it what fields
to include in the response
3. We introduce RECV2 [through N]
4. We never extend seccomp_data, and just continue to append things to the API
5. We rev the API _once_ and unroll seccomp_data, and make it so that
new members have to be *asked for*, rather than are implicitly
included.
>
> Thanks!
>
> -Kees
>
> --
> Kees Cook
