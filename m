Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD4C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7BE206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578637913;
	bh=rmtNks/wo9AC5FX1grJkK4J8MkxWr2BANXi/Hr9ZAsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S9j6GVVQFXUYT8D3yQ417oR2DQbiIuDJlmMxiOpD7qFzAE64Om0GhoM1CLB/vVBwf
	 6PIn1DIrHwZonmfoS4ZRkTn1seBsTPz8cfY9sar1mCaBsCG6EDsl9oJRMrPaKgeaUR
	 BYGMGQIptbNZbGD7KZ/am8ZZiwlamuiEGkfIrvkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgAJGbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:31:52 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:54110 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbgAJGbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:31:51 -0500
Received: by mail-wm1-f48.google.com with SMTP id m24so719623wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 22:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yrm6NEizNFg5aOT9NDnGTFqQS30CbndtpoTGtGdJOC4=;
        b=Bqv1OzyATKaaFZ/tpjQDoYmySQfsJQqtkzkSrm4BoxFr/7icXgJ+hsNtLDQswmTs+4
         873SNVICFZofliSdIOevTzJiFk7Xkgdmfs9HuziorqO/FpFXOgifRGWr//D0SFc/Bgfk
         CMGlIQLYo/6QnIaOBKC7KRr4Ycul3ae0pGrewOIAmKPOwpYNkUnYP7We7FccNgEhIZzN
         HCxJSmJ8RbMFyapjLieorbmZZhfnr2+Vry4rnjJtMPzgCrbSjmojccygMV2elCWMXCkb
         Hmwv4pEimZ0MINDjisdChCwMzPeSVMjWWN7U9KcPYR/e+ZEHEqEm/jvSUZ9X3uWjYjEF
         yB1g==
X-Gm-Message-State: APjAAAU8gq1QwyZSKQlzuxvHJww7akKAloBQXV6iPRmT3SamT0yR1dxy
        oTfPjRBkQi8rybBafwjUn3U=
X-Google-Smtp-Source: APXvYqzUQx9lUgC3/oVdrF41Ln8xwVkpFHiLPmOZNkwCmDu5NtdVt2i9v2Cs9hIQ8KoeDEiorJz8HQ==
X-Received: by 2002:a05:600c:d5:: with SMTP id u21mr2052278wmm.85.1578637909737;
        Thu, 09 Jan 2020 22:31:49 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id c17sm1013290wrr.87.2020.01.09.22.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 22:31:48 -0800 (PST)
Date:   Fri, 10 Jan 2020 07:31:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: OOM killer not nearly agressive enough?
Message-ID: <20200110063147.GB29802@dhcp22.suse.cz>
References: <20200107204412.GA29562@amd>
 <20200109115633.GR4951@dhcp22.suse.cz>
 <20200109210307.GA1553@duo.ucw.cz>
 <20200109212516.GA23620@dhcp22.suse.cz>
 <20200109224845.GA1220@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109224845.GA1220@amd>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-01-20 23:48:45, Pavel Machek wrote:
> Hi!
> 
> > > > > Do we agree that OOM killer should have reacted way sooner?
> > > > 
> > > > This is impossible to answer without knowing what was going on at the
> > > > time. Was the system threshing over page cache/swap? In other words, is
> > > > the system completely out of memory or refaulting the working set all
> > > > the time because it doesn't fit into memory?
> > > 
> > > Swap was full, so "completely out of memory", I guess. Chromium does
> > > that fairly often :-(.
> > 
> > The oom heuristic is based on the reclaim failure. If the reclaim makes
> > some progress then the oom killer is not hit. Have a look at
> > should_reclaim_retry for more details.
> 
> Thanks for pointer.
> 
> I guess setting MAX_RECLAIM_RETRIES to 1 is not something you'd
> recommend? :-).

You can certainly play with that. I am not overly optimistic that would
help though because symptoms of a threshing system is that we actually
do not even reach this point. Pages are simply recycled but they evict
other part of the hot working set. But I am only guessing what is the
problem in your case. Anyway MAX_RECLAIM_RETRIES would tend to be more
timing sensitive in general. If the reclaim progress cannot be made
because of IO latencies or other resource depletion then the OOM be
declared too early. The current MAX_RECLAIM_RETRIES is not something we
have tuned for in any sense. I remember it didn't make much difference
to change it unless the number would be really high which would be
signal that the reclaim is not throttled very well.

> > > PSI is completely different system, but I guess
> > > I should attempt to tweak the existing one first...
> > 
> > PSI is measuring the cost of the allocation (among other things) and
> > that can give you some idea on how much time is spent to get memory.
> > Userspace can implement a policy based on that and act. The kernel oom
> > killer is the last resort when there is really no memory to
> > allocate.
> 
> So what I'm seeing is system that is unresponsive, easily for an hour.
> 
> Sometimes, I'm able to log in. When I could do that, system was
> absurdly slow, like ps printing at more than 10 seconds per line.
> ps on my system takes 300msec, estimate in the slow case would be 2000
> seconds, that is slowdown by factor of 6000x. That would be X terminal
> opening in like two hours... that's not really usable.

It would be great to find out what is the bottle neck. Is the allocator
stuck in the memory reclaim? Waiting on some lock? Reclaiming pages
which are stolen by other contending processes?

-- 
Michal Hocko
SUSE Labs
