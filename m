Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C23DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F117208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpT91/Q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEHLFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:05:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58415 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726598AbgEHLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588935951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OyMx9aVUSu/DmTgJ6+OJtrR2qw2jHoUm0ebz2iMPXwE=;
        b=VpT91/Q4XjDtisLR7u/EHS8Z8K0VrENrDfN/zFtURUCbDXn1OY4uS+T4QSpeZDUxtmjZ1A
        45Vw1Z6kiVr4WqsVbQw9b8gCXFaB+3q1N+xKaYA6tl9YC4fUh/7qU/b3gowYkAxXzhc5Ff
        K3dMP5M4SZZjYR3RDHr/kpTHaA+5ImA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-4dTSnNzXNUG5belI-mozug-1; Fri, 08 May 2020 07:05:49 -0400
X-MC-Unique: 4dTSnNzXNUG5belI-mozug-1
Received: by mail-ej1-f70.google.com with SMTP id j21so594711ejs.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 04:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OyMx9aVUSu/DmTgJ6+OJtrR2qw2jHoUm0ebz2iMPXwE=;
        b=kf+IP4FA1IfpxNBzmwp2B8rwZIcqhTCCrw9FGhYM3sxY7IfKOuHfMcXnZS4LI0Pi0u
         /Nc34QKaL97U2707UneopbL8/Ae04r9zVweMJQ7MfM7T1mUt94hgQtddWyPmP7qylVEZ
         ixlRpwymkCwH/SH9PsoUmjJpvHaGJO0cTeUmlUFtmF2sv1UIKuDRrFzN6fAEGguoAGGB
         gMHcGHr+8bg14llmuyio5x95q67MaQNMhcsrILhBX4IU6dn/liks3J7tuM1SjANkaEL0
         bCq6VkA9YXTOe9N0MUFURzi/l3ULLBfxaEeayO1El8LSxnWFN0JV0BGqh/XBgF5PWy67
         5e4g==
X-Gm-Message-State: AGi0PuYEupwmlvkCZGthjmeDdeuTKNv8YqFy5YG416E/U86wJ8QRl1t8
        clM1CboMpf27DoIl/TFrOSHxQfMSw7JeWscNqMW+ZDETZDJUi6HyaqHrDykkAtekdhxMoxNgc+4
        ZoqyeWWTG5UuVQCJE0YsanUZjne3u8bnhudL6y1Rn
X-Received: by 2002:a17:906:4919:: with SMTP id b25mr1423997ejq.280.1588935947994;
        Fri, 08 May 2020 04:05:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypIrdmBnsLT6dHwjgKDq2PccbrBwdIiUdqtb64bL67SMEXzSd8xZvWOqjvyRgApQPG1S2PuHs0RUAp9y3JdAjZ4=
X-Received: by 2002:a17:906:4919:: with SMTP id b25mr1423980ejq.280.1588935947734;
 Fri, 08 May 2020 04:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGD8DUEi6JnKd8vrqUL_8HZXnNyHMoK2D+1-F5wo+5Z53Q@mail.gmail.com>
 <20200312214736.GA3818@techsingularity.net> <CAE4VaGCfDpu0EuvHNHwDGbR-HNBSAHY=yu3DJ33drKgymMTTOw@mail.gmail.com>
 <CAE4VaGC09OfU2zXeq2yp_N0zXMbTku5ETz0KEocGi-RSiKXv-w@mail.gmail.com>
 <20200320152251.GC3818@techsingularity.net> <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net> <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net> <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
In-Reply-To: <20200508092212.GE3758@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Fri, 8 May 2020 13:05:36 +0200
Message-ID: <CAE4VaGCWbfFoQ-cmtX+8JJeK1rxPBNchnxY6SQ6MZuUPyWhQNg@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

thanks for hints! We will try it.

@Phil - could you please prepare a kernel build for me to test?

Thank you!
Jirka

On Fri, May 8, 2020 at 11:22 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, May 07, 2020 at 06:29:44PM +0200, Jirka Hladky wrote:
> > Hi Mel,
> >
> > we are not targeting just OMP applications. We see the performance
> > degradation also for other workloads, like SPECjbb2005 and
> > SPECjvm2008. Even worse, it also affects a higher number of threads.
> > For example, comparing 5.7.0-0.rc2 against 5.6 kernel, on 4 NUMA
> > server with 2x AMD 7351 CPU, we see performance degradation 22% for 32
> > threads (the system has 64 CPUs in total). We observe this degradation
> > only when we run a single SPECjbb binary. When running 4 SPECjbb
> > binaries in parallel, there is no change in performance between 5.6
> > and 5.7.
> >
>
> Minimally I suggest confirming that it's really due to
> adjust_numa_imbalance() by making the function a no-op and retesting.
> I have found odd artifacts with it but I'm unsure how to proceed without
> causing problems elsehwere.
>
> For example, netperf on localhost in some cases reported a regression
> when the client and server were running on the same node. The problem
> appears to be that netserver completes its work faster when running
> local and goes idle more regularly. The cost of going idle and waking up
> builds up and a lower throughput is reported but I'm not sure if gaming
> an artifact like that is a good idea.
>
> > That's why we are asking for the kernel tunable, which we would add to
> > the tuned profile. We don't expect users to change this frequently but
> > rather to set the performance profile once based on the purpose of the
> > server.
> >
> > If you could prepare a patch for us, we would be more than happy to
> > test it extensively. Based on the results, we can then evaluate if
> > it's the way to go. Thoughts?
> >
>
> I would suggest simply disabling that function first to ensure that is
> really what is causing problems for you.
>
> --
> Mel Gorman
> SUSE Labs
>


-- 
-Jirka

