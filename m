Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E20FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FBD20784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzp6usWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCaSjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:39:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34279 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgCaSjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:39:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id l14so3604230pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHbm0jKU3Qf278+OR+FaPiESB5wVrt4XPcJB5hVkN60=;
        b=gzp6usWwaOaYw59h8kIkVvyKdywVJuZ3NJfd1wircVTJnmvJhRmmVES8Jd/uck+Hcj
         ihI+fmLC9r0Fv+rle/XhuJNKG4Dhm3WrAd9b6Gcf22o9h5fjVyDFOPWL42kso1BjM5Ur
         Aq4LNX5vpl4l7pUG4lJYmg9K8myTVDTRz/3Cb/ZLxtzl1N75YXTh7ZwYDQZnWSqTNFQ2
         0UxAU/6LqBe2UKoLTLyqYslEIfZlCWGgoUmL1E1HN9bAfYM2qIEUaUNBIbaIBGOWuojs
         YP2RcDR7MZJsyWmuOefOtp80GgmLixZ4eEUTEQOEyE4nnUkCANBzKbPpgq7dBHmtW9D1
         N1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHbm0jKU3Qf278+OR+FaPiESB5wVrt4XPcJB5hVkN60=;
        b=XODclHaD8Eue349bGJ4BUiCwHx95IHU19r1Sb+RgPZpCU1G4iIDhnukeLhF64tyVbZ
         ePt40Mv7XGMYyy+tpFSIg3zQBi9H7fUmo5g4Fs0amnJJypPYdn1OY8JGhRh40gaeWzdb
         s68XSqzdO/y0QmMDOwTSXRrcv1IeC9pPxQYxMg5ffZx6+l+fLIZYtH7ylxoHTi3eTNfO
         b+VnMEQTEUjzP5BUIl5lc1QJ5CXBvbBnyLh8I71sCws0czUaOzmXHoDzsvpKRm59/+4k
         UQ3rgZaI/V0pVdSV5eToPXFN3qO9xgzp30hIQCE1zLyNNHfzUj3tG1/1pwjtq7LlZAxf
         /eqw==
X-Gm-Message-State: ANhLgQ2N00qLvmzpS+iuFS4xAM1vA97n/0heNn7BwZg4Pepzpm5hALvb
        6gENJKyY6uycA5cO8BW7P/eTYch+HELiUMk8GKQDrASKskY=
X-Google-Smtp-Source: ADFU+vt+QKSB0svWikbyaxQU/tNYV7l0CyBNJzadXZUr6nAWWVA3ubW5u0JpCnXSlSUZLq70aMKxIv46KBrhiN7BU4s=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr19536884pgb.263.1585679979479;
 Tue, 31 Mar 2020 11:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200317202404.GA20746@ubuntu-m2-xlarge-x86> <20200317215515.226917-1-ndesaulniers@google.com>
 <20200327224246.GA12350@ubuntu-m2-xlarge-x86> <CAK7LNAShb1gWuZyycLAGWm19EWn17zeNcmdPyqu1o=K9XrfJbg@mail.gmail.com>
 <CAK7LNAQ3=jUu4aa=JQB8wErUGDd-Vr=cX_yZSdP_uAP6kWZ=pw@mail.gmail.com>
 <CAKwvOd=5AG1ARw6JUXmkuiftuShuYHKLk0ZnueuLhvOdMr5dOA@mail.gmail.com>
 <20200330190312.GA32257@ubuntu-m2-xlarge-x86> <CAK7LNAT1HoV5wUZRdeU0+P1nYAm2xQ4tpOG+7UtT4947QByakg@mail.gmail.com>
