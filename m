Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98344C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB54206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpIE4N1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgD2VHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726921AbgD2VG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:06:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF99DC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:06:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b2so4187189ljp.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vAEd4qpGTjTsBxSUDQpX7WNc+9HLuCvKB3PWjQN65+M=;
        b=RpIE4N1FPowHX+ITy8WXaLniD4bN254LFjfzcaiky6gLlMEzTzFXmIOW08lsIwFRPw
         4kAEYwSnqYnpTDaLW26Btj6q97j9n509Tp44iyoRUvHda7BagxRbTeUL2NFKfg7uv9Fu
         WFxQKJYk1EH0u/p4SFcq/xN9BhfK/v+/t7E97m6jWLlHPPg9imS5kvly5P5hGpy+6WBU
         45Ijg29/vaCA5lkdc2NVjZVYuYG8tyupiwMS5DDMXibOdZO+OqTGlY0thGK8qL3u/+YF
         aw1fUNR2wIIYae++uk9LIRxidGdkHuiP1nTZKQhO7MzJTsL3BlSN+hkFafDkxfzSW3cA
         Gfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAEd4qpGTjTsBxSUDQpX7WNc+9HLuCvKB3PWjQN65+M=;
        b=K9oUY+cDPnnGXrUzh0fUkf6WB/LnClFEd8X1FtBOSnQdTwdrvOzhy4JBLxMMKeR0Zz
         Y1s851LWKPGwuWnZ0rBp5PyFdfwcGgCIPXj1YQUz6+LC4/CQdwtwuV6lkFfcQkK3pzrg
         p2r2AzWsa7y1ChNDVerpjzrVrMmlMNq9G9OOfNXuYjd+EbtSB9oJkScC2rImVpPV4EDz
         S3J+xfltzl/AEk+BOGmwJlCS/qeyn2rTvUFB6VjCQFEauUIwhw7P4gw+/wDK0/Gs9t3+
         yeIInNseaSGtIfKQBn4LW/JjzU+xT7540vxKLWYVLeSzRDMJO4ocj6NEaIVaVp5f3GB5
         aRFw==
X-Gm-Message-State: AGi0PubnQ72MTL0VLLA55ikCcSdj2WeDzty8J3DAmacyH5CNE0HuqqBA
        u9c5ESiWX4J7SbSGkejIkRtfFpG3fnFsjmFPrKZRQQ==
X-Google-Smtp-Source: APiQypIZeLfhxO3536/hrbsTHxYDqu69DPxtnXgG9/DKAXgUUhkTelDlXyEn9nV7bWKxkE5EDm3BtlsF46Crqwg8j94=
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr70612ljj.137.1588194413842;
 Wed, 29 Apr 2020 14:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAG48ez07GSXAvqv03-1w=CqedgwmUis5=8oaQsfnFXkPpuN4_g@mail.gmail.com> <AM6PR03MB517073AD67CB8C6518F94436E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB517073AD67CB8C6518F94436E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 Apr 2020 23:06:26 +0200
Message-ID: <CAG48ez1rs1aS2N6tHo3gtsukdFTkSNh01OpiV63WDVG5ZTQr8w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
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

On Wed, Apr 29, 2020 at 10:20 PM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
> On 4/29/20 9:26 PM, Jann Horn wrote:
> > On Wed, Apr 29, 2020 at 9:23 PM Bernd Edlinger
> > <bernd.edlinger@hotmail.de> wrote:
> >> On 4/29/20 7:58 PM, Linus Torvalds wrote:
> >>> On Tue, Apr 28, 2020 at 4:36 PM Jann Horn <jannh@google.com> wrote:
> >>>>
> >>>> On Wed, Apr 29, 2020 at 12:14 AM Linus Torvalds
> >>>> <torvalds@linux-foundation.org> wrote:
> >>>>>
> >>>>>  - we move check_unsafe_exec() down. As far as I can tell, there's no
> >>>>> reason it's that early - the flags it sets aren't actually used until
> >>>>> when we actually do that final set_creds..
> >>>>
> >>>> Right, we should be able to do that stuff quite a bit later than it happens now.
> >>>
> >>> Actually, looking at it, this looks painful for multiple reasons.
> >>>
> >>> The LSM_UNSAFE_xyz flags are used by security_bprm_set_creds(), which
> >>> when I traced it through, happened much earlier than I thought. Making
> >>> things worse, it's done by prepare_binprm(), which also potentially
> >>> gets called from random points by the low-level binfmt handlers too.
> >>>
> >>> And we also have that odd "fs->in_exec" flag, which is used by thread
> >>> cloning and io_uring, and I'm not sure what the exact semantics are.
> >>>
> >>> I'm _almost_ inclined to say that we should just abort the execve()
> >>> entirely if somebody tries to attach in the middle.
> >>>
> >>> IOW, get rid of the locking, and replace it all just with a sequence
> >>> count. Make execve() abort if the sequence count has changed between
> >>> loading the original creds, and having installed the new creds.
> >>>
> >>> You can ptrace _over_ an execve, and you can ptrace _after_ an
> >>> execve(), but trying to attach just as we execve() would just cause
> >>> the execve() to fail.
> >>>
> >>> We could maybe make it conditional on the credentials actually having
> >>> changed at all (set another flag in bprm_fill_uid()). So it would only
> >>> fail for the suid exec case.
> >>>
> >>> Because honestly, trying to ptrace in the middle of a suid execve()
> >>> sounds like an attack, not a useful thing.
> >>>
> >>
> >> I think the use case where a program attaches and detaches many
> >> processes at a high rate, is either an attack or a very aggressive
> >> virus checker, fixing a bug that prevents an attack is not a good
> >> idea, but fixing a bug that would otherwise break a virus checker
> >> would be a good thing.
> >>
> >> By the way, all other attempts to fix it look much more dangerous
> >> than my initially proposed patch, you know the one you hated, but
> >> it does work and does not look overly complicated either.
> >>
> >> What was the reason why that cannot be done this way?
> >
> > I'm not sure which patch you're talking about - I assume you don't
> > mean <https://lore.kernel.org/lkml/AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com/>?
> >
>
> No, I meant:
>
> [PATCH v7 15/16] exec: Fix dead-lock in de_thread with ptrace_attach
> https://marc.info/?l=linux-kernel&m=158559277631548&w=2

(on lore: https://lore.kernel.org/lkml/AM6PR03MB51700577CF9EF4972FDE568AE4CB0@AM6PR03MB5170.eurprd03.prod.outlook.com/)

I mean - I guess that kinda works? It'll mean that attaching to a task
with "strace" as root won't work reliably if the task is in the middle
of execve though, there'll be a weird race where if strace first
attaches to a sibling and then tries to attach to the thread going
through execve(), it'll fail to attach to that thread, and then lose
the process entirely once de_thread() has killed off the other
threads. My perfectionist side is somewhat irked by that.

Still, it's probably far better than Linus' "simpler change" where the
target just gets killed off if someone tries to trace it at the wrong
time.
