Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CEBC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFC52076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgHKQVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:21:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:22263 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbgHKQVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:21:21 -0400
IronPort-SDR: RFW5IfSotSWxPfYyjDkkvwq+HDdmMXQruAiAL2K6kQbTvoRQggLubbgIZrt7Q7QXbyMa6FWOAu
 TwHL0jKwNO8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="133296949"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="133296949"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 09:21:19 -0700
IronPort-SDR: Jngo1nM1PaJVtTZF0MZwoseVnCZ8p07/QT30nt3kiJ+Z5K4zg1W4XU60xCCeYAbO7mmZAezNZi
 m7elcXCMPsKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="334634181"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2020 09:21:14 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     peterz@infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
In-Reply-To: <20200811143424.GD1448395@tassilo.jf.intel.com>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com> <20200708151635.81239-2-alexander.shishkin@linux.intel.com> <20200806083530.GV2674@hirez.programming.kicks-ass.net> <20200806153205.GA1448395@tassilo.jf.intel.com> <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com> <20200810144518.GB1448395@tassilo.jf.intel.com> <87364t1plf.fsf@ashishki-desk.ger.corp.intel.com> <20200811143424.GD1448395@tassilo.jf.intel.com>
Date:   Tue, 11 Aug 2020 19:21:13 +0300
Message-ID: <87zh71ywzq.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@linux.intel.com> writes:

> On Tue, Aug 11, 2020 at 12:47:24PM +0300, Alexander Shishkin wrote:
>> 
>> Right, but which bytes? One byte per event? That's
>> arbitrary. sizeof(struct perf_event)? Then, probably also sizeof(struct
>> perf_event_context).
>
> Yes the sum of all the sizeofs needed for a perf_event.

Well, *all* of them will be tedious to collect, seeing as there is
ctx->task_ctx_data, there is ring_buffer, scheduling trees, there is
stuff that pmus allocate under the hood, like AUX SG tables.

>> The above two structs add up to 2288 bytes on my local build. Given the
>> default RLIMIT_MEMLOCK of 64k, that's 28 events. As opposed to ~1k
>> events if we keep using the RLIMIT_NOFILE. Unless I'm missing your
>> point.
>
> Yes that's true. We would probably need to increase the limit to a few
> MB at least.

Ok, but if we have to increase a limit anyway, we might as well increase
the NOFILE.

> Or maybe use some combination with the old rlimit for compatibility.
> The old rlimit would give an implicit extra RLIMIT_NFILE * 2288 limit
> for RLIMIT_MEMLOCK. This would only give full compatibility for a single
> perf process, but I suspect that's good enough for most users.

We'd need to settle on charging a fixed set of structures per event,
then. And, without increasing the file limit, this would still total at
1052 events.

We could also involve perf_event_mlock_kb *and* increase it too, but I
suspect distros don't just leave it at kernel's default either.

Regards,
--
Alex
