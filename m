Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E9DC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E95F2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588183115;
	bh=MdxFZeC9lSI4iC70ueh3NmpBDxIWz8CxTIVmPQB8qXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OD280xrOgqXDXwIfQPBJbX4GxRF2uVlg5PbRId3En2NOTMcO3kkI01mRbixlfXU2M
	 lOON+ldp7ZgoYqC9DtN1Le2hj/ZLwMCydOyycXZS0fgPTwv9JykZy2BSYxyWAtAjSF
	 RBniM7W3LZvToL80k2tSIqBxdQrWyWQvp4+SmmbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgD2R6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2R6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:58:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDF7C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:58:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so3621846ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fohD9+nFMXnHZGAk7WijufaPtKOKI6hmvHAYohVrRCI=;
        b=IOIuMB8KVA2CA3zAwNci/S/oMZNaZhM3X/ZPaSDb0dKJ5zlUA6/4BBhdaD7fVWAtz2
         5bvopEKDrgRcsm72D40yhKr/rRESxc02lahrjC+5aZIcaffjtfiTvl0IiqCX4M1V+Vt9
         wyxrtRLuPvSSNE9EggEr7GtOgMUS5CMVN6UzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fohD9+nFMXnHZGAk7WijufaPtKOKI6hmvHAYohVrRCI=;
        b=U9ZsPzEnZNqIcmRXjk1X+nyDvERI6oeXcZft1LF6bb2+7qZ8PfCWKiNbK2KrWNowLi
         Earjas7XxHlF2itarDKgwbOYJ94rznIIXws7T8l9kRVUiTuQCjlyWYoRmyfdYR5MFM9F
         FUwZ6elmO0yqDlYtFUeCl6yMXx78TNZBQM41xUYhtYBPN83HdGimpCpo76L/tbaiA2BJ
         viJIp0FruO3ggqRBURo378WnYBv17fknN4N33Gg+NctqbGZEiIhx4gwqAH5JFSXNKmW7
         l6Ti4eL4+D1gKQO8pJJjlCZkAXHLSoJs9j5EeWaamIig8UsJEiRhMPyx3ikjJdcKg9/o
         MPkA==
X-Gm-Message-State: AGi0PubhE+sFphunP1qWK6JDOfGwE7eoeAcRp9zydRgrbGBpkIoxTE+c
        6nD/WZZ3wpEWSw42ZnPkRzaGBNWYGdg=
X-Google-Smtp-Source: APiQypL2TSD90EPfPWbgFoqgbWsYxwP1YY0KGnQFBFvpU+xt0i5Bg9CSA6j6Y/DSEwYVTmGVCtx06A==
X-Received: by 2002:a2e:8ed0:: with SMTP id e16mr22064323ljl.96.1588183110256;
        Wed, 29 Apr 2020 10:58:30 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t16sm2750649ljg.41.2020.04.29.10.58.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 10:58:29 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id j3so3578436ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:58:29 -0700 (PDT)
X-Received: by 2002:a2e:3017:: with SMTP id w23mr22142434ljw.150.1588183108706;
 Wed, 29 Apr 2020 10:58:28 -0700 (PDT)
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
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com> <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
In-Reply-To: <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 10:58:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
Message-ID: <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Jann Horn <jannh@google.com>
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

On Tue, Apr 28, 2020 at 4:36 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Apr 29, 2020 at 12:14 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >  - we move check_unsafe_exec() down. As far as I can tell, there's no
> > reason it's that early - the flags it sets aren't actually used until
> > when we actually do that final set_creds..
>
> Right, we should be able to do that stuff quite a bit later than it happens now.

Actually, looking at it, this looks painful for multiple reasons.

The LSM_UNSAFE_xyz flags are used by security_bprm_set_creds(), which
when I traced it through, happened much earlier than I thought. Making
things worse, it's done by prepare_binprm(), which also potentially
gets called from random points by the low-level binfmt handlers too.

And we also have that odd "fs->in_exec" flag, which is used by thread
cloning and io_uring, and I'm not sure what the exact semantics are.

I'm _almost_ inclined to say that we should just abort the execve()
entirely if somebody tries to attach in the middle.

IOW, get rid of the locking, and replace it all just with a sequence
count. Make execve() abort if the sequence count has changed between
loading the original creds, and having installed the new creds.

You can ptrace _over_ an execve, and you can ptrace _after_ an
execve(), but trying to attach just as we execve() would just cause
the execve() to fail.

We could maybe make it conditional on the credentials actually having
changed at all (set another flag in bprm_fill_uid()). So it would only
fail for the suid exec case.

Because honestly, trying to ptrace in the middle of a suid execve()
sounds like an attack, not a useful thing.

That sequence count approach would be a much simpler change.

              Linus
