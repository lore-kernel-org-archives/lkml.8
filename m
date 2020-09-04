Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC86BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC0B206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgIDHqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:46:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:44916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgIDHqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:46:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90D89ACC8;
        Fri,  4 Sep 2020 07:46:54 +0000 (UTC)
Date:   Fri, 4 Sep 2020 09:46:53 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 03/10] mm/memory_hotplug: simplify page offlining
Message-ID: <20200904074653.GD15277@dhcp22.suse.cz>
References: <20200903145844.2ead558f5bc3ef3d5230d30f@linux-foundation.org>
 <C2E636DD-EA64-4EC8-A33B-57DB26DB478C@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2E636DD-EA64-4EC8-A33B-57DB26DB478C@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-09-20 07:47:45, David Hildenbrand wrote:
> 
> 
> > Am 03.09.2020 um 23:58 schrieb Andrew Morton <akpm@linux-foundation.org>:
[...]
> > @@ -1589,16 +1567,27 @@ int __ref offline_pages(unsigned long st
> >            reason = "failure to dissolve huge pages";
> >            goto failed_removal_isolated;
> >        }
> > -        /* check again */
> > -        ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> > -                        NULL, check_pages_isolated_cb);
> > -    } while (ret);
> > -
> > -    /* Ok, all of our target is isolated.
> > -       We cannot do rollback at this point. */
> > -    walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> > -                  &offlined_pages, offline_isolated_pages_cb);
> > -    pr_info("Offlined Pages %ld\n", offlined_pages);
> > +
> > +        /*
> > +         * per-cpu pages are drained in start_isolate_page_range, but if
> > +         * there are still pages that are not free, make sure that we
> > +         * drain again, because when we isolated range we might
> > +         * have raced with another thread that was adding pages to pcp
> > +         * list.
> > +         *
> > +         * Forward progress should be still guaranteed because
> > +         * pages on the pcp list can only belong to MOVABLE_ZONE
> > +         * because has_unmovable_pages explicitly checks for
> > +         * PageBuddy on freed pages on other zones.
> > +         */
> > +        if (ret)
> > +            drain_all_pages(zone);
> > +    } while (test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE));
> 
> I think we have to do
> 
> ret = test_pages_isolated()
> if (ret)

Yes.
-- 
Michal Hocko
SUSE Labs
