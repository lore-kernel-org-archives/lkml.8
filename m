Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EFEC11D09
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493B724672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgBTKTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:19:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:41990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTKTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:19:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12DF2B285;
        Thu, 20 Feb 2020 10:19:50 +0000 (UTC)
Date:   Thu, 20 Feb 2020 10:19:45 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200220101945.GN3420@suse.de>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain>
 <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain>
 <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200219224231.GA5190@sultan-book.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 02:42:31PM -0800, Sultan Alsawaf wrote:
> On Wed, Feb 19, 2020 at 09:45:13PM +0000, Mel Gorman wrote:
> > This could be watermark boosting run wild again. Can you test with
> > sysctl vm.watermark_boost_factor=0 or the following patch? (preferably
> > both to compare and contrast).
> 
> I can test that, but something to note is that I've been doing equal testing
> with this on 4.4, which exhibits the same behavior, and that kernel doesn't have
> watermark boosting in it, as far as I can tell.
> 
> I don't think what we're addressing here is a "bug", but rather something
> fundamental about how we've been thinking about kswapd lifetime. The argument
> here is that it's not coherent to be letting kswapd run as it does, and instead
> gating it on outstanding allocation requests provides much more reasonable
> behavior, given real workloads and use patterns.
> 
> Does that make sense and seem reasonable?
> 

I'm not entirely convinced. The reason the high watermark exists is to have
kswapd work long enough to make progress without a process having to direct
reclaim. The most straight-forward example would be a streaming reader of
a large file. It'll keep pushing the zone towards the low watermark and
kswapd has to keep ahead of the reader. If we cut kswapd off too quickly,
the min watermark is hit and stalls occur. While kswapd could stop at the
min watermark, it leaves a very short window for kswapd to make enough
progress before the min watermark is hit.

At minimum, any change in this area would need to include the /proc/vmstats
on allocstat and pg*direct* to ensure that direct reclaim stalls are
not worse.

I'm not a fan of the patch in question because kswapd can be woken between
the low and min watermark without stalling but we really do expect kswapd
to make progress and continue to make progress to avoid future stalls. The
changelog had no information on the before/after impact of the patch and
this is an area where intuition can disagree with real behaviour.

-- 
Mel Gorman
SUSE Labs
