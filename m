Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD080C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED3B20770
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgIJIfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:35:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:42614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730551AbgIJIfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:35:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D18B8B20B;
        Thu, 10 Sep 2020 08:35:17 +0000 (UTC)
Date:   Thu, 10 Sep 2020 10:34:59 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC 1/5] mm, page_alloc: clean up pageset high and batch update
Message-ID: <20200910083459.GB2285@linux>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <20200907163628.26495-2-vbabka@suse.cz>
 <20200910083116.GA2285@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910083116.GA2285@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:31:20AM +0200, Oscar Salvador wrote:
> On Mon, Sep 07, 2020 at 06:36:24PM +0200, Vlastimil Babka wrote:
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> >  	for_each_possible_cpu(cpu)
> > -		setup_pageset(&per_cpu(boot_pageset, cpu), 0);
> > +		setup_pageset(&per_cpu(boot_pageset, cpu));
> 
> This is not really anything important but I realized we have like 7 functions
> messing with pcp lists, and everytime I try to follow them my head spins.
> 
> Since setup_pageset is only being called here, could we replace it by the
> pageset_init and pageset_update?
> 
> (As I said, not important and probably a matter of taste. I just think that
> having so many mini functions around is not always cool,
> e.g: setup_zone_pageset->zone_pageset_init)

Sorry, I did not see that you just did that in Patch#3, bleh.


-- 
Oscar Salvador
SUSE L3
