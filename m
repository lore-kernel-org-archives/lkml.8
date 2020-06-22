Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F98C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4599D20720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592835790;
	bh=2918mTIZ15KqyltCYg26Sc4l/e+SYijUmdigfLsJm/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g1kfYmwd1u7Rx0QK5odeZyTXBgenbVO0c3QUAh7m2odRsEJ1P9P6XzX40iitanWec
	 x/E7R+3b9NVsqZ/5BY7+UBzd++Uo19i7hzJzXAHkQnE7Jgtx4Unij3YTAwWCyBDmSZ
	 Eq+PQvy4CY3FLJHmx2YRJO7W9pSZbpk8iUjZ4CBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgFVOXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:23:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35834 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgFVOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:23:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id g18so7822961wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=29xwZ9yIkXzw59/mMSGaEdWIR6Vo+2txFUnfBg7oNgM=;
        b=YpNUdG5IC4w7BklHSHyMCXDURvlPYhiAhDADLx5lLzVSJ0W7OIGKoulU0IhXwBpOIE
         VETB3+okUPOoNkZiPR0mK8G6rV2MEwM7g5Y8pjD4PpIVQX1EFHvnO5rQibud+FkOEyUr
         4z8QlVY+fk3FRifE7qILnL8aEwJTWtyuErZ3OClRhESo9+k2HKSD/Y1wEWvmU2yfQZB/
         c3oe4kP2VdQSlGMGpMUSsvAeb1P+v29Ka3bme2J4hr+WsLgAGvoS5PGxWcaUgmrDoIfE
         NDWEErMkwMsnGDnkLKVPUxOJINGn/JFima6s5H5l+S7AmU3/L8AB2Yp/MXI0YGvBPxU5
         B5Iw==
X-Gm-Message-State: AOAM531eucHCk9Mkg7DbSHo2HqQkhLINyAYNrTLpej0lg4vb4qCwYh/U
        7R986zy0FSAlqk/k0gUU/Fk=
X-Google-Smtp-Source: ABdhPJyu52XSWNlixn7z2wIy6iYWYGXCxkK5rKvpQkDm57BgEa1vANNzCWwbLOUkJk/gMEEnCX6Kuw==
X-Received: by 2002:a05:6000:ce:: with SMTP id q14mr11556962wrx.294.1592835786276;
        Mon, 22 Jun 2020 07:23:06 -0700 (PDT)
Received: from localhost (ip-37-188-173-135.eurotel.cz. [37.188.173.135])
        by smtp.gmail.com with ESMTPSA id c66sm17946153wma.20.2020.06.22.07.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 07:23:05 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:23:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     ????????? <jaewon31.kim@samsung.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        ????????? <ytk.lee@samsung.com>,
        ????????? <cmlaika.kim@samsung.com>
Subject: Re: [PATCH v4] page_alloc: consider highatomic reserve in watermark
 fast
Message-ID: <20200622142304.GD31426@dhcp22.suse.cz>
References: <20200622091107.GC31426@dhcp22.suse.cz>
 <20200619235958.11283-1-jaewon31.kim@samsung.com>
 <CGME20200619055816epcas1p184da90b01aff559fe3cd690ebcd921ca@epcms1p6>
 <20200622094020epcms1p639cc33933fbb7a9d578adb16a6ea0734@epcms1p6>
 <20200622100439.GQ3183@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622100439.GQ3183@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-06-20 11:04:39, Mel Gorman wrote:
> On Mon, Jun 22, 2020 at 06:40:20PM +0900, ????????? wrote:
> > >But more importantly, I have hard time to follow why we need both
> > >zone_watermark_fast and zone_watermark_ok now. They should be
> > >essentially the same for anything but order == 0. For order 0 the
> > >only difference between the two is that zone_watermark_ok checks for
> > >ALLOC_HIGH resp ALLOC_HARDER, ALLOC_OOM. So what is exactly fast about
> > >the former and why do we need it these days?
> > > 
> > 
> > I think the author, Mel, may ansewr. But I think the wmark_fast may
> > fast by 1) not checking more condition about wmark and 2) using inline
> > rather than function. According to description on commit 48ee5f3696f6,
> > it seems to bring about 4% improvement.
> > 
> 
> The original intent was that watermark checks were expensive as some of the
> calculations are only necessary when a zone is relatively low on memory
> and the check does not always have to be 100% accurate. This is probably
> still true given that __zone_watermark_ok() makes a number of calculations
> depending on alloc flags even if a zone is almost completely free.

OK, so we are talking about 
	if (alloc_flags & ALLOC_HIGH)
		min -= min / 2;

	if (unlikely((alloc_flags & (ALLOC_HARDER|ALLOC_OOM))) {
		/*
		 * OOM victims can try even harder than normal ALLOC_HARDER
		 * users on the grounds that it's definitely going to be in
		 * the exit path shortly and free memory. Any allocation it
		 * makes during the free path will be small and short-lived.
		 */
		if (alloc_flags & ALLOC_OOM)
			min -= min / 2;
		else
			min -= min / 4;
	}

Is this something even measurable and something that would justify a
complex code? If we really want to keep it even after these changes
which are making the two closer in the cost then can we have it
documented at least?
-- 
Michal Hocko
SUSE Labs
