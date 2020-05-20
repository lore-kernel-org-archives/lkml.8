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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB535C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C7520578
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slokoVWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgETCrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgETCrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:47:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BC6C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 19:47:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so723857plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 19:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=U3JxxfWABjzw+muWBftLLoPg5L7tniD/yZsXvBpXo+8=;
        b=slokoVWJXaRttKsQqFtbb/IhJzyFeFiJdoTKI7HAt/WA2Zf1quWXNXytrZIKPCHZoL
         KSWsRvONvW4bnjCbl9iNys4AGIFQ/a7AcruxeYAOjQw0G7MJGRaHdSGv2D4EGb3vt/Oy
         9COo1VAOs7jaZAy12bFZb+wP/cP0OkpAZYIQN9UMz0qAUtqUMiUuNDNk5LPeTPppqyLT
         4fBr1ArE9MYD5bWkEUyPAHeF7PMA1MogRclTBEalp5sca+HFoq85fdl2D7zib9gGC5xy
         NqIZunM7PuIPI9TaAiRkhSYVZcUgSC2R2l+/3SvTWmD2oTZ90VuEoTXdWB004DgJ1oGW
         9Lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U3JxxfWABjzw+muWBftLLoPg5L7tniD/yZsXvBpXo+8=;
        b=fzqos5PPBj4vPnAtuOirBztEVVaeCTzSxBx89eYRVvoLJMLANFIY065COIPBLjf+1D
         5gukFTyByH4GjOXENWhCHqibT2B911TrsDixngoQbBdY/EZKB4HdRnlkve545JielqYT
         2u0N7CI5YHEoGFS+lDVr0jF5qGXfa3UfkUxSZqnxEerRP2IntQ6WMoaKJw5TqIbi011/
         sGa0sNjR12eckAWZKHCO/fxupzFi8gelpsWLDEPojAqHSqpO3KOyxu2WdegG15CdwvFD
         tU+QV3RB0BRoj6XwqsnnTjbqwHFWOFXpkgB3ZuM/HURXVsFshq695SFoFqP5dSCa0PT8
         BhEQ==
X-Gm-Message-State: AOAM533aMJjZtMQod0lyM/AjEJLWn0c4zv1fZ1iQ56VzH3rRffMmH7GA
        fYSDrzWQR+1v3srKEnxPmEBkqv9X
X-Google-Smtp-Source: ABdhPJxD1Q5IYFmBOdZAm+YJBAyV802hnWPPLSu5Bw/nuR+5YZztGYUG/iygBVz9P44a1illXkpnZA==
X-Received: by 2002:a17:90b:110d:: with SMTP id gi13mr2587365pjb.131.1589942859725;
        Tue, 19 May 2020 19:47:39 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id a2sm670964pfl.28.2020.05.19.19.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 19:47:39 -0700 (PDT)
Date:   Tue, 19 May 2020 19:47:36 -0700
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
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] READ_ONCE, WRITE_ONCE, kcsan: Perform checks in __*_ONCE
 variants
Message-ID: <20200520024736.GA854786@ubuntu-s3-xlarge-x86>
References: <87y2pn60ob.fsf@nanos.tec.linutronix.de>
 <360AFD09-27EC-4133-A5E3-149B8C0C4232@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <360AFD09-27EC-4133-A5E3-149B8C0C4232@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:28:41PM -0400, Qian Cai wrote:
> 
> 
> > On May 19, 2020, at 6:05 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > Yes, it's unfortunate, but we have to stop making major concessions just
> > because tools are not up to the task.
> > 
> > We've done that way too much in the past and this particular problem
> > clearly demonstrates that there are limits.
> > 
> > Making brand new technology depend on sane tools is not asked too
> > much. And yes, it's inconvenient, but all of us have to build tools
> > every now and then to get our job done. It's not the end of the world.
> > 
> > Building clang is trivial enough and pointing the make to the right
> > compiler is not rocket science either.
> 
> Yes, it all make sense from that angle. On the other hand, I want to be focus on kernel rather than compilers by using a stable and rocket-solid version. Not mentioned the time lost by compiling and properly manage my own toolchain in an automated environment, using such new version of compilers means that I have to inevitably deal with compiler bugs occasionally. Anyway, it is just some other more bugs I have to deal with, and I don’t have a better solution to offer right now.

Hi Qian,

Shameless plug but I have made a Python script to efficiently configure
then build clang specifically for building the kernel (turn off a lot of
different things that the kernel does not need).

https://github.com/ClangBuiltLinux/tc-build

I added an option '--use-good-revision', which uses an older master
version (basically somewhere between clang-10 and current master) that
has been qualified against the kernel. I currently update it every
Linux release but I am probably going to start doing it every month as
I have written a pretty decent framework to ensure that nothing is
breaking on either the LLVM or kernel side.

$ ./build-llvm.py --use-good-revision

should be all you need to get off the ground and running if you wanted
to give it a shot. The script is completely self contained by default so
it won't mess with the rest of your system. Additionally, leaving off
'--use-good-revision' will just use the master branch, which can
definitely be broken but not as often as you would think (although I
totally understand wanting to focus on kernel regressions only).

Cheers,
Nathan
