Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75840C3524F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA5320658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgBCJbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:31:32 -0500
Received: from relay.sw.ru ([185.231.240.75]:58162 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgBCJbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:31:32 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iyY4Y-0003vv-U0; Mon, 03 Feb 2020 12:31:15 +0300
Subject: Re: [PATCH v3] mm: Allocate shrinker_map on appropriate NUMA node
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <158047248934.390127.5043060848569612747.stgit@localhost.localdomain>
 <ebe1c944-2e0f-136d-dd09-0bb37d500fe2@redhat.com>
 <5f3fc9a9-9a22-ccc3-5971-9783b60807bc@virtuozzo.com>
 <20200131154735.GA4520@dhcp22.suse.cz>
 <a03cb815-8f80-03db-c1bd-39af960db601@virtuozzo.com>
 <20200131160151.GB4520@dhcp22.suse.cz>
 <fff0e636-4c36-ed10-281c-8cdb0687c839@virtuozzo.com>
 <20200131161814.GC4520@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <878c2752-9817-3c37-c9fc-ef46c3a9a256@virtuozzo.com>
Date:   Mon, 3 Feb 2020 12:31:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131161814.GC4520@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.2020 19:18, Michal Hocko wrote:
> On Fri 31-01-20 19:08:49, Kirill Tkhai wrote:
>> mm: Allocate shrinker_map on appropriate NUMA node
>>
>> From: Kirill Tkhai <ktkhai@virtuozzo.com>
>>
>> Despite shrinker_map may be touched from any cpu
>> (e.g., a bit there may be set by a task running
>> everywhere); kswapd is always bound to specific
>> node. So, we will allocate shrinker_map from
>> related NUMA node to respect its NUMA locality.
>> Also, this follows generic way we use for allocation
>> memcg's per-node data.
> 
> I would just drop the last sentence.

I mean we allocate memcg->nodeinfo from specific node,
so shrinker_map also should follow this rule. Though,
I have no objections to remove this on patch merge.

>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks,
Kirill.


