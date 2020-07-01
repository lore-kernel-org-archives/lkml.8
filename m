Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1244C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE8620760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgGAUEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:04:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:17954 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgGAUEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:04:49 -0400
IronPort-SDR: F+zGg31ecRnnrMLu4jm3FtWQOWt/r7xPyBICjU6N3cVxny9g3eoB3yDMA2oooiTfGwEzl7kt+P
 7lG3klIXeB4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144875094"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="144875094"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 13:04:49 -0700
IronPort-SDR: KRQVUdiyIf2tJNU3rFxi+VfhbLxczcnP2seiVBRUUfKXHTEoNGmZI4ZV4XvpOSdeui4dCGgtZB
 qZKQ7qsb8ukw==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="481418338"
Received: from sadedonx-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.134.113])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 13:04:48 -0700
Date:   Wed, 1 Jul 2020 13:04:46 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        alex.shi@linux.alibaba.com, dwagner@suse.de, tobin@kernel.org,
        cl@linux.com, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
Subject: Re: [PATCH 3/3] mm/vmscan: replace implicit RECLAIM_ZONE checks with
 explicit checks
Message-ID: <20200701200446.ki5hdgarcpmo2vuf@intel.com>
Mail-Followup-To: David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        alex.shi@linux.alibaba.com, dwagner@suse.de, tobin@kernel.org,
        cl@linux.com, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
References: <20200701152621.D520E62B@viggo.jf.intel.com>
 <20200701152627.8761147E@viggo.jf.intel.com>
 <alpine.DEB.2.23.453.2007011256280.1908531@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.23.453.2007011256280.1908531@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 13:03:01, David Rientjes wrote:
> On Wed, 1 Jul 2020, Dave Hansen wrote:
> 
> > diff -puN include/linux/swap.h~mm-vmscan-node_reclaim_mode_helper include/linux/swap.h
> > --- a/include/linux/swap.h~mm-vmscan-node_reclaim_mode_helper	2020-07-01 08:22:13.650955330 -0700
> > +++ b/include/linux/swap.h	2020-07-01 08:22:13.659955330 -0700
> > @@ -12,6 +12,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/atomic.h>
> >  #include <linux/page-flags.h>
> > +#include <uapi/linux/mempolicy.h>
> >  #include <asm/page.h>
> >  
> >  struct notifier_block;
> > @@ -374,6 +375,12 @@ extern int sysctl_min_slab_ratio;
> >  #define node_reclaim_mode 0
> >  #endif
> >  
> > +static inline bool node_reclaim_enabled(void)
> > +{
> > +	/* Is any node_reclaim_mode bit set? */
> > +	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
> > +}
> > +
> >  extern void check_move_unevictable_pages(struct pagevec *pvec);
> >  
> >  extern int kswapd_run(int nid);
> 
> If a user writes a bit that isn't a RECLAIM_* bit to vm.zone_reclaim_mode 
> today, it acts as though RECLAIM_ZONE is enabled: we try to reclaim in 
> zonelist order before falling back to the next zone in the page allocator.  
> The sysctl doesn't enforce any max value :/  I dont know if there is any 
> such user, but this would break them if there is.
> 
> Should this simply be return !!node_reclaim_mode?
> 

I don't think so because I don't think anything else validates the unused bits
remain unused.

