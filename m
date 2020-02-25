Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB88C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFE320732
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbgBYRMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:12:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44960 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbgBYRMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:12:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id a14so6792655pgb.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V/ZCIccIJ6u9bm3Rjv7+N6WTTpdrTbo3t75yfjBv9GE=;
        b=Jh9/XqLwAHCSEtv3BrTOm67EsyR+VQXrjTZaFhnU/rNGVoa5sRufSWxu7cYSk0YhFZ
         XS+fadTA4yyGhpppQUGLiLgmw086yhRKsgi0BWApZFwdP+5KkP6drmbwdUWTT9DjjDF4
         PXlBKRs1qQl3qYad8xFK0AxAzt72BZYXpGQ3Bcb1llFEyt8m4CoXmb0kMl3SzbZpcauu
         /jGSDAimQxl2IM+hxiCleW1faWJJ73iH6lEBbC+U0rSmyayTQhwfna522KtKUmTE0+Jp
         EuBHx2oqf3GmE05xxtUsjEU24ApRC9GT8FQSs1Ix1A/e+JPcfEx5WefkUbTYqQPa1jNj
         N1lw==
X-Gm-Message-State: APjAAAXdgdv0QKlDYPBUyzehmT7Flq0GH7ozGBSiuwKARXkP2xLUo7Q7
        rCooEYQ2g7xqv2stad2jNDc=
X-Google-Smtp-Source: APXvYqyU7j++q/aWy4d7ycebGNKVGShaQbogy6Y67Mbzi+FdBqnHygHLkz6eScpouw6chPDPbNYPhg==
X-Received: by 2002:a63:f450:: with SMTP id p16mr36265357pgk.211.1582650765382;
        Tue, 25 Feb 2020 09:12:45 -0800 (PST)
Received: from sultan-box.localdomain (c-71-63-179-120.hsd1.wa.comcast.net. [71.63.179.120])
        by smtp.gmail.com with ESMTPSA id e26sm18284499pfl.59.2020.02.25.09.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:12:44 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:12:42 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mel Gorman <mgorman@suse.de>, Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200225171242.GA496421@sultan-box.localdomain>
References: <20200219194006.GA3075@sultan-book.localdomain>
 <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain>
 <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain>
 <20200220101945.GN3420@suse.de>
 <20200221042232.GA2197@sultan-book.localdomain>
 <20200221080737.GK20509@dhcp22.suse.cz>
 <20200221210824.GA3605@sultan-book.localdomain>
 <20200225090945.GJ22443@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225090945.GJ22443@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:09:45AM +0100, Michal Hocko wrote:
> On Fri 21-02-20 13:08:24, Sultan Alsawaf wrote:
> [...]
> > Both of these logs are attached in a tarball.
> 
> Thanks! First of all
> $ grep pswp vmstat.1582318979
> pswpin 0
> pswpout 0
> 
> suggests that you do not have any swap storage, right?

Correct. I'm not using any swap (and it should not be necessary to make Linux mm
work of course). If I were to divide my RAM in half and use one half as swap,
do you think the results would be different? IMO they shouldn't be.

> The amount of anonymous memory is not really high (~560MB) but file LRU
> is _really_ low (~3MB), unevictable list is at ~200MB. That gets us to
> ~760M of memory which is 74% of the memory. Please note that your mem=2G
> setup gives you only 1G of memory in fact (based on the zone_info you
> have posted). That is not something unusual but the amount of the page
> cache is worrying because I would expect a heavy trashing because most
> of the executables are going to require major faults. Anonymous memory
> is not swapped out obviously so there is no other option than to refault
> constantly.

I noticed that only 1G was available as well. Perhaps direct reclaim wasn't
attempted due to the zone_reclaimable_pages() check, though I don't think direct
reclaim would've been particularly helpful in this case (see below).

> kswapd has some feedback mechanism to back off when the zone is hopless
> from the reclaim point of view AFAIR but it seems it has failed in this
> particular situation. It should have relied on the direct reclaim and
> eventually trigger the OOM killer. Your patch has worked around this by
> bailing out from the kswapd reclaim too early so a part of the page
> cache required for the code to move on would stay resident and move
> further.
> 
> The proper fix should, however, check the amount of reclaimable pages
> and back off if they cannot meet the target IMO. We cannot rely on the
> general reclaimability here because that could really be thrashing.

Yes, my guess was that thrashing out pages used by the running programs was the
cause for my freezes, but I didn't think of making kswapd back off a different
way.

Right now I don't see any such back-off mechanism in kswapd. Also, if we add
this into kswapd, we would need to plug it into the direct reclaim path as well,
no? I don't think direct reclaim would help with the situation I've run into;
although it wouldn't be as bad as letting kswapd evict pages to the high
watermark, it would still cause page thrashing that would just be capped to the
amount of pages a direct reclaimer is looking to steal.

Considering that my patch remedies this issue for me without invoking the OOM
killer, a proper solution should produce the same or better results. I don't
think the OOM killer should have been triggered in this case.

Sultan
