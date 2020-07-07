Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA404C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B375E206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGGLy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:54:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:18420 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgGGLy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:54:57 -0400
IronPort-SDR: khKurL59450+/kibfTom+kxOIYT4/Kdtu02upNX8GT8WkWQXPGgbTAtyGgcgOyZKtyezeIsz/1
 Qr1ZDyvyFQlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="165653233"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; 
   d="scan'208";a="165653233"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 04:54:57 -0700
IronPort-SDR: Q0XzBKzpLoC00gIXad7+vF1LH2FPQ7aV7UOLCWh9gfLBTzfkGKg8kftxLgX0Ju0fnrF7MBy4rR
 Ite9FIYltpUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; 
   d="scan'208";a="457073880"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2020 04:54:55 -0700
Date:   Tue, 7 Jul 2020 19:56:21 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][RFC] Makes sd->flags sysctl writable
Message-ID: <20200707115621.GB25765@chenyu-office.sh.intel.com>
References: <cover.1594062828.git.yu.c.chen@intel.com>
 <20200706200049.GB5523@worktop.programming.kicks-ass.net>
 <jhj7dvg8faj.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj7dvg8faj.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,
On Mon, Jul 06, 2020 at 11:11:32PM +0100, Valentin Schneider wrote:
> 
> On 06/07/20 21:00, Peter Zijlstra wrote:
> > On Tue, Jul 07, 2020 at 03:36:13AM +0800, Chen Yu wrote:
> >> It was found that recently the flags of sched domain could
> >> not be customized via sysctl, which might make it a little
> >> inconenient for performance tuning/debugging.
> >
> > What specific goals do you have? This is a debug interface.
> 
> Also, while the update_top_cache_domain() call on sysctl write may work,
> you're back to square one as soon as you go through a hotplug cycle, which
> is icky.
Do you mean, after the hotplug, all the settings of flags are lost? Yes,
it is, but in our testing environment we do not do hotplug offen : )
> 
> That said, I second Peter in that I'm curious as to what you're really
> using this interface for. Manually hacking the default / arch topology
> flags is a bit tedious, but it's doable.
Agree, but since we do monitor performance testings automatically,
it might save more time for us to not have to reboot everytime we
change the flags. So I guess we can hack the code to make that
flags field temporarily writable. I guess the concern here is that it
looks a little overkilled for us to invoke update_top_cache_domain(),
I'm okay with current read-only attribute.

Thanks,
Chenyu
