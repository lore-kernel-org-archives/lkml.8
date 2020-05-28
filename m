Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CE9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF082073B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHSXi142"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405767AbgE1SRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:17:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405735AbgE1SRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590689851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0aw5FkIJmuAbWTjzj646tyeDUOeCBjK1uXdDis+EquY=;
        b=RHSXi142xhtNJmndKau7docS1X41XZBj35NGHrrw71P/xcic0/7j4ze/YkDAnk/tLdp7NU
        BwGUAqow4Tfy1dQ6Nxwsr/cbcmDA5gkAt66wMP389C6jdFPrcX0T9cAjNwI3kfyXLnSXP1
        DZiEmMtyPCyLUqiMrh3EcK0ExW8Mo5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-mo6Rypq4PMqzQZPux6zIAQ-1; Thu, 28 May 2020 14:17:27 -0400
X-MC-Unique: mo6Rypq4PMqzQZPux6zIAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7B10107B7CA;
        Thu, 28 May 2020 18:17:24 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-31.phx2.redhat.com [10.3.114.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE2DE5F7EA;
        Thu, 28 May 2020 18:17:17 +0000 (UTC)
Date:   Thu, 28 May 2020 14:17:15 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <20200528181715.GC26442@lorien.usersys.redhat.com>
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
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 07:01:28PM +0200 Peter Zijlstra wrote:
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
>

That was a poorly worded example :)

The point I was trying to make was more that one TID of a group (not cgroup!)
of tasks is just an arbitrary value.

At a single process (or pair rather) level, sure, you can see it as an
identifier of whom you want to share with, but even then you have to tag
both processes with this. And it has less meaning when the whom you want to
share with is mutltiple tasks.

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

The kernel doesn't care or have to track anything.  The admin does.
At the kernel level it's just matching cookies. 

Tasks A,B,C all can share core so you give them each A's TID as a cookie.
Task A then exits. Now B and C are using essentially a random value.
Task D comes along and want to share with B and C. You have to tag it
with A's old TID, which has no meaning at this point.

And if A's TID ever gets reused. The new A` gets to share too. At some
level aren't those still 32bits? 

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

Seems that would be more flexible for the admin. 

What if you had two cgroups you wanted to allow to run together?  Or a
cgroup and a few processes from a different one (say with different
quotas or something).

I don't have such use cases so I don't feel that strongly but it seemed
more flexible and followed the mechanism-in-kernel/policy-in-userspace
dictum rather than basing the functionality on the implementation details.


Cheers,
Phil


> Also, fundamentally, we cannot have more threads than TID space, it's a
> natural identifier.
> 

-- 

