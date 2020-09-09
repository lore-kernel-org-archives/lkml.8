Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE24C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03040206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbgIIQFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:05:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:38034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730877AbgIIQDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:03:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 488D9AD1B;
        Wed,  9 Sep 2020 13:59:21 +0000 (UTC)
Date:   Wed, 9 Sep 2020 15:59:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200909135904.GL7348@dhcp22.suse.cz>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
 <20200908143503.GE26850@dhcp22.suse.cz>
 <7ed82cb06074b30c2956638082c515fb179f69a3.camel@surriel.com>
 <20200909070445.GA7348@dhcp22.suse.cz>
 <054d02f3b34d9946905929ff268b685c91494b3e.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <054d02f3b34d9946905929ff268b685c91494b3e.camel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-09-20 09:19:16, Rik van Riel wrote:
> On Wed, 2020-09-09 at 09:04 +0200, Michal Hocko wrote:
> > On Tue 08-09-20 10:41:10, Rik van Riel wrote:
> > > On Tue, 2020-09-08 at 16:35 +0200, Michal Hocko wrote:
> > > 
> > > > A global knob is insufficient. 1G pages will become a very
> > > > precious
> > > > resource as it requires a pre-allocation (reservation). So it
> > > > really
> > > > has
> > > > to be an opt-in and the question is whether there is also some
> > > > sort
> > > > of
> > > > access control needed.
> > > 
> > > The 1GB pages do not require that much in the way of
> > > pre-allocation. The memory can be obtained through CMA,
> > > which means it can be used for movable 4kB and 2MB
> > > allocations when not
> > > being used for 1GB pages.
> > 
> > That CMA has to be pre-reserved, right? That requires a
> > configuration.
> 
> To some extent, yes.
> 
> However, because that pool can be used for movable
> 4kB and 2MB
> pages as well as for 1GB pages, it would be easy to just set
> the size of that pool to eg. 1/3 or even 1/2 of memory for every
> system.
> 
> It isn't like the pool needs to be the exact right size. We
> just need to avoid the "highmem problem" of having too little
> memory for kernel allocations.

Which is the problem why this is not really suitable for an uneducated
guesses. It is really hard to guess the right amount of lowmem. Think of
heavy fs metadata workloads and their memory demand. Memory reclaim
usually struggles when zones are imbalanced from my experience.

-- 
Michal Hocko
SUSE Labs
