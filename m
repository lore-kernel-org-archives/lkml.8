Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D7C83001
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC1D42076A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxcZIVgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgD0Xxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:53:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34566 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726259AbgD0Xxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588031623;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCpLh05vrSFnAMWAQ3GvOGITpQiy3hkoT81RPE/4NEg=;
        b=gxcZIVglLN5BDTHLydfd4L6IbmXpetekkLOEIYaCm1FjIk2TDRa1qputZFvDLWNQ1TJGCq
        j6PKNka50zLOSildU/xGcn3z/b3+dmG4d9gnJbhLVHD/5D9K9b4+Mr7mw79dsXpRV5bxYz
        TF8avt107hqz5MX3jAmoWjvmW67Sw1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-xs_S9lOGM3a0v-IsKUqYAA-1; Mon, 27 Apr 2020 19:53:41 -0400
X-MC-Unique: xs_S9lOGM3a0v-IsKUqYAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FE2F1005510;
        Mon, 27 Apr 2020 23:53:39 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-127.bne.redhat.com [10.64.54.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B965910013D9;
        Mon, 27 Apr 2020 23:53:36 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/kernel: Fix range on invalidating dcache for boot
 page tables
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     steve.capper@arm.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        shan.gavin@gmail.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200424050230.16720-1-gshan@redhat.com>
 <20200424100131.GB1167@C02TD0UTHF1T.local>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <f62c7189-27e5-d820-fdd2-72ec5936aa68@redhat.com>
Date:   Tue, 28 Apr 2020 09:53:34 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200424100131.GB1167@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 4/24/20 8:01 PM, Mark Rutland wrote:
> Hi Gavin,
> 
> On Fri, Apr 24, 2020 at 03:02:30PM +1000, Gavin Shan wrote:
>> The MMU is disabled when __create_page_tables() is called. The data
>> cache corresponding to these two page tables, which are tracked by
>> @idmap_pg_dir and @init_pg_dir, is invalidated after the page tables
>> are populated. However, the wrong or inappropriate size have been used
>> and more data cache are invalidated than it need.
>>
>> This fixes the issue by invalidating the data cache for these two
>> page tables separately as they aren't necessarily physically adjacent.
> 
> Thanks for this!
> 
> I think the commit message needs to explain the issue more explicitly,
> e.g.
> 
> | Prior to commit:
> |
> |   8eb7e28d4c642c31i ("arm64/mm: move runtime pgds to rodata")
> |
> | ... idmap_pgd_dir, tramp_pg_dir, reserved_ttbr0, swapper_pg_dir, and
> | init_pg_dir were contiguous at the end of the kernel image. The
> | maintenance at the end of __create_page_tables assumed these were
> | contiguous, and affected everything from the start of idmap_pg_dir to
> | the end of init_pg_dir.
> |
> | That commit moved all but init_pg_dir into the .rodata section, with
> | other data placed between idmap_pg_dir and init_pg_dir, but did not
> | update the maintenance. Hence the maintenance is performed on much
> | more data than necessary (but as the bootloader previously made this
> | clean to the PoC there is no functional problem).
> |
> | As we only alter idmap_pg_dir, and init_pg_dir, we only need to
> | perform maintenance for these. As the other dirs are in .rodata, the
> | bootloader will have initialised them as expected and cleaned them to
> | the PoC. The kernel will initialize them as necessary after enabling
> | the MMU.
> |
> | This patch reworks the maintenance to only cover the idmap_pg_dir and
> | init_pg_dir to avoid this unnecessary work.
> 

Thanks for detailed changelog. I will use yours in v2, which will be posted
shortly. A nit is the correct commit ID would be 8eb7e28d4c642c31 instead
of 8eb7e28d4c642c31i :)

>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kernel/head.S | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index 57a91032b4c2..66947873c9e7 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -398,6 +398,10 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>>   	 * tables again to remove any speculatively loaded cache lines.
>>   	 */
> 
> The comment above has been stale for a while, since it says:
> 
> | 	/*
> | 	 * Since the page tables have been populated with non-cacheable
> | 	 * accesses (MMU disabled), invalidate the idmap and swapper page
> | 	 * tables again to remove any speculatively loaded cache lines.
> | 	 */
> 
> ... can we please update that at the same time? We can avoid mention of
> the specific tables and say:
> 
> | 	/*
> | 	 * Since the page tables have been populated with non-cacheable
> | 	 * accesses (MMU disabled), invalidate those tables again to
> | 	 * remove any speculatively loaded cache lines.
> | 	 */
> 

Sure, It will be included in v2.

>>   	adrp	x0, idmap_pg_dir
>> +	mov	x1, #IDMAP_DIR_SIZE
>> +	dmb	sy
>> +	bl	__inval_dcache_area
>> +	adrp	x0, init_pg_dir
>>   	adrp	x1, init_pg_end
>>   	sub	x1, x1, x0
>>   	dmb	sy
> 
> The existing DMB is to order prior non-cacheable accesses against cache
> maintenance, so we only need one of those at the start of the sequence.
> For consistency, we should use the same idiom to generate the size of
> both dirs. Given we use ADRP+ADRP+SUB here and elsewhere in head.S, I
> think that's preferable for now.
> 
> So I reckon this should be:
> 
> |	dmb	sy
> |
> |	adrp	x0, idmap_pg_dir
> |	adrp	x1, idmap_pg_end
> |	sub	x1, x1, x0
> |	bl	__inval_dcache_area
> |
> |	adrp	x0, init_pg_dir
> |	adrp	x1, init_pg_end
> |	sub	x1, x1, x0
> |	bl	__inval_dcache_area
> 
> ... with those line gaps to make the distinct blocks clearer.
> 

Yep, I'll change the code accordingly in v2. Also, symbol @idmap_pg_end
will be added to vmlinux.lds.S as it's not existing.

> Thanks,
> Mark.
> 

Thanks,
Gavin

