Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61647C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B4020738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590086331;
	bh=lHECUQZPonJ+twOcETYPfFj696I308tKqh8GGsdu5V8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vxMTf4x2O2sv0xuvNoCBxN2Z+IGNY7g4hj9prhHXEXhpNAiYu6u1EQapjtND/NYj3
	 7MbXo3Jt87k3n/4nkHOZRhKh/udZWwzgsFMokolgVXoTAfCw1qcwzxit5yd4NNdyky
	 5gqqJ2MIe8VxejRPQL/Lagq6EW1xW1lVUUJEUhSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgEUSiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbgEUSit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:38:49 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7DC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:38:49 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l5so7358993edn.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yrft6eXy+aY+C/nmbJKmKuZKyTimjGnAiz9JkgNsSbY=;
        b=hSVTTmym1pgL9YcNpVDIJBWF6WU0hQ91UA8xDxq8K8H18M/aZmUq/ehn5QhJzi6OSO
         jgDf9RIy4iDoFVM+3CP9qUB0XaV2kJzGcfpJMwvqCu3CWxmG2Sn3g20Dzb9Zjil0FiVX
         xX6BwQrCtncslZ+6UNswXHyLa1VJK+8+P/OCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yrft6eXy+aY+C/nmbJKmKuZKyTimjGnAiz9JkgNsSbY=;
        b=LygSzrQ+UFoLP+x1h/Vn9DWnDV8KOlltyR0Xfoe6nx4nWhWrv8YVSuyHv9d0fZvyOL
         iNCaatePWhZ/TCIo2zjv6RMWgaHrCDLMqOrbqxnGDnVr/8YQuYzvifh6QaSXYo/CMigx
         ez3o4cZs5pu/WouElEKTsWMvgh25hLKlM7qTDiQsr7nfju6C1seKc47hpkOkkJzAoc8U
         7Z+noKpgLAIrjesIs3yLXW60MSc7bUV6Zi8oj2y+dvanGFvgIiDWpm4M6KTJgkmS81Be
         3gvZ7voKNxRdIDcQbMTp/bFZ1VgGe4Efxgmc1IyB+EEhP+Bjcsqolaf9tPc3TSrwq66Z
         46vg==
X-Gm-Message-State: AOAM532Lo1NP56Rp0OldKleEZ5j9/pHVmEf45lzyXOZ4ahMkWdAlX0MF
        JJXj889bLEKT7xt430EPBCL8lIMXBFQ=
X-Google-Smtp-Source: ABdhPJxo1UrSYSPC1odbzbpiFU4n4ovseZ6cS60HClSfEvJRJm756KKNx/+BwKMpwgHNlLdeLNGoTA==
X-Received: by 2002:a50:88c6:: with SMTP id d64mr40612edd.324.1590086327585;
        Thu, 21 May 2020 11:38:47 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id h19sm5494096ejb.66.2020.05.21.11.38.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 11:38:47 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id x1so10040746ejd.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 11:38:47 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr3496127ljc.314.1590085914996;
 Thu, 21 May 2020 11:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com> <20200520222642.70679-1-joel@joelfernandes.org>
In-Reply-To: <20200520222642.70679-1-joel@joelfernandes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 May 2020 11:31:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUXRG53S0mLd8UVG2+cMC=2YLJGB-K_h2TkqHGZ-VSoA@mail.gmail.com>
Message-ID: <CAHk-=wjUXRG53S0mLd8UVG2+cMC=2YLJGB-K_h2TkqHGZ-VSoA@mail.gmail.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling interface
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 3:26 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> ChromeOS will use core-scheduling to securely enable hyperthreading.
> This cuts down the keypress latency in Google docs from 150ms to 50ms
> while improving the camera streaming frame rate by ~3%.

I'm assuming this is "compared to SMT disabled"?

What is the cost compared to "SMT enabled but no core scheduling"?

But the real reason I'm piping up is that your  latency benchmark
sounds very cool.

Generally throughput benchmarks are much easier to do, how do you do
this latency benchmark, and is it perhaps something that could be run
more widely (ie I'm thinking that if it's generic enough and stable
enough to be run by some of the performance regression checking
robots, it would be a much more interesting test-case than some of the
ones they run right now...)

I'm looking at that "threaded phoronix gzip performance regression"
thread due to a totally unrelated scheduling change ("sched/fair:
Rework load_balance()"), and then I see this thread and my reaction is
"the keypress latency thing sounds like a much more interesting
performance test than threaded gzip from clear linux".

But the threaded gzip test is presumably trivial to script, while your
latency test is perhaps very specific to one particular platform and
setuip?

                   Linus
