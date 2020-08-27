Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBE8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CF72087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCcrh3qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgH0SyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgH0SyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:54:25 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE107C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:54:24 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id m4so1461898oos.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BWqUveoeKZMIhm3GjalPyEQmnfCWpI1alLQjjqHt+NU=;
        b=SCcrh3qeuy5Pqm6KFI/xAj5Y/ENojt7/jYbC4IkRyQsWuyYTXztzy3Y/JwrtY3NGfK
         VJA5M/PFjjZNQZgCL4ipJNIe/29Icg2ojlK0A2jBoN2fPMa3Ljmy6wP/gwYIhQzI5LFf
         x0xQLnuGiXjWg1XJngPFxg+N/oncHwtwyx/QJ1d2o4CCgIWvNNh2YmvscoicgdTapmkx
         Avigv/QQopdYQ8XfX6SK5xvTrgHlbrIT1J7hzhJtXLWN6NpzInoHSkk2n5mDMmDHnKXh
         nYZv6OIfmGztUzuVBFq6FpcWumyGQO5lvbRrUQpmA06r767ZOPzu2PJXJZFndd22/MmJ
         50mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BWqUveoeKZMIhm3GjalPyEQmnfCWpI1alLQjjqHt+NU=;
        b=FpeM8uc6Xfkunl5aBENdbjVBAwuq6O3e+OLQ6wIvA3CILJdLSeTrQDpvXNBjHU6hZf
         oKDo8x1a2neKy6Czz3zxQlo0MqM4aljI4nDfifXKKCKsSXQR2esBRWWAHM3tDWMlajrK
         y2Qqhs4ehP71w4zLfGVDLHMoRZfX94qt8QFnmLUvbjrXnEUelSMt4e96fukQWWl9xPTI
         cQfqV5heB46Y1qHc0p0Z0jQymUUJgMC0nCLP25QBI9+rj2MWLxcLSoyZSQEovzzx65/j
         eQ0xy7s0uimDvkW/e+46kCCbtJ1cLS+75pW6r/ZDJR8Ae/4+6tXjuTn2A5TNCqo4Zt/h
         pSBA==
X-Gm-Message-State: AOAM530/tP89+r2InS1r0Xtvj4iyce+vnsxIbeRR/0C+X1ZRt15KblUj
        rn8OL8b3GYwfcNPGnUM8n4x6c0z0iNw3ODVtuRz6ZA==
X-Google-Smtp-Source: ABdhPJy8T8ttMmxpmzdBmMLZEkAuTLQvD2G2liKWH2H+Jb7ky01tXVyV7oYkkXZ8NroZL6tIlOl+3FM2CROEfwK+7xM=
X-Received: by 2002:a4a:aa42:: with SMTP id y2mr9682938oom.88.1598554463803;
 Thu, 27 Aug 2020 11:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200827123627.538189-1-gregkh@linuxfoundation.org>
 <3d8de519-65b3-123b-8ace-e820982884e0@labbott.name> <20200827160506.GC684514@kroah.com>
 <CAMi1Hd1Ch1RWvOTnON3tsrucaKThTuGQnwNFo94GqUjufVmnOg@mail.gmail.com> <20200827171745.GA701089@kroah.com>
In-Reply-To: <20200827171745.GA701089@kroah.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 27 Aug 2020 11:54:12 -0700
Message-ID: <CALAqxLVOEBaLtkbL-OENYSK0dUc_PBo-oC=BOBFQbPh-bkWTgQ@mail.gmail.com>
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

On Thu, Aug 27, 2020 at 10:17 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Aug 27, 2020 at 10:31:41PM +0530, Amit Pundir wrote:
> > I don't know what is the right thing to do here. I just want to
> > highlight that AOSP's audio (codec2) HAL depends on the ION system
> > heap and it will break AOSP for people who boot mainline on their
> > devices, even for just testing purpose like we do in Linaro. Right now
> > we need only 1 (Android specific out-of-tree) patch to boot AOSP with
> > mainline and Sumit is already trying to upstream that vma naming
> > patch. Removal of in-kernel ION, will just add more to that delta.
>
> As AOSP will continue to rely on ION after December of this year, all
> you are doing is postponing the inevitable a few more months.
>
> Push back on the Android team to fix up the code to not use ION, they
> know this needs to happen.

The point though, is your main premise that no one is using this isn't true.

I'm actively working with Hridya and folks on the codec2 HAL side to
transition this on the userland side:
  https://android-review.googlesource.com/c/platform/frameworks/av/+/1368918/3

I'd like AOSP to not use ION after September (though being external I
can't promise anything), much less continuing after December.

I want this migration to happen as much as anyone.  But I'd prefer to
keep ION in staging until after the LTS is announced. Having both
around helps development for the transition, which helps us have a
reliable solution, which helps vendors to migrate and be able to do
comparative performance testing.

I do appreciate that keeping it isn't free, but I also don't feel the
chaos-monkey approach here is really motivational in the way you
intend.

thanks
-john
