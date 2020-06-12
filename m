Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4C5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A9620663
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="gxmrCvV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFLVcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLVcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:32:15 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CADC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:32:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g5so8488858otg.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfr41w//Iq6L4D29Brj7mYe/GuqFaOrY8l4abvR0PaM=;
        b=gxmrCvV5G1tix2wqvkHSkUTHm+oaINr1b8AyqOq6bo39chOaqPPPR81ikDfZtLP83n
         OMthIbM/WujWSlAItMzXDr6C+faqOEqz6CEoMrH4kAWzykiX2XbMxjXba2/xqDbXdPfk
         TloJErwLik7sc+O+HBoZQ0keJVlRhGW2NBXHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfr41w//Iq6L4D29Brj7mYe/GuqFaOrY8l4abvR0PaM=;
        b=b9LMS3sqQBbn4FMHd1oD0ty2jsKNFQGKFj5a6YRjToNJebVn/o7/Y1j2OD27aqeKCs
         PnS7HjqweHpiJJRhq9Ps0npqoPiuQBoZQWWgvRvNc51fuuNAhhmfUbbkgtLxlK2lTJFw
         mBhmfBKJGGoNR9/C1bsCqX1ojTXcZIOsicT1msnuuvFxXLC6IH+eKHv0jQQbr0Oy4Kml
         wMXNLWpWSx+FSSziYqp1ES5YJY3YEZ9UAY/T2kREPpK7+awfdvM7l324bDNVHY1zFCVC
         r7Lrm7aSB3kyIjLk2iDWoNLNtnHhZRRwTenYYIpNlqLinsNQRDN0yjHQ5RPTpm05XSQ/
         OJvg==
X-Gm-Message-State: AOAM5310W/rJKfRbWdQlMNvPheURctjrUpYy//mW3/J6Wr/I6GAf0bdN
        4E4Ff1+/ElelITsDgveHYXI9gtEXTbjQFc1ydPZTbA==
X-Google-Smtp-Source: ABdhPJzziaOSH6RgwPaiwCafdrgPRaEhFGRSWyD75B8TyzJ/qs0fH1xd7NTn3AznF5fTqNnjaKJc/2A5XybHfWfh/6M=
X-Received: by 2002:a9d:186:: with SMTP id e6mr12528017ote.33.1591997532855;
 Fri, 12 Jun 2020 14:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <279f7f6606ea18e14d64517840bcada56deb0ce3.1583332765.git.vpillai@digitalocean.com>
 <20200612132127.GA90012@google.com>
In-Reply-To: <20200612132127.GA90012@google.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Fri, 12 Jun 2020 17:32:01 -0400
Message-ID: <CANaguZDguzOCvNmO1u7CZQU2DSFW0+uPt7ZwL18w4bG=-_Xe3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 11/13] sched: migration changes for core scheduling
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 9:21 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > +#ifdef CONFIG_SCHED_CORE
> > +             if (available_idle_cpu(cpu) &&
> > +                 sched_core_cookie_match(cpu_rq(cpu), p))
> > +                     break;
> > +#else
>
> select_idle_cpu() is called only if no idle core could be found in the LLC by
> select_idle_core().
>
> So, would it be better here to just do the cookie equality check directly
> instead of calling the sched_core_cookie_match() helper?  More so, because
> select_idle_sibling() is a fastpath.
>
Agree, this makes sense to me.

> AFAIR, that's what v4 did:
>
>                 if (available_idle_cpu(cpu))
> #ifdef CONFIG_SCHED_CORE
>                         if (sched_core_enabled(cpu_rq(cpu)) &&
>                             (p->core_cookie == cpu_rq(cpu)->core->core_cookie))
>                                 break;
> #else
>                         break;
> #endif
>
This patch was initially not in v4 and this is a merging of 4 patches
suggested post-v4. During the initial round, code was like above. But since
there looked like a code duplication in the different migration paths,
it was consolidated into sched_core_cookie_match() and it caused this
extra logic to this specific code path. As you mentioned, I also feel
we do not need to check for core idleness in this path.

Thanks,
Vineeth
