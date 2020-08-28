Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E075FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23C0207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9vxyGam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH1UOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgH1UOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:14:20 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72311C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:14:20 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h17so279265otl.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HoCq7hZfHCm7PsYPPZZKrsBeqX1HiFjWHIVfF9O1nts=;
        b=b9vxyGamlHheTjhK3U4kclX/OcRIIzhI8/rk1Vv4SFeX3yiKqzpBb6A5klAR0ERgGf
         EU+qfVErXLTS/ATpVznUUjz1ujoKxiNVoXJwixFQAK4/Q3zJAnNwKej1NLJ0s92m7Ydb
         Q3uSriyX6smYtC/BG15pS1uWgcuBVZCVTR+j45ZVwK9P+QgAeb9CyOPrkpXhzTZ5j0nh
         A0KMAWDXZ2w/SL9FGgHabDNad6puxWgXAACuflMZ50E3pmrFw/ZORFn2PJr9zgWNmDSE
         MReBdgSkMGiYC6DQE9HY302Jeg3Onbo67hZWG1fKW33J2uVIST/T3fmfMYm1uWoMsFvg
         nOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HoCq7hZfHCm7PsYPPZZKrsBeqX1HiFjWHIVfF9O1nts=;
        b=Ex0ht2DQK+VpgdP1/Mox/5NHuLsnmU0R3/MSo0bnUvJVu2x0PHoUOs8nBbwUjgEdWo
         0fFIDNrVj7jgV3j/7rk3bcgUz4dAHTMge2z5m/unzqN1hALNtH544c0XTdxtIfhv+nNP
         OjjWVasH7h5JbVB/Hj46TP5gHMbHs5b3lJsJxYI7vl9WL/XFn+CyGT9bR43eIyVlkXGf
         8W0BwAW+qG23YLkUKHnpYWShuI7kjHUWdr4tSDwvHzT6Ib3yV3fDCF19ORvgnB117Yyb
         RFIuTilZvEdpYUgvjHtUl7coKzYoylPhAdP3Cw346eFSHPLSapeUXAHC8IPVLaF3Ncrb
         Bbdw==
X-Gm-Message-State: AOAM530HwbG+GnvcYO51NTAZyuEws3xqoTZFGChfPCvw7YHm/urCTWgd
        nDc8MEvKQONiIc/55o30H/mzjIZowajeHP3CFGraVg==
X-Google-Smtp-Source: ABdhPJzxX5NHAVqNMEiVv/SKzj0eFHAuVGNEsCu+WHxPysGOtwVZFlHbFei6kXHHi4pHYTnTzkL3E6WiefJFIeH/j20=
X-Received: by 2002:a9d:7846:: with SMTP id c6mr239804otm.221.1598645658901;
 Fri, 28 Aug 2020 13:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200827123627.538189-1-gregkh@linuxfoundation.org>
 <3d8de519-65b3-123b-8ace-e820982884e0@labbott.name> <20200827160506.GC684514@kroah.com>
 <CAMi1Hd1Ch1RWvOTnON3tsrucaKThTuGQnwNFo94GqUjufVmnOg@mail.gmail.com>
 <20200827171745.GA701089@kroah.com> <CALAqxLVOEBaLtkbL-OENYSK0dUc_PBo-oC=BOBFQbPh-bkWTgQ@mail.gmail.com>
 <20200828080527.GA1005274@kroah.com>
In-Reply-To: <20200828080527.GA1005274@kroah.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 28 Aug 2020 13:14:06 -0700
Message-ID: <CALAqxLWk9uY=Xro1EJ=EQaEuQKS+AN6u0Dny-8-__m5TkxrZSQ@mail.gmail.com>
Subject: Re: [PATCH] staging: ion: remove from the tree
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Christoph Hellwig <hch@infradead.org>,
        Android Kernel Team <kernel-team@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Laura Abbott <laura@labbott.name>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 1:05 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 27, 2020 at 11:54:12AM -0700, John Stultz wrote:
