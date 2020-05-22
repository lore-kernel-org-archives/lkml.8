Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2E2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835DC20727
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590165235;
	bh=3KHar5wD0fW76UrByACoor1q1QL5EFDolr/Zva26JRc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U9KYSACTEvAKAUcFPzmT2aIV+llykegJ6/dmroq4Z4s/VnbydLWeVjqp/FpuP9kyN
	 +LCi2HQjl3keclW1E885uySRrh6DAOenmFGXO1RDWpZpiwPjBW467v1mGjE0AqY5/l
	 wIs4XuxHdvCKEM6ICzlkSiBn0FI5x7m2PmUa85tM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgEVQdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbgEVQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:33:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAA1C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:33:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m18so13374600ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unkC4MJf4UrfZxfvSQ5jcQaQs5HYMedcutrjwtxTsiU=;
        b=N0o/avkSp6x8SCtVJFADhUuwLFz481dTlntyRk+B6F6vQBLjnxMeQDOqUTFKErueX8
         cJDmv+wRTujyUQPLmHp/t1yQobiZdmpu7rOs0yKUIG/ffV1bXfpRG5lATEvJJOg8KKsC
         VWvyN0JE1zukNEO513FTfhjiAGjjYS+Xolupg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unkC4MJf4UrfZxfvSQ5jcQaQs5HYMedcutrjwtxTsiU=;
        b=oERj1lg95A50LxRz8iOFaWPma1lbXGRHqzQyKxWL/Txdg+amI6ko/YuqKARkpAWDWF
         rmFEs8eZbzFXRAgQ/p/l8mREkLtCCsRdEBmxPPC0oWwK5Ep57TIo7Lhr8EoT4Z3ieEBp
         ABhpB8uewT2Bk0LBNSCrlK4OKcFIj/5S8ZutusjukInfm4lqwjp80J+4DtzW32X6G3/K
         W0zbv5cwqWrQOWfCCSsP8WceS6fwx1b8D2P85JSk8gcCLlGsMKowzYLWmDOvl24b1GVL
         J2nnkLxi+T+n3zB5ZrpnSs/UAl3txcfBn2uYe5WrKIngrRg8G4Nibb+N4yPyiA4xjKh0
         AZCg==
X-Gm-Message-State: AOAM533tGKW6ZNvGdZ0K9oAY5QoXfQObbv060QSKPvD44RzxCKdwMVss
        j/vyxw12dIfZSXQnKb3ZlNV5chITtB0=
X-Google-Smtp-Source: ABdhPJz6jng8MMo/Zex8v1NQQUu3uQO23Rq7ugU2TyFKKA5cgvpVqhYLN4Iy3RibgfoHpB/m8TEhmQ==
X-Received: by 2002:a2e:b5da:: with SMTP id g26mr5454841ljn.349.1590165230341;
        Fri, 22 May 2020 09:33:50 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 9sm1527399ljv.137.2020.05.22.09.33.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 09:33:48 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id w10so13434573ljo.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:33:48 -0700 (PDT)
X-Received: by 2002:a2e:9891:: with SMTP id b17mr6124004ljj.312.1590165227929;
 Fri, 22 May 2020 09:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org> <CAHk-=wjUXRG53S0mLd8UVG2+cMC=2YLJGB-K_h2TkqHGZ-VSoA@mail.gmail.com>
 <20200521204044.GD140701@google.com> <CAJmaN=nq7qaLRdN6CTAqtYy4nfMe4NvAutF5m2v-Ng+5Kijx_A@mail.gmail.com>
In-Reply-To: <CAJmaN=nq7qaLRdN6CTAqtYy4nfMe4NvAutF5m2v-Ng+5Kijx_A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 May 2020 09:33:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whseFhtS+74FkNX=q=+-URQoG_7OiVzCokKbFNjFgSiAA@mail.gmail.com>
Message-ID: <CAHk-=whseFhtS+74FkNX=q=+-URQoG_7OiVzCokKbFNjFgSiAA@mail.gmail.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling interface
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        vpillai <vpillai@digitalocean.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 2:58 PM Jesse Barnes <jsbarnes@google.com> wrote:
>
> Expanding on this a little, we're working on a couple of projects that
> should provide results like these for upstream.  One is continuously
> rebasing our upstream backlog onto new kernels for testing purposes
> (the idea here is to make it easier for us to update kernels on
> Chromebooks),

Lovely. Not just for any performance work that comes out of this, but
hopefully this means that we'll also have quick problem reports if
something happens that affects chrome.

There's certainly been issues on the server side of google where we
made changes (*cough*cgroup*cough*) which didn't make anybody really
blink until years after the fact.. Which ends up being very
inconvenient when other parts of the community have been using the new
features for years.

> and the second is to drive more stuff into the
> kernelci.org infrastructure.  Given the test environments we have in
> place now, we can probably get results from our continuous rebase
> project first and provide those against -rc releases if that's
> something you'd be interested in.

I think the more automated (or regular, or close-to-upstream)
real-world testing that we get, the better off we are.  We have a
number of regular distributions that track the upstream kernel fairly
closely, so we get a fair amount of coverage for the normal desktop
loads.

And the bots are doing great, but they tend to test very specific
things (in the case of "syzbot" the "specific" thing is obviously
pretty far-ranging, but it's still very small details). And latency
has always been harder to really test (outside of the truly trivial
microbenchmarks), so the fact that it sounds like you're going to test
not only a different environment than the usual distros but have a few
macro-level latency tests just sounds lovely in general.

Let's see how lovely I think it is once you start sending regression reports..

                Linus
