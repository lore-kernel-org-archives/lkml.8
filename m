Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA70C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B46420757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isI3J18W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgD2Sdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Sdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:33:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA2C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:33:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so3723453ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cir/lv0gr0jqM/9RAZTjqohFxMF8rxZT7xpH/V9tx08=;
        b=isI3J18WjpIGZO4EXpJhkASI5rqAKW4KQeH7U6lgW2hDd71iIRmx579BvS8WKq5wit
         ebHIJbs3dginlnOGzEEUmHreOZITcmFxtsu81uL7od9yLYAZNfYj/a0f7Rp7X0goJ8OC
         hUa+fZtmO/xxg60NMMjDnUFhUglozu3dIHPLUTtt8JrLx1aSmwre3S5s88HWRqTZn8XI
         G8WEkD2YV3eHdmEZC6DKfCv09PuFykTpuWi2e1FttPMu/kIpZ3Vu+jL8h2E+0NCmik0r
         IlCztZC/HZk0MNEiBJRYIoylrFd8dfFJigXEoIBI8DEVBmkp/9FE+zo6aHbHvDvrYAhO
         U6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cir/lv0gr0jqM/9RAZTjqohFxMF8rxZT7xpH/V9tx08=;
        b=aMJZCVhpGTL3xBhdgDKa2+IQ+IpqJ530+5LAXko03PfRBjbAfnzdv8A8BCIoTzedkj
         Wm9MdpEKDsazqBQJdZV6FBs6EAJP/BigNT09rf96Af1/oXsN9dfGUEEusRWEFB5ls+Bo
         0PWzSb+60IKkwrBVWpJRftxVPnIDILDolE2OdpxtGWMqe7RZAfzdD6CAspCqsWlOzfjo
         Wk3Le+EuRzgMy3I8ltrNeBTG0q/EjgloMLIhcZAh/JzplMvgvvq0OhEmvpRqvDowWyXV
         d4ppJev/t/8wvJQuRU447mcAK2+NGyACmfvglU1EGXxKSyQ/WlDi3HIMIgjH1yr+AD0p
         R2rQ==
X-Gm-Message-State: AGi0Pua0VOSewX5Ed0EROlIft+LB3EJXwTEJdUY/hlslg2DkraxNjl+r
        qpwclwEVmDveBHClpcfOnOfSUNufBZP1iYi038uznA==
X-Google-Smtp-Source: APiQypK7H+WNjl7MgV9H6VpCJ21cqNs0D1HA8YsqIg1WUfIpRmpzTfDFiRtqZQtTY6pGPn7Q0vQyNa18W8Hr28IJUFM=
X-Received: by 2002:a2e:8999:: with SMTP id c25mr22226153lji.73.1588185222389;
 Wed, 29 Apr 2020 11:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com> <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com> <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
In-Reply-To: <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 Apr 2020 20:33:14 +0200
Message-ID: <CAG48ez06PwxJ5ysTapByKnm6O0ifJv8Py2Ln0ypZZCwdxTU9zw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 7:58 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 28, 2020 at 4:36 PM Jann Horn <jannh@google.com> wrote:
> >
> > On Wed, Apr 29, 2020 at 12:14 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > >  - we move check_unsafe_exec() down. As far as I can tell, there's no
> > > reason it's that early - the flags it sets aren't actually used until
> > > when we actually do that final set_creds..
> >
> > Right, we should be able to do that stuff quite a bit later than it happens now.
>
> Actually, looking at it, this looks painful for multiple reasons.
>
> The LSM_UNSAFE_xyz flags are used by security_bprm_set_creds(), which
> when I traced it through, happened much earlier than I thought. Making
> things worse, it's done by prepare_binprm(), which also potentially
> gets called from random points by the low-level binfmt handlers too.

Yeah, but all of that happens before we actually need to do anything
with the accumulated credential information from the prepare_binprm()
calls. We can probably move the unsafe calculation and a new LSM hook
into flush_old_exec(), right before de_thread().

> And we also have that odd "fs->in_exec" flag, which is used by thread
> cloning and io_uring, and I'm not sure what the exact semantics are.

The idea is to ensure that once we're through check_unsafe_exec() and
have computed our LSM_UNSAFE_* flags, another thread that's still
running must not be able to fork() off a child with CLONE_FS, because
having an fs_struct that's shared with anything other than sibling
threads (which will be killed off) is supposed to only be possible if
LSM_UNSAFE_SHARE is set. So:

If check_unsafe_exec() can match each reference in the refcount
->fs->users with a reference from a sibling thread (iow the fs_struct
is not currently shared with another task), it sets p->fs->in_exec.

If another thread tries to clone(CLONE_FS) while we're in execve(),
copy_fs() will throw -EAGAIN. And if io_uring tries to grab a
reference to the fs_struct with the intent to use it on a kernel
worker thread (which conceptually is kinda similar to the
clone(CLONE_FS) case), that also aborts.

And then at the end of execve(), we clear the ->fs->in_exec flag again.

So this should work fine as long as we ensure that we can't have two
threads from the same process going through execve concurrently. (Or
if we actually want to support that, we could make ->in_exec a counter
instead of a flag, but really, preventing concurrent execve()s from a
multithreaded process seems saner...)

> I'm _almost_ inclined to say that we should just abort the execve()
> entirely if somebody tries to attach in the middle.
>
> IOW, get rid of the locking, and replace it all just with a sequence
> count. Make execve() abort if the sequence count has changed between
> loading the original creds, and having installed the new creds.
>
> You can ptrace _over_ an execve, and you can ptrace _after_ an
> execve(), but trying to attach just as we execve() would just cause
> the execve() to fail.
>
> We could maybe make it conditional on the credentials actually having
> changed at all (set another flag in bprm_fill_uid()). So it would only
> fail for the suid exec case.
>
> Because honestly, trying to ptrace in the middle of a suid execve()
> sounds like an attack, not a useful thing.
>
> That sequence count approach would be a much simpler change.

In that model, what should happen if someone tries to attach to a
process that's in execve(), but after the point of no return in
de_thread()? "Abort" after the point of no return normally means
force_sigsegv(), right?
