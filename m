Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B9AC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAE920728
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="l3NLCWBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgAOQzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:55:47 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:37901 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAOQzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:55:46 -0500
Received: by mail-qk1-f175.google.com with SMTP id k6so16281249qki.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 08:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FPFBNeVEX0/iA2zW+3P39jtu411peuzYQwYNyRGywAY=;
        b=l3NLCWBQOEKrvK2JK/Zpgr1tIdj/9joXe8PKlcfxKiMKnFz6Beu1JSdeUL+m4r/BpU
         wakcl80DcORdCiYIOh9k2O+yVImroYtnNb/mf7XhtZHrVpKKloy0lhzN0w9Ebw5M219e
         iCaGujiyLPqRiPi6TLC09B6pF/dRPzOXZKtJaYQMqj5i3k0DsuCl53s0aJg+Tg0+qz/Y
         Z0/qHGpBkefnRS44gN79nUqYQl3NHdYexV3fh8HNY3TnqjdjTiiHl1FjQh1kt0bdwA6d
         UFB8o0dsA4Nj26djQO9e+dlfrZr/gLfwTWniIWcTVLjhIQ7J8omXsDKnz0uluJ56sllX
         9bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPFBNeVEX0/iA2zW+3P39jtu411peuzYQwYNyRGywAY=;
        b=ip9SkQOsNVcAqYRqs5mwh8+bZxEOhuIa4R1yR9bx9pTFRX0cLkq57QZAQ86Bsz3mci
         MdTCZ0WxKoDd4q1iNhK6l6oLYDE1g8nuhI6JJ6OzqtwVbtLqyzLXnEup98wQ89qLAoGT
         kcxyEhnu3ZOSoOqQzS8F+jqO9OB9ttkqzzKvOkb7MuzT4YRoyf1nS9AJaqaahal8oDmg
         ylY2JI2HzXOU/Ne582nUzvdRsFF58hdUs8oTK0vY6aZv81hBODhik5f4pefnQj4SaNE6
         vMg4mVIOW/1BbDzf9eEkiy4ZybGQrJ3ZgqyNJliPngztypqGik6TwPnHjzixSbMO1APy
         6SXw==
X-Gm-Message-State: APjAAAVlHGfJ0DFSToNRfS1BUH2VTcRA6jnI3rj5bl9qCNKVXMFXOoBD
        cgCsuOG92FvhkgHlt1yMxqGNW3cUh2A=
X-Google-Smtp-Source: APXvYqzhOz4JR1/HdclghA76Mn55l8him78waefGfymoKZLbbSR4NLC0xIPzpN27WDG45b1iUiylCQ==
X-Received: by 2002:a05:620a:139b:: with SMTP id k27mr28027169qki.112.1579107345574;
        Wed, 15 Jan 2020 08:55:45 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id k4sm8698193qki.35.2020.01.15.08.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 08:55:44 -0800 (PST)
Date:   Wed, 15 Jan 2020 11:55:43 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: Lower than expected CPU pressure in PSI
Message-ID: <20200115165543.GA47772@cmpxchg.org>
References: <CABWYdi25Y=zrfdnitT3sSgC3UqcFHfz6-N2YP7h2TJai=JH_zg@mail.gmail.com>
 <20200109161632.GB8547@cmpxchg.org>
 <CABWYdi1Hs3Jgn5Rq=4X9w2+kG4mfsbGuV=8UMS=6mr=SVjOfVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi1Hs3Jgn5Rq=4X9w2+kG4mfsbGuV=8UMS=6mr=SVjOfVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:28:32AM -0800, Ivan Babrou wrote:
> I applied the patch on top of 5.5.0-rc3 and it's definitely better
> now, both competing cgroups report 500ms/s delay. Feel free to add
> Tested-by from me.

Thanks, Ivan!

> I'm still seeing /unified/system.slice at 385ms/s and /unified.slice
> at 372ms/s, do you have an explanation for that part? Maybe it's
> totally reasonable, but warrants a patch for documentation.

Yes, this is a combination of CPU pinning and how pressure is
calculated in SMP systems.

The stall times are defined as lost compute potential - which scales
with the number of concurrent threads - normalized to wallclock
time. See the "Multiple CPUs" section in kernel/sched/psi.c.

By restricting the CPUs in system.slice, there is less compute
available in that group than in the parent, which means that the
relative loss of potential can be higher.

It's a bit unintuitive because most cgroup metrics are plain numbers
that add up to bigger numbers as you go up the tree. If we exported
both the numerator (waste) and denominator (compute potential) here,
the numbers would act more conventionally, with parent numbers always
bigger than the child's. But because pressure is normalized to
wallclock time, you only see the ratio at each level, and that can
shrink as you go up the tree if lower levels are CPU-constrained.

We could have exported both numbers, but for most usecases that would
be more confusing than helpful. And in practice it's the ratio that
really matters: the pressure in the leaf cgroups is high due to the
CPU restriction; but when you go higher up the tree and look at not
just the pinned tasks, but also include tasks in other groups that
have more CPUs available to them, the aggregate productivity at that
level *is* actually higher.

I hope that helps!
