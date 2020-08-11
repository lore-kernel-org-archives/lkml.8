Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514822083B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgHKOe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:34:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:59588 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgHKOe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:34:26 -0400
IronPort-SDR: 349InYtPa/uKYuws5mlnyVo2MAyIhC8XkCM17NTNFVSLUrI2RznCxqPMbDbzfgr4vffg4YEJHq
 YOn33luQX+Aw==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="171783532"
X-IronPort-AV: E=Sophos;i="5.76,461,1592895600"; 
   d="scan'208";a="171783532"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 07:34:25 -0700
IronPort-SDR: 30Q6wEZhMGlaEJBhaG8+jkm0kR2f/WkT6es1kzFJTzHSDqL+oeZcXFK4bTONZ26cjJRASoyDI7
 2AasSOgc9ijA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,461,1592895600"; 
   d="scan'208";a="324775517"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2020 07:34:25 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 07BBE301CB1; Tue, 11 Aug 2020 07:34:25 -0700 (PDT)
Date:   Tue, 11 Aug 2020 07:34:24 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     peterz@infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
Message-ID: <20200811143424.GD1448395@tassilo.jf.intel.com>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
 <20200806083530.GV2674@hirez.programming.kicks-ass.net>
 <20200806153205.GA1448395@tassilo.jf.intel.com>
 <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com>
 <20200810144518.GB1448395@tassilo.jf.intel.com>
 <87364t1plf.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87364t1plf.fsf@ashishki-desk.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:47:24PM +0300, Alexander Shishkin wrote:
> Andi Kleen <ak@linux.intel.com> writes:
> 
> >> It didn't. I can't figure out what to charge on the locked memory, as
> >> all that memory is in kernel-side objects. It also needs to make sense
> >
> > I don't see how that makes a difference for the count. It just account
> > bytes. Can you elaborate?
> 
> Right, but which bytes? One byte per event? That's
> arbitrary. sizeof(struct perf_event)? Then, probably also sizeof(struct
> perf_event_context).

Yes the sum of all the sizeofs needed for a perf_event.

> 
> >> as iirc the default MLOCK_LIMIT is quite low, you'd hit it sooner than
> >> the file descriptor limit.
> >
> > For a single process? 
> 
> The above two structs add up to 2288 bytes on my local build. Given the
> default RLIMIT_MEMLOCK of 64k, that's 28 events. As opposed to ~1k
> events if we keep using the RLIMIT_NOFILE. Unless I'm missing your
> point.

Yes that's true. We would probably need to increase the limit to a few
MB at least.

Or maybe use some combination with the old rlimit for compatibility.
The old rlimit would give an implicit extra RLIMIT_NFILE * 2288 limit
for RLIMIT_MEMLOCK. This would only give full compatibility for a single
perf process, but I suspect that's good enough for most users.

-Andi
