Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC68C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC62E20760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gj/tsU5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgFJHaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:30:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36354 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726401AbgFJHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591774206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=SurJWUtckwlHL/+sYCpJX5zoI0eH49onJUthp20u0gk=;
        b=gj/tsU5kq06pTUOdujquw1eLsrm1O96ZAUKEWUanmVWTABsax/8uoyA+lRnfqqDmSdOAaS
        FGMJJZmr5H/zbz0K5KJQiivo684OOvli/bYbI0fKc3txuYNHtRB5aVslVJWLGgEQ9W1t9x
        mIAiKCswrp7EgOETa+EqaQBCSp7tJK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-WEiOybC7NlerRH6_QIwpPQ-1; Wed, 10 Jun 2020 03:30:05 -0400
X-MC-Unique: WEiOybC7NlerRH6_QIwpPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 481B6107ACF2;
        Wed, 10 Jun 2020 07:30:03 +0000 (UTC)
Received: from [10.36.114.42] (ovpn-114-42.ams2.redhat.com [10.36.114.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 137F18927E;
        Wed, 10 Jun 2020 07:30:00 +0000 (UTC)
Subject: Re: [PATCH v2] x86/mm: use max memory block size on bare metal
From:   David Hildenbrand <david@redhat.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
References: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
 <ab4e0907-522d-7834-03f3-014e3ed904c5@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <0311c2e5-aa27-f59e-cd00-0c51332b73fd@redhat.com>
Date:   Wed, 10 Jun 2020 09:30:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ab4e0907-522d-7834-03f3-014e3ed904c5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.06.20 09:20, David Hildenbrand wrote:
> On 10.06.20 00:54, Daniel Jordan wrote:
>> Some of our servers spend significant time at kernel boot initializing
>> memory block sysfs directories and then creating symlinks between them
>> and the corresponding nodes.  The slowness happens because the machines
>> get stuck with the smallest supported memory block size on x86 (128M),
>> which results in 16,288 directories to cover the 2T of installed RAM.
>> The search for each memory block is noticeable even with
>> commit 4fb6eabf1037 ("drivers/base/memory.c: cache memory blocks in
>> xarray to accelerate lookup").
>>
>> Commit 078eb6aa50dc ("x86/mm/memory_hotplug: determine block size based
>> on the end of boot memory") chooses the block size based on alignment
>> with memory end.  That addresses hotplug failures in qemu guests, but
>> for bare metal systems whose memory end isn't aligned to even the
>> smallest size, it leaves them at 128M.
>>
>> Make kernels that aren't running on a hypervisor use the largest
>> supported size (2G) to minimize overhead on big machines.  Kernel boot
>> goes 7% faster on the aforementioned servers, shaving off half a second.
>>
>> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Steven Sistare <steven.sistare@oracle.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>
>> Applies to 5.7 and today's mainline
>>
>>  arch/x86/mm/init_64.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index 8b5f73f5e207c..906fbdb060748 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -55,6 +55,7 @@
>>  #include <asm/uv/uv.h>
>>  #include <asm/setup.h>
>>  #include <asm/ftrace.h>
>> +#include <asm/hypervisor.h>
>>  
>>  #include "mm_internal.h"
>>  
>> @@ -1390,6 +1391,15 @@ static unsigned long probe_memory_block_size(void)
>>  		goto done;
>>  	}
>>  
>> +	/*
>> +	 * Use max block size to minimize overhead on bare metal, where
>> +	 * alignment for memory hotplug isn't a concern.
>> +	 */
>> +	if (hypervisor_is_type(X86_HYPER_NATIVE)) {
>> +		bz = MAX_BLOCK_SIZE;
>> +		goto done;
>> +	}
> 
> I'd assume that bioses on physical machines >= 64GB will not align
> bigger (>= 2GB) DIMMs to something < 2GB.
> 
> Acked-by: David Hildenbrand <david@redhat.com>

FTWT, setup_arch() does the init_hypervisor_platform() call. I assume
that should be early enough.

We should really look into factoring out memory_block_size_bytes() into
common code, turning into a simple global variable read. Then, we should
provide an interface to configure the memory block size during boot from
arch code (set_memory_block_size()).

-- 
Thanks,

David / dhildenb

