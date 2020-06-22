Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1865BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DA720702
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpLmTQUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgFVNbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgFVNbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:31:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B2DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 06:31:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so8154086pgn.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sTd7LicY185JjmYkASNJZqode2H0qZcuUtoLofxdYco=;
        b=cpLmTQUZkR6m0WNqPIFfJoZ9+rqMJH+zXIs3tcsWiRgb1S3gyTbh5MPEEtQhzoabKK
         lYXIjIQQAMRcnNDPaECfgEHxRbEEUR/nNXLFlGwaNlOD/8Z8bEMPWAAUdh1PFX4UyR0+
         Avjxcwcz8p+VR8S/7S1jWaEDhgPJkhIfLAXeU5SqVCcyqoI0Nu8eeL/gbhBnXMSIAiHb
         //Fd/L630VCJOHi2hOH+zHctgv7m4TTbM19Dk4vFHzCUIrUQfZGApdbLgCutZPTUb4eb
         Oyiqq9EOOtu3LJhucWjCczpAMA/szf7k6M3BdXvHx3I1CaS1tCTP1qIbfZdQT0WCuF6Z
         AyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sTd7LicY185JjmYkASNJZqode2H0qZcuUtoLofxdYco=;
        b=pV2hblnFZipiFSD0wiv8p0NuT7jQuCh56ctkOMQe0m/UVblvmfO7sKaXW/yQ+zeugB
         PnwJeL/+Qd2GwIkL7VVC+6NdS7e8B0X6TyekNUDSFhI0itZevtK5XSYc8biZRroeyhm2
         5abmReNG2X+P46G4rr2TIvcSaKgriSkUZXWrFYgg0rX6L08ExKOXhX9kALe4PSagoDAW
         gIBXp5gdAdYQz5QgUA00KDlaD3XVWXcQvlQcyhKxQxzR8eOKHOD+O302bMojRjPcoqYD
         Gl1CbVedZNX5LlgwHYxZ1pyZibkb0jluEj/YWUOGboMM7fROX0YwgATEzeaYn+Mu1/bF
         dSxA==
X-Gm-Message-State: AOAM533IPmPEnCNvmr9MX4kN5t11tpOHyWqvNxA787FupABGX6Hrlz7g
        18wT22Txjo76DjKdaP1OpEM=
X-Google-Smtp-Source: ABdhPJz5Pcx7updPydKMqL9WbZmKhD9PEfrHIE0Pbx8A84vNnTbvURamFMdZUuOuRSSDUgUdvRGocg==
X-Received: by 2002:a63:a55e:: with SMTP id r30mr12828963pgu.329.1592832672125;
        Mon, 22 Jun 2020 06:31:12 -0700 (PDT)
Received: from aaronlu-desktop ([47.89.83.71])
        by smtp.gmail.com with ESMTPSA id z140sm14479088pfc.135.2020.06.22.06.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 06:31:11 -0700 (PDT)
Date:   Mon, 22 Jun 2020 21:31:04 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Subject: Re: [RFC PATCH 0/3 v2] futex: introduce FUTEX_SWAP operation
Message-ID: <20200622133104.GA1525@aaronlu-desktop>
References: <f2997cb9e52d0c2b88e6c5d3818a9331ba45ea5c.camel@posk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2997cb9e52d0c2b88e6c5d3818a9331ba45ea5c.camel@posk.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:22:11AM -0700, Peter Oskolkov wrote:
> From 7b091e46de4f9227b5a943e6d78283564e8c1c72 Mon Sep 17 00:00:00 2001
> From: Peter Oskolkov <posk@google.com>
> Date: Tue, 16 Jun 2020 10:13:58 -0700
> Subject: [RFC PATCH 0/3 v2] futex: introduce FUTEX_SWAP operation
> 
> This is an RFC!
> 
> As Paul Turner presented at LPC in 2013 ...
> - pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf
> - video: https://www.youtube.com/watch?v=KXuZi9aeGTw
> 
> ... Google has developed an M:N userspace threading subsystem backed
> by Google-private SwitchTo Linux Kernel API (page 17 in the pdf referenced
> above). This subsystem provides latency-sensitive services at Google with
> fine-grained user-space control/scheduling over what is running when,
> and this subsystem is used widely internally (called schedulers or fibers).
> 
> This RFC patchset is the first step to open-source this work. As explained
> in the linked pdf and video, SwitchTo API has three core operations: wait,
> resume, and swap (=switch). So this patchset adds a FUTEX_SWAP operation
> that, in addition to FUTEX_WAIT and FUTEX_WAKE, will provide a foundation
> on top of which user-space threading libraries can be built.
> 
> Another common use case for FUTEX_SWAP is message passing a-la RPC
> between tasks: task/thread T1 prepares a message,
> wakes T2 to work on it, and waits for the results; when T2 is done, it
> wakes T1 and waits for more work to arrive. Currently the simplest
> way to implement this is
> 
> a. T1: futex-wake T2, futex-wait
> b. T2: wakes, does what it has been woken to do
> c. T2: futex-wake T1, futex-wait
> 
> With FUTEX_SWAP, steps a and c above can be reduced to one futex operation
> that runs 5-10 times faster.

schbench used futex wait/wake to do sleep/wakeup between message thread
and worker thread and when worker thread is 1 per message thread, the
message thread and worker thread is also flipcall style.

So I modified schbench to make use of futex_swap and did a comparison.
In the not overloaded case, both runs roughly the same with futex_swap
performing slightly better. In the overloaded case, futex_swap performs
better than futex wait/wake in all metrics, with 90th seeing the largest
difference: 2556us vs 6us.

I guess when the scheduler change is in place, more latency gain is
expected.

Here is the log of the schbench run(on a 16core/32cpu x86_64 machine):

overloaded case

original schbench(aka futex wait/wake)
$./schbench -m 64 -t 1 -r 30

Latency percentiles (usec)
        50.0000th: 7
        75.0000th: 9
        90.0000th: 2556
        95.0000th: 7112
        *99.0000th: 14160
        99.5000th: 17504
        99.9000th: 22688
        min=0, max=30351

with futex swap
$./schbench -m 64 -t 1 -r 30

Latency percentiles (usec)
        50.0th: 4
        75.0th: 5
        90.0th: 6
        95.0th: 4568
        *99.0th: 12912
        99.5th: 15152
        99.9th: 20384
        min=0, max=30723


not overloaded case

original schbench(aka futex wait/wake)

$./schbench -m 32 -t 1 -r 30
Latency percentiles (usec)
        50.0000th: 6
        75.0000th: 7
        90.0000th: 8
        95.0000th: 9
        *99.0000th: 10
        99.5000th: 12
        99.9000th: 18
        min=0, max=398


with futex swap

$./schbench -m 32 -t 1 -r 30
Latency percentiles (usec)
        50.0th: 4
        75.0th: 5
        90.0th: 5
        95.0th: 6
        *99.0th: 8
        99.5th: 9
        99.9th: 12
        min=0, max=245
