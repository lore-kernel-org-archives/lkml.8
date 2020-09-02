Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3448C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9058B207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgIBOtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:49:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:40892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgIBOtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:49:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 849C4ACBA;
        Wed,  2 Sep 2020 14:49:21 +0000 (UTC)
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
 <20200902140116.GI4617@dhcp22.suse.cz> <20200902141057.GK4617@dhcp22.suse.cz>
 <CA+CK2bChfLLDikSzaD0kCkchxiRd0fzpyDEEpbzEh_7MEqhNgw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e20d9fec-c417-7415-72fb-ee44bf83ed67@suse.cz>
Date:   Wed, 2 Sep 2020 16:49:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bChfLLDikSzaD0kCkchxiRd0fzpyDEEpbzEh_7MEqhNgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 4:31 PM, Pavel Tatashin wrote:
>> > > The fix is to try to drain per-cpu lists again after
>> > > check_pages_isolated_cb() fails.
>>
>> Still trying to wrap my head around this but I think this is not a
>> proper fix. It should be the page isolation to make sure no races are
>> possible with the page freeing path.
>>
> 
> As Bharata B Rao found in another thread, the problem was introduced
> by this change:
> c52e75935f8d: mm: remove extra drain pages on pcp list
> 
> So, the drain used to be tried every time with lru_add_drain_all();
> Which, I think is excessive, as we start a thread per cpu to try to
> drain and catch a rare race condition. With the proposed change we
> drain again only when we find such a condition. Fixing it in
> start_isolate_page_range means that we must somehow synchronize it
> with the release_pages() which adds costs to runtime code, instead of
> to hot-remove code.

Agreed. Isolation was always racy wrt freeing to pcplists, and it was simply
acceptable to do some extra drains if needed. Removing that race would be indeed
acceptable only if it didn't affect alloc/free fastpaths.

> Pasha
> 

