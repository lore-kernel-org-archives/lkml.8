Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A6BC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C46220732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCSMcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:32:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:40646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgCSMcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:32:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 97411AAB8;
        Thu, 19 Mar 2020 12:32:53 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mm/page_alloc: integrate classzone_idx and
 high_zoneidx
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1584502378-12609-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584502378-12609-3-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <99196b17-24fb-8990-2d21-c459d2321747@suse.cz>
Date:   Thu, 19 Mar 2020 13:32:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584502378-12609-3-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/20 4:32 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> classzone_idx is just different name for high_zoneidx now.
> So, integrate them and add some comment to struct alloc_context
> in order to reduce future confusion about the meaning of this variable.
> 
> In addition to integration, this patch also renames high_zoneidx
> to highest_zoneidx since it represents more precise meaning.

2 years ago I suggested max_zone_idx.
Not insisting, but perhaps max_zoneidx would simply be shorter than
highest_zoneidx, while saying the same thing?

Also I wonder if we still need the accessor ac_classzone_idx() (before rename),
or just replace it with ac->highest_zoneidx (or whatever the final name is)
instead of renaming it?

Thanks!
Vlastimil
