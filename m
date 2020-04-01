Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F11C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D223820658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUHPxcjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgDAQQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:16:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44749 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726612AbgDAQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585757765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Lu/GC0q3eyXrqT8et0mcRt8CMhdeNxfMtXje2c9rRv4=;
        b=MUHPxcjHCsJtVoFCTZgHVPCSe6Qb+QBNlDBLWCPHw2bTitzVbYU2jcBhbZGXkjFdtmpZsf
        OlwE6Jqs++NiQZ6xyJWe3Nyp9jIiSkcIifF1HPpU/z5Gtgt2NkdCmayvgD4j0vLiZNSkEa
        cqLGClR8+TvZUl7NSaNP8hZNJiUhoVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-SEp07Wr9PT6XwdQ2_OQ2NQ-1; Wed, 01 Apr 2020 12:16:04 -0400
X-MC-Unique: SEp07Wr9PT6XwdQ2_OQ2NQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAB101902EA9;
        Wed,  1 Apr 2020 16:16:02 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C42255C1C5;
        Wed,  1 Apr 2020 16:16:00 +0000 (UTC)
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
To:     Michal Hocko <mhocko@kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200401154217.GQ22681@dhcp22.suse.cz>
 <dfc0014a-9b85-5eeb-70ea-d622ccf5d988@redhat.com>
 <20200401160048.GU22681@dhcp22.suse.cz>
 <20200401160929.jwekhr24tb44odea@ca-dmjordan1.us.oracle.com>
 <20200401161243.GW22681@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <92938a5c-ad19-4571-04f3-03530f687f61@redhat.com>
Date:   Wed, 1 Apr 2020 18:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401161243.GW22681@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.20 18:12, Michal Hocko wrote:
> On Wed 01-04-20 12:09:29, Daniel Jordan wrote:
>> On Wed, Apr 01, 2020 at 06:00:48PM +0200, Michal Hocko wrote:
>>> On Wed 01-04-20 17:50:22, David Hildenbrand wrote:
>>>> On 01.04.20 17:42, Michal Hocko wrote:
>>>>> I am sorry but I have completely missed this patch.
>>>>>
>>>>> On Wed 11-03-20 20:38:48, Shile Zhang wrote:
>>>>>> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
>>>>>> initialise the deferred pages with local interrupts disabled. It is
>>>>>> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
>>>>>> initializing deferred pages").
>>>>>>
>>>>>> On machine with NCPUS <= 2, the 'pgdatinit' kthread could be bound to
>>>>>> the boot CPU, which could caused the tick timer long time stall, system
>>>>>> jiffies not be updated in time.
>>>>>>
>>>>>> The dmesg shown that:
>>>>>>
>>>>>>     [    0.197975] node 0 initialised, 32170688 pages in 1ms
>>>>>>
>>>>>> Obviously, 1ms is unreasonable.
>>>>>>
>>>>>> Now, fix it by restore in the pending interrupts for every 32*1204 pages
>>>>>> (128MB) initialized, give the chance to update the systemd jiffies.
>>>>>> The reasonable demsg shown likes:
>>>>>>
>>>>>>     [    1.069306] node 0 initialised, 32203456 pages in 894ms
>>>>>>
>>>>>> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages").
>>>>>
>>>>> I dislike this solution TBH. It effectivelly conserves the current code
>>>>> and just works around the problem. Why do we hold the IRQ lock here in
>>>>> the first place? This is an early init code and a very limited code is
>>>>> running at this stage. Certainly nothing memory hotplug related which
>>>>> should be the only path really interested in the resize lock AFAIR.
>>>>
>>>> Yeah, I don't think ACPI and friends are up yet.
>>>
>>> Just to save somebody time to check. The deferred initialization blocks
>>> the further boot until all workders are done - see page_alloc_init_late
>>> (kernel_init path).
>>
>> Ha, I just finished following all the hotplug paths to check this out, and as
>> you all know there are a *lot* :-) Well at least we're in agreement.
> 
> Good to have it double checked!
>  
>>>>> This needs a double checking but I strongly believe that the lock can be
>>>>> simply dropped in this path.
>>
>> This is what my fix does, it limits the time the resize lock is held.
> 
> Just remove it from the deferred intialization and add a comment that we
> deliberately not taking the lock here because abc
> 

We should just double check what

commit 3a2d7fa8a3d5ae740bd0c21d933acc6220857ed0
Author: Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu Apr 5 16:22:27 2018 -0700

    mm: disable interrupts while initializing deferred pages
    
    Vlastimil Babka reported about a window issue during which when deferred
    pages are initialized, and the current version of on-demand
    initialization is finished, allocations may fail.  While this is highly
    unlikely scenario, since this kind of allocation request must be large,
    and must come from interrupt handler, we still want to cover it.
    
    We solve this by initializing deferred pages with interrupts disabled,
    and holding node_size_lock spin lock while pages in the node are being
    initialized.  The on-demand deferred page initialization that comes
    later will use the same lock, and thus synchronize with
    deferred_init_memmap().
    
    It is unlikely for threads that initialize deferred pages to be
    interrupted.  They run soon after smp_init(), but before modules are
    initialized, and long before user space programs.  This is why there is
    no adverse effect of having these threads running with interrupts
    disabled.

tried to solve does not apply.

-- 
Thanks,

David / dhildenb

