Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9E5C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C479F20737
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgICHY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:24:58 -0400
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:49661 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgICHYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:24:53 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id 59D46FA79F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 08:24:50 +0100 (IST)
Received: (qmail 6364 invoked from network); 3 Sep 2020 07:24:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.127])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Sep 2020 07:24:49 -0000
Date:   Thu, 3 Sep 2020 08:24:47 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
Message-ID: <20200903072447.GB3179@techsingularity.net>
References: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 03:01:20PM +0800, Alex Shi wrote:
> pageblock_flags is used as long, since every pageblock_flags is just 4
> bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
> that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
> flags. It would cause long waiting for sync.
> 
> If we could change the pageblock_flags variable as char, we could use
> char size cmpxchg, which just sync up with 2 pageblock flags. it could
> relief the false sharing in cmpxchg.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

Page block types were not known to change at high frequency that would
cause a measurable performance drop. If anything, the performance hit
from pageblocks is the lookup paths which is a lot more frequent.

What was the workload you were running that altered pageblocks at a high
enough frequency for collisions to occur when updating adjacent
pageblocks?

-- 
Mel Gorman
SUSE Labs
