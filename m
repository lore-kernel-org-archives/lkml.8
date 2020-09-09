Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54C4C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847F52074B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 11:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgIILaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 07:30:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbgIIL2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:28:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DAE0B1A9;
        Wed,  9 Sep 2020 11:27:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Sep 2020 13:27:42 +0200
From:   osalvador@suse.de
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC 0/5] disable pcplists during page isolation
In-Reply-To: <ce8d05db-b804-21c7-0d12-43e11fc232e5@suse.cz>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <0ffb1c2d-1b28-23f7-53e1-63e6f0f4cd41@redhat.com>
 <ce8d05db-b804-21c7-0d12-43e11fc232e5@suse.cz>
User-Agent: Roundcube Webmail
Message-ID: <3f4bd7b0c73f59b4cd2adaad3ccc38bf@suse.de>
X-Sender: osalvador@suse.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-09 12:54, Vlastimil Babka wrote:
> Thanks! I expect no performance change while no isolation is in 
> progress, as
> there are no new tests added in alloc/free paths. During page isolation 
> there's
> a single drain instead of once-per-pageblock, which is a benefit. But 
> the
> pcplists are effectively disabled for the whole of online_pages(),
> offline_pages() or alloc_contig_range(), which will affect parallel 
> page
> allocator users. It depends on how long these operations take and how 
> heavy the
> parallel usage is, so I have no good answers. Might be similar to the 
> current
> periodic drain.

I have seen some systems taking quite some time when offlining sections 
due to the migration of
the respective pages not being that smooth and having do_migrate_range 
to do some spins.
But to be fair, online_pages and offline_pages are not routines that get 
called that often, and we would be safe to assume that memory-hotplug 
operations are not constantly happening, but are rather one-offs 
operations.

I am not sure about Xen and HV, IIRC Xen was using online_pages and 
offline_pages routines to do the ballooning?

I will dive in this in the following days, thanks for the work Vlastimil


