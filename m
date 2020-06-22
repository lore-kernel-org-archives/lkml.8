Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F14BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4E2206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgFVKEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:04:44 -0400
Received: from outbound-smtp57.blacknight.com ([46.22.136.241]:52695 "EHLO
        outbound-smtp57.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726942AbgFVKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:04:44 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id 4739BFAE92
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:04:42 +0100 (IST)
Received: (qmail 13230 invoked from network); 22 Jun 2020 10:04:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Jun 2020 10:04:41 -0000
Date:   Mon, 22 Jun 2020 11:04:39 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     ????????? <jaewon31.kim@samsung.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20200622100439.GQ3183@techsingularity.net>
References: <20200622091107.GC31426@dhcp22.suse.cz>
 <20200619235958.11283-1-jaewon31.kim@samsung.com>
 <CGME20200619055816epcas1p184da90b01aff559fe3cd690ebcd921ca@epcms1p6>
 <20200622094020epcms1p639cc33933fbb7a9d578adb16a6ea0734@epcms1p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200622094020epcms1p639cc33933fbb7a9d578adb16a6ea0734@epcms1p6>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 06:40:20PM +0900, ????????? wrote:
> >But more importantly, I have hard time to follow why we need both
> >zone_watermark_fast and zone_watermark_ok now. They should be
> >essentially the same for anything but order == 0. For order 0 the
> >only difference between the two is that zone_watermark_ok checks for
> >ALLOC_HIGH resp ALLOC_HARDER, ALLOC_OOM. So what is exactly fast about
> >the former and why do we need it these days?
> > 
> 
> I think the author, Mel, may ansewr. But I think the wmark_fast may
> fast by 1) not checking more condition about wmark and 2) using inline
> rather than function. According to description on commit 48ee5f3696f6,
> it seems to bring about 4% improvement.
> 

The original intent was that watermark checks were expensive as some of the
calculations are only necessary when a zone is relatively low on memory
and the check does not always have to be 100% accurate. This is probably
still true given that __zone_watermark_ok() makes a number of calculations
depending on alloc flags even if a zone is almost completely free.

-- 
Mel Gorman
SUSE Labs
