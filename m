Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF371C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8122072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhJpbjvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbgF3OMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:12:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51697 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388818AbgF3OMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593526331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V3Af6hWTp7LBSaBND9ImFa5WyHf1i7dt1HmmPhjgU4Y=;
        b=fhJpbjvw4u0nEThXQgGhGLZVXCoPjizUAvBqZLFRd4mIvnQ2qw4F3B7TA0l1DRiCEZrZXU
        JRhjNRk/afGfjZsLd+Z3xwMXKnaIy8WqZcyk3f+oy0Y/4XSS3kP4H3uWcpYC4DDMG83Fu0
        DYDhSTk2EiQpcQ6Tg+moEYB6iffvzCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-iaiVYEzwP_aeq5AmCfPScQ-1; Tue, 30 Jun 2020 10:12:02 -0400
X-MC-Unique: iaiVYEzwP_aeq5AmCfPScQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73DFC804003;
        Tue, 30 Jun 2020 14:11:59 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-67.phx2.redhat.com [10.3.113.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 881701001B0B;
        Tue, 30 Jun 2020 14:11:57 +0000 (UTC)
Date:   Tue, 30 Jun 2020 10:11:55 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kerr <kerrnel@google.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Turner <pjt@google.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
Message-ID: <20200630141155.GB132455@lorien.usersys.redhat.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <CANaguZBQMarzMb-iXBEx8wJqkTYtRskTL+xQnShuAW7hP9UdqA@mail.gmail.com>
 <CAEXW_YSU5=ZUf-4j55av9Q8b+PRiM2DCKydM9Bv__mzL2MWx4g@mail.gmail.com>
 <CANaguZCi7Gj5TSUfU5AZ5w1v=EEz23rdgUsSg1NVb3DBM+F6bA@mail.gmail.com>
 <20200626151028.GA538235@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626151028.GA538235@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:10:28AM -0400 Joel Fernandes wrote:
> On Fri, Jun 26, 2020 at 10:36:01AM -0400, Vineeth Remanan Pillai wrote:
> > On Thu, Jun 25, 2020 at 9:47 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Thu, Jun 25, 2020 at 4:12 PM Vineeth Remanan Pillai
> > > <vpillai@digitalocean.com> wrote:
> > > [...]
> > > > TODO lists:
> > > >
> > > >  - Interface discussions could not come to a conclusion in v5 and hence would
> > > >    like to restart the discussion and reach a consensus on it.
> > > >    - https://lwn.net/ml/linux-kernel/20200520222642.70679-1-joel@joelfernandes.org
> > >
> > > Thanks Vineeth, just want to add: I have a revised implementation of
> > > prctl(2) where you only pass a TID of a task you'd like to share a
> > > core with (credit to Peter for the idea [1]) so we can make use of
> > > ptrace_may_access() checks. I am currently finishing writing of
> > > kselftests for this and post it all once it is ready.
> > >
> > Thinking more about it, using TID/PID for prctl(2) and internally
> > using a task identifier to identify coresched group may have
> > limitations. A coresched group can exist longer than the lifetime
> > of a task and then there is a chance for that identifier to be
> > reused by a newer task which may or maynot be a part of the same
> > coresched group.
> 
> True, for the prctl(2) tagging (a task wanting to share core with
> another) we will need some way of internally identifying groups which does
> not depend on any value that can be reused for another purpose.
>

That was my concern as well. That's why I was thinking it should be
an arbitrary, user/admin/orchestrator defined value and not be the
responsibility of the kernel at all.  However...


> [..]
> > What do you think about having a separate cgroup for coresched?
> > Both coresched cgroup and prctl() could co-exist where prctl could
> > be used to isolate individual process or task and coresched cgroup
> > to group trusted processes.
> 
> This sounds like a fine idea to me. I wonder how Tejun and Peter feel about
> having a new attribute-less CGroup controller for core-scheduling and just
> use that for tagging. (No need to even have a tag file, just adding/removing
> to/from CGroup will tag).
>

... this could be an interesting approach. Then the cookie could still
be the cgroup address as is and there would be no need for the prctl. At
least so it seems. 



Cheers,
Phil

> > > However a question: If using the prctl(2) on a CGroup tagged task, we
> > > discussed in previous threads [2] to override the CGroup cookie such
> > > that the task may not share a core with any of the tasks in its CGroup
> > > anymore and I think Peter and Phil are Ok with.  My question though is
> > > - would that not be confusing for anyone looking at the CGroup
> > > filesystem's "tag" and "tasks" files?
> > >
> > Having a dedicated cgroup for coresched could solve this problem
> > as well. "coresched.tasks" inside the cgroup hierarchy would list all
> > the taskx in the group and prctl can override this and take it out
> > of the group.
> 
> We don't even need coresched.tasks, just the existing 'tasks' of CGroups can
> be used.
> 
> > > To resolve this, I am proposing to add a new CGroup file
> > > 'tasks.coresched' to the CGroup, and this will only contain tasks that
> > > were assigned cookies due to their CGroup residency. As soon as one
> > > prctl(2)'s the task, it will stop showing up in the CGroup's
> > > "tasks.coresched" file (unless of course it was requesting to
> > > prctl-share a core with someone in its CGroup itself). Are folks Ok
> > > with this solution?
> > >
> > As I mentioned above, IMHO cpu cgroups should not be used to account
> > for core scheduling as well. Cpu cgroups serve a different purpose
> > and overloading it with core scheduling would not be flexible and
> > scalable. But if there is a consensus to move forward with cpu cgroups,
> > adding this new file seems to be okay with me.
> 
> Yes, this is the problem. Many people use CPU controller CGroups already for
> other purposes. In that case, tagging a CGroup would make all the entities in
> the group be able to share a core, which may not always make sense. May be a
> new CGroup controller is the answer (?).
> 
> thanks,
> 
>  - Joel
> 

-- 

