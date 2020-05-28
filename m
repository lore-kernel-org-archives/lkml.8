Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660A5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467B2207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vlerUmdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405778AbgE1SXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405744AbgE1SX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:23:28 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2BCC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:23:28 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v79so4020358qkb.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jUE11Y1zJ1Tl4fLukMQ9czYQe08xD80kHxTSnP4G7u4=;
        b=vlerUmdoTTV0h6PVlMN6uV7AORUgYR3hNxnZZFpoF2skLxgadPogBt/Kk7PZTKKgem
         LDBLFSUrbGe+DOlQ+lge0de4T2qoHUR5RNYBMWEViX0q1LqdESd2rKvaMSfwuHCmn7DC
         FGNDOn0hvIUKllzvfgFS4s44Qp32YpSMwto2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jUE11Y1zJ1Tl4fLukMQ9czYQe08xD80kHxTSnP4G7u4=;
        b=o37AYG3xoLOx5hI2Ad3P5VsFimnj/PCKtEtQSMavw0C/VurcQApMQCQrZPxZar4eeT
         dYklDiXUW4CB2JQ5c+IosEzOM0oh+GBxuLVFBSqDUwSss4p1Hjb9xU8Xxqajgl4Tlkd/
         X53h5d6a63V4txdfZ1nHokpa95bwo6Vm7jXIWfdZLva6RprP3w0RpmwjxtceeJG+ste/
         C8rP2EzOtfBR+d177eZl/XHnwDY4u6n8zXG1FF267Tb3wMdzBzuEYTvQOoIpEi6yb7aO
         736EtxRt+LkT0gFdl4Is2KEpP2tllpLVqZg/Xrjj9uIHs3mISS0SawZRYQFMVmHZu5sP
         xsIg==
X-Gm-Message-State: AOAM533Iz5gFq/A7Awr/BY9btMP6ZK+skgwaOs8DQDAMYY/wFk/eAUrO
        cafnAQRo1xVvMnNvAN3EoSjAMg==
X-Google-Smtp-Source: ABdhPJxuk9tx6GdFvWhLaf6TqLpuArfwhIMQJm0Ig5RYKkcDBVm41T3ezaQXW8cN5pORtOuejiOaJQ==
X-Received: by 2002:a37:9781:: with SMTP id z123mr4190669qkd.266.1590690207201;
        Thu, 28 May 2020 11:23:27 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t75sm1217463qke.35.2020.05.28.11.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:23:26 -0700 (PDT)
Date:   Thu, 28 May 2020 14:23:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling interface
Message-ID: <20200528182325.GA176149@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org>
 <20200521085122.GF325280@hirez.programming.kicks-ass.net>
 <20200521134705.GA140701@google.com>
 <20200522125905.GM325280@hirez.programming.kicks-ass.net>
 <20200522213524.GD213825@google.com>
 <20200524140046.GA5598@lorien.usersys.redhat.com>
 <20200528170128.GN2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528170128.GN2483@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, May 28, 2020 at 07:01:28PM +0200, Peter Zijlstra wrote:
> On Sun, May 24, 2020 at 10:00:46AM -0400, Phil Auld wrote:
> > On Fri, May 22, 2020 at 05:35:24PM -0400 Joel Fernandes wrote:
> > > On Fri, May 22, 2020 at 02:59:05PM +0200, Peter Zijlstra wrote:
> > > [..]
> > > > > > It doens't allow tasks for form their own groups (by for example setting
> > > > > > the key to that of another task).
> > > > > 
> > > > > So for this, I was thinking of making the prctl pass in an integer. And 0
> > > > > would mean untagged. Does that sound good to you?
> > > > 
> > > > A TID, I think. If you pass your own TID, you tag yourself as
> > > > not-sharing. If you tag yourself with another tasks's TID, you can do
> > > > ptrace tests to see if you're allowed to observe their junk.
> > > 
> > > But that would require a bunch of tasks agreeing on which TID to tag with.
> > > For example, if 2 tasks tag with each other's TID, then they would have
> > > different tags and not share.
> 
> Well, don't do that then ;-)

We could also guard it with a mutex. First task to set the TID wins, the
other thread just reuses the cookie of the TID that won.

But I think we cannot just use the TID value as the cookie, due to TID
wrap-around and reuse. Otherwise we could accidentally group 2 tasks. Instead, I
suggest let us keep TID as the interface per your suggestion and do the
needed ptrace checks, but convert the TID to the task_struct pointer value
and use that as the cookie for the group of tasks sharing a core.

Thoughts?

thanks,

 - Joel

> > > What's wrong with passing in an integer instead? In any case, we would do the
> > > CAP_SYS_ADMIN check to limit who can do it.
> 
> So the actual permission model can be different depending on how broken
> the hardware is.
> 
> > > Also, one thing CGroup interface allows is an external process to set the
> > > cookie, so I am wondering if we should use sched_setattr(2) instead of, or in
> > > addition to, the prctl(2). That way, we can drop the CGroup interface
> > > completely. How do you feel about that?
> > >
> > 
> > I think it should be an arbitrary 64bit value, in both interfaces to avoid
> > any potential reuse security issues.
> > 
> > I think the cgroup interface could be extended not to be a boolean but take
> > the value. With 0 being untagged as now.
> 
> How do you avoid reuse in such a huge space? That just creates yet
> another problem for the kernel to keep track of who is who.
> 
> With random u64 numbers, it even becomes hard to determine if you're
> sharing at all or not.
> 
> Now, with the current SMT+MDS trainwreck, any sharing is bad because it
> allows leaking kernel privates. But under a less severe thread scenario,
> say where only user data would be at risk, the ptrace() tests make
> sense, but those become really hard with random u64 numbers too.
> 
> What would the purpose of random u64 values be for cgroups? That only
> replicates the problem of determining uniqueness there. Then you can get
> two cgroups unintentionally sharing because you got lucky.
> 
> Also, fundamentally, we cannot have more threads than TID space, it's a
> natural identifier.
