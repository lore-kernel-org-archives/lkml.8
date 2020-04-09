Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39DBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 02:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1DA20730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 02:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tk3FPODE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDIC7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 22:59:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60684 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbgDIC7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 22:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586401162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=drb6LdoPt8DojKwyM0hU/W9FVGYuL0GAN//NvbMdUQQ=;
        b=Tk3FPODESRO13e6Caa4WuviI/cwTd5MzYNudPEEV8WwvzVbjDDLbGbhMIFQEvc8Al+Sl9Q
        Iegl+MSHVZOcObzvlQXjt3xgKvHNAUgC4vRyo5lVxhxEXdsrTXiI+HKaaJznjTvPvyMXw3
        TBt9m/hSVT7SnR58UzaYqKhbCvdHLg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-kLlVpwcxOh6qvgKVFagviQ-1; Wed, 08 Apr 2020 22:59:18 -0400
X-MC-Unique: kLlVpwcxOh6qvgKVFagviQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ED0918AB2C3;
        Thu,  9 Apr 2020 02:59:16 +0000 (UTC)
Received: from [10.72.8.19] (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0879FC0DA3;
        Thu,  9 Apr 2020 02:59:06 +0000 (UTC)
Subject: Re: [PATCH v1 1/2] powerpc/pseries/hotplug-memory: stop checking
 is_mem_section_removable()
To:     Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20200407135416.24093-1-david@redhat.com>
 <20200407135416.24093-2-david@redhat.com>
 <20200408024630.GQ2402@MiWiFi-R3L-srv>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>
From:   piliu <piliu@redhat.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <16187f69-0e5b-c9c2-a31b-8658425758aa@redhat.com>
Date:   Thu, 9 Apr 2020 10:59:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200408024630.GQ2402@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/2020 10:46 AM, Baoquan He wrote:
> Add Pingfan to CC since he usually handles ppc related bugs for RHEL.
> 
> On 04/07/20 at 03:54pm, David Hildenbrand wrote:
>> In commit 53cdc1cb29e8 ("drivers/base/memory.c: indicate all memory
>> blocks as removable"), the user space interface to compute whether a memory
>> block can be offlined (exposed via
>> /sys/devices/system/memory/memoryX/removable) has effectively been
>> deprecated. We want to remove the leftovers of the kernel implementation.
> 
> Pingfan, can you have a look at this change on PPC?  Please feel free to
> give comments if any concern, or offer ack if it's OK to you.
> 
>>
>> When offlining a memory block (mm/memory_hotplug.c:__offline_pages()),
>> we'll start by:
>> 1. Testing if it contains any holes, and reject if so
>> 2. Testing if pages belong to different zones, and reject if so
>> 3. Isolating the page range, checking if it contains any unmovable pages
>>
>> Using is_mem_section_removable() before trying to offline is not only racy,
>> it can easily result in false positives/negatives. Let's stop manually
>> checking is_mem_section_removable(), and let device_offline() handle it
>> completely instead. We can remove the racy is_mem_section_removable()
>> implementation next.
>>
>> We now take more locks (e.g., memory hotplug lock when offlining and the
>> zone lock when isolating), but maybe we should optimize that
>> implementation instead if this ever becomes a real problem (after all,
>> memory unplug is already an expensive operation). We started using
>> is_mem_section_removable() in commit 51925fb3c5c9 ("powerpc/pseries:
>> Implement memory hotplug remove in the kernel"), with the initial
>> hotremove support of lmbs.
>>
>> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Wei Yang <richard.weiyang@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  .../platforms/pseries/hotplug-memory.c        | 26 +++----------------
>>  1 file changed, 3 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index b2cde1732301..5ace2f9a277e 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -337,39 +337,19 @@ static int pseries_remove_mem_node(struct device_node *np)
>>  
>>  static bool lmb_is_removable(struct drmem_lmb *lmb)
>>  {
>> -	int i, scns_per_block;
>> -	bool rc = true;
>> -	unsigned long pfn, block_sz;
>> -	u64 phys_addr;
>> -
>>  	if (!(lmb->flags & DRCONF_MEM_ASSIGNED))
>>  		return false;
>>  
>> -	block_sz = memory_block_size_bytes();
>> -	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
>> -	phys_addr = lmb->base_addr;
>> -
>>  #ifdef CONFIG_FA_DUMP
>>  	/*
>>  	 * Don't hot-remove memory that falls in fadump boot memory area
>>  	 * and memory that is reserved for capturing old kernel memory.
>>  	 */
>> -	if (is_fadump_memory_area(phys_addr, block_sz))
>> +	if (is_fadump_memory_area(lmb->base_addr, memory_block_size_bytes()))
>>  		return false;
>>  #endif
>> -
>> -	for (i = 0; i < scns_per_block; i++) {
>> -		pfn = PFN_DOWN(phys_addr);
>> -		if (!pfn_in_present_section(pfn)) {
>> -			phys_addr += MIN_MEMORY_BLOCK_SIZE;
>> -			continue;
>> -		}
>> -
>> -		rc = rc && is_mem_section_removable(pfn, PAGES_PER_SECTION);
>> -		phys_addr += MIN_MEMORY_BLOCK_SIZE;
>> -	}
>> -
>> -	return rc;
>> +	/* device_offline() will determine if we can actually remove this lmb */
>> +	return true;
So I think here swaps the check and do sequence. At least it breaks
dlpar_memory_remove_by_count(). It is doable to remove
is_mem_section_removable(), but here should be more effort to re-arrange
the code.

Thanks,
Pingfan
>>  }
>>  
>>  static int dlpar_add_lmb(struct drmem_lmb *);
>> -- 
>> 2.25.1
>>

