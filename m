Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E256CC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56732083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgAQQWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:22:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:41594 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbgAQQWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:22:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 08:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="243712562"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2020 08:22:36 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id ABADF300DE4; Fri, 17 Jan 2020 08:22:36 -0800 (PST)
Date:   Fri, 17 Jan 2020 08:22:36 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: [RESEND PATCH V3] perf/x86: Consider pinned events for group
 validation
Message-ID: <20200117162236.GJ302770@tassilo.jf.intel.com>
References: <1579201225-178031-1-git-send-email-kan.liang@linux.intel.com>
 <20200117091341.GX2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117091341.GX2827@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So I still completely hate this, because it makes the counter scheduling
> more eratic.
> 
> It changes a situation where we only have false-positives (we allow
> scheduling a group that might not ever get to run) into a situation
> where we can have both false-positives and false-negatives.
> 
> Imagine the pinned event is for a currently running task; and that task
> only runs sporadically. Then you can sometimes not create the group, but
> mostly it'll work.

Right now we have real situations which always fail because of this.

> 
> Yes, this is all very annoying, but I really don't see how this makes
> anything any better.

The problem this is trying to solve is that some -M metrics fail
systematically with the NMI watchdog on. Metrics use weak groups
to avoid needing to have the full knowledge how events
can be scheduled in the user tools.  So they ely on weak groups working.

Some of the JSON metrics have groups which always validate, but never
schedule with the NMI watchdog on.

If you have a better proposal to solve this problem please share
it.

I suppose we could use export at least the number of available counters
in sysfs and then split the groups in the user tools (and assume
that's good enough and full counter constraints are not needed) 
I have some older patches to export the number at least. But fixing the
group validation seems better.

-Andi
