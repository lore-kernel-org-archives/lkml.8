Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D0A20679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JPQNbT6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbgEVVf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731081AbgEVVf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:35:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B8C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:35:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m44so9474449qtm.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EuUZVbTif3KQTMtt1mwZXN/LBHx9eL4POQtyuv8bdnA=;
        b=JPQNbT6Ni7OZV8qKbVNQLcMjnTzGnwPjU5KG7KgcIjKClsZWST+bh9K81Zr54rNKhm
         xsmCvVsQtMpftVrfyomb3fGA79Y7rYnOS2CIEpD68wHozmdcq9uBwpm4b5h7SCa8O/Nd
         0WfIdkPbUQeD7XeYv0O/OIh+oIopfo7XT7LqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EuUZVbTif3KQTMtt1mwZXN/LBHx9eL4POQtyuv8bdnA=;
        b=bX4RRyQJ1D3SQ7EupXv5tQdPJIK/MJ2jFKkw2wtbvYh0++gmoWwp6WZiYjNfjNEXuW
         wvZodkWJ6ZdeusQ/iHz0wHtnqDfS9spUaSjFURcLTOlAnSIhWP39yHcIOU5J+HSUpC3B
         xB0v4GEX+gbhnfgMASUNC4R76WVaz40AKUzrOQDD/Ns9JLZTbV1luvxKqqXRpSkGQbxl
         5yZFYmrkuS0k1fPvUzpwcPhYQ0rpxLaGDGjYKtIc3TNIbhh5GHl4CCB5bQ3RWWBrfHXW
         0oHXfRUFfs2cDChUp+Gw550s+y/1GgAKBPU+PVIYR4Y/+mOuFYlj6hPHCoxakXRsO3dH
         g+nQ==
X-Gm-Message-State: AOAM532N2xz3APmsO+LPCFUpLfQUfe05kNn3mrQ7PxN32gNGZbl6XlK2
        peTCrfyAT+oiPF2trdKW1Bc5mw==
X-Google-Smtp-Source: ABdhPJx1ZB1UAww7/066KI1b06h/rdiyGJZxo7XNaWn/YGkmLv+5q1lN3BnA4G69ze3SdFZvWVja4Q==
X-Received: by 2002:ac8:36a3:: with SMTP id a32mr18242439qtc.196.1590183325989;
        Fri, 22 May 2020 14:35:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u129sm7976590qkb.51.2020.05.22.14.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:35:24 -0700 (PDT)
Date:   Fri, 22 May 2020 17:35:24 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling interface
Message-ID: <20200522213524.GD213825@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org>
 <20200521085122.GF325280@hirez.programming.kicks-ass.net>
 <20200521134705.GA140701@google.com>
 <20200522125905.GM325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522125905.GM325280@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 02:59:05PM +0200, Peter Zijlstra wrote:
[..]
> > > It doens't allow tasks for form their own groups (by for example setting
> > > the key to that of another task).
> > 
> > So for this, I was thinking of making the prctl pass in an integer. And 0
> > would mean untagged. Does that sound good to you?
> 
> A TID, I think. If you pass your own TID, you tag yourself as
> not-sharing. If you tag yourself with another tasks's TID, you can do
> ptrace tests to see if you're allowed to observe their junk.

But that would require a bunch of tasks agreeing on which TID to tag with.
For example, if 2 tasks tag with each other's TID, then they would have
different tags and not share.

What's wrong with passing in an integer instead? In any case, we would do the
CAP_SYS_ADMIN check to limit who can do it.

Also, one thing CGroup interface allows is an external process to set the
cookie, so I am wondering if we should use sched_setattr(2) instead of, or in
addition to, the prctl(2). That way, we can drop the CGroup interface
completely. How do you feel about that?

> > > It is also horribly ill defined what it means to 'enable', with whoem
> > > is it allows to share a core.
> > 
> > I couldn't parse this. Do you mean "enabling coresched does not make sense if
> > we don't specify whom to share the core with?"
> 
> As a corrolary yes. I mostly meant that a blanket 'enable' doesn't
> specify a 'who' you're sharing your bits with.

Yes, ok. I can reword the commit log a bit to make it more clear that we are
specifying who we can share a core with.

> > I was just trying to respect the functionality of the CGroup patch in the
> > coresched series, after all a gentleman named Peter Zijlstra wrote that
> > patch ;-) ;-).
> 
> Yeah, but I think that same guy said that that was a shit interface and
> only hacked up because it was easy :-)

Fair enough :-)

> > More seriously, the reason I did it this way is the prctl-tagging is a bit
> > incompatible with CGroup tagging:
> > 
> > 1. What happens if 2 tasks are in a tagged CGroup and one of them changes
> > their cookie through prctl? Do they still remain in the tagged CGroup but are
> > now going to not trust each other? Do they get removed from the CGroup? This
> > is why I made the prctl fail with -EBUSY in such cases.
> > 
> > 2. What happens if 2 tagged tasks with different cookies are added to a
> > tagged CGroup? Do we fail the addition of the tasks to the group, or do we
> > override their cookie (like I'm doing)?
> 
> For #2 I think I prefer failure.
> 
> But having the rationale spelled out in documentation (man-pages for
> example) is important.

If we drop the CGroup interface, this would avoid both #1 and #2.

thanks,

 - Joel