> > On Thu, Aug 27, 2020 at 10:17 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Thu, Aug 27, 2020 at 10:31:41PM +0530, Amit Pundir wrote:
> > > > I don't know what is the right thing to do here. I just want to
> > > > highlight that AOSP's audio (codec2) HAL depends on the ION system
> > > > heap and it will break AOSP for people who boot mainline on their
> > > > devices, even for just testing purpose like we do in Linaro. Right now
> > > > we need only 1 (Android specific out-of-tree) patch to boot AOSP with
> > > > mainline and Sumit is already trying to upstream that vma naming
> > > > patch. Removal of in-kernel ION, will just add more to that delta.
> > >
> > > As AOSP will continue to rely on ION after December of this year, all
> > > you are doing is postponing the inevitable a few more months.
> > >
> > > Push back on the Android team to fix up the code to not use ION, they
> > > know this needs to happen.
> >
> > The point though, is your main premise that no one is using this isn't true.
>
> They are using the version of ion in the Android kernel tree, yes, as it
> has new features that many people are relying on.
>
> The version that is currently in the kernel tree is crippled, and maybe
> works for some use cases, but not the majority, right?

So my understanding is the Android Common Kernel tree version was
mostly reworked to allow heaps as modules, and allowed heaps to have
their own exporter logic (not unlike how dmabuf heaps do it). The main
allocation interface is maybe slightly tweaked for out-of-tree vendor
heaps, but doesn't affect the in-staging heaps. There's also a few
optimizations we have skipped taking upstream. So yes, there are
differences, but I don't feel your characterization is quite accurate.


> > I'm actively working with Hridya and folks on the codec2 HAL side to
> > transition this on the userland side:
> >   https://android-review.googlesource.com/c/platform/frameworks/av/+/1368918/3
> >
> > I'd like AOSP to not use ION after September (though being external I
> > can't promise anything), much less continuing after December.
>
> The android team has said they will be dropping ION use for the "next"
> Android release, which is sometime next year from what I recall.
> December is probably not going to happen :)

AOSP is what the next Android release forks off of, so it needs to be
fixed first.

> > I want this migration to happen as much as anyone.  But I'd prefer to
> > keep ION in staging until after the LTS is announced. Having both
> > around helps development for the transition, which helps us have a
> > reliable solution, which helps vendors to migrate and be able to do
> > comparative performance testing.
>
> I don't understand what having this in the "next" kernel helps us with
> here.  And I would really really prefer to NOT have an outdated version
> of this code in a kernel tree that I am going to have to support for the
> next X number of years, when no one is using that version of the driver.
>
> What is this LTS fixation to keep this code around for?  Who does it
> help?

Vendors usually target LTS releases for their hardware bringups.
Having a LTS release with both ION and DMA BUF Heaps helps them
validate their old ION solution as performant, and then migrate to DMA
BUF Heaps and be able to do performance comparisons holding all other
things equal.

> > I do appreciate that keeping it isn't free, but I also don't feel the
> > chaos-monkey approach here is really motivational in the way you
> > intend.
>
> I don't see it helping anyone to leave this around, except to cause
> merge issues for me, and development issues for other developers.
>
> Anyone who really wants this code, can easily revert the deletion and
> move on and grab the AOSP copy of the code.  That's what they did when
> we deleted other Android features that are still relied on.
>
> Given that the "isn't free" is causing _me_ real pain, and not the
> actual users of this code, I am leaning toward wanting to move that
> pain/cost to those users, for obvious reasons.

Sure. Again, I do understand the desire to remove it, and it's your
right to do so. Keeping the code for an extra year in LTS (over 5.4)
is a cost, so I understand if you drop it. But I'll ask that you make
that judgement clear as the main motivator/rationale of the commit
message, rather than flippantly pretending it's not being used, and
that everyone agrees it has no usefulness to keep around (especially
after we've had this conversation a few times already this year).

thanks
-john
