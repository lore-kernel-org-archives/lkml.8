Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF9C18E00
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDA1207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582142733;
	bh=xgCJfuRAggPv0eYvUOJyibuufkUiNQcPRp1/W6AkTiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h+j+OAzqVC+zcF/6B2OxoUSG24Izm0tJ6W9UVFQ0D56GjTMJzPlB7XIhpcrbgu5m3
	 MHj0oFI+uzlexEWYZx0aPhN8JhvdHl27upnRcuZZgi1v6FirsT5pIzTGze3hGeG4oO
	 83Y+c03lge/JR7owKFavsizceuBula9ErYQ5d0kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgBSUFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:05:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32923 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSUFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:05:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so2092939wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9QZaWm6tm+vk1ztWHlhdEgHBJhECaJCRQq7v49/23SM=;
        b=G9bOwnY26rfZ8L9cj1Gy5owXx/vOHWL5W2vLgPhC6P3o9sUyjHazf7pAdZ3bHOyUPY
         e4hMOJnR7pfcPwnDQc/3wKc39UTV2sXHfmaRhQkcjrNwDiT4QQwKY/Zp4HYIAVGtIRYS
         kAPpsI9Lrb3zHBGqy4TTbloVHqhGaqcsUFyKh3AXeCipc9Mv9EL30HWdDG+3+4pCc33I
         EMHfyvsS40vCrrlRb0SDWV7ydw3a0Fhr8Q3L0jsZBYksybXfhPXC6VoAMahFudsqIn9+
         iv5+nljyqhaNchhS/2Q10pZpOseOIiyvwG9tvIs0Bws0yDqB/TeSe3fMlnBJoW8ZPzj+
         Hjow==
X-Gm-Message-State: APjAAAWyvyXlUtsdMiDtQbUg8NU8VUq2oRzJBErRKxiZkPQnV84ky5Mq
        WeTTnjeeEXt8WM2JAbUQcRU=
X-Google-Smtp-Source: APXvYqwdo3/b888DT9z4zeiJK6HdstVQrqV0Q2qZiwl4mCTXqtkY08/Ulkfcg5vfITd0j88zfiuvCQ==
X-Received: by 2002:adf:f484:: with SMTP id l4mr39326744wro.207.1582142729697;
        Wed, 19 Feb 2020 12:05:29 -0800 (PST)
Received: from localhost (ip-37-188-133-21.eurotel.cz. [37.188.133.21])
        by smtp.gmail.com with ESMTPSA id a8sm1117642wmc.20.2020.02.19.12.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:05:28 -0800 (PST)
Date:   Wed, 19 Feb 2020 21:05:27 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200219200527.GF11847@dhcp22.suse.cz>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219194006.GA3075@sultan-book.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Ups, for some reason I have missed Dave's response previously]

On Wed 19-02-20 11:40:06, Sultan Alsawaf wrote:
> On Wed, Feb 19, 2020 at 11:13:21AM -0800, Dave Hansen wrote:
> > On 2/19/20 10:25 AM, Sultan Alsawaf wrote:
> > > Keeping kswapd running when all the failed allocations that invoked it
> > > are satisfied incurs a high overhead due to unnecessary page eviction
> > > and writeback, as well as spurious VM pressure events to various
> > > registered shrinkers. When kswapd doesn't need to work to make an
> > > allocation succeed anymore, stop it prematurely to save resources.
> > 
> > But kswapd isn't just to provide memory to waiters.  It also serves to
> > get free memory back up to the high watermark.  This seems like it might
> > result in more frequent allocation stalls and kswapd wakeups, which
> > consumes extra resources.

Agreed as expressed in my other reply

> > I guess I'd wonder what positive effects you have observed as a result
> > of this patch and whether you've gone looking for any negative effects.
> 
> This patch essentially stops kswapd from going overboard when a failed
> allocation fires up kswapd. Otherwise, when memory pressure is really high,
> kswapd just chomps through CPU time freeing pages nonstop when it isn't needed.

Could you be more specific please? kspwad should stop as soon as the
high watermark is reached. If that is not the case then there is a bug
which should be fixed.

Sure it is quite possible that kswapd is busy for extended amount of
time if the memory pressure is continuous.

> On a constrained system I tested (mem=2G), this patch had the positive effect of
> improving overall responsiveness at high memory pressure.

Again, do you have more details about the workload and what was the
cause of responsiveness issues? Because I would expect that the
situation would be quite opposite because it is usually the direct
reclaim that is a source of stalls visible from userspace. Or is this
about a single CPU situation where kswapd saturates the single CPU and
all other tasks are just not getting enough CPU cycles?
 
> On systems with more memory I tested (>=4G), kswapd becomes more expensive to
> run at its higher scan depths, so stopping kswapd prematurely when there aren't
> any memory allocations waiting for it prevents it from reaching the *really*
> expensive scan depths and burning through even more resources.
> 
> Combine a large amount of memory with a slow CPU and the current problematic
> behavior of kswapd at high memory pressure shows. My personal test scenario for
> this was an arm64 CPU with a variable amount of memory (up to 4G RAM + 2G swap).

But still, somebody has to put the system into balanced state so who is
going to do all the work?
-- 
Michal Hocko
SUSE Labs
