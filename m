Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28ACC7619D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78ABE24671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="KNCHQ7Ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgBSWJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:09:03 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37734 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgBSWJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:09:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id c188so1719049qkg.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnF5DCQHVLUnfSmn+1ERWkaSX6Vm56uQOFXrLzOaRr8=;
        b=KNCHQ7ChkERIcb/bdTd8hqb6netRcNVRd1DLmtBvs7LPPDhPPJ6M3is5PKZe9vNoT6
         Frcn3LOhDntoI0kybkgkdCbpb+X0b87pjt/TZLvRr0ypZe7gyIVM3Nn5bMohRaUGp922
         Rn/LmqIJFt2RPPl2OaTV1Sc4h1mRx/vJRLZP2Nfz49ehWSQl2TqXGnC4jfnTbte5Tvso
         w9kI50aIGRQgal37qMd3VBetpnqu0/191gyevyDlrqlsbUp96TWb3DO5FlvqatPEhKxJ
         n4NmHFp38ROakzQcUqixDZtBPRs4VY+EiWATwuQ8CsLRUf4hTThSgu1Tcy8jOB1dHmpG
         0QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnF5DCQHVLUnfSmn+1ERWkaSX6Vm56uQOFXrLzOaRr8=;
        b=t7zI6sGU0OPmRC6TbuFlejZlbl7h0jB8j7cwN7an1vj2QSQqt2Gu1Y8EyDoYxgdWTi
         PFGkR3hkmiefSUihF3dsxXJr1qPLYWfCegErReFzw4IFrC85xD088jnnLLs5srp/ir2C
         bpwEbWC0BZCYB9DiEp3dC+CHy3WloH+sz1Ay4dTHRzYGeochg3L/1NG5X1du6AHxUGNG
         Cl0zW0hwup8yT/5C87O245JHAA6y2Qdu0V6cwCmjNLa1hnUafD7G7XpuH3xq7o76cgMr
         aR8Tair2OjndKXDWuaWNI3VVq+wPzxNABVe0xXan5UREWT5jL9eapBKC9L/d8wdrhygF
         V81g==
X-Gm-Message-State: APjAAAXfLa0OWr85kYCgrskyUC3Xl2uDEB06xQs4o0mjPM7KlzowU9Bs
        swl3Gtq/KOITwSK/tO/zAFbEgf0nCh4=
X-Google-Smtp-Source: APXvYqyaLpldaJ86llXEnYR6FKWl4mdZMXj9zC1eE7A4+pcGVzseUVLTy6IAoZDQ/GLLuC2vd35A2A==
X-Received: by 2002:a37:6690:: with SMTP id a138mr23459032qkc.475.1582150141425;
        Wed, 19 Feb 2020 14:09:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3bde])
        by smtp.gmail.com with ESMTPSA id p135sm588862qke.2.2020.02.19.14.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:09:00 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:08:59 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200219220859.GF54486@cmpxchg.org>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
 <20200219195332.GE11847@dhcp22.suse.cz>
 <20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 04:41:12PM -0500, Daniel Jordan wrote:
> On Wed, Feb 19, 2020 at 08:53:32PM +0100, Michal Hocko wrote:
> > On Wed 19-02-20 14:16:18, Johannes Weiner wrote:
> > > On Wed, Feb 19, 2020 at 07:37:31PM +0100, Michal Hocko wrote:
> > > > On Wed 19-02-20 13:12:19, Johannes Weiner wrote:
> > > > > This patch adds asynchronous reclaim to the memory.high cgroup limit
> > > > > while keeping direct reclaim as a fallback. In our testing, this
> > > > > eliminated all direct reclaim from the affected workload.
> > > > 
> > > > Who is accounted for all the work? Unless I am missing something this
> > > > just gets hidden in the system activity and that might hurt the
> > > > isolation. I do see how moving the work to a different context is
> > > > desirable but this work has to be accounted properly when it is going to
> > > > become a normal mode of operation (rather than a rare exception like the
> > > > existing irq context handling).
> > > 
> > > Yes, the plan is to account it to the cgroup on whose behalf we're
> > > doing the work.
> 
> How are you planning to do that?
> 
> I've been thinking about how to account a kernel thread's CPU usage to a cgroup
> on and off while working on the parallelizing Michal mentions below.  A few
> approaches are described here:
> 
> https://lore.kernel.org/linux-mm/20200212224731.kmss6o6agekkg3mw@ca-dmjordan1.us.oracle.com/

What we do for the IO controller is execute the work unthrottled but
charge the cgroup on whose behalf we are executing with whatever cost
or time or bandwith that was incurred. The cgroup will pay off this
debt when it requests more of that resource.

This is from blk-iocost.c:

	/*
	 * We're over budget.  If @bio has to be issued regardless,
	 * remember the abs_cost instead of advancing vtime.
	 * iocg_kick_waitq() will pay off the debt before waking more IOs.
	 * This way, the debt is continuously paid off each period with the
	 * actual budget available to the cgroup.  If we just wound vtime,
	 * we would incorrectly use the current hw_inuse for the entire
	 * amount which, for example, can lead to the cgroup staying
	 * blocked for a long time even with substantially raised hw_inuse.
	 */
	if (bio_issue_as_root_blkg(bio) || fatal_signal_pending(current)) {
		atomic64_add(abs_cost, &iocg->abs_vdebt);
		iocg_kick_delay(iocg, &now, cost);
		return;
	}

blk-iolatency.c has similar provisions. bio_issue_as_root_blkg() says this:

/**
 * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
 * @return: true if this bio needs to be submitted with the root blkg context.
 *
 * In order to avoid priority inversions we sometimes need to issue a bio as if
 * it were attached to the root blkg, and then backcharge to the actual owning
 * blkg.  The idea is we do bio_blkcg() to look up the actual context for the
 * bio and attach the appropriate blkg to the bio.  Then we call this helper and
 * if it is true run with the root blkg for that queue and then do any
 * backcharging to the originating cgroup once the io is complete.
 */
static inline bool bio_issue_as_root_blkg(struct bio *bio)
{
        return (bio->bi_opf & (REQ_META | REQ_SWAP)) != 0;
}

The plan for the CPU controller is similar. When a remote execution
begins, flush the current runtime accumulated (update_curr) and
associate the current thread with another cgroup (similar to
current->active_memcg); when remote execution is done, flush the
runtime delta to that cgroup and unset the remote context.

For async reclaim, whether that's kswapd or the work item that I'm
adding here, we'd want the cycles to go to the cgroup whose memory is
being reclaimed.

> > > The problem is that we have a general lack of usable CPU control right
> > > now - see Rik's work on this: https://lkml.org/lkml/2019/8/21/1208.
> > > For workloads that are contended on CPU, we cannot enable the CPU
> > > controller because the scheduling latencies are too high. And for
> > > workloads that aren't CPU contended, well, it doesn't really matter
> > > where the reclaim cycles are accounted to.
> > > 
> > > Once we have the CPU controller up to speed, we can add annotations
> > > like these to account stretches of execution to specific
> > > cgroups. There just isn't much point to do it before we can actually
> > > enable CPU control on the real workloads where it would matter.
> 
> Which annotations do you mean?  I didn't see them when skimming through Rik's
> work or in this patch.

Sorry, they're not in Rik's patch. My point was that we haven't gotten
to making such fine-grained annotations because the CPU isolation as a
whole isn't something we have working in practice right now. It's not
relevant who is spending the cycles if we cannot enable CPU control.
