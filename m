Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A88AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46042071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k249CAwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgHYS1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYS1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:27:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4695BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 11:27:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so5308053pgd.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Frh/07NL+SeAwzNhxHk08QT8uzH1n69RJ6apIPJINLs=;
        b=k249CAwkkdiodz5Lh+8psM7apvQ5+S4+PeZ48kZFRHAxm6een3GVVTHZARntPnnxsR
         1jQPqcIUdtNtQqfXH6yPbFqZUYVg859H3apo9updsDpwZB7P1OEIRDUDu6xQXtYQq5WN
         3OJ0FCO4yrdqUxW3YbrHgZRo5A3No+UiErK5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Frh/07NL+SeAwzNhxHk08QT8uzH1n69RJ6apIPJINLs=;
        b=BLs7R2YihKJVd1Pj6A69NCx0665RxAWLC2clXpdKxXpgE/I2LiX6yPUeVyIrYi8hk3
         8/ad31AtJvV8AB6iu0TVbOCmbxcjpe5wfwndqMnKcK+k4jcS48XoEnyVbZ0ai9VOi18k
         +VFjMCX6ti14MYX5sYryqVFDwa2+3VFTElz3a47yPo/igOLCqEAbxrVVRG6cdEzXp5Fg
         qLEssTTHugZmV7ahmiJURGawuR00yjnPWL2AWs4HmbYR7lg2FuDZpkAP4hNNK2YMqkAU
         CDu6fVG1UpGPN7wUI7aU3GTD7T2ZN//w9icd0GtR4qskxPdVbQmpHDYDCl+LgfJaJ1L0
         /jYQ==
X-Gm-Message-State: AOAM531BN69nrD2foNSmgR19QAoBr0wsZrEMBgRyP22wU6/Td1N9nMnK
        4BlAGPP2ZdLyG+gYyDYY0+tJIQ==
X-Google-Smtp-Source: ABdhPJwHxtvZlBE2saQ9lZK+FBUHslLIwWGSp9YVck1ce3kV7sxOAIQ9Fabdeqyfal0ctXKIYkcImQ==
X-Received: by 2002:a17:902:a981:: with SMTP id bh1mr9002608plb.157.1598380031980;
        Tue, 25 Aug 2020 11:27:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x13sm7498961pfr.69.2020.08.25.11.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:27:10 -0700 (PDT)
Date:   Tue, 25 Aug 2020 11:27:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: add namespace entry
Message-ID: <202008251055.7F5DD6FAEB@keescook>
References: <20200825154148.1219500-1-christian.brauner@ubuntu.com>
 <87zh6in140.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh6in140.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:26:07AM -0500, Eric W. Biederman wrote:
> B) The challenge is that most of the namespace work has become part of
>    it's upstream subsystem so we really need to list the containers
>    list and ourselves as reviewers, more than maintainers who run
>    a tree for the code.

As a person who has to touch multiple subsystems regularly while doing
treewide changes, I'm WAY happier to have a distinct set of maintainers
for specific files, and I can track the patch acceptance because I see
them appearing in a specific tree (via -next, etc).

> C) You have overstated what I have agreed to here.
>    I have have previously said that I agree that having a MAINTAINERS
>    entry so people who are unfamiliar with the situation with namespaces
>    can find us.  Given that most of the changes going forward are likely
>    to be maintenance changes.
> 
>    I also said we need to talk about how we plan to maintain the code
>    here.
> 
>    It feels like you are pushing this hard, and I am not certain why you
>    are pushing and rushing this.  With my maintainer hat on my big
>    concern is we catch the issues that will introduce security issue.
>    Recently I have seen a report that there is an issue on Ubuntu
>    kernels where anyone can read /etc/shadow.  The problem is that
>    Ubuntu has not been cautions and has not taken the time to figure out
>    how to enable things for unprivileged users safely, and have just
>    enabled the code to be used by unprivileged users because it is
>    useful.
> 
>    In combination with you pushing hard and not taking the time to
>    complete this conversation in private with me, this MAINTAINERS entry
>    makes me uneasy as it feels like you may be looking for a way to push
>    the code into the mainline kernel like has been pushed into the
>    Ubuntu kernel.  I may be completely wrong I just don't know what to
>    make of your not finishing our conversation in private, and forcing
>    my hand by posting this patch publicly.

Eh? I don't see a conspiracy here; I think you are, as you suggest above,
completely wrong. ;) I haven't seen the private emails, obviously, but
what I see here is just Christian's drive to get things nailed down. It
sounds like the "here's who to CC" part of the MAINTAINERS file was
agreed to, but there was a misunderstanding about the resolution of
group maintainership?

> The files you have listed are reasonable for a maintainers entry as they
> have no other maintainers.

Agreed; if this was in place a few years ago, it might have been a bit
easier to direct and land some of the (now straggling) refcount_t
conversion patches.

> I know I have been less active after the birth of my young son, and I
> know the practical rule is that the person who does the work is the
> maintainer.  At the same time I am not convinced you are actually going
> to do the work to make new code maintainable and not a problem for other
> kernel developers.

O_O  I find this opinion very surprising. I hold Christian's judgement
in high regard (and yours). He's tackled the pidfd API (which solves so
many ancient gnarly problems with pid management) in a clean, measured,
and consistent manner. He and Aleksa have diligently worked on extensible
syscalls, which solve years of headaches over code maintainability, and
Christian regularly adds kernel selftests. I think he's absolutely got the
best interests of other developers (and users) in mind. Certainly none
of us are perfect, but your statement feels way way off base to me.

> A big part the job over the years has been to make the namespace ideas
> proposed sane, and to keep the burden from other maintainers of naive
> and terrible code.  Pushing this change before we finished our private
> conversation makes me very nervous on that front.

I think you both want the same thing (generally awesome Linux,
specifically sane and safe namespaces), and I think you're both deeply
involved in the namespace code and the use-cases, so it seems natural
to me that you'd have some form of shared maintainership. To that end, I
hope this can get sorted out. I'd like to have a tree I can count on to
have patches reviewed (and hopefully landed) that touch these areas.

To me, it seems like there has just been an impedance mismatch on the
expectations/priorities of communication speed. I don't see bad
motivations here at all.

> > [...]
> > +T:     https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/
> > +T:     https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/

Obviously y'all still need to finish this discussion, I but I'd expect a
single tree at the end of the day. No other subsystem has multiple trees
that I can find:

$ git grep -A1 ^T: -- MAINTAINERS  | grep -- -T: | wc -l
0

And please use the "git" format for T: so you can specify branches,
which helps immensely in tracking down "latest" commits:

T: git git://URL/TREE.git BRANCH

No other trees use a bare https schema:

$ git grep ^T: -- MAINTAINERS | grep "git " | wc -l
632
$ git grep ^T: -- MAINTAINERS | grep -v "git "
MAINTAINERS:T:  quilt http://people.redhat.com/agk/patches/linux/editing/
MAINTAINERS:T:  quilt http://jdelvare.nerim.net/devel/linux/jdelvare-dmi/
MAINTAINERS:T:  hg http://tboot.hg.sourceforge.net:8000/hgroot/tboot/tboot
MAINTAINERS:T:  quilt https://ozlabs.org/~akpm/mmotm/
MAINTAINERS:T:  quilt https://ozlabs.org/~akpm/mmots/
MAINTAINERS:T:  git://git.infradead.org/nvme.git
MAINTAINERS:T:  git://git.infradead.org/nvme.git


-- 
Kees Cook