In-Reply-To: <CAK7LNAT1HoV5wUZRdeU0+P1nYAm2xQ4tpOG+7UtT4947QByakg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Mar 2020 11:39:27 -0700
Message-ID: <CAKwvOd==U6NvvYz8aUz8fUNdvz27pKrn8X5205rFadpGXzRC-Q@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile.llvm: simplify LLVM build
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 11:25 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Mar 31, 2020 at 4:03 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Mon, Mar 30, 2020 at 11:58:19AM -0700, Nick Desaulniers wrote:
> > > On Sat, Mar 28, 2020 at 6:57 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > I also had planned to provide a single switch to change
> > > > all the tool defaults to LLVM.
> > > >
> > > > So, supporting 'LLVM' is fine, but I'd rather want this
> > > > look symmetrical, and easy to understand.
> > > >
> > > > CPP        = $(CC) -E
> > > > ifneq ($(LLVM),)
> > >
> > > Yes, a simple if statement is much simpler than the overly complex patch I had.
> > >
> > > > CC         = $(LLVM_DIR)clang
> > >
> > > Do we need $LLVM_DIR? Shouldn't users just have that in their $PATH?
> > >
> > > Also, I think we need to support suffixed binaries, as debian
> > > distributes these with version suffixes, as Nathan points out.  Or do
> > > the debian packages install suffixed binaries AND path versioned
> > > non-suffixed binaries?
> >
> > I think the idea here is that ultimately, the suffixed versions of clang
> > that Debian has in /usr/bin are symlinks to binaries in
> > /usr/lib/llvm-#/bin; as a result, a user could say
> > LLVM_DIR=/usr/lib/llvm-#/bin/ and all of those tools would be picked up
> > automatically. I am not really sure what is better.

$ sudo apt install clang-8
$ which clang-8
/usr/bin/clang-8
$ ls -l `!!`
/usr/bin/clang-8 -> ../lib/llvm-8/bin/clang
$ ls /usr/lib/llvm-8/bin
<non suffixed versions>

Ok, so Nathan, it looks like we don't need the version suffixes.
Instead, we can be more explicit with our $PATH, and only add the
above (and bintutils).  I was thinking supporting the suffix was
required for our CI, but it seems like maybe not.

> I periodically build the latest llvm from the trunk,
> and install it under my home directory.
> So, I just thought it would be useful to
> allow a user to specify the llvm directory.
> Of course, I can do the equivalent by tweaking PATH, but
> I hesitate to make the non-released version my default.

Respectfully, I strongly disagree.  This should be handled by
modifications to $PATH, either by your shell's .rc file when you
always want it, or exported for a session when you want it, or
prefixed to an invocation for the duration of that command.  We should
not have a new variable just for the path of a few tools.

Rather than `make LLVM_DIR=~/llvm-project LLVM=1`, you can do
`PATH=$PATH:~/llvm-project make LLVM=1`. (or export it manually or via
your shell .rc, depending on how comfortable you are with that
version).

> Having both LLVM_DIR and LLVM_SUFFIX seems verbose.

I agree, so maybe just LLVM=y, and we can support both non-standard
locations and debian suffixes via modifications to PATH.

>
> In fact, the debian provides multiple versions of GCC.
> For example, my machine has
>
> masahiro@pug:~$ ls -1 /usr/bin/gcc-*
> /usr/bin/gcc-4.8
> /usr/bin/gcc-5
> /usr/bin/gcc-7
> /usr/bin/gcc-ar
> /usr/bin/gcc-ar-4.8
> /usr/bin/gcc-ar-5
> /usr/bin/gcc-ar-7
> /usr/bin/gcc-nm
> /usr/bin/gcc-nm-4.8
> /usr/bin/gcc-nm-5
> /usr/bin/gcc-nm-7
> /usr/bin/gcc-ranlib
> /usr/bin/gcc-ranlib-4.8
> /usr/bin/gcc-ranlib-5
> /usr/bin/gcc-ranlib-7
>
> But, nobody has suggested GCC_SUFFIX.
>
> So, I guess CROSS_COMPILE was enough to
> choose a specific tool version.

Or no one was testing specific versions of gcc with more than one
installed.  I can ask the KernelCI folks next week if this is an issue
they face or have faced.
-- 
Thanks,
~Nick Desaulniers
