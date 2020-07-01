Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17103C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54AD2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593597964;
	bh=+oe6RU3WDCcR1+24HtabtIDOYO6VXdkkfuZEKbHBYb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tSHhkHM+4A2+80wof8Wub0UsXsPeAlQknLCzN9uQvhPYpwY7B/qlQfndz8v09ZdJM
	 FNe28XH5HtBxlAn55y3fWAV+O5nDt+o9n0qZkKuCGcRTVfrxVil6U9CzHslVcKqfox
	 s/+mJgw+d3JlxoxVC7EDuVJFt7fGrbTSqQClR+mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgGAKGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:06:02 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42526 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgGAKGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:06:02 -0400
Received: by mail-ej1-f67.google.com with SMTP id i14so23918397ejr.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 03:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rsUj7DlBZ6M+wGKkVIdI5HybWRoDhFOjqUHfmhTwGG8=;
        b=KOvj6DgB+p05f9y9CBKhY/0CByWWT2jjuZqw/0PKZBAPkgDkyywpiwmbjIw6rp7Ylc
         2catjrOY+r8RuaG8ee3Rrox55Z/a6ijh+jE8T2NvcFPDA5oYmKn6vtMKxd6JL+2PQpj4
         fYXDGEwQHFrVnNciCVdhrpEwtDtq9EaA+F4g9k0tnNaMZhULLbgFLdoGCMgOVXEr9eGl
         vKaSWwOCYv3jtK1v6wwX032k4v9AN7YbD10zJfsr3EFOs1dcRD418INck8CgjJCMozke
         4nVWf1FjNkjJ4k1wwRlERgjQ8egQ8uZ3ajKIsOqIdYNTt0qwBMbyjnTYCVEDfNib1Uem
         sCIA==
X-Gm-Message-State: AOAM5327H4/eOoBYWxclnIQWcQHINmihK54vVKj0EhP7MjZ3/JXqDx3J
        oN2Ew38wWMlbGoZIak+aykA=
X-Google-Smtp-Source: ABdhPJxusZx5FwVct6q6aR0tnn/SkBmxrGo0c3NRy+df/P1khhDPjjeet6irL5Jib8wS59WKdA3txQ==
X-Received: by 2002:a17:906:ecb3:: with SMTP id qh19mr10499598ejb.273.1593597960160;
        Wed, 01 Jul 2020 03:06:00 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id r17sm5659343edw.68.2020.07.01.03.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:05:59 -0700 (PDT)
Date:   Wed, 1 Jul 2020 12:05:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch] mm: Increase pagevec size on large system
Message-ID: <20200701100557.GQ2369@dhcp22.suse.cz>
References: <d1cc9f12a8ad6c2a52cb600d93b06b064f2bbc57.1593205965.git.tim.c.chen@linux.intel.com>
 <20200627031304.GC25039@casper.infradead.org>
 <20200626204704.f023988699421db00e9bdab7@linux-foundation.org>
 <6260c66e-68a3-ab3e-4bd9-4a290d068e1f@linux.intel.com>
 <20200630172713.496590a923744c0e0160d36b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630172713.496590a923744c0e0160d36b@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-06-20 17:27:13, Andrew Morton wrote:
> On Mon, 29 Jun 2020 09:57:42 -0700 Tim Chen <tim.c.chen@linux.intel.com> wrote:
> > I am okay with Matthew's suggestion of keeping the stack pagevec size unchanged.
> > Andrew, do you have a preference?
> > 
> > I was assuming that for people who really care about saving the kernel memory
> > usage, they would make CONFIG_NR_CPUS small. I also have a hard time coming
> > up with a better scheme.
> > 
> > Otherwise, we will have to adjust the pagevec size when we actually 
> > found out how many CPUs we have brought online.  It seems like a lot
> > of added complexity for going that route.
> 
> Even if we were to do this, the worst-case stack usage on the largest
> systems might be an issue.  If it isn't then we might as well hard-wire
> it to 31 elements anyway,

I am not sure this is really a matter of how large the machine is. For
example in the writeout paths this really depends on how complex the IO
stack is much more.

Direct memory reclaim is also a very sensitive stack context. As we are
not doing any writeout anymore I believe a large part of the on stack fs
usage is not really relevant. There seem to be only few on stack users
inside mm and they shouldn't be part of the memory reclaim AFAICS.
I have simply did
$ git grep "^[[:space:]]*struct pagevec[[:space:]][^*]"
and fortunately there weren't that many hits to get an idea about the
usage. There is some usage in the graphic stack that should be double
check though.

Btw. I think that pvec is likely a suboptimal data structure for many
on stack users. It allows only very few slots to batch. Something like
mmu_gather which can optimistically increase the batch sounds like
something that would be worth

The main question is whether the improvement is  visible on any
non-artificial workloads. If yes then the quick fix
is likely the best way forward. If this is mostly a microbench thingy
then I would be happier to see a more longterm solution. E.g. scale
pcp pagevec sizes on the machine size or even use something better than
pvec (e.g. lru_deactivate_file could scale much more and I am not sure
pcp aspect is really improving anything - why don't we simply invalidate
all gathered pages at once at the end of invalidate_mapping_pages?).
-- 
Michal Hocko
SUSE Labs
