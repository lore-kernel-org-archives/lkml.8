Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77B1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10D620723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rTJKxZcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgEVM7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgEVM7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:59:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F26C05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YVfc7SiyzoogxVJFfdDGGh7+zHJ0Lb5CyJPw53pfYto=; b=rTJKxZcx7v5At6aOBDYNjsSJva
        QDUp0T0VXVpoH4LAUsfb7lgZ5lqA3/K3vs5D1J3+eMwidJQ6qxAVStbmHIAWkXrra6IedH+DUaGYF
        CjGqIppjkp4YRa5kZXtBkrwtXV84SxGbGtdsaIY1MP3spQ5IJ54ZEDLhXUMSdZbC030E7v4r9A7Jg
        AlyBZUxi75yt6xsBOOwcGxzsnikPsiRtL1h+5tjlrCf9sHQxTdpYWfiftciM9FN4qQiKwo3TTfiVv
        5N3oC6PmG2rZqHiEq191i0pvnVbqaWX9UZ7v4jqfvp2RvdidJewDjU9ntsLMR1mrgGay51UmjWvfW
        6FjWV9Cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jc7GW-0001V8-Er; Fri, 22 May 2020 12:59:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6BD203062C2;
        Fri, 22 May 2020 14:59:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A160201479BB; Fri, 22 May 2020 14:59:05 +0200 (CEST)
Date:   Fri, 22 May 2020 14:59:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20200522125905.GM325280@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org>
 <20200521085122.GF325280@hirez.programming.kicks-ass.net>
 <20200521134705.GA140701@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521134705.GA140701@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 09:47:05AM -0400, Joel Fernandes wrote:
> Hi Peter,
> Thanks for the comments.
> 
> On Thu, May 21, 2020 at 10:51:22AM +0200, Peter Zijlstra wrote:
> > On Wed, May 20, 2020 at 06:26:42PM -0400, Joel Fernandes (Google) wrote:
> > > Add a per-thread core scheduling interface which allows a thread to tag
> > > itself and enable core scheduling. Based on discussion at OSPM with
> > > maintainers, we propose a prctl(2) interface accepting values of 0 or 1.
> > >  1 - enable core scheduling for the task.
> > >  0 - disable core scheduling for the task.
> > 
> > Yeah, so this is a terrible interface :-)
> 
> I tried to keep it simple. You are right, lets make it better.
> 
> > It doens't allow tasks for form their own groups (by for example setting
> > the key to that of another task).
> 
> So for this, I was thinking of making the prctl pass in an integer. And 0
> would mean untagged. Does that sound good to you?

A TID, I think. If you pass your own TID, you tag yourself as
not-sharing. If you tag yourself with another tasks's TID, you can do
ptrace tests to see if you're allowed to observe their junk.

> > It is also horribly ill defined what it means to 'enable', with whoem
> > is it allows to share a core.
> 
> I couldn't parse this. Do you mean "enabling coresched does not make sense if
> we don't specify whom to share the core with?"

As a corrolary yes. I mostly meant that a blanket 'enable' doesn't
specify a 'who' you're sharing your bits with.

> > OK, so cgroup always wins; is why is that a good thing?
> 
> I was just trying to respect the functionality of the CGroup patch in the
> coresched series, after all a gentleman named Peter Zijlstra wrote that
> patch ;-) ;-).

Yeah, but I think that same guy said that that was a shit interface and
only hacked up because it was easy :-)

> More seriously, the reason I did it this way is the prctl-tagging is a bit
> incompatible with CGroup tagging:
> 
> 1. What happens if 2 tasks are in a tagged CGroup and one of them changes
> their cookie through prctl? Do they still remain in the tagged CGroup but are
> now going to not trust each other? Do they get removed from the CGroup? This
> is why I made the prctl fail with -EBUSY in such cases.
> 
> 2. What happens if 2 tagged tasks with different cookies are added to a
> tagged CGroup? Do we fail the addition of the tasks to the group, or do we
> override their cookie (like I'm doing)?

For #2 I think I prefer failure.

But having the rationale spelled out in documentation (man-pages for
example) is important.

> > > ChromeOS will use core-scheduling to securely enable hyperthreading.
> > > This cuts down the keypress latency in Google docs from 150ms to 50ms
> > > while improving the camera streaming frame rate by ~3%.
> > 
> > It doesn't consider permissions.
> > 
> > Basically, with the way you guys use it, it should be a CAP_SYS_ADMIN
> > only to enable core-sched.
> 
> True, we were relying on the seccomp sandboxing in ChromeOS to protect the
> prctl but you're right and I fixed it for next revision.

With the TID idea above you get the ptrace tests.
