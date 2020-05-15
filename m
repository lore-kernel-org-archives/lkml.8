Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1EBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C74620657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEOILQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:11:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:61049 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgEOILQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:11:16 -0400
IronPort-SDR: JAX6Q+Tg8o8xjKomrkQQUc8QQ61vPtZbHM1qA5yq8ZkBWKptqgZvEiWJVqqUCFuDZEiUr6dQ9B
 TA8WieN4pn+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 01:11:14 -0700
IronPort-SDR: 0t00XxL70jqXX0GJ+KfI01HDFCWd+CcWGKRNnOh54ai/t1MavrOlvsWhqtaBew52cyYH1l2Jl7
 YKnzh+xc5pEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="298350913"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by fmsmga002.fm.intel.com with ESMTP; 15 May 2020 01:11:10 -0700
Date:   Fri, 15 May 2020 16:11:09 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm/util.c: make vm_memory_committed() more accurate
Message-ID: <20200515081109.GD69177@shbuild999.sh.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-3-git-send-email-feng.tang@intel.com>
 <20200515072307.GG29153@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515072307.GG29153@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:23:07PM +0800, Michal Hocko wrote:
> On Fri 08-05-20 15:25:16, Feng Tang wrote:
> > percpu_counter_sum_positive() will provide more accurate info.
> 
> Why do we need that?

This is a preparation for patch 3/3, which will enlarge the batch size
of percpu-counter 'vm_committed_as'. Andi Kleen concerned that may
hurt the accuracy for those readers (currently only /proc/meminfo
and hyperV balloon drivers for status check)

As in worst case, the deviation could be 'batch * nr_cpus', and
with patch 3/3, that could be totalram_pages/16.

Thanks,
Feng

> > Its time cost is about 800 nanoseconds on a 2C/4T platform and
> > 2~3 microseconds on a 2S/36C/72T server in normal case, and in
> > worst case where vm_committed_as's spinlock is under severe
> > contention, it costs 30~40 microseconds for the 2S/36C/72T sever,
> > which should be fine for its two users: /proc/meminfo and HV ballon
> > driver's status trace per second.
> 
> OK, this explains that the additional overhead is not terrible but there
> is no actual information on why the imprecision is a problem.
> 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  mm/util.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/util.c b/mm/util.c
> > index 988d11e..3de78e9 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -774,7 +774,7 @@ struct percpu_counter vm_committed_as ____cacheline_aligned_in_smp;
> >   */
> >  unsigned long vm_memory_committed(void)
> >  {
> > -	return percpu_counter_read_positive(&vm_committed_as);
> > +	return percpu_counter_sum_positive(&vm_committed_as);
> >  }
> >  EXPORT_SYMBOL_GPL(vm_memory_committed);
> >  
> > -- 
> > 2.7.4
> 
> -- 
> Michal Hocko
> SUSE Labs
