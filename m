Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE12FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760A021741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgIIHEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:04:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:58080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgIIHEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:04:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B0E6ADFE;
        Wed,  9 Sep 2020 07:04:48 +0000 (UTC)
Date:   Wed, 9 Sep 2020 09:04:45 +0200
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
Message-ID: <20200909070445.GA7348@dhcp22.suse.cz>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
 <20200908143503.GE26850@dhcp22.suse.cz>
 <7ed82cb06074b30c2956638082c515fb179f69a3.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed82cb06074b30c2956638082c515fb179f69a3.camel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-09-20 10:41:10, Rik van Riel wrote:
> On Tue, 2020-09-08 at 16:35 +0200, Michal Hocko wrote:
> 
> > A global knob is insufficient. 1G pages will become a very precious
> > resource as it requires a pre-allocation (reservation). So it really
> > has
> > to be an opt-in and the question is whether there is also some sort
> > of
> > access control needed.
> 
> The 1GB pages do not require that much in the way of
> pre-allocation. The memory can be obtained through CMA,
> which means it can be used for movable 4kB and 2MB
> allocations when not
> being used for 1GB pages.

That CMA has to be pre-reserved, right? That requires a configuration.

> That makes it relatively easy to set aside
> some fraction
> of system memory in every system for 1GB and movable
> allocations, and use it for whatever way it is needed
> depending on what workload(s) end up running on a system.

I was not talking about how easy or hard it is. My main concern is that
this is effectively a pre-reserved pool and a global knob is a very
suboptimal way to control access to it. I (rather) strongly believe this
should be an explicit opt-in and ideally not 1GB specific but rather
something to allow large pages to be created as there is a fit. See
other subthread for more details.

-- 
Michal Hocko
SUSE Labs
