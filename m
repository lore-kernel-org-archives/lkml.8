Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D0EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF38820781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHCPp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:45:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:39826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgHCPp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:45:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ADAECAB89;
        Mon,  3 Aug 2020 15:46:11 +0000 (UTC)
Subject: Re: [PATCH] mm: sort freelist by rank number
To:     David Hildenbrand <david@redhat.com>, pullip.cho@samsung.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hyesoo.yu@samsung.com, janghyuck.kim@samsung.com
References: <CGME20200803061805epcas2p20faeeff0b31b23d1bc4464972285b561@epcas2p2.samsung.com>
 <1596435031-41837-1-git-send-email-pullip.cho@samsung.com>
 <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ebea485c-7cce-3a4a-2ac4-7a608efe2844@suse.cz>
Date:   Mon, 3 Aug 2020 17:45:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f41af0f-4593-3441-12f4-5b0f7e6999ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/20 9:57 AM, David Hildenbrand wrote:
> On 03.08.20 08:10, pullip.cho@samsung.com wrote:
>> From: Cho KyongHo <pullip.cho@samsung.com>
>> 
>> LPDDR5 introduces rank switch delay. If three successive DRAM accesses
>> happens and the first and the second ones access one rank and the last
>> access happens on the other rank, the latency of the last access will
>> be longer than the second one.
>> To address this panelty, we can sort the freelist so that a specific
>> rank is allocated prior to another rank. We expect the page allocator
>> can allocate the pages from the same rank successively with this
>> change. It will hopefully improves the proportion of the consecutive
>> memory accesses to the same rank.
> 
> This certainly needs performance numbers to justify ... and I am sorry,
> "hopefully improves" is not a valid justification :)
> 
> I can imagine that this works well initially, when there hasn't been a
> lot of memory fragmentation going on. But quickly after your system is
> under stress, I doubt this will be very useful. Proof me wrong. ;)

Agreed. The implementation of __preferred_rank() seems to be very simple and
optimistic.
I think these systems could perhaps better behave as NUMA with (interleaved)
nodes for each rank, then you immediately have all the mempolicies support etc
to achieve what you need? Of course there's some cost as well, but not the costs
of adding hacks to page allocator core?
