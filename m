Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB563C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9177321744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582621792;
	bh=tpjQ45p7r1ps14Z3kP8eeSKUpmMzgqVzsWCAfUII5WQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0BjT2WmaTX5e7bAXiJGajOh6s51MyqnwIXJ7RhfRdxVLcc070u+aMNuYsvGXHCRrM
	 g1nMVVlsDCAhjxJP4uW291nQGTL7YRhEBzzt040Na82QMn0g4TqPt454yaeQj3Rzpw
	 QWXVGB9vBb4Zs1FLhK+KVsmgXhaB2iZUNcEb+Xjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgBYJJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:09:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52233 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbgBYJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:09:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so2150006wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 01:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QHaclFPIY13mvPspJZLNKlXQdjEW/zdYlrNl6VD7TMc=;
        b=kIJcmNI9Y+DgKlpOUGxak+9m3PQoBty4URXIwQm6GKXaW+8tDU6aPtbkZQ6WrWad7c
         vvlBxh11URzDDgPJBspsFLM6qUxsW1MlZJ7pKfzh7v76vsEDp3F3Pkahws9W+kZSIQP1
         QjeVhuH0HqUU/wmqjAVtOGrxLUMlGUvRRi2ZHQLya0327BujTqCImku/WgLcjdPc/Zfk
         tdDmFGW62TRcuftccUJRZ0pZ+NTwvpBDhG/47+90ARJfo2hXbDgakcgFYJj8sJZ4MAEI
         70bMTTOYszO70U4Ya6TPZvOyYkozEXAVRSfj1JFJDx0qgUzpqJ6ocp4oT5lg8O32IYxF
         7kWA==
X-Gm-Message-State: APjAAAUJgJEyVPhMNWjLZ7/49qHrYC7S/9H1lqSIBewv4m58iP0aZrym
        +9o9J3GIMH3d0L7aI+UrTW8=
X-Google-Smtp-Source: APXvYqxfHkqNKyPCP1YAaoP8oymy4CucVZY5mLAOq8eQoz0zcY7eOMQLWFRWPhb55ILVOpjgYFdLLw==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr4252567wmi.46.1582621787848;
        Tue, 25 Feb 2020 01:09:47 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id s139sm3322312wme.35.2020.02.25.01.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 01:09:46 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:09:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Mel Gorman <mgorman@suse.de>, Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200225090945.GJ22443@dhcp22.suse.cz>
References: <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain>
 <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain>
 <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain>
 <20200220101945.GN3420@suse.de>
 <20200221042232.GA2197@sultan-book.localdomain>
 <20200221080737.GK20509@dhcp22.suse.cz>
 <20200221210824.GA3605@sultan-book.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221210824.GA3605@sultan-book.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-02-20 13:08:24, Sultan Alsawaf wrote:
[...]
> Both of these logs are attached in a tarball.

Thanks! First of all
$ grep pswp vmstat.1582318979
pswpin 0
pswpout 0

suggests that you do not have any swap storage, right? I will get back
to this later. Now, let's have a look at snapshots. We have regular 1s
snapshots intially but then we have
vmstat.1582318734
vmstat.1582318736
vmstat.1582318758
vmstat.1582318763
vmstat.1582318768
[...]
vmstat.1582318965
vmstat.1582318975
vmstat.1582318976

That is 242s time period when even a simple bash script was struggling
to write a snapshot of a /proc/vmstat which by itself shouldn't really
depend on the system activity much. Let's have a look at a random chosen
two consecutive snapshots from this time period:

		vmstat.1582318736	vmstat.1582318758
			base		diff
allocstall_dma  	0       	0
allocstall_dma32        0       	0
allocstall_movable      5773    	0
allocstall_normal       906     	0

to my surprise there was no invocation of the direct reclaim in this
time period. I would expect this to be the case considering the long
stall. But the source of the stall might be different than the DR.

compact_stall   	13      	1

Direct compaction has been invoked but this shouldn't cause a major
stall for all processes.

nr_active_anon  	133932  	236
nr_inactive_anon        9350    	-1179
nr_active_file  	318     	190
nr_inactive_file        673     	56
nr_unevictable  	51984   	0

The amount of anonymous memory is not really high (~560MB) but file LRU
is _really_ low (~3MB), unevictable list is at ~200MB. That gets us to
~760M of memory which is 74% of the memory. Please note that your mem=2G
setup gives you only 1G of memory in fact (based on the zone_info you
have posted). That is not something unusual but the amount of the page
cache is worrying because I would expect a heavy trashing because most
of the executables are going to require major faults. Anonymous memory
is not swapped out obviously so there is no other option than to refault
constantly.

pgscan_kswapd   	64788716        14157035
pgsteal_kswapd  	29378868        4393216
pswpin  		0       	0
pswpout 		0       	0
workingset_activate     3840226 	169674
workingset_refault      29396942        4393013
workingset_restore      2883042 	106358

And here we can see it clearly happening. Note how working set refaults
matches the amount of memory reclaimed by kswapd.

I would be really curious whether adding swap space would help some.

Now to your patch and why it helps here. It seems quite obvious that the
only effectively reclaimable memory (page cache) is not going to satisfy
the high watermark target
Node 0, zone    DMA32
  pages free     87925
        min      11090
        low      13862
        high     16634

kswapd has some feedback mechanism to back off when the zone is hopless
from the reclaim point of view AFAIR but it seems it has failed in this
particular situation. It should have relied on the direct reclaim and
eventually trigger the OOM killer. Your patch has worked around this by
bailing out from the kswapd reclaim too early so a part of the page
cache required for the code to move on would stay resident and move
further.

The proper fix should, however, check the amount of reclaimable pages
and back off if they cannot meet the target IMO. We cannot rely on the
general reclaimability here because that could really be thrashing.

Thoughts?
-- 
Michal Hocko
SUSE Labs
