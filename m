Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5FDC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1010F2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgnMuiRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgD1Xgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726042AbgD1Xge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:36:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FADC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:36:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b2so694127ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPTJAggZAL1TiwwVFVyMYLHNuYPJ/mQJGZs0N9OslBs=;
        b=rgnMuiRzRZtqdkY9jOFy9ihQ+WcyjO/1g0sOBV1L5MtgqI3GzlQiolLZuRkhff703L
         eZKLhwO2WRX+Uoc51UPjbNQiuz7Iq5V3Zu3gBM6hoPuAeUf+lBvXnUtcz/j9RnQ+dJXI
         +fKiIo1MUrCgsV1FLr5MG0IJiqdHEngjNA1KFrlb8zlTSMni5x66nepRDrdJVxNxvclr
         FDL6KosnpRmBC3HvROkp1eLgvf6DZYy5Y3pZPrhiLTjCLeSs0R95WchbohnKnApp/aaM
         T9STxJuw2R53Ji38DvPXJkTHOFLGRixCraEvVCKZKsoRP2oNbEetvrkODK8+Iu2cWVhs
         nOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPTJAggZAL1TiwwVFVyMYLHNuYPJ/mQJGZs0N9OslBs=;
        b=m3/yeL5ny5cyXybRWXAKiJ4DhZq/GDZaM6g3jHvnbFmNgRoN/tBH9eMYC8pNwigfDd
         HUqSQ+pjHGPmo2c3Sdt/3E9G9rYZASOLbkxnF+9YQxVQ+NVxEtjcZB59lSjlHr3rYjsl
         +teAoRKIL7D0tyoFnQoArpJLOKKL9CL96GZBPlnT9K/GeScDn9nNVQKgWaWI1HRpovwj
         ozPm8LJSaXP+2KKOoFY+bNr0kbHom1zN6rkYs609lsUEOIMj8H27iBzSXtamSf09fBKH
         rY0lc+Ue7DAiPIJQoLtpDVpc1cdobrX+iIuD4meOlvywycVgV2/wIFF6L0j9s6ONfYLE
         dNPQ==
X-Gm-Message-State: AGi0Pua7n0hp9wuvYy5ijF0pogbLx/7I5Je8WxnBx9ii6ZOnecSFLxJo
        D0Vsml3DSA6vqZ73CdPGd6tbgfh02qV7OEUHPvK6qM2lPoWATg==
X-Google-Smtp-Source: APiQypLZ45crD/0hJ9haG4wjQH1ZS7COdjQToHrAsIJocxq3FbLkNwlF1C43CBytmHF8KRhNDolfnx4UEAbBXn+GVsY=
X-Received: by 2002:a2e:760c:: with SMTP id r12mr18502857ljc.139.1588116992515;
 Tue, 28 Apr 2020 16:36:32 -0700 (PDT)
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
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com> <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
In-Reply-To: <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 Apr 2020 01:36:05 +0200
Message-ID: <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
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

On Wed, Apr 29, 2020 at 12:14 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 28, 2020 at 2:53 PM Jann Horn <jannh@google.com> wrote:
> >
> > You don't need LSM_UNSAFE_PTRACE if the tracer has already passed a
> > ptrace_may_access() check against the post-execve creds of the target
> > - that's no different from having done PTRACE_ATTACH after execve is
> > over.
>
> Hmm. That sounds believable, I guess.
>
> But along these ways, I'm starting to think that we might perhaps skip
> the lock entirely.

Just as a note: One effect of that will be that if a process goes into
execve on a setuid binary, but bails out before the point of no
return, a tracer may fail to attach to it during that time window. But
that should be completely fine.

> What if we made the rule instead be:
>
>  - we move check_unsafe_exec() down. As far as I can tell, there's no
> reason it's that early - the flags it sets aren't actually used until
> when we actually do that final set_creds..

Right, we should be able to do that stuff quite a bit later than it happens now.

At the moment the final security_bprm_set_creds() seems to happen
before we're calling would_dump(), which computes some of the data
we'll need for access checks... I guess we'll have to split up
security_bprm_set_creds into one hook for "here's another executable
file that's part of the execve chain" and a second hook
("security_bprm_cred_sync()"?) for "now the ->unsafe flags are ready
and we're about to drop the lock again, time to modify the creds if
you want to do that". And then LSMs can make decisions that are
influenced by ->unsafe (fiddling with the creds or rejecting the
execution - I think e.g. selinux_bprm_set_creds() can do both) inside
the "cred sync point".

>  - we add a "next cred" pointer to the signal struct (or task struct)
>
>  - make the rule be that check_unsafe_exec() checks p->ptrace under
> the tasklist_lock (or sighand lock - whatever ends up being most
> convenient)
>
>  - set "next cred" to be the known next cred there too under the lock.
> We call this small locked region the "cred sync point".
>
>  - ptrace will check if we have the "in_exec" flag set and have one of
> those "next cred" pointers, in which case it checks both the old and
> the next credentials.
>
> No cred_guard_mutex at all, instead the rule is that as execve() goes
> through that "cred sync point", we have two cases
>
>  (a) either ptrace has attached (because task->ptrace is set), and it
> does the LSM_UNSAFE_PTRACE dance.
>
> or
>
>  (b) it knows that ptrace will check the next creds if it races with execve.
>
> And then after execve has installed the final new creds, it just
> clears the "next cred" pointer again, because at that point it knows
> that now any subsequent PTRACE_ATTACH will be checking the new creds.
>
> So instead of taking and dropping the cred_guard_mutex, we'd basically
> get rid of it entirely.
>
> Yeah, I didn't look at the seccomp case, but I guess the issues will be similar.

Yeah, seccomp should be able to reject any thread sync if the "next
cred" pointer is set on any of the threads. It should work well as
long as the lock around the "next cred" pointer is at least on the
level of the signal_struct (or broader), so that TSYNC can decide
whether everything's good before starting to iterate over the threads.
