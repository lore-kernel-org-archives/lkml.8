Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7706AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1CE20748
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt9bXylY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgETDob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgETDoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:44:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAFCC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:44:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so640380pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ONyQEflSz6Imoxq9sQgBsPIATKu6ZPvvMsByuX0h1+8=;
        b=kt9bXylY+RAM5vpvdD+8IrOHxKcqWaaW8hnbYaktR7y4L82/T74QPkmgI0TitR3Vz2
         /xToURJbrAuIigpLVUObcyGF+q+Y85cDsM/33ZZAMzH/zkvJPYHGJczNB6PhN4DZEmln
         i/niEJzusYieEdnsGGVkbOBwj8J7pijSfyq0ZMr5SyGuSwLL+yqpksUj79t4pxnLAiuG
         +DrWUewIw+YDYv06ndcAhYndeb3kUW92shxrQUeffedJ9j/mzo6oTv0TJVKCuDPlUbOd
         9ust7TnsH4DlS2nCYLvT/n5Ev9vpWOFZkjn+f58fsE3fbOp/QtW/YiPTYMQXyd8wgLF7
         4uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ONyQEflSz6Imoxq9sQgBsPIATKu6ZPvvMsByuX0h1+8=;
        b=nKm+GOiX2oRJgyqQRPh5a//j5zpe7yeqPBVlH0rLo8Q0oVoeBxRJG/5+ruiLPdhpf1
         UAU4Rl+GNlyipZLX8xpoC9qyzDsnQQCXQHrUuvadHAE7lN5f2QaeknGcqLpgm0TG8K9l
         PV2qeWC3q6oPVXlmmKTyqNZ3lJxtCRZQneRNG0ID5Eer8m4RNsr3CVaAe6bFmCrCbsMF
         OtxZM8/KuaFocFtJVMopcGhRaB0uGRaUn1vIKRYe+L2eAj6Ym7rBICKfQsKqH3nHBy3J
         m40Cd5caVPCheDZRDlbbyjGgLPu7zV6u4rfVFMKE2HxgJegsoxUvTYnRsDBGL6RHtOFi
         nPkg==
X-Gm-Message-State: AOAM530z+TTrYRfbFYxfThWdKKfEse59arBO1tFCgsPF8n6zTGQm6ijL
        /Zr2GQLCuZ5OaH6qZJpvSplNxAWL
X-Google-Smtp-Source: ABdhPJylutM5UMhKEMid+UE25TQVzbr1GNG19QYSPhq5R5GY5NqKw/L0IjrkL6XObiZzzTwvOEQsqA==
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr2625015plb.255.1589946269662;
        Tue, 19 May 2020 20:44:29 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id h3sm745528pjk.10.2020.05.19.20.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 20:44:28 -0700 (PDT)
Date:   Tue, 19 May 2020 20:44:26 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] READ_ONCE, WRITE_ONCE, kcsan: Perform checks in __*_ONCE
 variants
Message-ID: <20200520034426.GA1027673@ubuntu-s3-xlarge-x86>
References: <87y2pn60ob.fsf@nanos.tec.linutronix.de>
 <360AFD09-27EC-4133-A5E3-149B8C0C4232@lca.pw>
 <20200520024736.GA854786@ubuntu-s3-xlarge-x86>
 <CAG=TAF4M5s1kQ98ys_YCgRS9WqjV_9KEbPCFiS71MA_QK8epdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=TAF4M5s1kQ98ys_YCgRS9WqjV_9KEbPCFiS71MA_QK8epdA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:16:24PM -0400, Qian Cai wrote:
> On Tue, May 19, 2020 at 10:47 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Tue, May 19, 2020 at 10:28:41PM -0400, Qian Cai wrote:
> > >
> > >
> > > > On May 19, 2020, at 6:05 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > Yes, it's unfortunate, but we have to stop making major concessions just
> > > > because tools are not up to the task.
> > > >
> > > > We've done that way too much in the past and this particular problem
> > > > clearly demonstrates that there are limits.
> > > >
> > > > Making brand new technology depend on sane tools is not asked too
> > > > much. And yes, it's inconvenient, but all of us have to build tools
> > > > every now and then to get our job done. It's not the end of the world.
> > > >
> > > > Building clang is trivial enough and pointing the make to the right
> > > > compiler is not rocket science either.
> > >
> > > Yes, it all make sense from that angle. On the other hand, I want to be focus on kernel rather than compilers by using a stable and rocket-solid version. Not mentioned the time lost by compiling and properly manage my own toolchain in an automated environment, using such new version of compilers means that I have to inevitably deal with compiler bugs occasionally. Anyway, it is just some other more bugs I have to deal with, and I don’t have a better solution to offer right now.
> >
> > Hi Qian,
> >
> > Shameless plug but I have made a Python script to efficiently configure
> > then build clang specifically for building the kernel (turn off a lot of
> > different things that the kernel does not need).
> >
> > https://github.com/ClangBuiltLinux/tc-build
> >
> > I added an option '--use-good-revision', which uses an older master
> > version (basically somewhere between clang-10 and current master) that
> > has been qualified against the kernel. I currently update it every
> > Linux release but I am probably going to start doing it every month as
> > I have written a pretty decent framework to ensure that nothing is
> > breaking on either the LLVM or kernel side.
> >
> > $ ./build-llvm.py --use-good-revision
> >
> > should be all you need to get off the ground and running if you wanted
> > to give it a shot. The script is completely self contained by default so
> > it won't mess with the rest of your system. Additionally, leaving off
> > '--use-good-revision' will just use the master branch, which can
> > definitely be broken but not as often as you would think (although I
> > totally understand wanting to focus on kernel regressions only).
> 
> Great, thanks. I'll try it in a bit.

Please let me know if there are any issues!

Do note that in order to get support for Marco's series, you will need
to have a version of LLVM that includes [1], which the current
--use-good-revision does not. You can checkout that revision exactly
through the '-b' ('--branch') parameter:

$ ./build-llvm.py -b 5a2c31116f412c3b6888be361137efd705e05814

I also see another patch in LLVM that concerns KCSAN [2] but that does
not appear used in Marco's series. Still might be worth having available
in your version of clang.

I'll try to bump the hash that '--use-good-revision' uses soon. I might
wait until 5.7 final so that I can do both at the same time like I
usually do but we'll see how much time I have.

[1]: https://github.com/llvm/llvm-project/commit/5a2c31116f412c3b6888be361137efd705e05814
[2]: https://github.com/llvm/llvm-project/commit/151ed6aa38a3ec6c01973b35f684586b6e1c0f7e

Cheers,
Nathan
