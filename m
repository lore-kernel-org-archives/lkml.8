Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83748C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 14:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE9620776
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 14:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+lwWQQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgEXOBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 10:01:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40131 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729149AbgEXOBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 10:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590328858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKbHCmwkQnDS9Cy+qwvCvj19Zkm1/77I8cc9ukphsYE=;
        b=C+lwWQQRZP+wxLV28CjNB8YT0OBqInXXBN++1cb2L1tSFxULlFDGfKQ0Xn/flwpjgKJcH4
        j5L+aElF6pHXoGMKh81IEfdwf/q37tBChNgxuapvduAcKpmyQdhUN6Jn3k3ypapJVswQ0R
        KuLRLZOqouU5FguykNP7YRF/5ci3Xjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-srTMtUleOVaXFZeDj4GVRw-1; Sun, 24 May 2020 10:00:53 -0400
X-MC-Unique: srTMtUleOVaXFZeDj4GVRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC3E4107ACCD;
        Sun, 24 May 2020 14:00:50 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-112-48.phx2.redhat.com [10.3.112.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 578D25D788;
        Sun, 24 May 2020 14:00:48 +0000 (UTC)
Date:   Sun, 24 May 2020 10:00:46 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20200524140046.GA5598@lorien.usersys.redhat.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org>
 <20200521085122.GF325280@hirez.programming.kicks-ass.net>
 <20200521134705.GA140701@google.com>
 <20200522125905.GM325280@hirez.programming.kicks-ass.net>
 <20200522213524.GD213825@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522213524.GD213825@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 05:35:24PM -0400 Joel Fernandes wrote:
> On Fri, May 22, 2020 at 02:59:05PM +0200, Peter Zijlstra wrote:
> [..]
> > > > It doens't allow tasks for form their own groups (by for example setting
> > > > the key to that of another task).
> > > 
> > > So for this, I was thinking of making the prctl pass in an integer. And 0
> > > would mean untagged. Does that sound good to you?
> > 
> > A TID, I think. If you pass your own TID, you tag yourself as
> > not-sharing. If you tag yourself with another tasks's TID, you can do
> > ptrace tests to see if you're allowed to observe their junk.
> 
> But that would require a bunch of tasks agreeing on which TID to tag with.
> For example, if 2 tasks tag with each other's TID, then they would have
> different tags and not share.
> 
> What's wrong with passing in an integer instead? In any case, we would do the
> CAP_SYS_ADMIN check to limit who can do it.
> 
> Also, one thing CGroup interface allows is an external process to set the
> cookie, so I am wondering if we should use sched_setattr(2) instead of, or in
> addition to, the prctl(2). That way, we can drop the CGroup interface
> completely. How do you feel about that?
>

I think it should be an arbitrary 64bit value, in both interfaces to avoid
any potential reuse security issues. 

I think the cgroup interface could be extended not to be a boolean but take
the value. With 0 being untagged as now.

And sched_setattr could be used to set it on a per task basis.


> > > > It is also horribly ill defined what it means to 'enable', with whoem
> > > > is it allows to share a core.
> > > 
> > > I couldn't parse this. Do you mean "enabling coresched does not make sense if
> > > we don't specify whom to share the core with?"
> > 
> > As a corrolary yes. I mostly meant that a blanket 'enable' doesn't
> > specify a 'who' you're sharing your bits with.
> 
> Yes, ok. I can reword the commit log a bit to make it more clear that we are
> specifying who we can share a core with.
> 
> > > I was just trying to respect the functionality of the CGroup patch in the
> > > coresched series, after all a gentleman named Peter Zijlstra wrote that
> > > patch ;-) ;-).
> > 
> > Yeah, but I think that same guy said that that was a shit interface and
> > only hacked up because it was easy :-)
> 
> Fair enough :-)
> 
> > > More seriously, the reason I did it this way is the prctl-tagging is a bit
> > > incompatible with CGroup tagging:
> > > 
> > > 1. What happens if 2 tasks are in a tagged CGroup and one of them changes
> > > their cookie through prctl? Do they still remain in the tagged CGroup but are
> > > now going to not trust each other? Do they get removed from the CGroup? This
> > > is why I made the prctl fail with -EBUSY in such cases.
> > > 
> > > 2. What happens if 2 tagged tasks with different cookies are added to a
> > > tagged CGroup? Do we fail the addition of the tasks to the group, or do we
> > > override their cookie (like I'm doing)?
> > 
> > For #2 I think I prefer failure.
> > 
> > But having the rationale spelled out in documentation (man-pages for
> > example) is important.
> 
> If we drop the CGroup interface, this would avoid both #1 and #2.
>

I believe both are useful.  Personally, I think the per-task setting should
win over the cgroup tagging. In that case #1 just falls out. And #2 pretty
much as well. Nothing would happen to the tagged task as they were added
to the cgroup. They'd keep their explicitly assigned tags and everything
should "just work". There are other reasons to be in a cpu cgroup together
than just the core scheduling tag.

There are a few other edge cases, like if you are in a cgroup, but have
been tagged explicitly with sched_setattr and then get untagged (presumably
by setting 0) do you get the cgroup tag or just stay untagged? I think based
on per-task winning you'd stay untagged. I supposed you could move out and
back in the cgroup to get the tag reapplied (Or maybe the cgroup interface
could just be reused with the same value to re-tag everyone who's untagged).



Cheers,
Phil


> thanks,
> 
>  - Joel
> 

-- 

