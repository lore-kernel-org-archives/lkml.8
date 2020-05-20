Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A716C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04C8205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEvWD2Pb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgETH24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgETH2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:28:34 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BA1C05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v17so1747876ote.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xkPHVoXP68BKS5mey7jq2q721wyLayczstvvUEvUVF8=;
        b=pEvWD2PbPHRjXPov0v2cPi6kSsk2SgidZEVQWiKP8t8HL+JLZFvt4KZ8EYY2Bn7cVG
         39AeQe/ptN2kBoSaOBbJZcZ0MCK15MyXClTAU80ZaaYuoZFF5NJOPJfvTkfVGb8EUK28
         sJm9O6LWJU6p71VM3KDh7lW/fPq5/0zl0yrJ8dIFdIWWvnP4mWqLrg4fbTrF4H+5py6M
         IiWfLYKiYvAjt01S8sK6rz97dGBIcMLqKK0tHyxQ4lEtn0oDaN1Dkoq/sDvToyrE7khA
         04CSFCH7qXynRt3Q6XBMhs9xLs0viiLWy5ltq41le9hewUyJ9SwLeU058foskccxKkbW
         MyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xkPHVoXP68BKS5mey7jq2q721wyLayczstvvUEvUVF8=;
        b=ShpQQs67SXwReGA6cDffCJd6ikULoD1di2G16M/HdOX/n9a4PKr2BwnTRjmv/AY07E
         cvZ7iUGDZoJ3QoN5xQsQdutlPbT6ovPLPwyR2NRqNG0L13K0M5XwnYDjevQfA4BigXLx
         PzIRivFQ+z7q4wH2tC5YxYnI8Ea62vwzXy5v0GaCAevfa7+Bt3a9cHuarCEU0eNlWeLj
         1vX8IZhof4pGzxySdxLPODl8bBS4sl9M0Nx0GkU+O2Jf0SIfwjRJ3TxftIlAbWtmOyuk
         YEPssky10Py2K+o2DlZmKIPEghJ1+AoVmJTQ46ZhYQhouEdz6AFszQwMyVOSHdL9GX/l
         RTsw==
X-Gm-Message-State: AOAM531vyjFRNYgZW054BEZIV2oaj/gB0W+MuKDOs8SsufUlbki5YCaq
        RK7c93Oio1sDubxIlS7+W6d6mZawQ0jRNzB7kDz3gtZsNzQ=
X-Google-Smtp-Source: ABdhPJxHTL1f25cq3vSGAreLPX7msUeW/P6u8CQM4XOy/t7vEjOii5sMZ0nbDVN30Ck6Irnxw5Hx2MPMVu6XbglWi94=
X-Received: by 2002:a05:6830:18ce:: with SMTP id v14mr2045756ote.251.1589959713491;
 Wed, 20 May 2020 00:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <87y2pn60ob.fsf@nanos.tec.linutronix.de> <360AFD09-27EC-4133-A5E3-149B8C0C4232@lca.pw>
 <20200520024736.GA854786@ubuntu-s3-xlarge-x86> <CAG=TAF4M5s1kQ98ys_YCgRS9WqjV_9KEbPCFiS71MA_QK8epdA@mail.gmail.com>
 <20200520034426.GA1027673@ubuntu-s3-xlarge-x86>
In-Reply-To: <20200520034426.GA1027673@ubuntu-s3-xlarge-x86>
From:   Marco Elver <elver@google.com>
Date:   Wed, 20 May 2020 09:28:20 +0200
Message-ID: <CANpmjNMiiDN0AueijLbkbhEX0vLc3xfPyA7kec5_T3Qku7wkMw@mail.gmail.com>
Subject: Re: [PATCH] READ_ONCE, WRITE_ONCE, kcsan: Perform checks in __*_ONCE variants
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 at 05:44, Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, May 19, 2020 at 11:16:24PM -0400, Qian Cai wrote:
> > On Tue, May 19, 2020 at 10:47 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Tue, May 19, 2020 at 10:28:41PM -0400, Qian Cai wrote:
> > > >
> > > >
> > > > > On May 19, 2020, at 6:05 PM, Thomas Gleixner <tglx@linutronix.de>=
 wrote:
> > > > >
> > > > > Yes, it's unfortunate, but we have to stop making major concessio=
ns just
> > > > > because tools are not up to the task.
> > > > >
> > > > > We've done that way too much in the past and this particular prob=
lem
> > > > > clearly demonstrates that there are limits.
> > > > >
> > > > > Making brand new technology depend on sane tools is not asked too
> > > > > much. And yes, it's inconvenient, but all of us have to build too=
ls
> > > > > every now and then to get our job done. It's not the end of the w=
orld.
> > > > >
> > > > > Building clang is trivial enough and pointing the make to the rig=
ht
> > > > > compiler is not rocket science either.
> > > >
> > > > Yes, it all make sense from that angle. On the other hand, I want t=
o be focus on kernel rather than compilers by using a stable and rocket-sol=
id version. Not mentioned the time lost by compiling and properly manage my=
 own toolchain in an automated environment, using such new version of compi=
lers means that I have to inevitably deal with compiler bugs occasionally. =
Anyway, it is just some other more bugs I have to deal with, and I don=E2=
=80=99t have a better solution to offer right now.
> > >
> > > Hi Qian,
> > >
> > > Shameless plug but I have made a Python script to efficiently configu=
re
> > > then build clang specifically for building the kernel (turn off a lot=
 of
> > > different things that the kernel does not need).
> > >
> > > https://github.com/ClangBuiltLinux/tc-build
> > >
> > > I added an option '--use-good-revision', which uses an older master
> > > version (basically somewhere between clang-10 and current master) tha=
t
> > > has been qualified against the kernel. I currently update it every
> > > Linux release but I am probably going to start doing it every month a=
s
> > > I have written a pretty decent framework to ensure that nothing is
> > > breaking on either the LLVM or kernel side.
> > >
> > > $ ./build-llvm.py --use-good-revision
> > >
> > > should be all you need to get off the ground and running if you wante=
d
> > > to give it a shot. The script is completely self contained by default=
 so
> > > it won't mess with the rest of your system. Additionally, leaving off
> > > '--use-good-revision' will just use the master branch, which can
> > > definitely be broken but not as often as you would think (although I
> > > totally understand wanting to focus on kernel regressions only).
> >
> > Great, thanks. I'll try it in a bit.
>
> Please let me know if there are any issues!
>
> Do note that in order to get support for Marco's series, you will need
> to have a version of LLVM that includes [1], which the current
> --use-good-revision does not. You can checkout that revision exactly
> through the '-b' ('--branch') parameter:
>
> $ ./build-llvm.py -b 5a2c31116f412c3b6888be361137efd705e05814
>
> I also see another patch in LLVM that concerns KCSAN [2] but that does
> not appear used in Marco's series. Still might be worth having available
> in your version of clang.
>
> I'll try to bump the hash that '--use-good-revision' uses soon. I might
> wait until 5.7 final so that I can do both at the same time like I
> usually do but we'll see how much time I have.
>
> [1]: https://github.com/llvm/llvm-project/commit/5a2c31116f412c3b6888be36=
1137efd705e05814
> [2]: https://github.com/llvm/llvm-project/commit/151ed6aa38a3ec6c01973b35=
f684586b6e1c0f7e

Thanks for sharing the script, this is very useful!

Note that [2] above is used, but optional:
https://lore.kernel.org/lkml/20200515150338.190344-5-elver@google.com/
It's not required for KCSAN to function correctly, but if it's
available it'll help find more data races with the default config.

Thanks,
-- Marco
