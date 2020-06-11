Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5768C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FB920691
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgFKPLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:11:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:38604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgFKPLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:11:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4494FAD33;
        Thu, 11 Jun 2020 15:11:23 +0000 (UTC)
Date:   Thu, 11 Jun 2020 16:11:16 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Baoquan He <bhe@redhat.com>, minchan@kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com, cmlaika.kim@samsung.com
Subject: Re: [PATCH] page_alloc: consider highatomic reserve in wmartermark
 fast
Message-ID: <20200611151116.GE3129@suse.de>
References: <CGME20200609095139epcas1p17f9c213de6daf25fe848921bc70481c0@epcas1p1.samsung.com>
 <20200609095128.8112-1-jaewon31.kim@samsung.com>
 <20200609142747.GA3346@MiWiFi-R3L-srv>
 <20200609151330.GL3127@techsingularity.net>
 <5EE18C38.3090601@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <5EE18C38.3090601@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 10:43:20AM +0900, Jaewon Kim wrote:
> > That's fine, I simply wanted to illustrate where I thought the check
> > should go to minimise the impact to the majority of allocations.
> Hello Mel.
> Can I understand that you also agrees on checking highatomic reserved?
> 

Yes, I think it should be ok.

> Additionally I've wondered why the number of  highatomic free pages is not
> accurately counted like cma free. Is there any concern on counting it?

At the time, the cost of tracking it with 100% accuracy was not worth
it due to a reliance on the pageblock types to protect the regions from
other allocation types.

-- 
Mel Gorman
SUSE Labs
