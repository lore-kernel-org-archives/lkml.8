Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1ABC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE62206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgHKOky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:40:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:39417 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbgHKOkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:40:53 -0400
IronPort-SDR: 53KUnZqTTqY2CHQMgStOOuKS0hr/4CZAP37o6C2N4Jf/1TFRjPv6cksQ94N/KW+8lviwfHpR0X
 Rdbx6Q9xRtJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="141595789"
X-IronPort-AV: E=Sophos;i="5.76,461,1592895600"; 
   d="scan'208";a="141595789"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 07:40:53 -0700
IronPort-SDR: JGfBK8o+ksaoxfDMs5qMmlA6+A78FyKE42qHn7BbegCwAzsraHtXotUojVRJoqvgefCiLl6opJ
 NWwTNkEGnCuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,461,1592895600"; 
   d="scan'208";a="324777032"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2020 07:40:53 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C5847301CAF; Tue, 11 Aug 2020 07:29:55 -0700 (PDT)
Date:   Tue, 11 Aug 2020 07:29:55 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
Message-ID: <20200811142955.GC1448395@tassilo.jf.intel.com>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
 <20200806083530.GV2674@hirez.programming.kicks-ass.net>
 <20200806153205.GA1448395@tassilo.jf.intel.com>
 <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com>
 <20200810144518.GB1448395@tassilo.jf.intel.com>
 <20200810203632.GF3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810203632.GF3982@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:36:32PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 10, 2020 at 07:45:18AM -0700, Andi Kleen wrote:
> 
> > Unfortunately we're kind of stuck with the old NFILE=1024 default
> > even though it makes little sense on modern servers.
> 
> Why can't that be changed? It seems to me all of userspace changes all
> the time; heck that system-doofus thing flushed 20+ years of sysadmin
> experience down the drain, just cause. Why can't we up a file limit?

We could try, but I believe it's hard coded in various places outside
the kernel.

But this wouldn't solve the problem of the unnecessary overhead of 
the inode + file descriptor per event that the patch was trying
to address. It would just waste more memory.

And increasing it makes the worst case memory consumption you complained
about event worse because the real limit per uid i
RLIMIT_NPROC*RLIMIT_FILES.  Of course NPROC needs to be large enough too,
so the total just becomes bigger and bigger.

Ultimatively you need another accounting mechanism that actually
works per uid without extra factors.

Now perf already has one so it's still unclear to me why we can't use it.

-Andi
