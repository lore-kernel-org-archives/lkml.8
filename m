Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6B5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA32925471
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpDyoyBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbgFVHdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:33:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60085 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731323AbgFVHdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592811220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Bl1UeornAt/775yEZ4avXhN5Jaa/cDGCCOWXwTwWe1I=;
        b=GpDyoyByw8k0aUyf64KHwtbsbYi0LY8V0n1z/J6zMZrHjmtnHiiX/ax6TtSwWuoWQq41jM
        +q08pocTZwGe1ZHV3ohq6Rc2CHRkURVsKNlRbUxln/F8ezzB+UA2zHyLaGHRUJEnOadl4l
        nV3kyNeJ3FQOPP7bRYFl9WqB9JPrhEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-QKvxSkPTPMOLxRw3SSrOFA-1; Mon, 22 Jun 2020 03:33:34 -0400
X-MC-Unique: QKvxSkPTPMOLxRw3SSrOFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C864A0BD8;
        Mon, 22 Jun 2020 07:33:33 +0000 (UTC)
Received: from [10.36.113.213] (ovpn-113-213.ams2.redhat.com [10.36.113.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF4AC5C296;
        Mon, 22 Jun 2020 07:33:29 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] mm/shuffle: remove dynamic reconfiguration
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20200619125923.22602-1-david@redhat.com>
 <20200619125923.22602-4-david@redhat.com>
 <CAPcyv4hvwHDa=1suuuEFX5mmpOm12kv-Axbd8G7bp9iaA+FWAA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <7a5f9ea1-7405-7058-af60-eea0bc165e79@redhat.com>
Date:   Mon, 22 Jun 2020 09:33:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hvwHDa=1suuuEFX5mmpOm12kv-Axbd8G7bp9iaA+FWAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.20 03:49, Dan Williams wrote:
> On Fri, Jun 19, 2020 at 5:59 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Commit e900a918b098 ("mm: shuffle initial free memory to improve
>> memory-side-cache utilization") promised "autodetection of a
>> memory-side-cache (to be added in a follow-on patch)" over a year ago.
>>
>> The original series included patches [1], however, they were dropped
>> during review [2] to be followed-up later.
>>
>> Due to lack of platforms that publish an HMAT, autodetection is currently
>> not implemented. However, manual activation is actively used [3]. Let's
>> simplify for now and re-add when really (ever?) needed.
>>
>> [1] https://lkml.kernel.org/r/154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com
>> [2] https://lkml.kernel.org/r/154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com
>> [3] https://lkml.kernel.org/r/CAPcyv4irwGUU2x+c6b4L=KbB1dnasNKaaZd6oSpYjL9kfsnROQ@mail.gmail.com
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Wei Yang <richard.weiyang@gmail.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/shuffle.c | 28 ++--------------------------
>>  mm/shuffle.h | 17 -----------------
>>  2 files changed, 2 insertions(+), 43 deletions(-)
>>
>> diff --git a/mm/shuffle.c b/mm/shuffle.c
>> index dd13ab851b3ee..9b5cd4b004b0f 100644
>> --- a/mm/shuffle.c
>> +++ b/mm/shuffle.c
>> @@ -10,33 +10,11 @@
>>  #include "shuffle.h"
>>
>>  DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
>> -static unsigned long shuffle_state __ro_after_init;
>> -
>> -/*
>> - * Depending on the architecture, module parameter parsing may run
>> - * before, or after the cache detection. SHUFFLE_FORCE_DISABLE prevents,
>> - * or reverts the enabling of the shuffle implementation. SHUFFLE_ENABLE
>> - * attempts to turn on the implementation, but aborts if it finds
>> - * SHUFFLE_FORCE_DISABLE already set.
>> - */
>> -__meminit void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
>> -{
>> -       if (ctl == SHUFFLE_FORCE_DISABLE)
>> -               set_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state);
>> -
>> -       if (test_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state)) {
>> -               if (test_and_clear_bit(SHUFFLE_ENABLE, &shuffle_state))
>> -                       static_branch_disable(&page_alloc_shuffle_key);
>> -       } else if (ctl == SHUFFLE_ENABLE
>> -                       && !test_and_set_bit(SHUFFLE_ENABLE, &shuffle_state))
>> -               static_branch_enable(&page_alloc_shuffle_key);
>> -}
>>
>>  static bool shuffle_param;
>>  static int shuffle_show(char *buffer, const struct kernel_param *kp)
>>  {
>> -       return sprintf(buffer, "%c\n", test_bit(SHUFFLE_ENABLE, &shuffle_state)
>> -                       ? 'Y' : 'N');
>> +       return sprintf(buffer, "%c\n", shuffle_param ? 'Y' : 'N');
>>  }
>>
>>  static __meminit int shuffle_store(const char *val,
>> @@ -47,9 +25,7 @@ static __meminit int shuffle_store(const char *val,
>>         if (rc < 0)
>>                 return rc;
>>         if (shuffle_param)
>> -               page_alloc_shuffle(SHUFFLE_ENABLE);
>> -       else
>> -               page_alloc_shuffle(SHUFFLE_FORCE_DISABLE);
>> +               static_branch_enable(&page_alloc_shuffle_key);
>>         return 0;
>>  }
> 
> Let's do proper input validation here and require 1 / 'true' to enable
> shuffling and not also allow 0 to be an 'enable' value.

I don't think that's currently done?

param_set_bool(val, kp) will only default val==NULL to 'true'. Passing 0
will properly be handled by strtobool(). Or am I missing something?

Thanks!

-- 
Thanks,

David / dhildenb

