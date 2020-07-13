Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5851EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369AA2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594607287;
	bh=vchnt4viyhaGqqi0YJEBNTk0gEWNggJ/EphtpLGqUEA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bU+smNyvP3cdFy2tECqzbY4P2J5XRbAYk8Pns+1ccwNVcRa06IfkLE+vxV3etXwdA
	 BGCgZtOU8JuFdNRtq2ZNx2l2Wk11Je55+4hGbA3FhrAVRVK9ioy6DsxCgJOo7Q2yin
	 J2cNl6Tmw0xCUobxqL28SMsWQCtPF7SHhMhPG9yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgGMC2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgGMC2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:28:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543C7C08C5DB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:28:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x9so4454791ljc.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Kd3bokmakAC9QLj74KST8J4C2nrYiNiziDMMNq1eaw=;
        b=ac0NG0+2PZyjgTW6CDWM53lyaoZXyWfgHkVgnJiQK8FkT5VJ+sXdLYnUA/mPQ7bTXD
         ESopsgeKDLLL62c+WlIcVr+Ou42Ld9893HGuRO+eR3hxx0WcDGBCJEZSM6TSRM9qYBRY
         yggXg6JJs9fRMnCRHkQ3z3mITIoGFcVa0OVcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Kd3bokmakAC9QLj74KST8J4C2nrYiNiziDMMNq1eaw=;
        b=DDtWz5VE7eoiZafRXPNttI1mnhWkc3ONovAXCENucReL7wMzWfWAmd3FGOCJ3SSorf
         HoBDBtPwLhmt8p6/7qWh41nWgp6KLnRpP418J0fg0oHyyW/fW8OiOMQBqkxtgQCvh6Lz
         u2I/J5BImlvBYjV0EGpnS3kSfFmdVrNbs96NhitYcXumYgzITPp/54YjADWuG8he/u0N
         /3b2XGBnzFG+1zTEpA1wlCIImb4IJl1YlJb5P2P3kcWPo1rv7muNv1TjZ9FOZyK/t/zd
         lXalA7U11/uFYP4QwfU1Zdyo9NGnCPB4XuSBXhiSaT/uM5aaZiq4qYQJC+gA+1N3O/p0
         Y4aw==
X-Gm-Message-State: AOAM533Lenb8gFzKy/A4JWcCfVenIla30doTfV7NTmFXRqwEDoV37YGD
        InyntpQwDrX3oMCh/qoxzpb8rJZEfxw=
X-Google-Smtp-Source: ABdhPJx2GAa8NMP0aR875izPzaExQ8T5HLcYT8XZFuWuc0xemaUUnDDENhg1XqMYTbmXv1CVfU2Cug==
X-Received: by 2002:a2e:88c6:: with SMTP id a6mr43023021ljk.27.1594607283403;
        Sun, 12 Jul 2020 19:28:03 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id d2sm3794930ljg.6.2020.07.12.19.28.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 19:28:02 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id g2so7333900lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:28:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3f1:: with SMTP id n17mr51767523lfq.125.1594607281826;
 Sun, 12 Jul 2020 19:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200710183318.7b808092@canb.auug.org.au> <20200712155604.GA342822@smile.fi.intel.com>
 <20200713080152.63ee1246@canb.auug.org.au> <e519f1c2-9761-4866-4878-09cc3da23d1f@infradead.org>
In-Reply-To: <e519f1c2-9761-4866-4878-09cc3da23d1f@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Jul 2020 19:27:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wib+gfHwo0zADm-rMXuBaHMdosudtBXeUk0qfQEna9Hjw@mail.gmail.com>
Message-ID: <CAHk-=wib+gfHwo0zADm-rMXuBaHMdosudtBXeUk0qfQEna9Hjw@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 10
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 7:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> >
> > Not that I am aware of at the moment.  Does next-20200709 work?  Does
> > Linus' tree work?  The only obvious thing I can think of is commit
>
> I'm hitting this same thing on 5.8-rc5. (x86_64)
>
> > 6ec4476ac825 ("Raise gcc version requirement to 4.9")
> >
> > The commmit message says:
> >
> >     Using _Generic also means that you will need to have a very recent
> >     version of 'sparse', but thats easy to build yourself, and much less of
> >     a hassle than some old gcc version can be.

Yes, you need a very recent version of sparse.

I was oging to hold off that sparse upgrade requirement for 5.9, but
we had independent reasons to just say "gcc 4.9", and at that point
the code that allowed old versions of sparse to work was entirely dead
outside of sparse.

Sparse is really easy to build and install as a regular user. Just do

    mkdir -p ~/src ; cd ~/src
    git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
    cd sparse
    make && make install

and it will install the sparse binaries in your ~/bin directory. No
need to be root, it just works.

              Linus
