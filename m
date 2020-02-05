Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B686C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35050217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KpvCmxsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBEM6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:58:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39252 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgBEM6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dlZ2JXatY1iOQhXGUdRNEAvuT1KiYZNZnQJyohz4mds=; b=KpvCmxsD8VwVPC0iBV9NgtM+6F
        fwehJCBoNIRQY0xVYWuM1KCZaWDc9q3fHiHje/Iup7/vLepWq/Cfs+3jolQVOKqC59K9MXgRIZRm/
        5mjWN48c3Y7mYqffxqXzGeNF/O2PHbB7Bvvaix8vzUjRaAg4VTPP/O4p+dGkx+/1+c1GU2oIqFH2g
        qorkjk7JErvAT8jux4la0PhUI6j77BDELRv+SwoKqZEDngvcxRUMprGCstCovCeDbI6MuUMiL8rFw
        25U9wdEU+09IetjLHUbrvAOK3E5NfF/Rw/PeHFpijo5EHS399y8XmipZ4dq0MnwPmaghBeLoyymw+
        pX+NYlXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izKFr-0002fZ-Vu; Wed, 05 Feb 2020 12:58:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DA7F3016E5;
        Wed,  5 Feb 2020 13:56:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0702A2B77760E; Wed,  5 Feb 2020 13:58:05 +0100 (CET)
Date:   Wed, 5 Feb 2020 13:58:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops -5.5%
 regression
Message-ID: <20200205125804.GM14879@hirez.programming.kicks-ass.net>
References: <20200205123216.GO12867@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205123216.GO12867@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 08:32:16PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -5.5% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: 81ec3f3c4c4d78f2d3b6689c9816bfbdf7417dbb ("perf/x86: Add check_period PMU callback")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 

I'm fairly sure this bisect/result is bogus.
