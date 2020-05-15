Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6410C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7E82074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgEOL0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:26:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:31576 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgEOL0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:26:34 -0400
IronPort-SDR: s03uqEhmUxtYN1kQE3u1PQtNi+LrYQY1UzcHzM6519Ua8AwC3hZvKpwCXRODAKJ9GiOLX87Au8
 X8hdAAT4eqYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 04:26:33 -0700
IronPort-SDR: kRwtGx5woMScn27vmqwCcUxKAuTzOd9+yHJpSIMvZ62UjIIkeJXKFA930f5DNC7hXLNsNq78VS
 fUYymvjFuciA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="266574467"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga006.jf.intel.com with ESMTP; 15 May 2020 04:26:28 -0700
Date:   Fri, 15 May 2020 19:26:27 +0800
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
Subject: Re: [PATCH 3/3] mm: adjust vm_committed_as_batch according to vm
 overcommit policy
Message-ID: <20200515112627.GF69177@shbuild999.sh.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-4-git-send-email-feng.tang@intel.com>
 <20200515074125.GH29153@dhcp22.suse.cz>
 <20200515080210.GC69177@shbuild999.sh.intel.com>
 <20200515090821.GO29153@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515090821.GO29153@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 05:08:21PM +0800, Michal Hocko wrote:
> > > > +void mm_compute_batch(void)
> > > >  {
> > > >  	u64 memsized_batch;
> > > >  	s32 nr = num_present_cpus();
> > > >  	s32 batch = max_t(s32, nr*2, 32);
> > > > -
> > > > -	/* batch size set to 0.4% of (total memory/#cpus), or max int32 */
> > > > -	memsized_batch = min_t(u64, (totalram_pages()/nr)/256, 0x7fffffff);
> > > > +	unsigned long ram_pages = totalram_pages();
> > > > +
> > > > +	/*
> > > > +	 * For policy of OVERCOMMIT_NEVER, set batch size to 0.4%
> > > > +	 * of (total memory/#cpus), and lift it to 6.25% for other
> > > > +	 * policies to easy the possible lock contention for percpu_counter
> > > > +	 * vm_committed_as, while the max limit is INT_MAX
> > > > +	 */
> > > > +	if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> > > > +		memsized_batch = min_t(u64, ram_pages/nr/256, INT_MAX);
> > > > +	else
> > > > +		memsized_batch = min_t(u64, ram_pages/nr/16, INT_MAX);
> > 
> > Also as you mentioned there are real-world work loads with big mmap
> > size and multi-threading, can we lift it even further ?
> > 	memsized_batch = min_t(u64, ram_pages/nr/4, INT_MAX)
> 
> Try to measure those and see what numbers look like.

With the same benchmark, for the 16X lifting in this patch, about
1/3 of the test platforms (servers, desktops, laptops) will show
improvements (up to 20X for servers, much less on platform with
fewer CPUs). 

If we further lift it to 64X, most of the test platforms will
show improvements. 

Thanks,
Feng
