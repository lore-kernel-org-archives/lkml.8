Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186E3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB87620721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P+T2oevs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgEUNrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbgEUNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:47:08 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F87FC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:47:08 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z18so5503819qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=44FYlkUrt8i90UVdJutZuc7RtdPIilkJHRfkNsLzvz8=;
        b=P+T2oevsrMwt9Bij/ihxWdOK8KwWgzy8u/kkA0uyB1t4fxz8j7sEd+WZmQ3/qGW3vN
         4ijlnbA8I678sfzZbNUQsycLFzDdAmEkXA1kpZdK1DWvladeb6rGOd31JzlAPiEcwlL7
         IpdP4mo0Lsoyu3jqWkn6qhcQKg6ltm6tTjIb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=44FYlkUrt8i90UVdJutZuc7RtdPIilkJHRfkNsLzvz8=;
        b=lfxhUAxLeem6+qEay8Qc+StFmh3HIkQDo1BMZ7UONSixLPgaJcvUdNUETGaZOBd5C4
         Yqy+cm70RKc8pC9GYHdRggCGXWtb9GBa9+GLMlzvHANJwUbfLSFYA+ucQI3YKSpucx5A
         S/LS63ywMrssdJzqZ6dHE7HW8FWNSBjz6Q7lPj3mDvVlij+TVEpE+XRJBHcUbaIj7VJd
         TbEg7v7h7QJwlFnPKMwlsjfwQZPeynOpFaqhiqdNl/nwagh0JabnqGu9lXtH25IvK9U6
         WV5xJXvt9HfXta707Tg7OO9+bm5qSZooo2DwpmkMttnGPh4hjfg3DCuKCUOxcmOQclxZ
         YQQw==
X-Gm-Message-State: AOAM531hpJdxaU9CqmSOwpnSLpYGo8g6pG+y9mFprET0ugwUifoz8Wdy
        zFt/GU5kWPp9NZP9x7f7zUwCWg==
X-Google-Smtp-Source: ABdhPJw9Tvzcr/XATyOG/O6EqPKbtZISWNLdDVGk6HNso6/Rw7ShAMsvHaPcUCOEz3TK6HJj8vfwfQ==
X-Received: by 2002:ac8:6b84:: with SMTP id z4mr10903446qts.227.1590068826804;
        Thu, 21 May 2020 06:47:06 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m6sm4794876qkc.4.2020.05.21.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:47:06 -0700 (PDT)
Date:   Thu, 21 May 2020 09:47:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling interface
Message-ID: <20200521134705.GA140701@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org>
 <20200521085122.GF325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521085122.GF325280@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
Thanks for the comments.

On Thu, May 21, 2020 at 10:51:22AM +0200, Peter Zijlstra wrote:
> On Wed, May 20, 2020 at 06:26:42PM -0400, Joel Fernandes (Google) wrote:
> > Add a per-thread core scheduling interface which allows a thread to tag
> > itself and enable core scheduling. Based on discussion at OSPM with
> > maintainers, we propose a prctl(2) interface accepting values of 0 or 1.
> >  1 - enable core scheduling for the task.
> >  0 - disable core scheduling for the task.
> 
> Yeah, so this is a terrible interface :-)

I tried to keep it simple. You are right, lets make it better.

> It doens't allow tasks for form their own groups (by for example setting
> the key to that of another task).

So for this, I was thinking of making the prctl pass in an integer. And 0
would mean untagged. Does that sound good to you?

> It is also horribly ill defined what it means to 'enable', with whoem
> is it allows to share a core.

I couldn't parse this. Do you mean "enabling coresched does not make sense if
we don't specify whom to share the core with?"

> > Special cases:
> 
> > (1)
> > The core-scheduling patchset contains a CGroup interface as well. In
> > order for us to respect users of that interface, we avoid overriding the
> > tag if a task was CGroup-tagged because the task becomes inconsistent
> > with the CGroup tag. Instead return -EBUSY.
> > 
> > (2)
> > If a task is prctl-tagged, allow the CGroup interface to override
> > the task's tag.
> 
> OK, so cgroup always wins; is why is that a good thing?

I was just trying to respect the functionality of the CGroup patch in the
coresched series, after all a gentleman named Peter Zijlstra wrote that
patch ;-) ;-).

More seriously, the reason I did it this way is the prctl-tagging is a bit
incompatible with CGroup tagging:

1. What happens if 2 tasks are in a tagged CGroup and one of them changes
their cookie through prctl? Do they still remain in the tagged CGroup but are
now going to not trust each other? Do they get removed from the CGroup? This
is why I made the prctl fail with -EBUSY in such cases.

2. What happens if 2 tagged tasks with different cookies are added to a
tagged CGroup? Do we fail the addition of the tasks to the group, or do we
override their cookie (like I'm doing)?

> > ChromeOS will use core-scheduling to securely enable hyperthreading.
> > This cuts down the keypress latency in Google docs from 150ms to 50ms
> > while improving the camera streaming frame rate by ~3%.
> 
> It doesn't consider permissions.
> 
> Basically, with the way you guys use it, it should be a CAP_SYS_ADMIN
> only to enable core-sched.

True, we were relying on the seccomp sandboxing in ChromeOS to protect the
prctl but you're right and I fixed it for next revision.

> That also means we should very much default to disable.

This is how it is already.

thanks,

 - Joel

