Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7E5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B40207CD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHJN57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:57:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:25445 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbgHJN56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:57:58 -0400
IronPort-SDR: RK9PLOcql2I/j79yww0M60FrprKDxA0KrAm8R3Zm8tLmkU+dMKjnF4C2meSvmMOPyT0rEKcC+Z
 DrB9RzlAYhzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="150969357"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="150969357"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 06:57:58 -0700
IronPort-SDR: unklh3Is/xfywKnmdcebNcmDXp90MkvOjJgiIx580TsBBevmNSMt3qupsfUo97a2GdEK1h8lNM
 cEAg1kGJYQhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="276015511"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga007.fm.intel.com with ESMTP; 10 Aug 2020 06:57:55 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>, peterz@infradead.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
In-Reply-To: <20200806153205.GA1448395@tassilo.jf.intel.com>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com> <20200708151635.81239-2-alexander.shishkin@linux.intel.com> <20200806083530.GV2674@hirez.programming.kicks-ass.net> <20200806153205.GA1448395@tassilo.jf.intel.com>
Date:   Mon, 10 Aug 2020 16:57:55 +0300
Message-ID: <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@linux.intel.com> writes:

>> > This adds an opt-in flag to the perf_event_open() syscall to retain
>> > sibling events after their file descriptors are closed. In this case, the
>> > actual events will be closed with the group leader.
>> 
>> So having the 1:1 relation with filedesc imposes a resource limit on
>> userspace.
>> 
>> This patch breaks that and enables a user to basically DoS the system by
>> creating unbound events.
>
> The idea was to account the events in the locked memory allocation too.
> Not sure that made it into the patch though.

It didn't. I can't figure out what to charge on the locked memory, as
all that memory is in kernel-side objects. It also needs to make sense
as iirc the default MLOCK_LIMIT is quite low, you'd hit it sooner than
the file descriptor limit.

> It has a minor issue that it might break some existing setups that rely
> on the mmap fitting exactly into the mmap allocation, but that could
> be solved by allowing a little slack, since the existing setups
> likely don't have that many events.

I don't see how to make this work in a sane way. Besides, if we have to
have a limit anyway, sticking with the existing one is just easier and
1:1 is kind of more logical.

Regards,
--
Alex
