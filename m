Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D52AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDEC207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgEOIiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:38:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:20585 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgEOIiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:38:19 -0400
IronPort-SDR: KRFIazBTHIqofEYfQHF0FO8IuhHW63A0sjuUtsWsOJ6OzEyZaNk6AsUCVGQ1hbyYMvSMx7If9/
 vD0Xs2eh0W7A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 01:38:19 -0700
IronPort-SDR: ap3WmmjCJ0XbtaIaCaJF842iRRfzguCYuAbsDRQGIGn9+Qi4YB05k3DtnE0xXnRKEtBuXBkG+J
 ZZcHxIHmcvWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="438238552"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2020 01:38:15 -0700
Date:   Fri, 15 May 2020 16:38:14 +0800
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
Message-ID: <20200515083814.GE69177@shbuild999.sh.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-4-git-send-email-feng.tang@intel.com>
 <20200515074443.GI29153@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515074443.GI29153@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:44:43PM +0800, Michal Hocko wrote:
> On Fri 08-05-20 15:25:17, Feng Tang wrote:
> > When checking a performance change for will-it-scale scalability
> > mmap test [1], we found very high lock contention for spinlock of
> > percpu counter 'vm_committed_as':
> 
> Btw. you are focusing on a microbenchmark here but I believe that there
> are non-synthetic worklaods which would benefit from a larger batch.
> E.g. large in memory databases which do large mmaps during startups
> from multiple threads.

I imagined cases like this too :) but was not sure there are such cases.
So I only put down the the benchmark I've worked with in 0day.

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
