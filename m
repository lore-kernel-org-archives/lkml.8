Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332F12070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLLgnzhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgGFN5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:57:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59540 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728940AbgGFN5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594043826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=KRTv0folRt/5tw+UDLWBJrPgFbYsVqLGAXYurdQnLA4=;
        b=GLLgnzhJIs00ffmP5KyE1n1Hb7aWKN+82B2AqJOcZnvdYxZLYZ1IGWF2X4CUgImcmSIzHv
        GRxLFTuEVCPdt7y8FEQsXMyryU7z45Df+AradRxBtOkLLL5i28eRSAWMFFNnZ9OUpHTYnJ
        PST1wY2AZ4uGeb1BB5Jn2Xqng5aHTOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-ueak3Bf9PoC9gZsWgZfO1A-1; Mon, 06 Jul 2020 09:57:05 -0400
X-MC-Unique: ueak3Bf9PoC9gZsWgZfO1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57A5319200C0;
        Mon,  6 Jul 2020 13:57:03 +0000 (UTC)
Received: from [10.36.114.3] (ovpn-114-3.ams2.redhat.com [10.36.114.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C461F512FE;
        Mon,  6 Jul 2020 13:56:58 +0000 (UTC)
Subject: Re: [PATCH 1/3] arm64/numa: set numa_off to false when numa node is
 fake
To:     Justin He <Justin.He@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kaly Xin <Kaly.Xin@arm.com>
References: <20200706011947.184166-1-justin.he@arm.com>
 <20200706011947.184166-2-justin.he@arm.com>
 <5006eb38-a80e-e368-48db-7f497e15c8af@redhat.com>
 <AM6PR08MB4069A96C32135C2C4A8A9FD2F7690@AM6PR08MB4069.eurprd08.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <ef441868-9336-5cf4-5e5e-78dc3e3e8a96@redhat.com>
Date:   Mon, 6 Jul 2020 15:56:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <AM6PR08MB4069A96C32135C2C4A8A9FD2F7690@AM6PR08MB4069.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.20 14:36, Justin He wrote:
> Hi David, thanks for the comments. See my answer please:
> 
>> -----Original Message-----
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Monday, July 6, 2020 4:03 PM
>> To: Justin He <Justin.He@arm.com>; Catalin Marinas
>> <Catalin.Marinas@arm.com>; Will Deacon <will@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>; Mike Rapoport
>> <rppt@linux.ibm.com>; Baoquan He <bhe@redhat.com>; Chuhong Yuan
>> <hslester96@gmail.com>; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; linux-mm@kvack.org; Kaly Xin <Kaly.Xin@arm.com>
>> Subject: Re: [PATCH 1/3] arm64/numa: set numa_off to false when numa node
>> is fake
>>
>> On 06.07.20 03:19, Jia He wrote:
>>> Previously, numa_off is set to true unconditionally in dummy_numa_init(),
>>> even if there is a fake numa node.
>>>
>>> But acpi will translate node id to NUMA_NO_NODE(-1) in
>> acpi_map_pxm_to_node()
>>> because it regards numa_off as turning off the numa node.
>>>
>>> Without this patch, pmem can't be probed as a RAM device on arm64 if
>> SRAT table
>>> isn't present.
>>>
>>> $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -
>> a 64K
>>> kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with
>> invalid node: -1
>>> kmem: probe of dax0.0 failed with error -22
>>>
>>> This fixes it by setting numa_off to false.
>>>
>>> Signed-off-by: Jia He <justin.he@arm.com>
>>> ---
>>>  arch/arm64/mm/numa.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>>> index aafcee3e3f7e..7689986020d9 100644
>>> --- a/arch/arm64/mm/numa.c
>>> +++ b/arch/arm64/mm/numa.c
>>> @@ -440,7 +440,8 @@ static int __init dummy_numa_init(void)
>>>  		return ret;
>>>  	}
>>>
>>> -	numa_off = true;
>>> +	/* force numa_off to be false since we have a fake numa node here
>> */
>>> +	numa_off = false;
>>>  	return 0;
>>>  }
>>>
>>>
>>
>> What would happen if we use something like this in drivers/dax/kmem.c
>> instead:
>>
>> numa_node = dev_dax->target_node;
>> if (numa_node == NUMA_NO_NODE)
>> 	numa_node = memory_add_physaddr_to_nid(kmem_start);
>>
>> and eventually dropping the pr_warn in
>> arm64/memory_add_physaddr_to_nid() ? Would that work?
> 
> Yes, it works. I sent a similar patch [1] before. But seems pmem
> maintainer didn't satisfy it. Do you think memory_add_physaddr_to_nid()
> is better than numa_mem_id()? 

Well, it's the somewhat-common way to get a NID for memory hotadd.

E.g.,
- drivers/acpi/acpi_memhotplug.c
- drivers/base/memory.c
- drivers/hv/hv_balloon.c
- drivers/virtio/virtio_mem.c
- drivers/xen/balloon.c

use it in combination with add_memory_*()

Especially, ACPI and virtio-mem use it in case NUMA_NO_NID is detected.

-- 
Thanks,

David / dhildenb

