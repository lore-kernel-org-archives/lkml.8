Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B6720748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oHMIim3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgEUUkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbgEUUkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:40:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:40:46 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 190so8719835qki.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nS/3XCQOUwQxkN/+ybpYVJRq8cwnaFFhp9azEcrkODs=;
        b=oHMIim3byaor6v3ZOguZWXdnh+aajwbaJCFu5DLMfxfl5MOL4MlgN0f0n+0gXLAtRo
         dL9XoP25uUv0vns46WvKuc01jyYub3cCtN3cFHe51Hno/DngdoK49tRXOuwW1DUqwYvc
         4wMrbqxAb7/9U7fOiM68zzQ7JxvSl0BM3pZ4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nS/3XCQOUwQxkN/+ybpYVJRq8cwnaFFhp9azEcrkODs=;
        b=sfrt9kV14vcHOAqPRZHy0MZgXlkXx4bmMKjLTq/mnFt2Xkri8l8kOSmIuCH0PSf7qk
         baX8V/flumziG4Q43LLHXzO02E+UsxIwB+U6oL+ddHc/bZE7tHtGQbWPoF7oljtGiQLn
         CIgWsNe3s7rx4dOicDFqI+avcEHfraeQqL+fKWDOlOG6mQ7tT0yVMR0M9R4YT7qO+i8g
         qy4Fu3VR8HTX8A37FCc6pQhdQCSMLDjHWgc/XjuGMgIZCQw41Kpswji52oR/WzQL/9Ew
         itS3xi6MZWeVoy4cfyT2FyHb7kpSK2l1nc/dus3eaB7TZfQwtch0LVAdaWKIAhnvQQOv
         uzpw==
X-Gm-Message-State: AOAM530bNFXbfQY067A4SzERzejm6tNbkH4GUvNBRlN5x7QQNiuttdQ7
        bMUgmgysBBOmTllVa8qTOHOC3Q==
X-Google-Smtp-Source: ABdhPJwjzzw5Do5lIeNozUjhmvb/VRgfWAX80KXERbyevUvc+ufUCRzhw7QDXx0FyMxAVzVNxqUQjg==
X-Received: by 2002:a05:620a:1472:: with SMTP id j18mr10680271qkl.363.1590093645264;
        Thu, 21 May 2020 13:40:45 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y21sm5777319qkb.95.2020.05.21.13.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 13:40:44 -0700 (PDT)
Date:   Thu, 21 May 2020 16:40:44 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        vpillai <vpillai@digitalocean.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling interface
Message-ID: <20200521204044.GD140701@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org>
 <CAHk-=wjUXRG53S0mLd8UVG2+cMC=2YLJGB-K_h2TkqHGZ-VSoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUXRG53S0mLd8UVG2+cMC=2YLJGB-K_h2TkqHGZ-VSoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, May 21, 2020 at 11:31:38AM -0700, Linus Torvalds wrote:
> On Wed, May 20, 2020 at 3:26 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > ChromeOS will use core-scheduling to securely enable hyperthreading.
> > This cuts down the keypress latency in Google docs from 150ms to 50ms
> > while improving the camera streaming frame rate by ~3%.
> 
> I'm assuming this is "compared to SMT disabled"?

Yes this is compared to SMT disabled, I'll improve the commit message.

> What is the cost compared to "SMT enabled but no core scheduling"?

With SMT enabled and no core scheduling, it is around 40ms in the higher
percentiles. Also one more thing I wanted to mention, this is the 90th
percentile.

> But the real reason I'm piping up is that your  latency benchmark
> sounds very cool.
> 
> Generally throughput benchmarks are much easier to do, how do you do
> this latency benchmark, and is it perhaps something that could be run
> more widely (ie I'm thinking that if it's generic enough and stable
> enough to be run by some of the performance regression checking
> robots, it would be a much more interesting test-case than some of the
> ones they run right now...)

Glad you like it! The metric is calculated with a timestamp of when the
driver says the key was pressed, up until when the GPU says we've drawn
pixels in response.

The test requires a mostly only requires Chrome browser. It opens some
pre-existing test URLs (a google doc, a window that opens a camera stream and
another window that decodes video). This metric is already calculated in
Chrome, we just scrape it from
chrome://histograms/Event.Latency.EndToEnd.KeyPress.  If you install Chrome,
you can goto this link and see the histogram.  We open a Google docs window
and synthetically input keys into it with a camera stream and video decoding
running in other windows which gives the CPUs a good beating. Then we collect
roughly the 90th percentile keypress latency from the above histogram and the
camera and decoded video's FPS, among other things. There is a test in the
works that my colleagues are writing to run the full Google hangout video
chatting stack to stress the system more (versus just the camera stream).  I
guess if the robots can somehow input keys into the Google docs and open the
right windows, then it is just a matter of scraping the histogram.

> I'm looking at that "threaded phoronix gzip performance regression"
> thread due to a totally unrelated scheduling change ("sched/fair:
> Rework load_balance()"), and then I see this thread and my reaction is
> "the keypress latency thing sounds like a much more interesting
> performance test than threaded gzip from clear linux".
> 
> But the threaded gzip test is presumably trivial to script, while your
> latency test is perhaps very specific to one particular platform and
> setuip?

Yes it is specifically a ChromeOS running on a pixel book running a 7th Gen
Intel Core i7 with 4 hardware threads.
https://store.google.com/us/product/google_pixelbook

I could try to make it a synthetic test but it might be difficult for a robot
to run it if it does not have graphics support and a camera connected to it.
It would then need a fake/emulated camera connected to it. These robots run
Linux in a non-GUI environment in qemu instances right?

thanks,

 - Joel

