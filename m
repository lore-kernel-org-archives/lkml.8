Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E857C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0952F206BE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgGBQNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:13:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:58640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgGBQNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:13:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 987DCC11D;
        Thu,  2 Jul 2020 16:13:10 +0000 (UTC)
Subject: Re: [PATCH v3 3/8] mm/hugetlb: unify migration callbacks
To:     Joonsoo Kim <js1304@gmail.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-4-git-send-email-iamjoonsoo.kim@lge.com>
 <20200625112625.GD1320@dhcp22.suse.cz>
 <CAAmzW4N646-xYWosMwwnOgjAB+Z_eoZO4rs58ab+gYbHXmydJA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c3d97171-b36a-338b-5e5c-360bb52ffe0c@suse.cz>
Date:   Thu, 2 Jul 2020 18:13:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAAmzW4N646-xYWosMwwnOgjAB+Z_eoZO4rs58ab+gYbHXmydJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/20 6:02 AM, Joonsoo Kim wrote:
> 2020년 6월 25일 (목) 오후 8:26, Michal Hocko <mhocko@kernel.org>님이 작성:
>>
>> On Tue 23-06-20 15:13:43, Joonsoo Kim wrote:
>> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> >
>> > There is no difference between two migration callback functions,
>> > alloc_huge_page_node() and alloc_huge_page_nodemask(), except
>> > __GFP_THISNODE handling. This patch adds an argument, gfp_mask, on
>> > alloc_huge_page_nodemask() and replace the callsite for
>> > alloc_huge_page_node() with the call to
>> > alloc_huge_page_nodemask(..., __GFP_THISNODE).
>> >
>> > It's safe to remove a node id check in alloc_huge_page_node() since
>> > there is no caller passing NUMA_NO_NODE as a node id.
>>
>> Yes this is indeed safe. alloc_huge_page_node used to be called from
>> other internal hugetlb allocation layer and that allowed NUMA_NO_NODE as
>> well. Now it is called only from the mempolicy migration callback and
>> that always specifies a node and want to stick with that node.
>>
>> But I have to say I really dislike the gfp semantic because it is
>> different from any other allocation function I can think of. It
>> specifies what to be added rather than what should be used.
>>
>> Removing the function is ok but please use the full gfp mask instead
>> or if that is impractical for some reason (wich shouldn't be the case
>> as htlb_alloc_mask should be trivial to make static inline) make it
>> explicit that this is not a gfp_mask but a gfp modifier and explicitly
>> state which modifiers are allowed.
> 
> Okay. I will try to solve your concern. Concrete solution is not yet prepared
> but perhaps I will use full gfp_mask by using htlb_alloc_mask() in caller sites.

Yeah, that should be feasible. alloc_huge_page_vma() already does
htlb_alloc_mask(h). In alloc_new_node_page() and new_page_nodemask() it would be
consistent with the other cases handled there (THP and base).

> Thanks.
> 

