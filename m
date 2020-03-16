Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63E8C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE49A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgCPBVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 21:21:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:9713 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbgCPBVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:21:39 -0400
IronPort-SDR: 4EyZJ+cxFBdJDAAOU34OBUABX19u56JYAw7yyJB5QklT+6mIRLv1/53yjIdMjHYbQcyg1R6aFv
 of3bLCotttNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 18:21:38 -0700
IronPort-SDR: ZXwYIRpgEy8sv4KL07auN1zyi9Gi7bYlBzkAlfgyM+k1GnTAs/2Eo9/TLYOv9K/BJ3bbFKNaSr
 zP5X/m2uCAcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,558,1574150400"; 
   d="scan'208";a="390540021"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2020 18:21:34 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Mika Penttil?? <mika.penttila@nextfour.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Mel Gorman" <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [RFC 2/3] mm: Add a new page flag PageLayzyFree() for MADV_FREE
References: <20200228033819.3857058-1-ying.huang@intel.com>
        <20200228033819.3857058-3-ying.huang@intel.com>
        <20200315081854.rcqlmfckeqrh7fbt@master>
        <92d4b0fe-f592-8da6-0282-2ea8a015b247@nextfour.com>
        <20200315122217.45mioaxzuulwvx2f@master>
Date:   Mon, 16 Mar 2020 09:21:34 +0800
In-Reply-To: <20200315122217.45mioaxzuulwvx2f@master> (Wei Yang's message of
        "Sun, 15 Mar 2020 12:22:17 +0000")
Message-ID: <87pnddrt5t.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> On Sun, Mar 15, 2020 at 10:54:03AM +0200, Mika Penttil?? wrote:
>>
>>
>>On 15.3.2020 10.18, Wei Yang wrote:
>>> On Fri, Feb 28, 2020 at 11:38:18AM +0800, Huang, Ying wrote:
>>> > From: Huang Ying <ying.huang@intel.com>
>>> > 
>>> > Now !PageSwapBacked() is used as the flag for the pages freed lazily
>>> > via MADV_FREE.  This isn't obvious enough.  So Dave suggested to add a
>>> > new page flag for that to improve the code readability.
>>> I am confused with the usage of PageSwapBacked().
>>> 
>>> Previously I thought this flag means the page is swapin, set in
>>> swapin_readahead(). While I found page_add_new_anon_rmap() would set it too.
>>> This means every anon page would carry this flag. Then what is this flag
>>> means?
>>> 
>>> 
>>
>>But not all PageSwapBacked() pages are anon, like shmem.
>>
>
> Yes, while it looks shmem is the only exception.

Another exception is the pages freed lazily via MADV_FREE.

> I am still struggling to understand the meaning of this flag.

You can use `git blame` to find out the commit which introduces this
flag.  Which describes why this flag is introduced.

Best Regards,
Huang, Ying

>>
>>--Mika
