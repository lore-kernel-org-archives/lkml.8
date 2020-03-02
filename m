Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A0C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C17724699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/KNoxaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCBIm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:42:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34437 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCBImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:42:55 -0500
Received: by mail-qk1-f194.google.com with SMTP id 11so9282579qkd.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8aSF5MeqDQUW8YKb8YbsbsupScDDHgnONeFSMF1J5M=;
        b=B/KNoxaQBGiH3PD1NpEzCo1O0oK4E7EK+1S3evPRu02hz84J4NBnPjObI8b1gKqd4p
         c1hs9hOlTU4U3f1nxTLhByHL1nWKv73jKdbN6fOKC1q6atwvoOAxFgV1YWZJm0VoENj0
         z7VBgyGWyTbTRoSkSpLOAe0ZBovE60dzdlycqAbec+ttpuz4989oFrgKBUsRyN7N5ucu
         Bz3PiXGf1+EXZHg+suW1UR8i5GirjuSp2OlsCh54mr8OnXEu5Cmdwb/4NTHwZc7RJ6r+
         oz9RH21mh4B5udlNT2u1CHarVJgtk7XeMmXpmn1yaF8OMCT+6+vdHLMAuBtDs7o6vO0+
         tVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8aSF5MeqDQUW8YKb8YbsbsupScDDHgnONeFSMF1J5M=;
        b=XjWLCngQWpUk8Qib2vCh6GzMsZFsv88ksTDA/BsOKHrwAluU8lfyv2LYpI87FZRd2z
         1FhU0bc3XtZeNMWzhfoCb3+zU68zcqmuuPG5eUcbx/Bey9nTEg9toga/IyOaKmnoX0nY
         4aaKRHSnI5y1aPklAKmy9l64ah+vQztZrOhcTquGRRvLhMsW3qFws1iyBGHdlf71kJmF
         5u+BcMso828sYd+MP1+DBxen3EqS1w4HXGhROieNQEYSFYhJuPwMRPUn29/LyNvXTeNu
         EgQoMr7AJfF+/LWiN6/FGQFftRB8FleSg5kG//G035H+Z3lqj+z1nxwLCPLcWVa8drU3
         nJUA==
X-Gm-Message-State: APjAAAW5DKd0tlx63MOk1Ip+jFvUt+YzXh/jTpISqYOwTlOLxguTehoc
        VFeLhWJt0I2vax0WQOKvi3XdAI6cYVm9P71taTbJ5A==
X-Google-Smtp-Source: APXvYqztcu29n10/zsKgII0AqR3Fc9rw71b3zIoTvJYDp6H3lPYF0NTShZJmpjhfeX5F1NoW+jLeFauy7Qb3dxiFWO0=
X-Received: by 2002:ae9:e003:: with SMTP id m3mr15639507qkk.250.1583138573164;
 Mon, 02 Mar 2020 00:42:53 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003cbb40059f4e0346@google.com> <CAHC9VhQVXk5ucd3=7OC=BxEkZGGLfXv9bESX67Mr-TRmTwxjEg@mail.gmail.com>
 <17916d0509978e14d9a5e9eb52d760fa57460542.camel@redhat.com>
 <CAHC9VhQnbdJprbdTa_XcgUJaiwhzbnGMWJqHczU54UMk0AFCtw@mail.gmail.com>
 <CACT4Y+azQXLcPqtJG9zbj8hxqw4jE3dcwUj5T06bdL3uMaZk+Q@mail.gmail.com> <CAHC9VhRRDJzyene2_40nhnxRV_ufgyaU=RrFxYGsnxR4Z_AWWw@mail.gmail.com>
In-Reply-To: <CAHC9VhRRDJzyene2_40nhnxRV_ufgyaU=RrFxYGsnxR4Z_AWWw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 2 Mar 2020 09:42:41 +0100
Message-ID: <CACT4Y+YkJSLt+-0_wvSHfxi8J1Tn=H-NBeZ+E3h-TAKu53vyqw@mail.gmail.com>
Subject: Re: kernel panic: audit: backlog limit exceeded
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Paris <eparis@redhat.com>,
        syzbot <syzbot+9a5e789e4725b9ef1316@syzkaller.appspotmail.com>,
        a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Miller <davem@davemloft.net>, fzago@cray.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        john.hammond@intel.com, linux-audit@redhat.com,
        LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch,
        netdev <netdev@vger.kernel.org>, sw@simonwunderlich.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 1:14 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Feb 27, 2020 at 10:40 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, Feb 24, 2020 at 11:47 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Feb 24, 2020 at 5:43 PM Eric Paris <eparis@redhat.com> wrote:
> > > > https://syzkaller.appspot.com/x/repro.syz?x=151b1109e00000 (the
> > > > reproducer listed) looks like it is literally fuzzing the AUDIT_SET.
> > > > Which seems like this is working as designed if it is setting the
> > > > failure mode to 2.
> > >
> > > So it is, good catch :)  I saw the panic and instinctively chalked
> > > that up to a mistaken config, not expecting that it was what was being
> > > tested.
> >
> > Yes, this audit failure mode is quite unpleasant for fuzzing. And
> > since this is not a top-level syscall argument value, it's effectively
> > impossible to filter out in the fuzzer. Maybe another use case for the
> > "fuzer lockdown" feature +Tetsuo proposed.
> > With the current state of the things, I think we only have an option
> > to disable fuzzing of audit. Which is pity because it has found 5 or
> > so real bugs in audit too.
> > But this happened anyway because audit is only reachable from init pid
> > namespace and syzkaller always unshares pid namespace for sandboxing
> > reasons, that was removed accidentally and that's how it managed to
> > find the bugs. But the unshare is restored now:
> > https://github.com/google/syzkaller/commit/5e0e1d1450d7c3497338082fc28912fdd7f93a3c
> >
> > As a side effect all other real bugs in audit will be auto-obsoleted
> > in future if not fixed because they will stop happening.
>
> On the plus side, I did submit fixes for the other real audit bugs
> that syzbot found recently and Linus pulled them into the tree today
> so at least we have that small victory.

+1!

> We could consider adding a fuzz-friendly build time config which would
> disable the panic failsafe, but it probably isn't worth it at the
> moment considering the syzbot's pid namespace limitations.
>
> --
> paul moore
> www.paul-moore.com
