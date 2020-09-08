Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EE5C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA2220658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbgIHTlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:41:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:47734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730912AbgIHPxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:53:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D8E6AC26;
        Tue,  8 Sep 2020 15:42:07 +0000 (UTC)
Subject: Re: [PATCH] mm/vmscan: fix infinite loop in drop_slab_node
To:     Chris Down <chris@chrisdown.name>, zangchunxin@bytedance.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20200908142456.89626-1-zangchunxin@bytedance.com>
 <20200908150945.GA1301981@chrisdown.name>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <07c6ebf1-e2b3-11a2-538f-4ac542a4373b@suse.cz>
Date:   Tue, 8 Sep 2020 17:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908150945.GA1301981@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 5:09 PM, Chris Down wrote:
> drop_caches by its very nature can be extremely performance intensive -- if 
> someone wants to abort after trying too long, they can just send a 
> TASK_KILLABLE signal, no? If exiting the loop and returning to usermode doesn't 
> reliably work when doing that, then _that's_ something to improve, but this 
> looks premature to me until that's demonstrated not to work.

Hm there might be existings scripts (even though I dislike those) running
drop_caches periodically, and they are currently not set up to be killed, so one
day it might surprise someone. Dropping should be a one-time event, not a
continual reclaim.

Maybe we could be a bit smarter and e.g. double the threshold currently
hardcoded as "10" with each iteration?

> zangchunxin@bytedance.com writes:
>>In one drop caches action, only traverse memcg once maybe is better.
>>If user need more memory, they can do drop caches again.
> 
> Can you please provide some measurements of the difference in reclamation in 
> practice?
> 

