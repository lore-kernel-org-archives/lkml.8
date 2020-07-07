Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77271C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7D8206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgGGLnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:43:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:30778 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgGGLnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:43:23 -0400
IronPort-SDR: cAUUrvW/l+t5jssCsQujWvaimEdGWug7nCaXb2DT9NW+oginVxZCKGkRqd/XPQWl/xsIv1SV6d
 wBTAfBee3tNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="147591448"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; 
   d="scan'208";a="147591448"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 04:43:22 -0700
IronPort-SDR: GCuC/FORKkR4Jxrfb3KiRRGaDII+yAnyEk1Dbl1/bBv/VtBTukqSmssBxbnrWxmRXWR4ZL+sxm
 5sx3H641rS0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; 
   d="scan'208";a="388489360"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2020 04:43:19 -0700
Date:   Tue, 7 Jul 2020 19:44:45 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][RFC] Makes sd->flags sysctl writable
Message-ID: <20200707114445.GA25765@chenyu-office.sh.intel.com>
References: <cover.1594062828.git.yu.c.chen@intel.com>
 <20200706200049.GB5523@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706200049.GB5523@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
On Mon, Jul 06, 2020 at 10:00:49PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 07, 2020 at 03:36:13AM +0800, Chen Yu wrote:
> > It was found that recently the flags of sched domain could
> > not be customized via sysctl, which might make it a little
> > inconenient for performance tuning/debugging.
> 
> What specific goals do you have? This is a debug interface.
The origin motivation is for debugging purpose during daily work,
I was trying to evaluate the load balance behavior on some specific
platforms.
Another motivation was inspired by a previous lkp performance regression
report that, after the rework of load balance, some workloads might get
performance downgrading. And it is suspected that the system after the
rework is more likely to spread tasks onto more CPUs, which brings more
idle time -> and deeper cstate -> lower performance. So in order to
evaluate which flag might help mitigate the spreading(disable PREFER_SIBLING?),
it might be an applicable option to make the flags writable, so lkp could
launch the workload with different flags settings so we can gather more clues.
But yes, I'm ok if the flags are kept read-only, and we can hack into
the code temporarily to turn it into writable for debugging.

thx,
Chenyu
