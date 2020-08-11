Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A9AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18D320774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgHKJr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:47:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:17966 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbgHKJr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:47:28 -0400
IronPort-SDR: RWGSq/DlbdSV5jc4qXTRNpzilnDbVnr5Brc3ubAJl6BLBJ7i2yPkIExzcVAef9RHWKdGJwRsDc
 pGAAlFRHnDlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="154820265"
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; 
   d="scan'208";a="154820265"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 02:47:27 -0700
IronPort-SDR: 7pAq3sgAPjEfge61/OgB2MIbTTf7TPURc6xbnHMi/fzX63ICJvi+55iMIoZMat77zfKrQl37bk
 iF88IMUbsMvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; 
   d="scan'208";a="308354350"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga002.jf.intel.com with ESMTP; 11 Aug 2020 02:47:25 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     peterz@infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
In-Reply-To: <20200810144518.GB1448395@tassilo.jf.intel.com>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com> <20200708151635.81239-2-alexander.shishkin@linux.intel.com> <20200806083530.GV2674@hirez.programming.kicks-ass.net> <20200806153205.GA1448395@tassilo.jf.intel.com> <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com> <20200810144518.GB1448395@tassilo.jf.intel.com>
Date:   Tue, 11 Aug 2020 12:47:24 +0300
Message-ID: <87364t1plf.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@linux.intel.com> writes:

>> It didn't. I can't figure out what to charge on the locked memory, as
>> all that memory is in kernel-side objects. It also needs to make sense
>
> I don't see how that makes a difference for the count. It just account
> bytes. Can you elaborate?

Right, but which bytes? One byte per event? That's
arbitrary. sizeof(struct perf_event)? Then, probably also sizeof(struct
perf_event_context).

>> as iirc the default MLOCK_LIMIT is quite low, you'd hit it sooner than
>> the file descriptor limit.
>
> For a single process? 

The above two structs add up to 2288 bytes on my local build. Given the
default RLIMIT_MEMLOCK of 64k, that's 28 events. As opposed to ~1k
events if we keep using the RLIMIT_NOFILE. Unless I'm missing your
point.

Regards,
--
Alex
