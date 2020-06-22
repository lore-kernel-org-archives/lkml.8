Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AECC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90601206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgFVIh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:37:29 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57976 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbgFVIh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:37:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0U0K3ntX_1592815044;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0K3ntX_1592815044)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Jun 2020 16:37:24 +0800
Date:   Mon, 22 Jun 2020 16:37:24 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v2 3/3] mm/shuffle: remove dynamic reconfiguration
Message-ID: <20200622083724.GA96508@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200619125923.22602-1-david@redhat.com>
 <20200619125923.22602-4-david@redhat.com>
 <CAPcyv4hvwHDa=1suuuEFX5mmpOm12kv-Axbd8G7bp9iaA+FWAA@mail.gmail.com>
 <7a5f9ea1-7405-7058-af60-eea0bc165e79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a5f9ea1-7405-7058-af60-eea0bc165e79@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 09:33:28AM +0200, David Hildenbrand wrote:
>On 20.06.20 03:49, Dan Williams wrote:
>> On Fri, Jun 19, 2020 at 5:59 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> Commit e900a918b098 ("mm: shuffle initial free memory to improve
>>> memory-side-cache utilization") promised "autodetection of a
>>> memory-side-cache (to be added in a follow-on patch)" over a year ago.
>>>
>>> The original series included patches [1], however, they were dropped
>>> during review [2] to be followed-up later.
>>>
>>> Due to lack of platforms that publish an HMAT, autodetection is currently
>>> not implemented. However, manual activation is actively used [3]. Let's
>>> simplify for now and re-add when really (ever?) needed.
>>>
>>> [1] https://lkml.kernel.org/r/154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com
>>> [2] https://lkml.kernel.org/r/154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com
>>> [3] https://lkml.kernel.org/r/CAPcyv4irwGUU2x+c6b4L=KbB1dnasNKaaZd6oSpYjL9kfsnROQ@mail.gmail.com
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Minchan Kim <minchan@kernel.org>
>>> Cc: Huang Ying <ying.huang@intel.com>
>>> Cc: Wei Yang <richard.weiyang@gmail.com>
>>> Cc: Mel Gorman <mgorman@techsingularity.net>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  mm/shuffle.c | 28 ++--------------------------
>>>  mm/shuffle.h | 17 -----------------
>>>  2 files changed, 2 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/mm/shuffle.c b/mm/shuffle.c
>>> index dd13ab851b3ee..9b5cd4b004b0f 100644
>>> --- a/mm/shuffle.c
>>> +++ b/mm/shuffle.c
>>> @@ -10,33 +10,11 @@
>>>  #include "shuffle.h"
>>>
>>>  DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
>>> -static unsigned long shuffle_state __ro_after_init;
>>> -
>>> -/*
>>> - * Depending on the architecture, module parameter parsing may run
>>> - * before, or after the cache detection. SHUFFLE_FORCE_DISABLE prevents,
>>> - * or reverts the enabling of the shuffle implementation. SHUFFLE_ENABLE
>>> - * attempts to turn on the implementation, but aborts if it finds
>>> - * SHUFFLE_FORCE_DISABLE already set.
>>> - */
>>> -__meminit void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
>>> -{
>>> -       if (ctl == SHUFFLE_FORCE_DISABLE)
>>> -               set_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state);
>>> -
>>> -       if (test_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state)) {
>>> -               if (test_and_clear_bit(SHUFFLE_ENABLE, &shuffle_state))
>>> -                       static_branch_disable(&page_alloc_shuffle_key);
>>> -       } else if (ctl == SHUFFLE_ENABLE
>>> -                       && !test_and_set_bit(SHUFFLE_ENABLE, &shuffle_state))
>>> -               static_branch_enable(&page_alloc_shuffle_key);
>>> -}
>>>
>>>  static bool shuffle_param;
>>>  static int shuffle_show(char *buffer, const struct kernel_param *kp)
>>>  {
>>> -       return sprintf(buffer, "%c\n", test_bit(SHUFFLE_ENABLE, &shuffle_state)
>>> -                       ? 'Y' : 'N');
>>> +       return sprintf(buffer, "%c\n", shuffle_param ? 'Y' : 'N');
>>>  }
>>>
>>>  static __meminit int shuffle_store(const char *val,
>>> @@ -47,9 +25,7 @@ static __meminit int shuffle_store(const char *val,
>>>         if (rc < 0)
>>>                 return rc;
>>>         if (shuffle_param)
>>> -               page_alloc_shuffle(SHUFFLE_ENABLE);
>>> -       else
>>> -               page_alloc_shuffle(SHUFFLE_FORCE_DISABLE);
>>> +               static_branch_enable(&page_alloc_shuffle_key);
>>>         return 0;
>>>  }
>> 
>> Let's do proper input validation here and require 1 / 'true' to enable
>> shuffling and not also allow 0 to be an 'enable' value.
>
>I don't think that's currently done?
>
>param_set_bool(val, kp) will only default val==NULL to 'true'. Passing 0
>will properly be handled by strtobool(). Or am I missing something?
>

Agree with this statement.

>Thanks!
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
