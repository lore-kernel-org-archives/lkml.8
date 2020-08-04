Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD898C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD22B22CAE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgHDJM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:12:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:37674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgHDJM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:12:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B0900B1B9;
        Tue,  4 Aug 2020 09:13:10 +0000 (UTC)
Subject: Re: [PATCH] mm: sort freelist by rank number
To:     Cho KyongHo <pullip.cho@samsung.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hyesoo.yu@samsung.com, janghyuck.kim@samsung.com
References: <CGME20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561@epcas2p2.samsung.com>
 <1596435031-41837-1-git-send-email-pullip.cho@samsung.com>
 <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com>
 <ebea485c-7cce-3a4a-2ac4-7a608efe2844@suse.cz> <20200804023548.GA186735@KEI>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <947a09ba-968b-4c4d-68bb-d13de9c885a1@suse.cz>
Date:   Tue, 4 Aug 2020 11:12:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804023548.GA186735@KEI>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/20 4:35 AM, Cho KyongHo wrote:
> On Mon, Aug 03, 2020 at 05:45:55PM +0200, Vlastimil Babka wrote:
>> On 8/3/20 9:57 AM, David Hildenbrand wrote:
>> > On 03.08.20 08:10, pullip.cho@samsung.com wrote:
>> >> From: Cho KyongHo <pullip.cho@samsung.com>
>> >> 
>> >> LPDDR5 introduces rank switch delay. If three successive DRAM accesses
>> >> happens and the first and the second ones access one rank and the last
>> >> access happens on the other rank, the latency of the last access will
>> >> be longer than the second one.
>> >> To address this panelty, we can sort the freelist so that a specific
>> >> rank is allocated prior to another rank. We expect the page allocator
>> >> can allocate the pages from the same rank successively with this
>> >> change. It will hopefully improves the proportion of the consecutive
>> >> memory accesses to the same rank.
>> > 
>> > This certainly needs performance numbers to justify ... and I am sorry,
>> > "hopefully improves" is not a valid justification :)
>> > 
>> > I can imagine that this works well initially, when there hasn't been a
>> > lot of memory fragmentation going on. But quickly after your system is
>> > under stress, I doubt this will be very useful. Proof me wrong. ;)
>> 
>> Agreed. The implementation of __preferred_rank() seems to be very simple and
>> optimistic.
> 
> DRAM rank is selected by CS bits from DRAM controllers. In the most systems
> CS bits are alloated to specific bit fields in BUS address. For example,
> If CS bit is allocated to bit[16] in bus (physical) address in two rank
> system, all 16KiB with bit[16] = 1 are in the rank 1 and the others are
> in the rank 0.
> This patch is not beneficial to other system than the mobile devices
> with LPDDR5. That is why the default behavior of this patch is noop.

Hmm, the patch requires at least pageblock_nr_pages, which is 2MB on x86 (dunno
about ARM), so 16KiB would be way too small. What are the actual granularities then?

>> I think these systems could perhaps better behave as NUMA with (interleaved)
>> nodes for each rank, then you immediately have all the mempolicies support etc
>> to achieve what you need? Of course there's some cost as well, but not the costs
>> of adding hacks to page allocator core?
> 
> Thank you for the proposal. NUMA will be helpful to allocate pages from
> a specific rank programmatically. I should consider NUMA if rank
> affinity should be also required.
> However, page allocation overhead by this policy (page migration and
> reclamation ect.) will give the users worse responsiveness. The intend
> of this patch is to reduce rank switch delay optimistically without
> hurting page allocation speed.

The problem is, without some control of page migration and reclaim, the simple
preference approach will not work after some uptime, as David suggested. It will
just mean that the preferred rank will be allocated first, then the
non-preferred rank (Linux will fill all unused memory with page cache if
possible), then reclaim will free memory from both ranks without any special
care, and new allocations will thus come from both ranks.

