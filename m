Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D18C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A233B22314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgBNHfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:35:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:21250 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgBNHfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:35:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 23:35:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,439,1574150400"; 
   d="scan'208";a="432936843"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 13 Feb 2020 23:35:41 -0800
Date:   Fri, 14 Feb 2020 15:35:59 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shakeelb@google.com,
        yang.shi@linux.alibaba.com
Subject: Re: [RFC Patch] mm/vmscan.c: not inherit classzone_idx from previous
 reclaim
Message-ID: <20200214073559.GA28295@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200209074145.31389-1-richardw.yang@linux.intel.com>
 <20200211104223.GL3466@techsingularity.net>
 <20200212022554.GA7855@richard>
 <20200212074333.GM3466@techsingularity.net>
 <20200214020515.GC20833@richard>
 <20200214024806.GU7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214024806.GU7778@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 06:48:06PM -0800, Matthew Wilcox wrote:
>On Fri, Feb 14, 2020 at 10:05:15AM +0800, Wei Yang wrote:
>> On Wed, Feb 12, 2020 at 07:43:33AM +0000, Mel Gorman wrote:
>> >Broadly speaking it was driven by cases whereby kswapd either a) fell
>> >asleep prematurely and there were many stalls in direct reclaim before
>> >kswapd recovered, b) stalls in direct reclaim immediately after kswapd went
>> >to sleep or c) kswapd reclaimed for lower zones and went to sleep while
>> >parallel tasks were direct reclaiming in higher zones or higher orders.
>> 
>> Thanks for your explanation. I am trying to understand the connection between
>> those cases and the behavior of kswapd.
>> 
>> In summary, all three cases are related to direct reclaim, while happens in
>> three different timing of kswapd:
>
>Reclaim performed by kswapd is the opposite of direct reclaim.  Direct
>reclaim is reclaim initiated by a task which is trying to allocate memory.
>If a task cannot perform direct reclaim itself, it may ask kswapd to
>attempt to reclaim memory for it.

Not totally opposite, I think.

They both reclaim some memory, while after direct reclaim, some freed memory
will be allocated.

Is this the difference you want to mention?

-- 
Wei Yang
Help you, Help me
