Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B5C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B20B206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="rCKM7mUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgIJQKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:10:44 -0400
Received: from one.firstfloor.org ([193.170.194.197]:49132 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbgIJQFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:05:25 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2020 12:05:25 EDT
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 2F90386867; Thu, 10 Sep 2020 17:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1599753459;
        bh=fCNxqNmi1WnGEFEJGGvyF/0Ajb/10mQNUWjdOF3dC2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCKM7mULCXEliGHrgDm2vhPv8g6NQU90f9qicKamzuTpKSfd5K7CPokX0ivWZjHOK
         1WEXTc1D9WMrPFmH7mSdlpuAwS1Sds00bZzeUa/lv4a3q39iMymMFWKSMwX1RyawFs
         payPoBosVvPpSDOvAffEpzNafZeecrqBs0csSsDM=
Date:   Thu, 10 Sep 2020 08:57:38 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET 0/4] perf stat: Add --multiply-cgroup option
Message-ID: <20200910155736.jadhmqvnqquammpn@two.firstfloor.org>
References: <20200908044228.61197-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908044228.61197-1-namhyung@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 01:42:24PM +0900, Namhyung Kim wrote:
> When we profile cgroup events with perf stat, it's very annoying to
> specify events and cgroups on the command line as it requires the
> mapping between events and cgroups.  (Note that perf record can use
> cgroup sampling but it's not usable for perf stat).

The problem is real, but I don't really like your solution.
The option is ugly. Should rather be solved with some suitable
syntax in the expression parser to express: apply to all,
instead of adding adhoc options like this.

There are some additional problems that really need to be eventually
solved too:

- If you use the old syntax and some cgroups are not covered you don't
get any warning. At least that should be fixed too.

- And of course if everything works it is still very slow for the kernel
because there are so many perf events to handle. Long term we probably
need some more flexible way to just specify for given perf events which set of
cgroups they should apply, so that sharing and low overhead monitoring
of many cgroups is possible I hate to say it, but maybe some eBPF filter
is the solution here.

-Andi
