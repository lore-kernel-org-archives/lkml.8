Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C3DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B5A2187F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="y88UAVSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgCBNnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:43:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33561 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgCBNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:43:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id c62so11834654edf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6wHBP0VVsRK6PiQUs79yDBoMlD7zs+yQopGmLDQDrQ=;
        b=y88UAVSCD0J+Txl5FpeGa/Z3e+iWNt9Zho2Iwu4hJA8faGpM9ebosIA/VlY63Xh4/G
         mP7pWiA/W9FRdsqoElBYg1G9Gfa7MgkhrXhfHPumX6mjUXyxb1Fk8tZs8RRW0+jvMRJh
         LaMlsozrF0FJrelLTQQ0utYve4/SSh8FfQoPmg8vVG6/VEjQ+kxUEBk0BZPyl/Mur/Ic
         7lLR8xknEqddnEUuPXepX1DYOyMydy5Wu97WdU8sX2IiwSqOmCCrS33DeXrG/dlMW6Sh
         eEXnFc4y9No16kG9Rn3Do/qH28ZOzrGGU1w/bgk0GdeFNWnnOZuqD0NUD7DiN6T4swIT
         apBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6wHBP0VVsRK6PiQUs79yDBoMlD7zs+yQopGmLDQDrQ=;
        b=OeCgqnOPLcM2+syY5pU//UQghUmheaOp1NSGxnaxsJ0XRmp7/dtPqXJJG1/vKiJpRi
         mv9F9fRebx3fGdEKO5KsrUdq5QcDuj08GJR0MA3mtXXKBHKjzvYyNdRQCjDcM8X8SthX
         iEZN7IRT9bKSZB8RJE29/rXk5slWyxAqVDUYT+1ez/JMo3mT+db/0YAG4kAOTG5M6eFC
         3HyIxWy35cBpPrcAKqKcSqv69OCUrHm1gBFZ+XYcHgW40TuclPM3op9hCbb3eElQNxP6
         Ha5fEtilqmKRtetTSRp+h8mTjytgabYFZvMeEjZnhV2JsXdPbMekAigglqUlMk8iQnBa
         i1mQ==
X-Gm-Message-State: APjAAAWA7hFbJAV2XwQuIb3KSUFdjKvwg5gEEDnpuehmSva0A1SpKqTh
        ZPsIpCXZVzZVSjhFAENhf5Trzj3+JG70Ee+SousF
X-Google-Smtp-Source: APXvYqxo7EV7IJM9uJ5Z/Mg+v7MU65Kbb8K1dYVa+2g+mNBd9JKJTgiAz1HafS2Mvw4T/BYButk5U2vqpe+jX9zAnM0=
X-Received: by 2002:a50:e108:: with SMTP id h8mr15496661edl.196.1583156619539;
 Mon, 02 Mar 2020 05:43:39 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003cbb40059f4e0346@google.com> <CAHC9VhQVXk5ucd3=7OC=BxEkZGGLfXv9bESX67Mr-TRmTwxjEg@mail.gmail.com>
 <17916d0509978e14d9a5e9eb52d760fa57460542.camel@redhat.com>
 <CAHC9VhQnbdJprbdTa_XcgUJaiwhzbnGMWJqHczU54UMk0AFCtw@mail.gmail.com>
 <CACT4Y+azQXLcPqtJG9zbj8hxqw4jE3dcwUj5T06bdL3uMaZk+Q@mail.gmail.com>
 <CAHC9VhRRDJzyene2_40nhnxRV_ufgyaU=RrFxYGsnxR4Z_AWWw@mail.gmail.com>
 <55b362f2-9e6b-2121-ad1f-61d34517520b@i-love.sakura.ne.jp>
 <CAHC9VhT51-xezOmy1SM4eP_jFH9A8Tc05wY=cwDg7oC=FgYbYQ@mail.gmail.com> <CACT4Y+YgoyBCoPYxXOb8oQjXYc+Q-cZLPi6y1Yrx_mnfzOQafQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YgoyBCoPYxXOb8oQjXYc+Q-cZLPi6y1Yrx_mnfzOQafQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Mar 2020 08:43:28 -0500
Message-ID: <CAHC9VhTsKCJf8bjOT+cxWZEX1y4c57KcVz0Y2c3vRGnJJQA4pA@mail.gmail.com>
Subject: Re: kernel panic: audit: backlog limit exceeded
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+9a5e789e4725b9ef1316@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 3:47 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Feb 28, 2020 at 2:09 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Feb 28, 2020 at 5:03 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > On 2020/02/28 9:14, Paul Moore wrote:
> > > > We could consider adding a fuzz-friendly build time config which would
> > > > disable the panic failsafe, but it probably isn't worth it at the
> > > > moment considering the syzbot's pid namespace limitations.
> > >
> > > I think adding a fuzz-friendly build time config does worth. For example,
> > > we have locations where printk() emits "BUG:" or "WARNING:" and fuzzer
> > > misunderstands that a crash occurred. PID namespace is irrelevant.
> > > I proposed one at
> > > https://lkml.kernel.org/r/20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp .
> > > I appreciate your response.
> >
> > To be clear, I was talking specifically about the intentional panic in
> > audit_panic().  It is different from every other panic I've ever seen
> > (perhaps there are others?) in that it doesn't indicate a serious
> > error condition in the kernel, it indicates that audit records were
> > dropped.  It seems extreme to most people, but some use cases require
> > that the system panic rather than lose audit records.
> >
> > My suggestion was that we could introduce a Kconfig build flag that
> > syzbot (and other fuzzers) could use to make the AUDIT_FAIL_PANIC case
> > in audit_panic() less panicky.  However, as syzbot isn't currently
> > able to test the kernel's audit code due to it's pid namespace
> > restrictions, it doesn't make much sense to add this capability.  If
> > syzbot removes that restriction, or when we get to the point that we
> > support multiple audit daemons, we can revisit this.
>
> Yes, we need some story for both panic and pid ns.
>
> We also use a separate net ns, but allow fuzzer to create some sockets
> in the init net ns to overcome similar limitations. This is done using
> a pseudo-syscall hack:
> https://github.com/google/syzkaller/blob/4a4e0509de520c7139ca2b5606712cbadc550db2/executor/common_linux.h#L1546-L1562
>
> But the pid ns is different and looks a bit harder as we need it
> during send of netlink messages.
>
> As a strawman proposal: the comment there says "for now":
>
> /* Only support auditd and auditctl in initial pid namespace
>  * for now. */
> if (task_active_pid_ns(current) != &init_pid_ns)
>   return -EPERM;
>
> What does that mean? Is it a kind of TODO? I mean if removing that
> limitation is useful for other reasons, then maybe we could kill 2
> birds with 1 stone.

Long story made short - the audit subsystem doesn't handle namespaces
or containers as well as it should.  Work is ongoing to add the
necessary support, but it isn't there yet and I don't want us to just
start removing restrictions until we have the proper support in place
(this what I alluded to with my "... when we get to the point that we
support multiple audit daemons, we can revisit this").

-- 
paul moore
www.paul-moore.com
