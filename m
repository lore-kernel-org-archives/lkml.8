Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E692CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B191920671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgETLgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:36:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgETLgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:36:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B5FDBAE61;
        Wed, 20 May 2020 11:36:12 +0000 (UTC)
Subject: Re: [PATCH v3 02/19] mm: memcg: prepare for byte-sized vmstat items
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-3-guro@fb.com>
 <a63f9190-e91b-97d7-f579-8ccf0fce46c7@suse.cz>
Message-ID: <ab1e0eae-9baf-eccf-82cb-9e47dbbab13b@suse.cz>
Date:   Wed, 20 May 2020 13:36:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a63f9190-e91b-97d7-f579-8ccf0fce46c7@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 1:31 PM, Vlastimil Babka wrote:
> On 4/22/20 10:46 PM, Roman Gushchin wrote:
>> To implement per-object slab memory accounting, we need to
>> convert slab vmstat counters to bytes. Actually, out of
>> 4 levels of counters: global, per-node, per-memcg and per-lruvec
>> only two last levels will require byte-sized counters.
>> It's because global and per-node counters will be counting the
>> number of slab pages, and per-memcg and per-lruvec will be
>> counting the amount of memory taken by charged slab objects.
>> 
>> Converting all vmstat counters to bytes or even all slab
>> counters to bytes would introduce an additional overhead.
>> So instead let's store global and per-node counters
>> in pages, and memcg and lruvec counters in bytes.
>> 
>> To make the API clean all access helpers (both on the read
>> and write sides) are dealing with bytes.
>> 
>> To avoid back-and-forth conversions a new flavor of helpers
>> is introduced, which always returns values in pages:
>> node_page_state_pages() and global_node_page_state_pages().
>> 
>> Actually new helpers are just reading raw values. Old helpers are
>> simple wrappers, which perform a conversion if the vmstat items are
>> in bytes. Because at the moment no one actually need bytes,
>> there are WARN_ON_ONCE() macroses inside to warn about inappropriate
>> use cases.
>> 
>> Thanks to Johannes Weiner for the idea of having the byte-sized API
>> on top of the page-sized internal storage.
>> 
>> Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Reviewed-By: Vlastimil Babka <vbabka@suse.cz>
> 
> But it's somewhat complicated, so it would be great to document it in comments
> of e.g. include/linux/vmstat.h that what the API returns as unsigned long, can
> be either bytes or pages depending on vmstat_item_in_bytes().

Also forgot to add that if those WARN_ON_ONCEs are going to stay, they should
rather become VM_WARN_ON_ONCEs
