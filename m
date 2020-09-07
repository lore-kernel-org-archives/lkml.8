Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6915C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7102166E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgIGGqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:46:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:40624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbgIGGqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:46:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8268AA55;
        Mon,  7 Sep 2020 06:45:58 +0000 (UTC)
Date:   Mon, 7 Sep 2020 08:45:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 03/10] mm/memory_hotplug: simplify page offlining
Message-ID: <20200907064556.GB30144@dhcp22.suse.cz>
References: <20200903145844.2ead558f5bc3ef3d5230d30f@linux-foundation.org>
 <C2E636DD-EA64-4EC8-A33B-57DB26DB478C@redhat.com>
 <20200904122134.1000bb0bf6bc6baf7f5302a7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904122134.1000bb0bf6bc6baf7f5302a7@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-09-20 12:21:34, Andrew Morton wrote:
> On Fri, 4 Sep 2020 07:47:45 +0200 David Hildenbrand <david@redhat.com> wrote:
[...]
> @@ -1589,9 +1567,7 @@ int __ref offline_pages(unsigned long st
>  			reason = "failure to dissolve huge pages";
>  			goto failed_removal_isolated;
>  		}
> -		/* check again */
> -		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> -					    NULL, check_pages_isolated_cb);
> +
>  		/*
>  		 * per-cpu pages are drained in start_isolate_page_range, but if
>  		 * there are still pages that are not free, make sure that we
> @@ -1604,15 +1580,15 @@ int __ref offline_pages(unsigned long st
>  		 * because has_unmovable_pages explicitly checks for
>  		 * PageBuddy on freed pages on other zones.
>  		 */
> +		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
>  		if (ret)
>  			drain_all_pages(zone);
>  	} while (ret);

Looks ok
-- 
Michal Hocko
SUSE Labs
