Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD845C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F9324656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582708138;
	bh=H5YQMAe/crf9DHOdvFbziDKcP0GzpJDJSP5tTKD1foM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jNxCXDpYeSas3ai7v6dVbLjWivX+AVA0H2rLZuASJ0IHSkt7qbbKZSdkIQixck/0G
	 gvK5/PCozl9Rm26YqvWqQOVjfb+HkxVeOrNOWbvCf6pD1rpZu9mK8iTYwTuXVw3H10
	 YhlhGtdoyF39SgXrvavGzGaUfKnsxRBoTipST0Mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgBZJI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:08:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36649 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgBZJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:08:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so2128295wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 01:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFEIr9nnOW1UYtZBYSkNlGUPhLd1mBP0PtrFmzLzvzo=;
        b=dsIIfw08mIWZX+E6l9Z0eiIhYUk4rF68jdQ8JAzSgfmOgP951BEUtMLWI6Awb/bbZg
         8JylXjmlkN1Bw7oiU9rcaX4zbEJVzEa2yu4oFG8bkZ2QvGN7Tw6HUKpHcppcjQTpqt7t
         llq+pKQb8x0BVxBx8mL2mQqFvrUMuF5OYguMhMx4iLysj7jaC7fgW5iESsJe4jl7cDC5
         tGRc85s/NtyxrpZuIidJOmrJuRqPFbvQp7nq86VWx0/BKZzZxTQb65B8SaIOhrHVEgti
         wLsWbnMcWT9biawhmKDmke5AVTiBym8MecRcsHM2jBT1GeF/6CqhpwIji7Zr/8NBz39y
         CZjg==
X-Gm-Message-State: APjAAAURUAOCRh83Sht1rS8QlcW/0d+V3M/v6asbBSvZ8g2qVdPzG3t4
        yJ0uqn7IA2sg8JtKZAnMWUE=
X-Google-Smtp-Source: APXvYqznaluSdyT5HEc2CI7VtV7sDRhSBWd3vC/0MUtPYUuvnUN9CWBfBs4yohy3o2BHDi7VByo5ug==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr4146905wma.159.1582708135122;
        Wed, 26 Feb 2020 01:08:55 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a7sm2353805wrm.29.2020.02.26.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 01:08:54 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:08:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200226090853.GC3771@dhcp22.suse.cz>
References: <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain>
 <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain>
 <20200220101945.GN3420@suse.de>
 <20200221042232.GA2197@sultan-book.localdomain>
 <20200221080737.GK20509@dhcp22.suse.cz>
 <20200221210824.GA3605@sultan-book.localdomain>
 <20200225090945.GJ22443@dhcp22.suse.cz>
 <CALvZod6MW62-+nEw-d0jKxFK9mspOY_tt2JRTDYOrOVyM9_QHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6MW62-+nEw-d0jKxFK9mspOY_tt2JRTDYOrOVyM9_QHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-02-20 14:30:03, Shakeel Butt wrote:
> On Tue, Feb 25, 2020 at 1:10 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> [snip]
> >
> > The proper fix should, however, check the amount of reclaimable pages
> > and back off if they cannot meet the target IMO. We cannot rely on the
> > general reclaimability here because that could really be thrashing.
> >
> 
> "check the amount of reclaimable pages" vs "cannot rely on the general
> reclaimability"? Can you clarify?

kswapd targets the high watermark and if your reclaimable memory (aka
zone_reclaimable_pages) is lower than the high wmark then it cannot
simply satisfy that target, right? Keeping reclaim in that situations
seems counter productive to me because you keep evicting pages that
might be reused without any feedback mechanism on the actual usage.
Please see my other reply.

> BTW we are seeing a similar situation in our production environment.
> We have swappiness=0, no swap from kswapd (because we don't swapout on
> pressure, only on cold age) and too few file pages, the kswapd goes
> crazy on shrink_slab and spends 100% cpu on it.

I am not sure this is the same problem. It seems that the slab shrinkers
are not really a bottle neck here. I would recommend you to identify
which shrinkers are eating the cpu time in your case.
-- 
Michal Hocko
SUSE Labs
