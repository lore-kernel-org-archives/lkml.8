Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B86EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D384820C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIJLuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:50:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:36158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgIJLnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:43:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A19AAD52;
        Thu, 10 Sep 2020 11:31:11 +0000 (UTC)
Date:   Thu, 10 Sep 2020 13:30:50 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC 4/5] mm, page_alloc: cache pageset high and batch in struct
 zone
Message-ID: <20200910113046.GA5848@linux>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <20200907163628.26495-5-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907163628.26495-5-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 06:36:27PM +0200, Vlastimil Babka wrote:
   */
> -static void setup_pageset(struct per_cpu_pageset *p);
> +static void pageset_init(struct per_cpu_pageset *p);

this belongs to the respective patches

> -static void zone_set_pageset_high_and_batch(struct zone *zone)
> +static void zone_set_pageset_high_and_batch(struct zone *zone, bool force_update)
>  {
>  	unsigned long new_high;
>  	unsigned long new_batch;
> @@ -6256,6 +6256,14 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
>  		new_batch = max(1UL, 1 * new_batch);
>  	}
>  
> +	if (zone->pageset_high != new_high ||
> +	    zone->pageset_batch != new_batch) {
> +		zone->pageset_high = new_high;
> +		zone->pageset_batch = new_batch;
> +	} else if (!force_update) {
> +		return;
> +	}

I am probably missimg something obvious, so sorry, but why do we need
force_update here?
AFAICS, we only want to call pageset_update() in case zone->pageset_high/batch
and the new computed high/batch differs, so if everything is equal, why do we want
to call it anyways?

-- 
Oscar Salvador
SUSE L3
