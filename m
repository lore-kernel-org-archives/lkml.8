Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D66C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AF6206D3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEHMdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:33:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:44678 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEHMdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:33:37 -0400
IronPort-SDR: muK1Qm0u59jqnJNHMPrbiZmvb/7U6kNwj8pNjIe2dOmjTpVyLWX8R8Cv5ksEUr8pFHHSLuRhHX
 zSrcFpmAw12A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 05:33:37 -0700
IronPort-SDR: z1RhVsduoIrC2tnsuUc5AAdakEHy2sRC+v8gIKe6U0+K7S9yDPUiPWBcbhWdOjh7lZ9t9I0SvX
 fsdLGtbTvWjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="285391433"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.136])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2020 05:33:34 -0700
Date:   Fri, 8 May 2020 20:33:33 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <20200508123333.GA69441@shbuild999.sh.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-4-git-send-email-feng.tang@intel.com>
 <20200508112448.GP16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508112448.GP16070@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:24:48PM +0800, Matthew Wilcox wrote:
> On Fri, May 08, 2020 at 03:25:17PM +0800, Feng Tang wrote:
> > +void mm_compute_batch(void)
> >  {
> >  	u64 memsized_batch;
> >  	s32 nr = num_present_cpus();
> >  	s32 batch = max_t(s32, nr*2, 32);
> > -
> > -	/* batch size set to 0.4% of (total memory/#cpus), or max int32 */
> > -	memsized_batch = min_t(u64, (totalram_pages()/nr)/256, 0x7fffffff);
> > +	unsigned long ram_pages = totalram_pages();
> > +
> > +	/*
> > +	 * For policy of OVERCOMMIT_NEVER, set batch size to 0.4%
> > +	 * of (total memory/#cpus), and lift it to 6.25% for other
> > +	 * policies to easy the possible lock contention for percpu_counter
> > +	 * vm_committed_as, while the max limit is INT_MAX
> > +	 */
> > +	if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> > +		memsized_batch = min_t(u64, ram_pages/nr/256, INT_MAX);
> > +	else
> > +		memsized_batch = min_t(u64, ram_pages/nr/16, INT_MAX);
> >  
> >  	vm_committed_as_batch = max_t(s32, memsized_batch, batch);
> > +	printk("vm_committed_as_batch = %d\n", vm_committed_as_batch);
> >  }
> 
> You left a debugging printk in ...

Yep, my bad, thanks for the catching, will remove it.

- Feng
