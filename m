Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF7FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279A420885
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgHJRup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:50:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:51484 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgHJRun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:50:43 -0400
IronPort-SDR: eT9EWZ6McbmJyxUR46EEvuJf+wE83m/2qgJkKakHv6vf8j9vM9wZsLM83hwu+8azWAvoXdhNOz
 nsca1Nqq/iFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="215101661"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="215101661"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 10:50:42 -0700
IronPort-SDR: vpzcQZYNsAW9jmuTF4kuBbii8AQLquvwRdeTooIXqtd8XQZ1yR4g0CDZCRIOZ1tG2wWtjlqdCU
 jErFZ0Bliw8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="324514275"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2020 10:50:42 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 90B6C301CAF; Mon, 10 Aug 2020 07:45:18 -0700 (PDT)
Date:   Mon, 10 Aug 2020 07:45:18 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     peterz@infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
Message-ID: <20200810144518.GB1448395@tassilo.jf.intel.com>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
 <20200806083530.GV2674@hirez.programming.kicks-ass.net>
 <20200806153205.GA1448395@tassilo.jf.intel.com>
 <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It didn't. I can't figure out what to charge on the locked memory, as
> all that memory is in kernel-side objects. It also needs to make sense

I don't see how that makes a difference for the count. It just account
bytes. Can you elaborate?

> as iirc the default MLOCK_LIMIT is quite low, you'd hit it sooner than
> the file descriptor limit.

For a single process? 

> 
> > It has a minor issue that it might break some existing setups that rely
> > on the mmap fitting exactly into the mmap allocation, but that could
> > be solved by allowing a little slack, since the existing setups
> > likely don't have that many events.
> 
> I don't see how to make this work in a sane way. Besides, if we have to
> have a limit anyway, sticking with the existing one is just easier and
> 1:1 is kind of more logical.

It's just a very wasteful way because we need an extra inode and file descriptor
for each event*cgroup.

And of course it's super user unfriendly because managing the fd limits
is a pain, apart from them not really working that well anyways 
(since someone who really wants to do a memory DoS can still open
RLIMIT_NPROC*RLIMIT_NFILE fds just by forking) 

Unfortunately we're kind of stuck with the old NFILE=1024 default
even though it makes little sense on modern servers. Right now a lot
of very reasonable perf stat command lines don't work out of the box
on larger machines because of this (and since cores are growing all
the time "larger machines" of today are the standard servers of
tomorrow)

Maybe an alternative would be to allow a multiplier. For each open fd
you can have N perf events. With N being a little higher than the current
cost of the inode + file descriptor together.

But would really prefer to have some kind of limit per uid that is
actually sane.

-Andi
